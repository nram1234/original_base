import 'dart:io';
//---------------
import 'package:flutter/material.dart';
//-------------------------------------
import 'package:original_base/src/core/services/chat/chat_media_files_uploader.dart';
import 'package:original_base/src/core/services/chat/private_chat_room_client.dart';
import 'package:original_base/src/core/models/results/http_client_result.dart';
import 'package:original_base/src/core/models/chat/chat_message_type.dart';
import 'package:original_base/src/ui/widgets/popups/snack_bar_alert.dart';
//------------------------------------------------------------------------

class ChatMediaUrlsUploader {
  final PrivateChatRoomClient _chatRoomClient;

  ChatMediaUrlsUploader(this._chatRoomClient);

  Future<bool> sendMediaFileUrlToFirebase({
    int? recordSeconds,
    required String peerId,
    required ChatMessageType messageType,
    required File mediaFile,
    required BuildContext context,
  }) async {
    // first send a default message which indicates that
    // media file is still uploading.
    String messageId = await _chatRoomClient.sendMessage(
      durationInSeconds: recordSeconds,
      peerId: peerId,
      message: "uploading",
      messageType: messageType.toString(),
    );

    // upload media file to server and get its URL.
    String? uploadedFileUrl = await _uploadMediaFileAndGetUrl(
      context: context,
      mediaFile: mediaFile,
      mediaType: messageType.toString(),
    );

    if (uploadedFileUrl != null) {
      // update message record in firebase with the file URL
      // when the file gets uploaded successfully to the server.
      _chatRoomClient.updateMediaMessageUrl(
        messageDocumentId: messageId,
        mediaFileUrl: uploadedFileUrl,
        typeName: messageType.toString(),
      );
      return true;
    } else {
      // delete message from firebase if file upload fails.
      _chatRoomClient.deleteMessage(messageId);
      return false;
    }
  }

  Future<String?> _uploadMediaFileAndGetUrl({
    required BuildContext context,
    required File mediaFile,
    required String mediaType,
  }) async {
    var imageUploadResult = await ChatMediaFilesUploader().uploadFile(
      file: mediaFile,
      mediaType: mediaType,
    );

    if (imageUploadResult is SuccessfulRequest) {
      return imageUploadResult.retrievedData;
    } else if (imageUploadResult is FailedRequest) {
      showSnackBarAlert(imageUploadResult.errorId, context);
      return null;
    }

    return null;
  }
}
