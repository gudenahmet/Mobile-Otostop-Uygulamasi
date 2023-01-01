import 'package:flutter/widgets.dart';
import 'package:online_otostop/controllers/hesap_veri_yonetimi.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../models/kullanici.dart';

class ProfilSayfaYonetimi with ChangeNotifier {
  final _kullaniciAdi = TextEditingController();
  final _iletisimTel = TextEditingController();
  final _bio = TextEditingController();
  final _webIletisim = TextEditingController();
  bool _telGizli = true;

  // getters
  TextEditingController get getKullaniciAdi => _kullaniciAdi;
  TextEditingController get getIletisimTel => _iletisimTel;
  TextEditingController get getWebIletisim => _webIletisim;
  TextEditingController get getBio => _bio;
  bool get getTelGizli => _telGizli;

  set setTelGizli(bool condition) {
    _telGizli = condition;
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

  List<dynamic> tecrubeTipi(String tag, String kullaniciAdi) {
    switch (tag) {
      case 'İlanlar':
        return getkullanici(kullaniciAdi).ilanlar!;
      case 'Yolculuklar':
        return getkullanici(kullaniciAdi).yolculuklar!;
      default:
        return [];
    }
  }
}
