import 'dart:async';
//------------------
import 'package:flutter/foundation.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//------------------------------------------------------
import 'package:original_base/src/core/utils/numeral_extensions.dart';
//--------------------------------------------------------------------

final voiceRecordProvider = ChangeNotifierProvider.autoDispose
    .family<VoiceRecordNotifier, int>((_, int maxDuration) {
  return VoiceRecordNotifier(
    recordDurationCounter: Duration(seconds: maxDuration),
  );
});

class VoiceRecordNotifier extends ChangeNotifier {
  Duration recordDurationCounter;
  FlutterSoundPlayer? _audioPlayer;
  StreamSubscription? _recordingStreamSubscription;

  bool isPlaying = false;

  VoiceRecordNotifier({
    required this.recordDurationCounter,
  });

  void init(String recordUrl) {
    if (recordUrl != "uploading") {
      _audioPlayer = FlutterSoundPlayer();
      _audioPlayer!.openPlayer();
      _audioPlayer!.setSubscriptionDuration(
        const Duration(milliseconds: 100),
      );
    }
  }

  void handleMessageGestureTap(String recordUrl) {
    if (recordUrl != "uploading") {
      if (_audioPlayer!.isStopped) {
        _openRecord(recordUrl);
      } else {
        _audioPlayer!.isPaused ? _resumeRecord() : _pauseRecord();
      }
    }
  }

  void _openRecord(String recordUrl) {
    recordDurationCounter = Duration.zero;
    isPlaying = true;
    notifyListeners();

    _audioPlayer?.startPlayer(fromURI: recordUrl);

    // record listener
    _recordingStreamSubscription ??=
        _audioPlayer?.onProgress!.listen((e) async {
      recordDurationCounter = e.position;
      if (recordDurationCounter.nearestSecond == e.duration.nearestSecond) {
        isPlaying = false;
      }
      notifyListeners();
    });
  }

  void _pauseRecord() {
    _audioPlayer?.pausePlayer();
    isPlaying = false;
    notifyListeners();
  }

  void _resumeRecord() {
    _audioPlayer?.resumePlayer();
    isPlaying = true;
    notifyListeners();
  }

  @override
  void dispose() {
    _recordingStreamSubscription?.cancel();
    _audioPlayer?.closePlayer();
    _audioPlayer = null;
    super.dispose();
  }
}
