import 'package:flutter/material.dart';
import 'package:taj_app/blocs/generalinfo.dart';
import 'package:http/http.dart' as http;
import 'package:taj_app/pages/homepage.dart';

class EditItem extends StatefulWidget {
 final  Map _items;
  final List _subItems;
  final  _name;
  final String pk;
  EditItem(this._items, this._subItems, this._name,this.pk);

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

    http.put(url + 'items/',
        body: { 'pk':int.parse(widget.pk), 'name':items['name'],'price': int.parse(items['price']), 'quantity':int.parse(items['quantity']) ,'subitems': subItems}).then((resp) {
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
