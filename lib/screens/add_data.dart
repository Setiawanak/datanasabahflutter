import 'dart:convert';

import 'package:data_nasabah/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddData extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _noRekController = TextEditingController();
  TextEditingController _noKTPController = TextEditingController();

  Future saveData() async {
    final response =
        await http.post(Uri.parse("http://192.168.1.2:8000/api/data"), body: {
      "name": _nameController.text,
      'noRek': _noRekController.toString(),
      'noKTP': _noKTPController.toString(),
    });
    print(response.body);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Create Data Nasabah"),
        ),
        body: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Masukan data nama !";
                      }
                      return null;
                    },
                    controller: _nameController,
                    decoration: InputDecoration(labelText: "Name")),
                TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Masukan data rekening !";
                      }
                      return null;
                    },
                    controller: _noRekController,
                    decoration: InputDecoration(labelText: "No Rekening")),
                TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Masukan data KTP !";
                      }
                      return null;
                    },
                    controller: _noKTPController,
                    decoration: InputDecoration(labelText: "No KTP")),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        saveData().then((value) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => HomePage())));
                        });
                      }
                      ;
                    },
                    child: Text("Save"))
              ],
            )));
  }
}
