import 'package:online_otostop/main.dart';

class SurucuIlan {
  String kullaniciAdi;
  final Cinsiyet surucuCinsiyet;
  final String kalkisYeri;
  final String varisYeri;
  final DateTime tarih;
  final int tahminiYolSuresi;
  final int koltukSayisi;
  final int fiyat;
  final String adres;
  final String aciklama;
  SurucuIlan({
    required this.kullaniciAdi,
    required this.surucuCinsiyet,
    required this.kalkisYeri,
    required this.varisYeri,
    required this.tarih,
    required this.tahminiYolSuresi,
    required this.koltukSayisi,
    required this.fiyat,
    required this.adres,
    required this.aciklama,
  });
}
