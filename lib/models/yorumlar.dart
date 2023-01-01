import 'package:online_otostop/main.dart';

class Yorumlar {
  final String yorumYapanKisiAdi;
  final Cinsiyet yorumYapanKisiCinsiyet;
  final DateTime yorumTarihi;
  final String yorum;

  Yorumlar({
    required this.yorumYapanKisiAdi,
    required this.yorumYapanKisiCinsiyet,
    required this.yorumTarihi,
    required this.yorum,
  });
}
