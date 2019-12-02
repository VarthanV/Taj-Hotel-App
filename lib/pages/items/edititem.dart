import 'package:flutter/material.dart';
import 'package:taj_app/blocs/generalinfo.dart';
import 'package:http/http.dart' as http;
import 'package:taj_app/pages/homepage.dart';

class EditItem extends StatefulWidget {
  Map _items;
  List _subItems;
  var _name;
  String pk;
  EditItem(this._items, this._subItems, this._name);

  @override
  _EditItemState createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  bool isLoading = false;
  final style =
      TextStyle(color: Colors.blue, fontFamily: fontFamily, fontSize: 20.0);

  submitItem(Map items, List subItems) {
    setState(() {
      isLoading = true;
    });

    http.post(url + 'edit/' + widget.pk + '/',
        body: {'items': items, 'subitems': subItems}).then((resp) {
          if(resp.statusCode ==200){
            setState(() {
              Navigator.pushReplacement(context,
              MaterialPageRoute(
                builder: (ctx) =>HomePage()
              )
              
              );
            });
          }
        });
  }

  Widget subItemForm(List subItems) {
    return Container(
      alignment: Alignment.center,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: subItems.length,
        itemBuilder: (BuildContext ctx, int i) {
          return SafeArea(
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: subItems[i]['name'], hintStyle: style),
                    onChanged: (value) {
                      subItems[i]['name'] = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: subItems[i]['price'].toString(),
                        hintStyle: style),
                    onChanged: (value) {
                      subItems[i]['price'] = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: subItems[i]['quantity'].toString(),
                      hintStyle: style,
                    ),
                    onChanged: (value) {
                      subItems[i]['quantity'] = value;
                    },
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      super.initState();
      print(widget._items);
      print(widget._subItems);
    }

    Map _itemsMap = widget._items;
    List _subitemsList = widget._subItems;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget._name == null ? 'Loading' : widget._name,
            style: TextStyle(fontFamily: fontFamily),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: SafeArea(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 8.0, left: 10.0),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: _itemsMap['name'], hintStyle: style),
                  onChanged: (value) {
                    _itemsMap['name'] = value;
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 8.0, left: 10.0),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: _itemsMap['price'].toString(),
                      hintStyle: style),
                  onChanged: (value) {
                    _itemsMap['price'] = int.parse(value);
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 8.0, left: 10.0),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: _itemsMap['total_price'].toString(),
                      hintStyle: style),
                  onChanged: (value) {
                    _itemsMap['totalPrice'] = int.parse(value);
                  },
                ),
              ),
              subItemForm(_subitemsList),
              Container(
                alignment: Alignment.center,
                child: !isLoading
                    ? RaisedButton(
                        child: Text("Submit"),
                        color: Colors.blue,
                        onPressed: () {},
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
              )
            ],
          ),
        ));
  }
}
