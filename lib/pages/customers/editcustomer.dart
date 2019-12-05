import 'package:flutter/material.dart';
import 'package:taj_app/blocs/generalinfo.dart';
import 'package:http/http.dart' as http;
import 'package:taj_app/pages/customers/customerDetailView.dart';

class CustomerEditView extends StatefulWidget {
  final _uniqueID;
  final _customer;
  CustomerEditView(this._uniqueID, this._customer);
  @override
  _CustomerEditViewState createState() => _CustomerEditViewState();
}

class _CustomerEditViewState extends State<CustomerEditView> {
  final style =
      TextStyle(color: Colors.blue, fontFamily: fontFamily, fontSize: 20.0);
  bool isLoading = false;
  editCustomer(Map customerMap) {
    setState(() {
      isLoading = true;
    });
    http.put(url + 'customer/', body: {
      'u_id': widget._uniqueID,
      'name': customerMap['name'],
      'phone_number': customerMap['phone_number'],
      'email': customerMap['email'],
      'address': customerMap['address']
    }).then((response) {
      if (response.statusCode == 200) {
        setState(() {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (ctx) => CustomerView()));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var _customerMap = widget._customer;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _customerMap['name'] == null ? "Loading" : _customerMap['name'],
          style: TextStyle(fontFamily: fontFamily),
        ),
        centerTitle: true,
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                  hintText: _customerMap['name'], hintStyle: style),
              onChanged: (value) {
                _customerMap['name'] = value;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                  hintText: _customerMap['phone_number'], hintStyle: style),
              onChanged: (value) {
                _customerMap['phone_number'] = value;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: _customerMap['email'], hintStyle: style),
              onChanged: (value) {
                _customerMap['email'] = value;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                  hintText: _customerMap['address'], hintStyle: style),
              onChanged: (value) {
                _customerMap['address'] = value;
              },
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 8.0),
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RaisedButton(
                    child:
                        Text("Submit", style: TextStyle(color: Colors.white)),
                    color: Colors.blue,
                    onPressed: () {},
                  ),
          )
        ],
      ),
    );
  }
}
