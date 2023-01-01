import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online_otostop/controllers/hesap_veri_yonetimi.dart';
import 'package:online_otostop/units/degismeyen_birimler.dart';
import 'package:online_otostop/view/auth/widgets/kayit_mod_degistirme_yazisi.dart';
import 'package:online_otostop/view/auth/widgets/avatar/kisi_avatari.dart';
import 'package:online_otostop/view/auth/widgets/text_girdi_alani.dart';
import 'package:provider/provider.dart';

import 'widgets/giris_butonu.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  @override
  Widget build(BuildContext context) {
    final hesap = Provider.of<HesapVeriYonetimi>(context, listen: true);
    final theme = Theme.of(context);
    final themeColor = theme.colorScheme;
    return SafeArea(
      child: Scaffold(
        backgroundColor: themeColor.background,
        body: ListView(
          padding: DegismeyenBirimler.varsayilanSimetrikPadding,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  KisiAvatari(themeColor),
                  if (hesap.getKayit)
                    TextGirdiAlani(
                      kontrolcu: hesap.isimTextKontrolcusu,
                      sifreGoster: false,
                      baslikText: "Kullanıcı Adı",
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(15),
                      ],
                      errorKontrol:
                          hesap.kontrolculer[0].values.first == HataTipi.ad,
                      errorText:
                          "Kullanıcı adı uzunluğu 3 karakterden az olamaz!",
                    ),
                  TextGirdiAlani(
                    kontrolcu: hesap.mailTextKontrolcusu,
                    sifreGoster: false,
                    baslikText: "E-Posta",
                    errorKontrol:
                        hesap.kontrolculer[1].values.first == HataTipi.mail,
                    errorText: "Girilen e-posta formatı hatalı!",
                  ),
                  TextGirdiAlani(
                    kontrolcu: hesap.sifreTextKontrolcusu,
                    sifreGoster: hesap.getSifreGoster,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: IconButton(
                        icon: Icon(!hesap.getSifreGoster
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () => hesap.setSifreGoster(),
                      ),
                    ),
                    baslikText: "Şifre",
                    errorKontrol:
                        hesap.kontrolculer[2].values.first == HataTipi.sifre,
                    errorText: "Şifre uzunluğu 6 karakterden az olamaz!",
                  ),
                  const KayitModDegistirmeYazisi(),
                  const SizedBox(height: 42),
                  const GirisButonu(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
