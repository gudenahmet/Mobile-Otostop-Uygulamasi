import 'package:flutter/widgets.dart';
import 'package:online_otostop/main.dart';
import 'package:online_otostop/models/kullanici.dart';
import 'package:online_otostop/units/degismeyen_birimler.dart';

enum HataTipi { ad, mail, sifre, yok }

class HesapVeriYonetimi with ChangeNotifier {
  // degiskenler
  // _ basinda isaretine sahip olan degiskenler private demek yani getter setter fonksiyonlari olmadan baska dosyadan ulasilamaz!
  final List<Kullanici> _kullanicilar = KullaniciListesi.kullaniciListesi;
  late Kullanici _simdikiKullanici;
  late Kullanici _kullaniciProfil;
  // TextEditingController kullanici girdilerini alip kullanmamizi saglar
  List<Map<TextEditingController, HataTipi>> kontrolculer = [
    {TextEditingController(): HataTipi.yok},
    {TextEditingController(): HataTipi.yok},
    {TextEditingController(): HataTipi.yok},
  ];
  Cinsiyet _cinsiyet = Cinsiyet.erkek;
  bool _kayit = false;
  bool _sifreGoster = false;
  bool _hepsiDolu = false;
  bool _girdilerHatasiz = false;
  String _geriBildirimMesaji = '';

  // getter fonksiyonlari (degisken degerine ulasmayi saglar)
  List<Kullanici> get getKullanicilar => _kullanicilar;
  Kullanici get getSimdikiKullanici => _simdikiKullanici;
  Kullanici get getKullaniciProfil => _kullaniciProfil;
  Cinsiyet get getCinsiyet => _cinsiyet;
  bool get getKayit => _kayit;
  bool get getSifreGoster => _sifreGoster;
  bool get getHepsiDolu => _hepsiDolu;
  bool get getGirdilerHatasiz => _girdilerHatasiz;
  TextEditingController get isimTextKontrolcusu => kontrolculer[0].keys.first;
  TextEditingController get mailTextKontrolcusu => kontrolculer[1].keys.first;
  TextEditingController get sifreTextKontrolcusu => kontrolculer[2].keys.first;
  String get getGeriBildirimMesaji => _geriBildirimMesaji;
  // setter fonksiyonlari (degisken degerini degistirmeyi saglar)

  set setSimdikiKullanici(Kullanici kullanici) {
    _simdikiKullanici = kullanici;
  }

  set setKullaniciProfil(Kullanici kullanici) {
    _kullaniciProfil = kullanici;
  }

  set setCinsiyet(Cinsiyet cinsiyet) {
    _cinsiyet = cinsiyet;
    notifyListeners();
  }

  // fonksiyonlar

  void setKayit() {
    _kayit = !_kayit;
    notifyListeners();
  }

  void setSifreGoster() {
    _sifreGoster = !_sifreGoster;
    notifyListeners();
  }

  String girisProfilFotosu() {
    return _cinsiyet == Cinsiyet.erkek
        ? './lib/images/man.png'
        : './lib/images/woman.png';
  }

  void bilgiGirdilerikontrolu() {
    // bu fonksiyon herhangi bi durumda girdiler bos ise giris butonunu devre disi birakir.
    if (_kayit) {
      if (isimTextKontrolcusu.text.isEmpty ||
          mailTextKontrolcusu.text.isEmpty ||
          sifreTextKontrolcusu.text.isEmpty) {
        _hepsiDolu = false;
        notifyListeners();
      } else {
        _hepsiDolu = true;
        notifyListeners();
      }
    } else {
      if (mailTextKontrolcusu.text.isEmpty ||
          sifreTextKontrolcusu.text.isEmpty) {
        _hepsiDolu = false;
        notifyListeners();
      } else {
        _hepsiDolu = true;
        notifyListeners();
      }
    }
  }

  void girdiKontrolu() {
    _girdilerHatasiz = true;
    for (var kontrolcu in kontrolculer) {
      // tum kontrolcu hata tiplerini sifirla
      kontrolcu.update(kontrolcu.keys.first, (value) => HataTipi.yok);
    }
    // Kosula uymayan kontrolcu verisi mevcut ise hata tiplerini guncelle
    if (isimTextKontrolcusu.text.length < 3 &&
        isimTextKontrolcusu.text.isNotEmpty) {
      kontrolculer[0].update(isimTextKontrolcusu, (value) => HataTipi.ad);
      _girdilerHatasiz = false;
    }
    if (!mailTextKontrolcusu.text.contains('@') &&
        mailTextKontrolcusu.text.isNotEmpty) {
      kontrolculer[1].update(mailTextKontrolcusu, (value) => HataTipi.mail);
      _girdilerHatasiz = false;
    }
    if (sifreTextKontrolcusu.text.length < 6 &&
        sifreTextKontrolcusu.text.isNotEmpty) {
      kontrolculer[2].update(sifreTextKontrolcusu, (value) => HataTipi.sifre);
      _girdilerHatasiz = false;
    }
    notifyListeners();
  }

  void giris(BuildContext context) {
    if (mailMevcutDegil()) {
      _geriBildirimMesaji = 'Bu mail bulunamadı!';
      DegismeyenBirimler.showSnackbar(context, _geriBildirimMesaji);
      return;
    }
    if (sifreMevcutDegil()) {
      _geriBildirimMesaji = 'Girilen şifre hatalı!';
      DegismeyenBirimler.showSnackbar(context, _geriBildirimMesaji);
      return;
    }
    _geriBildirimMesaji = 'Başarıyla giriş yapıldı.';
    _simdikiKullanici = KullaniciListesi.kullaniciListesi.firstWhere(
        (kullanici) =>
            kullanici.mail == mailTextKontrolcusu.text &&
            kullanici.sifresi == sifreTextKontrolcusu.text);
    _girisBasarili(context, _geriBildirimMesaji);
    setKullaniciProfil = _simdikiKullanici;
  }

  void kayit(BuildContext context) {
    if (isimZatenMevcut() && mailZatenMevcut()) {
      _geriBildirimMesaji = 'Bu isim ve mail zaten mevcut!';
      DegismeyenBirimler.showSnackbar(context, _geriBildirimMesaji);
      return;
    }
    if (isimZatenMevcut()) {
      _geriBildirimMesaji = 'Bu isim zaten mevcut!';
      DegismeyenBirimler.showSnackbar(context, _geriBildirimMesaji);
      return;
    }
    if (mailZatenMevcut()) {
      _geriBildirimMesaji = 'Bu mail zaten mevcut!';
      DegismeyenBirimler.showSnackbar(context, _geriBildirimMesaji);
      return;
    }
    _geriBildirimMesaji = 'Başarıyla kayıt yapıldı.';
    setSimdikiKullanici = Kullanici(
      kullaniciAdi: isimTextKontrolcusu.text,
      mail: mailTextKontrolcusu.text,
      sifresi: sifreTextKontrolcusu.text,
      cinsiyet: _cinsiyet,
      telGizli: true,
    );
    KullaniciListesi.kullaniciListesi.add(getSimdikiKullanici);
    setKullaniciProfil = _simdikiKullanici;
    _girisBasarili(context, _geriBildirimMesaji);
  }

  bool mailMevcutDegil() {
    return KullaniciListesi.kullaniciListesi.any(
            (kisi) => kisi.mail.contains(mailTextKontrolcusu.text.trim())) ==
        false;
  }

  bool sifreMevcutDegil() {
    return KullaniciListesi.kullaniciListesi
            .firstWhere(
                (kisi) => kisi.mail.contains(mailTextKontrolcusu.text.trim()))
            .sifresi !=
        sifreTextKontrolcusu.text;
  }

  bool isimZatenMevcut() {
    return KullaniciListesi.kullaniciListesi.any(
        (kisi) => kisi.kullaniciAdi.contains(isimTextKontrolcusu.text.trim()));
  }

  bool mailZatenMevcut() {
    return KullaniciListesi.kullaniciListesi
        .any((kisi) => kisi.mail.contains(mailTextKontrolcusu.text.trim()));
  }

  void _girisBasarili(BuildContext context, String mesaj) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/AnaSayfa', (Route<dynamic> route) => false)
        .then((_) {
      DegismeyenBirimler.showSnackbar(context, mesaj);
    });
  }
}
