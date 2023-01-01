import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:online_otostop/controllers/BaglantiliProviderYonetimi/abstract_provider_koprusu.dart';
import 'package:online_otostop/controllers/hesap_veri_yonetimi.dart';
import 'package:online_otostop/models/surucu_ilan.dart';
import 'package:provider/provider.dart';

import '../../units/degismeyen_birimler.dart';

class SurucuIlanEklemeYonetimi with ChangeNotifier implements ProviderKoprusu {
  //TextEditingController
  final Map<String, TextEditingController> kontrolculer = {
    'kalkisYeri': TextEditingController(),
    'varisYeri': TextEditingController(),
    'koltukSayisi': TextEditingController(),
    'tahminiSaat': TextEditingController(),
    'fiyat': TextEditingController(),
    'adres': TextEditingController(),
    'aciklama': TextEditingController(),
    'tarih': TextEditingController(),
  };
  // Degiskenler
  @override
  List<String> uyusanKonumListesi = [];
  DateTime _tarih = DateTime.now();
  bool _hepsiDolu = false;
  bool _kalkisYeriSecili = false;
  bool _varisYeriSecili = false;
  List<String> konumlar = DegismeyenBirimler.konumlar;
  @override
  var kalkisYeriFocus = FocusNode();
  @override
  var varisYeriFocus = FocusNode();
  // getters
  DateTime get getTarih => _tarih;
  bool get getHepsiDolu => _hepsiDolu;
  bool get getKalkisYeriSecili => _kalkisYeriSecili;
  bool get getVarisYeriSecili => _varisYeriSecili;
  @override
  TextEditingController get kalkisYeri => kontrolculer['kalkisYeri']!;
  @override
  TextEditingController get varisYeri => kontrolculer['varisYeri']!;
  TextEditingController get tarih => kontrolculer['tarih']!;
  TextEditingController get koltukSayisi => kontrolculer['koltukSayisi']!;
  TextEditingController get tahminiSaat => kontrolculer['tahminiSaat']!;
  TextEditingController get fiyat => kontrolculer['fiyat']!;
  TextEditingController get adres => kontrolculer['adres']!;
  TextEditingController get aciklama => kontrolculer['aciklama']!;
  // setters
  set setTarih(DateTime tarih) {
    _tarih = tarih;
  }

  @override
  set setKalkisYeriSecili(bool kosul) {
    _kalkisYeriSecili = kosul;
    notifyListeners();
  }

  @override
  set setVarisYeriSecili(bool kosul) {
    _varisYeriSecili = kosul;
    notifyListeners();
  }

  // fonksiyonlar
  void bilgiGirdilerikontrolu() {
    // her textField dolu m udiye kontrol edilir
    _hepsiDolu = true;
    kontrolculer.forEach((_, value) {
      if (value.text.isEmpty) {
        _hepsiDolu = false;
      }
    });
    notifyListeners();
  }

  void tarihSecimi(BuildContext context) {
    // takvimden tarih ayarlama.
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(
        DateTime.now().year,
        DateTime.now().month + 1,
      ),
    ).then((value) {
      if (value != null) {
        setTarih = value;
        tarih.text = DateFormat.yMd().format(value);
        bilgiGirdilerikontrolu();
      }
    });
  }

  void uyusanKonumlar(TextEditingController kontrolcu) {
    // 81 ilden birini secmek icin anlik secim listesi olusturma fonksiyonu
    uyusanKonumListesi.clear();
    for (var konum in DegismeyenBirimler.konumlar) {
      if (konum.toLowerCase().contains(kontrolcu.text.toLowerCase()) &&
          konum.toLowerCase() != kalkisYeri.text.toLowerCase() &&
          konum.toLowerCase() != varisYeri.text.toLowerCase()) {
        uyusanKonumListesi.add(konum);
      }
    }
  }

  void ilanGirdileriVeDegiskenleriSifirla() {
    kontrolculer.forEach((key, value) {
      value.clear();
    });
    _tarih = DateTime.now();
    _hepsiDolu = false;
    _kalkisYeriSecili = false;
    _varisYeriSecili = false;
    uyusanKonumListesi.clear();
  }

  void ilaniEkle(BuildContext context) {
    // tum kontroller olumlu sonuc veriyorsa ilani kullanicinin ilanlarina ekler ve ana sayfaya doner.
    final hesap = Provider.of<HesapVeriYonetimi>(context, listen: false);
    hesap.getKullanicilar
        .firstWhere((kullanici) =>
            kullanici.kullaniciAdi == hesap.getSimdikiKullanici.kullaniciAdi)
        .ilanlar!
        .add(
          SurucuIlan(
            kullaniciAdi: hesap.getSimdikiKullanici.kullaniciAdi,
            surucuCinsiyet: hesap.getSimdikiKullanici.cinsiyet,
            kalkisYeri: kalkisYeri.text,
            varisYeri: varisYeri.text,
            tarih: getTarih,
            tahminiYolSuresi: int.parse(tahminiSaat.text),
            koltukSayisi: int.parse(koltukSayisi.text),
            fiyat: int.parse(fiyat.text),
            adres: adres.text,
            aciklama: aciklama.text,
          ),
        );
    ilanGirdileriVeDegiskenleriSifirla();
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/AnaSayfa', (Route<dynamic> route) => false);
  }
}
