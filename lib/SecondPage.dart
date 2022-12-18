import 'package:flutter/material.dart';


class SecondPage extends StatefulWidget {
   SecondPage({Key? key,this.msg}) : super(key: key);
  String? msg;

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.msg!),
      ),
    );
  }
}
