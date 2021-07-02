import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'features/ZaloMessageDetail/ZaloMessagesDetailScreen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ZaloMessagesDetailScreen()
    );
  }

}