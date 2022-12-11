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
      iletisimTel: "(xxx)4533421",
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
      iletisimTel: "(xxx)5516451",
      iletisimWeb: '',
      bio: '',
      yolculuklar: [],
      ilanlar: [],
      yorumlar: [],
    ),
    Kullanici(
      kullaniciAdi: "SerdarCan",
      mail: "SerdarCan13@mail.com",
      sifresi: 'srdrcn13',
      cinsiyet: Cinsiyet.erkek,
      telGizli: false,
      iletisimTel: "(xxx)5579473",
      iletisimWeb: '',
      bio: '',
      yolculuklar: [],
      ilanlar: [],
      yorumlar: [],
    ),
    Kullanici(
      kullaniciAdi: "Omer Faruk",
      mail: "Omer23@gmail.com",
      sifresi: 'omer.omer23',
      cinsiyet: Cinsiyet.erkek,
      telGizli: true,
      iletisimTel: "(xxx)5311481",
      iletisimWeb: '',
      bio: '',
      yolculuklar: [],
      ilanlar: [],
      yorumlar: [],
    ),
  ];
}
