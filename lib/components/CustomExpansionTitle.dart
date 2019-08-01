import 'package:flutter/material.dart';

class CustomExpansionTile extends StatefulWidget {
  final String title;
  final Color header;
  final Color header_exp;
  final Color background;
  final Color background_exp;
  final Widget leading;
  final List<Widget> children;
  final Widget trailing;

  CustomExpansionTile(
      {this.title,
      this.leading,
      this.children,
      this.background,
      this.background_exp,
      this.header,
      this.trailing,
      this.header_exp});

  @override
  State createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Container(
        child: Text(
          widget.title,
          style: TextStyle(
            color: isExpanded ? widget.header_exp : widget.header,
          ),
        ),
        // Change header (which is a Container widget in this case) background colour here.
        color: isExpanded ? widget.background_exp : widget.background,
      ),
      leading: widget.leading,
      trailing: widget.trailing,
      children: widget.children,
      onExpansionChanged: (bool expanding) =>
          setState(() => this.isExpanded = expanding),
    );
  }
}
