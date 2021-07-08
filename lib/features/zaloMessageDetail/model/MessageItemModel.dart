
import 'package:fake_message_screen/utils/Constants.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class MessageItemModel extends Object {
  String content;
  String time;
  MessageType messageType;

  MessageItemModel(
      {this.content = "",
      this.time = "",
      this.messageType = MessageType.INCOMING_MESSAGE});
}