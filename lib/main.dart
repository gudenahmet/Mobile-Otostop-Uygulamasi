import 'package:flutter/material.dart';
import 'package:online_otostop/controllers/BaglantiliProviderYonetimi/birlestirici_provider.dart';
import 'package:online_otostop/controllers/hesap_veri_yonetimi.dart';
import 'package:online_otostop/controllers/BaglantiliProviderYonetimi/musteri_sayfa_yonetimi.dart';
import 'package:online_otostop/controllers/profil_sayfa_yonetimi.dart';
import 'package:online_otostop/controllers/BaglantiliProviderYonetimi/surucu_ilan_ekleme_yonetimi.dart';
import 'package:online_otostop/view/customer/musteri_tercih_sayfasi.dart';
import 'package:online_otostop/view/customer/ilan_arama_sayfasi.dart';
import 'package:online_otostop/view/customer/secilen_ilan_sayfasi.dart';
import 'package:online_otostop/view/driver/ilan_ekleme_sayfasi.dart';
import 'package:online_otostop/view/ana_sayfa.dart';
import 'package:online_otostop/view/profile/profil_sayfasi.dart';
import 'package:provider/provider.dart';
import 'view/auth/hesap_sayfasi.dart';

enum Cinsiyet { erkek, kadin }

enum Kosul { profil, arama }

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HesapVeriYonetimi()),
        ChangeNotifierProvider(create: (context) => SurucuIlanEklemeYonetimi()),
        ChangeNotifierProvider(create: (context) => MusteriSayfaYonetimi()),
        ChangeNotifierProvider(create: (context) => ProfilSayfaYonetimi()),
        ChangeNotifierProvider(create: (context) => BirlestiriciProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Online Otostop',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/GirisSayfasi',
        routes: {
          '/GirisSayfasi': (context) => const Authentication(),
          '/AnaSayfa': (context) => const AnaSayfa(),
          '/ProfilSayfasi': (context) => const ProfilSayfasi(),
          '/IlanEklemeSayfasi': (context) => const IlanEklemeSayfasi(),
          '/IlanAramaSayfasi': (context) => const IlanAramaSayfasi(),
          '/MusteriTercihSayfasi': (context) => const MusteriTercihSayfasi(),
          '/SecilenIlanSayfasi': (context) => const SecilenIlanSayfasi(),
        },
      ),
    );
  }
}
