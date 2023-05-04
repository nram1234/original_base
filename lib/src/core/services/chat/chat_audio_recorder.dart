import 'dart:async';
//------------------
import 'package:flutter/foundation.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
//----------------------------------------------------------

class ChatAudioRecorder {
  final VoidCallback onRecordStarted;

  final ValueChanged<Duration> onSecondPassed;
  final ValueChanged<String?> onRecordCompleted;

  ChatAudioRecorder({
    required this.onRecordStarted,
    required this.onSecondPassed,
    required this.onRecordCompleted,
  });

  bool recordSessionOpened = false;
  bool recordPermissionGranted = false;
  Duration recordDuration = Duration.zero;
  StreamSubscription? _recordingStreamSubscription;

  final _audioRecorder = FlutterSoundRecorder();

  Future<void> handleRecordButtonClick() async {
    await _ensureRecordPermissionIsGranted();
    _ensureAudioSessionIsInitialized();
    _audioRecorder.isRecording ? _stopRecording() : _startRecording();
  }

  Future<void> cancelRecording() async {
    if (_audioRecorder.isRecording) {
      String? recordPath = await _audioRecorder.stopRecorder();
      if (recordPath != null) {
        await _audioRecorder.deleteRecord(fileName: recordPath);
      }
    }
  }

  Future<void> _ensureRecordPermissionIsGranted() async {
    if (recordPermissionGranted) return;

    PermissionStatus status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException("");
    } else {
      recordPermissionGranted = true;
    }
  }

  void _ensureAudioSessionIsInitialized() {
    if (!recordSessionOpened) {
      _audioRecorder.openRecorder();
      _audioRecorder.setSubscriptionDuration(
        const Duration(seconds: 1),
      );
    }
  }

  Future<void> _startRecording() async {
    this.onRecordStarted();
    await _audioRecorder.startRecorder(
      codec: Codec.aacADTS,
      toFile: "record.aac",
    );
    _recordingStreamSubscription ??=
        _audioRecorder.onProgress!.listen((e) async {
      recordDuration = e.duration;
      this.onSecondPassed(recordDuration);
      if (recordDuration.inMinutes >= 1) {
        String? recordPath = await _audioRecorder.stopRecorder();
        this.onRecordCompleted(recordPath);
      }
    });
  }

  Future<void> _stopRecording() async {
    if (_audioRecorder.isRecording) {
      if (recordDuration.inSeconds > 0) {
        String? recordPath = await _audioRecorder.stopRecorder();
        this.onRecordCompleted(recordPath);
      } else {
        this.cancelRecording();
      }
    }
  }

  void dispose() {
    _audioRecorder.closeRecorder();
    _recordingStreamSubscription?.cancel();
  }
}
