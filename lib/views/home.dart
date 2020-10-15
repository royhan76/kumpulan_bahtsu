import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kumpulan_bahtsu/models/data.dart';
import 'package:kumpulan_bahtsu/server/api.dart';
import 'package:kumpulan_bahtsu/views/Detail.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var loading = false;
  List<DataApi> listModels = [];
  var dataa;

  Future<Null> getData({url: baseUrl}) async {
    setState(() {
      loading = true;
    });

    final respon = await http.get(url);
    // var dataa = json.decode(respon.body)['data'];
    // print(dataa);

    if (respon.statusCode == 200) {
      // dataa = json.decode(respon.body)['data'];
      dataa = json.decode(utf8.decode(respon.bodyBytes))['data'];
    }
    setState(() {
      for (Map i in dataa) {
        listModels.add(DataApi.fromJson(i));
      }
      loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    this.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("kumpulan hasil Bahtsu"),
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: Stack(
                children: [
                  Container(
                    child: ListView.builder(
                      itemCount: listModels.length,
                      itemBuilder: (context, i) {
                        final dataA = listModels[i];

                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Card(
                            elevation: 5,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Detail(listModels[i])));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      dataA.judul,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      dataA.des,
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.justify,
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
