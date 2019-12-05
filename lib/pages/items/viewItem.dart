import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:taj_app/blocs/generalinfo.dart';
import 'package:http/http.dart' as http;

import 'package:taj_app/pages/items/edititem.dart';

var _items = [];

class ViewItem extends StatefulWidget {
  @override
  _ViewItemState createState() => _ViewItemState();
}

class _ViewItemState extends State<ViewItem> {
  getItems() {
    http.get(url + 'items/').then((response) {
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        setState(() {
          _items = jsonDecode(response.body);
        });
      }
    });
  }

  deleteItem(var pk) {
    http.patch(url + 'items/', body: {'pk': int.parse(pk)}).then((resp) {
      if (resp.statusCode == 200) {
        setState(() {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (ctx) => ViewItem()));
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getItems();
  }

  @override
  Widget build(BuildContext context) {
    Widget subItemBuilder(var item) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left: 20.0, top: 8.0),
            child: Text(
              "Name :  " + item['name'].toString(),
              style: TextStyle(fontFamily: fontFamily, fontSize: 20.0),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(top: 8.0, left: 20.0),
            child: Text(
              "Price " + item['price'].toString(),
              style: TextStyle(fontFamily: fontFamily, fontSize: 20.0),
            ),
          ),
          Divider(
            color: Colors.black,
          )
        ],
      );
    }

    Widget itemCard(Map item, int i) {
      return Container(
        padding: EdgeInsets.only(top: 10.0),
        margin: EdgeInsets.only(left: 10.0),
        child: ExpansionTile(
          key: Key(i.toString()),
          title: Text(
            item['name'],
            style: TextStyle(fontFamily: fontFamily, fontSize: 20.0),
          ),
          children: <Widget>[
            ListView(
              shrinkWrap: true,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 8.0),
                      alignment: Alignment.topLeft,
                      child: RaisedButton(
                        color: Colors.blue,
                        child: Text("Edit",
                            style: TextStyle(fontFamily: fontFamily)),
                        onPressed: () {
                          setState(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => EditItem(
                                        item,
                                        item['subitems'],
                                        item['name'],
                                        item['pk'])));
                          });
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 8.0),
                      alignment: Alignment.topLeft,
                      child: RaisedButton(
                        color: Colors.blue,
                        child: Text("Delete",
                            style: TextStyle(fontFamily: fontFamily)),
                        onPressed: () {
                          deleteItem(item['pk']);
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Price :  " + item['price'].toString(),
                    style: TextStyle(fontFamily: fontFamily, fontSize: 20.0),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: item['subitems'].length,
                  itemBuilder: (ctx, int i) {
                    return subItemBuilder(item['subitems'][i]);
                  },
                )
              ],
            )
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            color: Colors.white,
            onPressed: () {
              showSearch(context: context, delegate: ItemSearch());
            },
          )
        ],
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text(
          "View Items",
          style: TextStyle(fontFamily: fontFamily),
        ),
      ),
      body: _items.length == 0
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _items.length,
              itemBuilder: (ctx, int i) {
                return itemCard(_items[i], i);
              },
            ),
    );
  }
}

class ItemSearch extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions

    Widget subItemBuilder(var item) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left: 20.0, top: 8.0),
            child: Text(
              "Name :  " + item['name'].toString(),
              style: TextStyle(fontFamily: fontFamily, fontSize: 20.0),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(top: 8.0, left: 20.0),
            child: Text(
              "Price " + item['price'].toString(),
              style: TextStyle(fontFamily: fontFamily, fontSize: 20.0),
            ),
          ),
          Divider(
            color: Colors.black,
          )
        ],
      );
    }

    List _filtered = _items
        .where((item) => item['name'].toString().toLowerCase().contains(query))
        .toList();
    if (query == '' || _filtered.length == 0) {
      return Center(
        child: Text("Please enter a valid query"),
      );
    }

    print(_filtered);
    return _filtered.length != 0
        ? ListView.builder(
            itemCount: _filtered.length,
            itemBuilder: (ctx, int i) {
              return Container(
                padding: EdgeInsets.only(top: 10.0),
                margin: EdgeInsets.only(left: 10.0),
                child: ExpansionTile(
                  key: Key(i.toString()),
                  title: Text(
                    _filtered[i]['name'],
                    style: TextStyle(fontFamily: fontFamily, fontSize: 20.0),
                  ),
                  children: <Widget>[
                    ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(left: 20.0),
                          child: Text(
                            "Price :  " + _filtered[i]['price'].toString(),
                            style: TextStyle(
                                fontFamily: fontFamily, fontSize: 20.0),
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: _filtered[i]['subitems'].length,
                          itemBuilder: (ctx, int count) {
                            return subItemBuilder(
                                _filtered[i]['subitems'][count]);
                          },
                        )
                      ],
                    )
                  ],
                ),
              );
            },
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
