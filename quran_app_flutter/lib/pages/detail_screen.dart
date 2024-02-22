import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app_flutter/model/ayat_model.dart';
import 'package:quran_app_flutter/model/surah_model.dart';
import 'package:quran_app_flutter/viewmodel/ayat_viewmodel.dart';

class DetailScreen extends StatelessWidget {
  static const routeName = 'detail_screen';
  final String id_surah;
  const DetailScreen({super.key, required this.id_surah});

  @override
  Widget build(BuildContext context) {
    final AyatViewModel _viewModel = AyatViewModel();
    return Scaffold(
      body: FutureBuilder(
          future: _viewModel.getListAyat(id_surah),
          builder: (context, AsyncSnapshot<AyatModel> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }else if(snapshot.hasError){
              return Center(child: Text('Error: ${snapshot.error}'),);
            }else if(snapshot.hasData){
              return ListView.separated(
              itemBuilder: (context, index) => _itemList(
                  context: context, ayat: snapshot.data!.ayat!.elementAt(index)),
              separatorBuilder: (context, index) =>
                  Divider(color: Colors.grey.withOpacity(0.1)),
              itemCount: snapshot.data!.ayat!.length);
            }else{
              return Center(child: Text('No Data Available'));
            }
          }
          ),
    );
  }
  Widget _itemList({required BuildContext context, required Ayat ayat}) =>
  Padding(
    padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(children: [
            Stack(
              children : [
            SvgPicture.asset('assets/svg/nomor_surah.svg'),
            SizedBox(
              height: 36,
              width: 36,
              child: Center(
                  child: Text(ayat.nomor.toString(),
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500, color: Colors.black)
                          )
                          ),
            )
          ],
          ),
          const SizedBox(
            width: 10,
            height: 20,
          ),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(ayat.ar.toString(),
              style: GoogleFonts.amiriQuran(
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontSize: 16
              ),
              ),
              Text(ayat.tr.toString(),
              
              style: 
              GoogleFonts.amiri(
                fontWeight: FontWeight.w300,
                color: Colors.black,
                fontSize: 12
              ),
              ),
              Text(ayat.idn.toString(),
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w300,
                color: Colors.black,
                fontSize: 12
              ),
              ),
            ],
          )),
          ],
          ),
  );
}
