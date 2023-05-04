import 'dart:io';
//---------------
import 'package:flutter/material.dart';
import 'package:original_base/original_base.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//------------------------------------------------------
import 'package:original_base/src/core/services/chat/chat_media_urls_uploader.dart';
import 'package:original_base/src/core/services/chat/chat_audio_recorder.dart';
//-----------------------------------------------------------------------------

final privateChatRoomProvider = ChangeNotifierProvider.autoDispose
    .family<PrivateChatRoomNotifier, PrivateChatRoomClient>((_, client) {
  return PrivateChatRoomNotifier(client);
});

class PrivateChatRoomNotifier extends ChangeNotifier {
  static const _messageSendSound = "audio/message_send_sound.mp3";
  static const _recordCancelSound = "audio/record_cancel_sound.mp3";

  bool showSendButton = false;
  bool isRecording = false;
  Duration? recordDuration;

  final PrivateChatRoomClient _chatRoomClient;

  final messageTextController = TextEditingController();
  final scrollController = ScrollController();
  final _audioPlayer = FlutterSoundPlayer();
  ChatAudioRecorder? _chatAudioRecorder;

  PrivateChatRoomNotifier(this._chatRoomClient) {
    _audioPlayer.openPlayer();
  }

  Future<void> sendTextMessage(String peerId) async {
    _chatRoomClient.sendMessage(
      peerId: peerId,
      message: messageTextController.text,
      messageType: "text",
    ).then((_) {
      _triggerOnMessageSent();
    });
    messageTextController.clear();
    _changeSendButtonShowState(false);
  }

  void handleOnTextChanged() {
    if (messageTextController.text.isEmpty) {
      _changeSendButtonShowState(false);
    } else {
      _changeSendButtonShowState(true);
    }
  }

  Future<void> sendImageMessage(
    BuildContext context, {
    required String peerId,
  }) async {
    var imagePickerResult = await showImageSourcePopup(context);
    if (imagePickerResult is ImagePickedSuccessfully) {
      _handleMediaFileUrlUploadToFirebase(
        peerId: peerId,
        mediaFile: imagePickerResult.image,
        messageType: ImageMessage(),
        context: context,
      );
    } else if (imagePickerResult is ErrorWhilePickingImage) {
      showSnackBarAlert("#error_while_picking_image", context);
    }
  }

  Future<void> onVoiceRecordButtonClicked(
    BuildContext context, {
    required String peerId,
  }) async {
    _chatAudioRecorder ??= ChatAudioRecorder(
      onRecordStarted: _onRecordStarted,
      onSecondPassed: _onRecordDurationChange,
      onRecordCompleted: (String? recordPath) {
        _onRecordCompleted(
          peerId: peerId,
          recordPath: recordPath,
          context: context,
        );
      },
    );
    try {
      _chatAudioRecorder!.handleRecordButtonClick();
    } on RecordingPermissionException {
      showSnackBarAlert("#record_permission_failed", context);
    }
  }

  void cancelAudioRecording() {
    recordDuration = null;
    _chatAudioRecorder?.cancelRecording();
    convertAssetFileToUnit8List(_recordCancelSound).then((soundBuffer) {
      _audioPlayer.startPlayer(fromDataBuffer: soundBuffer);
    });
    _changeIsRecordingState(false);
  }

  void _onRecordStarted() {
    recordDuration = null;
    _changeIsRecordingState(true);
  }

  void _onRecordDurationChange(Duration newDuration) {
    recordDuration = newDuration;
    notifyListeners();
  }

  void _onRecordCompleted({
    required String peerId,
    required String? recordPath,
    required BuildContext context,
  }) {
    _changeIsRecordingState(false);
    if (recordPath != null) {
      _handleMediaFileUrlUploadToFirebase(
        recordSeconds: recordDuration?.inSeconds,
        peerId: peerId,
        mediaFile: File(recordPath),
        messageType: VoiceRecordMessage(),
        context: context,
      );
    } else {
      showSnackBarAlert("#failed_to_get_record", context);
    }
  }

  void _changeIsRecordingState(bool newBool) {
    isRecording = newBool;
    notifyListeners();
  }

  void _changeSendButtonShowState(bool newBool) {
    if (showSendButton != newBool) {
      showSendButton = newBool;
      notifyListeners();
    }
  }

  Future<void> _handleMediaFileUrlUploadToFirebase({
    int? recordSeconds,
    required String peerId,
    required ChatMessageType messageType,
    required File mediaFile,
    required BuildContext context,
  }) async {
    final _chatMediaUrlsUploader = ChatMediaUrlsUploader(_chatRoomClient);
    bool messageSent = await _chatMediaUrlsUploader.sendMediaFileUrlToFirebase(
      recordSeconds: recordSeconds,
      peerId: peerId,
      messageType: messageType,
      mediaFile: mediaFile,
      context: context,
    );
    if (messageSent) _triggerOnMessageSent();
  }

  void _triggerOnMessageSent() {
    scrollController.jumpTo(
      scrollController.position.minScrollExtent,
    );
    convertAssetFileToUnit8List(_messageSendSound).then((soundBuffer) {
      _audioPlayer.startPlayer(fromDataBuffer: soundBuffer);
    });
  }

  @override
  void dispose() {
    _audioPlayer.closePlayer();
    _chatRoomClient.disposePlayer();
    _chatAudioRecorder?.dispose();
    super.dispose();
  }
}
