import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final TextEditingController _filter = new TextEditingController();
  String _searchText = "";
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text( 'YouPlayer' );

  _HomePageState(){
    _filter.addListener(() {
        if (_filter.text.isEmpty) {
          setState(() {
            _searchText = "";
          });
        } else {
          setState(() {
            _searchText = _filter.text;
          });
        }
      });
  }
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: _buildAppBar(context),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Text(_searchText),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return new AppBar(
      title: _appBarTitle,
      leading: new IconButton(
        icon: _searchIcon,
        onPressed: _searchPressed,

      ),
    );
  }

  void _searchPressed() {
      setState(() {
        if (this._searchIcon.icon == Icons.search) {
          this._searchIcon = new Icon(Icons.close);
          this._appBarTitle = new TextField(
            controller: _filter,
            decoration: new InputDecoration(
              hintText: 'Search...',
              hintStyle: Theme.of(context).textTheme.title,
              contentPadding: EdgeInsets.all(0),
            ),
            style: Theme.of(context).textTheme.title,
          );
        } else {
          this._searchIcon = new Icon(Icons.search);
          this._appBarTitle = new Text( 'YouPlayer');
          _filter.clear();
        }
      });
    }
}
