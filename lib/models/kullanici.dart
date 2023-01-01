import 'package:online_otostop/main.dart';
import 'package:online_otostop/models/gecmis_yolculuklar.dart';
import 'package:online_otostop/models/surucu_ilan.dart';
import 'package:online_otostop/models/yorumlar.dart';

class Kullanici {
  String kullaniciAdi;
  String mail;
  String sifresi;
  Cinsiyet cinsiyet;
  String? iletisimTel = '';
  bool telGizli;
  String? iletisimWeb = '';
  String? bio = '';
  List<GecmisYolculuklar>? yolculuklar = [];
  List<SurucuIlan>? ilanlar = [];
  List<Yorumlar>? yorumlar = [];

  Kullanici({
    required this.kullaniciAdi,
    required this.mail,
    required this.sifresi,
    required this.cinsiyet,
    this.iletisimTel,
    required this.telGizli,
    this.iletisimWeb,
    this.bio,
    this.yolculuklar,
    this.ilanlar,
    this.yorumlar,
  });
}

class KullaniciListesi {
  static final List<Kullanici> kullaniciListesi = [
    // fake data kullanicilar
    Kullanici(
      kullaniciAdi: "Furkan32",
      mail: "Furkan32@hotmail.com",
      sifresi: 'asdasd.12',
      cinsiyet: Cinsiyet.erkek,
      telGizli: false,
      iletisimTel: "xxx4533421",
      iletisimWeb: '',
      bio: '',
      yolculuklar: [],
      ilanlar: [],
      yorumlar: [],
    ),

    Kullanici(
      kullaniciAdi: "Pelinsu",
      mail: "Pelinsu@hotmail.com",
      sifresi: 'pelin.pelin123',
      cinsiyet: Cinsiyet.kadin,
      telGizli: true,
      iletisimTel: "xxx5516451",
      iletisimWeb: '',
      bio: '',
      yolculuklar: [],
      ilanlar: [
        SurucuIlan(
          kullaniciAdi: "Pelinsu",
          surucuCinsiyet: Cinsiyet.kadin,
          kalkisYeri: 'İstanbul',
          varisYeri: 'Adana',
          tarih: DateTime.now(),
          tahminiYolSuresi: 12,
          koltukSayisi: 3,
          fiyat: 700,
          adres: 'dddddddddddddddddddddddddddddddddddddddddddddddddddddddd',
          aciklama: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
        ),
        SurucuIlan(
          kullaniciAdi: "Pelinsu",
          surucuCinsiyet: Cinsiyet.kadin,
          kalkisYeri: 'İstanbul',
          varisYeri: 'Ankara',
          tarih: DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day + 1,
          ),
          tahminiYolSuresi: 6,
          koltukSayisi: 2,
          fiyat: 500,
          adres: 'dddddddddddddddddddddddddddddddddddddddddddddddddddddddd',
          aciklama: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
        ),
        SurucuIlan(
          kullaniciAdi: "Pelinsu",
          surucuCinsiyet: Cinsiyet.kadin,
          kalkisYeri: 'Çanakkale',
          varisYeri: 'Adana',
          tarih: DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day + 2,
          ),
          tahminiYolSuresi: 5,
          koltukSayisi: 1,
          fiyat: 300,
          adres: 'dddddddddddddddddddddddddddddddddddddddddddddddddddddddd',
          aciklama: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
        ),
      ],
      yorumlar: [],
    ),
    Kullanici(
      kullaniciAdi: "SerdarCan",
      mail: "SerdarCan13@mail.com",
      sifresi: 'srdrcn13',
      cinsiyet: Cinsiyet.erkek,
      telGizli: false,
      iletisimTel: "xxx5579473",
      iletisimWeb: '',
      bio: '',
      yolculuklar: [],
      ilanlar: [
        SurucuIlan(
          kullaniciAdi: "SerdarCan",
          surucuCinsiyet: Cinsiyet.erkek,
          kalkisYeri: 'İstanbul',
          varisYeri: 'Adana',
          tarih: DateTime.now(),
          tahminiYolSuresi: 10,
          koltukSayisi: 3,
          fiyat: 800,
          adres: 'DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD',
          aciklama: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
        ),
      ],
      yorumlar: [],
    ),
    Kullanici(
      kullaniciAdi: "Omer Faruk",
      mail: "Omer23@gmail.com",
      sifresi: 'omer.omer23',
      cinsiyet: Cinsiyet.erkek,
      telGizli: true,
      iletisimTel: "xxx5311481",
      iletisimWeb: '',
      bio: '',
      yolculuklar: [],
      ilanlar: [
        SurucuIlan(
          kullaniciAdi: "Omer Faruk",
          surucuCinsiyet: Cinsiyet.erkek,
          kalkisYeri: 'İstanbul',
          varisYeri: 'Adana',
          tarih: DateTime.now(),
          tahminiYolSuresi: 9,
          koltukSayisi: 3,
          fiyat: 850,
          adres: 'DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD',
          aciklama: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
        ),
      ],
      yorumlar: [],
    ),
  ];
}
