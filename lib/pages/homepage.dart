import 'package:flutter/material.dart';
import 'package:taj_app/pages/customers/customerDetailView.dart';

import '../blocs/generalinfo.dart';
import './items/additem.dart';
import 'items/deleteitem.dart';
import 'items/viewItem.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text(
          'Taj Catering',
          style: TextStyle(
              fontFamily: fontFamily, fontSize: 25.0, color: Colors.white),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10.0),
        margin: EdgeInsets.only(top: 10.0, left: 10.0),
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text("Add Item",
                  style: TextStyle(fontFamily: fontFamily, fontSize: 20.0)),
              onTap: () {
                setState(() {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (ctx) => AddItem()));
                });
              },
            ),
            ListTile(
              title: Text("View Items",
                  style: TextStyle(fontFamily: fontFamily, fontSize: 20.0)),
              onTap: () {
                setState(() {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (ctx) => ViewItem()));
                });
              },
            ),
            ListTile(
              title: Text("Delete Item",
                  style: TextStyle(fontFamily: fontFamily, fontSize: 20.0)),
              onTap: () {
                setState(() {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (ctx) => DeleteItem()));
                });
              },
            ),
            ListTile(
              title: Text("Edit Item",
                  style: TextStyle(fontFamily: fontFamily, fontSize: 20.0)),
              onTap: () {
                setState(() {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (ctx) => ViewItem()));
                });
              },
            ),
             ListTile(
              title: Text("Customers",
                  style: TextStyle(fontFamily: fontFamily, fontSize: 20.0)),
              onTap: () {
                setState(() {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (ctx) => CustomerView()));
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
