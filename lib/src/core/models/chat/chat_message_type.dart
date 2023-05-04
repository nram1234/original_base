abstract class ChatMessageType {}

class TextMessage extends ChatMessageType {
  @override
  String toString() => "text";
}

class ImageMessage extends ChatMessageType {
  @override
  String toString() => "image";
}

class VoiceRecordMessage extends ChatMessageType {
  @override
  String toString() => "voice";
}
