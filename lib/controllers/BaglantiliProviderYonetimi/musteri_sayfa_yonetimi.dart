import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:online_otostop/controllers/BaglantiliProviderYonetimi/abstract_provider_koprusu.dart';
import 'package:online_otostop/controllers/hesap_veri_yonetimi.dart';
import 'package:online_otostop/models/gecmis_yolculuklar.dart';
import 'package:online_otostop/models/kullanici.dart';
import 'package:online_otostop/models/surucu_ilan.dart';
import 'package:online_otostop/models/yorumlar.dart';
import 'package:provider/provider.dart';
import '../../units/degismeyen_birimler.dart';

class MusteriSayfaYonetimi with ChangeNotifier implements ProviderKoprusu {
  final Map<String, TextEditingController> kontrolculer = {
    'kalkisYeri': TextEditingController(),
    'varisYeri': TextEditingController(),
    'tarih': TextEditingController(),
    'kisiSayisi': TextEditingController(),
    'fiyatMin': TextEditingController(),
    'fiyatMax': TextEditingController(),
  };
  // Degiskenler
  DateTime _tarih = DateTime.now();
  bool _hepsiDolu = false;
  bool _kalkisYeriSecili = false;
  bool _varisYeriSecili = false;
  bool _fiyatGirdileriDogru = false;
  final List<SurucuIlan> filtreliIlanlar = [];
  @override
  List<String> uyusanKonumListesi = [];
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
  bool get getFiyatGirdileriDogru => _fiyatGirdileriDogru;

  @override
  TextEditingController get kalkisYeri => kontrolculer['kalkisYeri']!;
  @override
  TextEditingController get varisYeri => kontrolculer['varisYeri']!;
  TextEditingController get tarih => kontrolculer['tarih']!;
  TextEditingController get koltukSayisi => kontrolculer['kisiSayisi']!;
  TextEditingController get fiyatMin => kontrolculer['fiyatMin']!;
  TextEditingController get fiyatMax => kontrolculer['fiyatMax']!;

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

  set setFiyatGirdileriDogru(bool condition) {
    _fiyatGirdileriDogru = condition;
  }

  // fonksiyonlar

  // musteri tercih sayfasi
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

  void degiskenleriSifirla() {
    kontrolculer.forEach((key, value) {
      value.clear();
    });
    _tarih = DateTime.now();
    _hepsiDolu = false;
    _kalkisYeriSecili = false;
    _varisYeriSecili = false;
    _fiyatGirdileriDogru = false;
    uyusanKonumListesi.clear();
  }

  void fiyatGirdileriKontrolu() {
    try {
      if (int.parse(fiyatMin.text) < int.parse(fiyatMax.text)) {
        setFiyatGirdileriDogru = true;
      } else {
        setFiyatGirdileriDogru = false;
      }
    } catch (e) {
      setFiyatGirdileriDogru = false;
      debugPrint('$e');
    }
    notifyListeners();
  }

  void ilanlariFiltrele(BuildContext context) {
    for (var kullanici in KullaniciListesi.kullaniciListesi) {
      for (var ilan in kullanici.ilanlar!) {
        if (filtreKosullari(context, ilan)) {
          filtreliIlanlar.add(ilan);
        }
      }
    }
    filtreliIlanlar.sort(
      (a, b) => a.fiyat.compareTo(b.fiyat),
    );
    //degiskenleriSifirla();
  }

  bool filtreKosullari(BuildContext context, SurucuIlan ilan) {
    final kullaniciKontrol = context.read<HesapVeriYonetimi>();
    return ilan.kalkisYeri == kalkisYeri.text &&
        ilan.varisYeri == varisYeri.text &&
        ilan.tarih.day == getTarih.day &&
        ilan.koltukSayisi == int.parse(koltukSayisi.text) &&
        (int.parse(fiyatMin.text) <= ilan.fiyat &&
            ilan.fiyat <= int.parse(fiyatMax.text)) &&
        ilan.kullaniciAdi != kullaniciKontrol.getSimdikiKullanici.kullaniciAdi;
  }

  // ilan onay sayfasi
  void ilanOnay(BuildContext context, SurucuIlan ilan) {
    final hesap = context.read<HesapVeriYonetimi>();
    // onaylanan ilani onaylayan kisinin gecmisine ekle.
    KullaniciListesi.kullaniciListesi
        .singleWhere(
          (kullanici) =>
              hesap.getSimdikiKullanici.kullaniciAdi == kullanici.kullaniciAdi,
        )
        .yolculuklar!
        .add(
          GecmisYolculuklar(
            kullaniciAdi: ilan.kullaniciAdi,
            surucuCinsiyet: ilan.surucuCinsiyet,
            kalkisYeri: ilan.kalkisYeri,
            varisYeri: ilan.varisYeri,
            tarih: ilan.tarih,
            tahminiYolSuresi: ilan.tahminiYolSuresi,
            koltukSayisi: ilan.koltukSayisi,
            fiyat: ilan.fiyat,
            adres: ilan.adres,
            aciklama: ilan.aciklama,
          ),
        );
    // onaylanan ilani kaldır.
    KullaniciListesi.kullaniciListesi
        .singleWhere(
          (kullanici) => ilan.kullaniciAdi == kullanici.kullaniciAdi,
        )
        .ilanlar!
        .remove(ilan);
  }

  // yorum ekleme dialog
  void yorumuEkleme({
    required BuildContext context,
    required String yazilanYorum,
    required DateTime yorumTarihi,
    required String yorumYapilanKisiAdi,
  }) {
    final hesap = context.read<HesapVeriYonetimi>();
    KullaniciListesi.kullaniciListesi
        .singleWhere(
          (kullanici) => yorumYapilanKisiAdi == kullanici.kullaniciAdi,
        )
        .yorumlar!
        .add(
          Yorumlar(
            yorumYapanKisiAdi: hesap.getSimdikiKullanici.kullaniciAdi,
            yorumYapanKisiCinsiyet: hesap.getSimdikiKullanici.cinsiyet,
            yorumTarihi: yorumTarihi,
            yorum: yazilanYorum,
          ),
        );
  }
}
