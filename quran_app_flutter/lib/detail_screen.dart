import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  static const routeName = 'detail_screen';
  final int id_surah;
  const DetailScreen({super.key, required this.id_surah});

  Future _detailSurah() async {
    var data = await Dio().get("https://equran.id/api/surat/$id_surah");
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: _detailSurah(),
          builder: (context, snapshot) =>
            SafeArea(
              child: Text('$id_surah'),
            )
          ),
    );
  }
}
