import 'dart:convert';
import 'dart:ffi';

import 'package:data_nasabah/screens/add_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  final String url = 'http://localhost:8000/api/data';

  Future getData() async {
    var response = await http.get(Uri.parse(url));
    print(json.decode(response.body));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddData()));
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text('Data Nasabah'),
        ),
        body: FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data['data'].length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 75,
                        child: Card(
                          elevation: 3,
                          child: Row(
                            children: [
                              GestureDetector(
                                /* onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DataDetail(
                                                Data: snapshot.data['data']
                                                    [index],
                                              )));
                                },*/
                                child: Container(
                                    padding: EdgeInsets.all(10),
                                    width: 90,
                                    child: Text(
                                        snapshot.data['data'][index]['name'])),
                              ),
                              //Text(snapshot.data['data'][index]['noRek']),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(Icons.edit),
                                      Icon(Icons.delete),
                                      Text(
                                        snapshot.data['data'][index]['noRek']
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        snapshot.data['data'][index]['noKtp']
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              } else {
                return Text('Data Error');
              }
            }));
  }
}
