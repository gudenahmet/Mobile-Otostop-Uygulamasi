import 'package:flutter/widgets.dart';
import 'package:online_otostop/controllers/hesap_veri_yonetimi.dart';
import 'package:online_otostop/models/surucu_ilan.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../models/kullanici.dart';

class ProfilSayfaYonetimi with ChangeNotifier {
  final _kullaniciAdi = TextEditingController();
  final _iletisimTel = TextEditingController();
  final _bio = TextEditingController();
  final _webIletisim = TextEditingController();
  bool _isimGirdileriDogru = false;
  bool _telGizli = true;

  // getters
  TextEditingController get getKullaniciAdi => _kullaniciAdi;
  TextEditingController get getIletisimTel => _iletisimTel;
  TextEditingController get getWebIletisim => _webIletisim;
  TextEditingController get getBio => _bio;
  bool get getTelGizli => _telGizli;
  bool get getIsimGirdileriDogru => _isimGirdileriDogru;

  set setTelGizli(bool condition) {
    _telGizli = condition;
  }

  set setIsimGirdileriDogru(bool condition) {
    _isimGirdileriDogru = condition;
  }

  void telGizliDegis() {
    _telGizli = !_telGizli;
    notifyListeners();
  }

  String profilFotosu(Cinsiyet cinsiyet) {
    return cinsiyet.name == 'erkek'
        ? 'lib/images/man.png'
        : 'lib/images/woman.png';
  }

  Kullanici getkullanici(String kullaniciAdi) {
    return KullaniciListesi.kullaniciListesi
        .singleWhere((kullanici) => kullanici.kullaniciAdi == kullaniciAdi);
  }

  bool kullaniciAyni(
    BuildContext context,
    Kullanici kullaniciVerisi,
  ) {
    return kullaniciVerisi.kullaniciAdi ==
        context.read<HesapVeriYonetimi>().getSimdikiKullanici.kullaniciAdi;
  }

  String bulunamadiText(String tag) {
    switch (tag) {
      case 'İlanlar':
        return 'İlan bulunamadı!';
      case 'Yolculuklar':
        return 'Yolculuk bulunamadı!';
      case 'Yorumlar':
        return 'Yorum bulunamadı!';
      default:
        return '';
    }
  }

  List<SurucuIlan> tecrubeTipi(String tag, String kullaniciAdi) {
    switch (tag) {
      case 'İlanlar':
        return getkullanici(kullaniciAdi).ilanlar!;
      case 'Yolculuklar':
        return getkullanici(kullaniciAdi).yolculuklar!;
      default:
        return [];
    }
  }

  void isimGirdileriKontrolu() {
    if (getKullaniciAdi.text.isNotEmpty && getKullaniciAdi.text.length >= 3) {
      setIsimGirdileriDogru = true;
    } else {
      setIsimGirdileriDogru = false;
    }
    notifyListeners();
  }

  void ismiGuncelle(BuildContext context) {
    var hesap = context.read<HesapVeriYonetimi>();
    for (var kullanici in KullaniciListesi.kullaniciListesi) {
      if (kullanici.yolculuklar!.any((yolculuk) =>
          yolculuk.kullaniciAdi == hesap.getSimdikiKullanici.kullaniciAdi)) {
        kullanici.yolculuklar!
            .where((yolculuk) =>
                yolculuk.kullaniciAdi == hesap.getSimdikiKullanici.kullaniciAdi)
            .forEach((item) {
          item.kullaniciAdi = getKullaniciAdi.text;
        });
      }
      for (var element in kullanici.ilanlar!) {
        print(element.kullaniciAdi);
      }
      if (kullanici.ilanlar!.any((ilan) =>
          ilan.kullaniciAdi == hesap.getSimdikiKullanici.kullaniciAdi)) {
        kullanici.ilanlar!
            .where((ilan) =>
                ilan.kullaniciAdi == hesap.getSimdikiKullanici.kullaniciAdi)
            .forEach((item) {
          item.kullaniciAdi = getKullaniciAdi.text;
        });
      }
      if (kullanici.yorumlar!.any((yorum) =>
          yorum.yorumYapanKisiAdi == hesap.getSimdikiKullanici.kullaniciAdi)) {
        kullanici.yorumlar!
            .where((yorum) =>
                yorum.yorumYapanKisiAdi ==
                hesap.getSimdikiKullanici.kullaniciAdi)
            .forEach((item) {
          item.yorumYapanKisiAdi = getKullaniciAdi.text;
        });
      }
      if (kullanici.kullaniciAdi == hesap.getSimdikiKullanici.kullaniciAdi) {
        kullanici.kullaniciAdi = getKullaniciAdi.text;
      }
    }
    notifyListeners();
  }
}
