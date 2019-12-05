import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:taj_app/blocs/generalinfo.dart';

List _customers = [];

class CustomerView extends StatefulWidget {
  @override
  _CustomerViewState createState() => _CustomerViewState();
}

_deleteCustomer(String pk) {}

class _CustomerViewState extends State<CustomerView> {
  _getCustomers() {
    http.get(url + 'customers/').then((response) {
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        setState(() {
          _customers = jsonDecode(response.body);
          print(_customers);
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getCustomers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            color: Colors.white,
            onPressed: () {
              showSearch(context: context, delegate: CustomerSearch());
            },
          )
        ],
      ),
      body: ListView(
        shrinkWrap: true,
      ),
    );
  }
}

class CustomerSearch extends SearchDelegate {
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

    Widget customerCard(Map item, int i) {
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
                        onPressed: () {},
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
                          _deleteCustomer(item['pk']);
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(left: 20.0, top: 5.0),
                  child: InkWell(
                    onTap: () {},
                    child: Text(
                      "PhoneNumber :  " + item['phone_number'].toString(),
                      style: TextStyle(fontFamily: fontFamily, fontSize: 20.0),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(left: 20.0, top: 5.0),
                  child: Text('Email : ' + item['email']),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(top: 5.0, left: 20.0),
                  child: Text('Address :' + item['address']),
                )
              ],
            )
          ],
        ),
      );
    }

    List _filtered = _customers
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
            shrinkWrap: true,
            itemCount: _filtered.length,
            itemBuilder: (BuildContext ctx, int i) {
              return customerCard(_filtered[i], i);
            },
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
