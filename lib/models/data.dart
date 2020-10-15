import 'dart:convert';

List<DataApi> modelPublishersFromJson(String str) =>
    List<DataApi>.from(json.decode(str).map((x) => DataApi.fromJson(x)));
String modelPublishersToJson(List<DataApi> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DataApi {
  String judul;
  String des;
  String pertanyaan;
  String jawaban;
  String ibarot;

  DataApi({
    this.judul,
    this.des,
    this.pertanyaan,
    this.jawaban,
    this.ibarot,
  });

  factory DataApi.fromJson(Map<String, dynamic> json) => DataApi(
        judul: json["Judul"],
        des: json["Deskripsi"],
        pertanyaan: json["Pertanyaan"],
        jawaban: json["Jawaban"],
        ibarot: json["Ibarot"],
      );
  Map<String, dynamic> toJson() => {
        "Judul": judul,
        "Deskripsi": des,
        "Pertanyaan": pertanyaan,
        "Jawaban": jawaban,
        "Ibarot": ibarot,
      };
}
