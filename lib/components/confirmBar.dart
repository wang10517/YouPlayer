import 'package:flutter/material.dart';

class ConfirmBar extends StatelessWidget {
  final Function onCancel;
  final Function onConfirm;

  ConfirmBar({this.onCancel, this.onConfirm, key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: GestureDetector(
        child: Icon(Icons.cancel),
        onTap: onCancel,
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.check,
            color: Theme.of(context).accentColor,
          ),
          onPressed: onConfirm,
        )
      ],
    );
  }
}
