import 'package:flutter/material.dart';

class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  var _formKey = GlobalKey<FormState>();
  var _nameController = TextEditingController();
  var _priceController = TextEditingController();
  var _totalPriceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            "Add Item ",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.only(top: 8.0,left: 8.0,right: 8.0),
          
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Container(
                  child: TextField(
                    controller: _nameController,
                    decoration: InputDecoration(),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
