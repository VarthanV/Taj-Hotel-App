import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:taj_app/blocs/generalinfo.dart';

class CustomerView extends StatefulWidget {
  @override
  _CustomerViewState createState() => _CustomerViewState();
}

class _CustomerViewState extends State<CustomerView> {
  List _customers = [];

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
    return Container();
  }
}
