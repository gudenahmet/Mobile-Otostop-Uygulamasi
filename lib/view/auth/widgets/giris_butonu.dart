import 'package:flutter/material.dart';
import 'package:online_otostop/controllers/hesap_veri_yonetimi.dart';
import 'package:online_otostop/units/degismeyen_birimler.dart';
import 'package:provider/provider.dart';

class GirisButonu extends StatelessWidget {
  const GirisButonu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hesap = Provider.of<HesapVeriYonetimi>(context);
    final theme = Theme.of(context);
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          hesap.getHepsiDolu
              ? theme.colorScheme.primary
              : theme.colorScheme.secondaryContainer,
        ),
        //overlayColor: MaterialStateProperty.all(themeColor.primary),
      ),
      onPressed: hesap.getHepsiDolu && hesap.getGirdilerHatasiz
          ? () {
              if (hesap.getKayit) {
                hesap.kayit(context);
              } else {
                hesap.giris(context);
              }
            }
          : null,
      child: Padding(
        padding: DegismeyenBirimler.varsayilanSimetrikPadding,
        child: Text(
          hesap.getKayit ? 'Kaydol' : 'Giriş Yap',
          style: theme.textTheme.labelLarge!.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.background,
          ),
        ),
      ),
    );
  }
}
