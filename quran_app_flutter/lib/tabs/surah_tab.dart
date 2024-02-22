import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app_flutter/pages/detail_screen.dart';
import 'package:quran_app_flutter/model/surah_model.dart';
import 'package:quran_app_flutter/theme.dart';
import 'package:quran_app_flutter/viewmodel/surah_viewmodel.dart';

class TabSurah extends StatelessWidget {
  const TabSurah({super.key});
  @override
  Widget build(BuildContext context) {
    final SurahViewModel _viewModel = SurahViewModel();
    return FutureBuilder<List<Surah>>(
        future: _viewModel.getListSurah(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text("Tidak Ada Data"),
            );
          }
          return ListView.separated(
              itemBuilder: (context, index) => _itemList(
                  context: context, surah: snapshot.data!.elementAt(index)),
              separatorBuilder: (context, index) =>
                  Divider(color: secondary.withOpacity(0.1)),
              itemCount: snapshot.data!.length);
        });
  }

  Widget _itemList({required BuildContext context, required Surah surah}) =>
      InkWell(
        onTap: () {
          Navigator.pushNamed(context, DetailScreen.routeName, arguments: surah.nomor.toString());
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(children: [
            Stack(
              children : [
            SvgPicture.asset('assets/svg/nomor_surah.svg'),
            SizedBox(
              height: 36,
              width: 36,
              child: Center(
                  child: Text(surah.nomor.toString(),
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500, color: Colors.black)
                          )
                          ),
            )
          ],
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(surah.nama_latin,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontSize: 16
              ),
              ),
              Text("${surah.tempat_turun} - ${surah.jumlah_ayat}",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w300,
                color: secondary,
                fontSize: 16
              ),
              ),
            ],
          )),
          Text(surah.nama,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
                color: secondary,
                fontSize: 18
          ),
          )
        ]),
        ),
      );
}
