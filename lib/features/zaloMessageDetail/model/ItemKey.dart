import 'package:fake_message_screen/utils/Constants.dart';

class ItemKey extends Object{
  String value;
  dynamic key;
  bool isSelected;

  ItemKey(this.key, this.value, {this.isSelected = false});
}