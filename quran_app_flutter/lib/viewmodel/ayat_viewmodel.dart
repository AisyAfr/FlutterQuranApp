import 'package:quran_app_flutter/model/ayat_model.dart';
import 'package:quran_app_flutter/repository/quran_repo.dart';

class AyatViewModel{
  final _repository = QuranRepository();
  Future<AyatModel> getListAyat(String id_surah) async{
    try{
      final response = await _repository.getListAyat(id_surah);
      return response;
    }catch (e){
      print("Error : $e");
      rethrow;
    }
  }
}