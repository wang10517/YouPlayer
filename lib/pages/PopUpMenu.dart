import 'package:flutter/material.dart';

class PopUpMenu extends StatelessWidget {
  Map<String, Function> options;

  PopUpMenu({Key key, this.options}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) {
        List<PopupMenuEntry<Object>> entries = options.keys
            .map((title) => PopupMenuItem(
                  child: Text(title),
                  value: title,
                ))
            .toList();
        return entries;
      },
      icon: Icon(
        Icons.more_vert,
        color: Colors.black,
      ),
      onSelected: (value) => options[value](),
    );
  }
}
