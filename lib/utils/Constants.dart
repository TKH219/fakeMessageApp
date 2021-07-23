enum MessageType {INCOMING_MESSAGE, OUTGOING_MESSAGE}

extension MesssageTypeExtension on MessageType {
  String getTitleDisplay() {
    switch (this) {
      case MessageType.INCOMING_MESSAGE:
        return "Incoming Message";
      case MessageType.OUTGOING_MESSAGE:
        return "Outgoing Message";
    }
  }
}