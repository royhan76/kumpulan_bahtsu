import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:kumpulan_bahtsu/models/data.dart';
import 'package:kumpulan_bahtsu/server/api.dart';
import 'package:kumpulan_bahtsu/views/home.dart';
import 'package:http/http.dart' as http;

class Detail extends StatefulWidget {
  final DataApi dataApi;
  Detail(this.dataApi);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  var loading = false;
  var dataa;
  List<DataApi> listModels = [];

  Future<Null> getData({url: baseUrl}) async {
    setState(() {
      loading = true;
    });

    final respon = await http.get(url);

    if (respon.statusCode == 200) {
      // dataa = json.decode(respon.body)['data'];
      dataa = json.decode(utf8.decode(respon.bodyBytes))['data'];

      // print(data1);
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
    this.getData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
        actions: [
          // Icon(Icons.backpack_outlined),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.dataApi.judul,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.dataApi.des,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.dataApi.pertanyaan,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.dataApi.jawaban,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      fontFamily: ArabicFonts.Cairo,
                      package: 'google_fonts_arabic',
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.dataApi.ibarot,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      fontFamily: ArabicFonts.Cairo,
                      package: 'google_fonts_arabic',
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
