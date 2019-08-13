import 'package:flutter/material.dart';
import '../model/Video.dart';

class CollectionAdder extends StatefulWidget {
  final List<String> existingNames;
  final Function adder;

  CollectionAdder({this.adder, this.existingNames, Key key}) : super(key: key);

  @override
  _CollectionAdderState createState() => _CollectionAdderState();
}

class _CollectionAdderState extends State<CollectionAdder> {
  final _collectionController = TextEditingController();
  bool _validate = true;
  String erorMessage = "";

  void onSubmit(BuildContext context) {
    if (_collectionController.text.isEmpty) {
      setState(() {
        _validate = false;
        erorMessage = "Name could not be empty";
      });
    } else if (widget.existingNames.contains(_collectionController.text)) {
      setState(() {
        _validate = false;
        erorMessage = "Please enter a unique title for the new collection";
      });
    }

    if (_validate) {
      print('Enter validateing');
      widget.adder(_collectionController.text);
      print('here?');
      Navigator.of(context).pop();
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget inputName = Container(
        alignment: Alignment.centerLeft,
        child: TextField(
          autofocus: true,
          controller: _collectionController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              helperText: "Create a new collection in your personal library",
              labelText: "Collection Title",
              labelStyle: TextStyle(color: Colors.black),
              errorText: _validate ? null : erorMessage,
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue)),
              focusedErrorBorder: _validate
                  ? null
                  : OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)))),
          onSubmitted: (_) => onSubmit(context),
        ));

    return Container(
        margin: EdgeInsets.all(5.0),
        padding: EdgeInsets.only(top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[inputName],
        ));
  }
}
