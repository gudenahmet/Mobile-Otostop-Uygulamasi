import 'package:flutter/material.dart';
import 'package:online_otostop/controllers/hesap_veri_yonetimi.dart';
import 'package:online_otostop/units/degismeyen_birimler.dart';
import 'package:provider/provider.dart';
import 'cinsiyet_secimi.dart';

class KisiAvatari extends StatelessWidget {
  final ColorScheme themeColor;
  const KisiAvatari(this.themeColor, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hesap = Provider.of<HesapVeriYonetimi>(context);
    return hesap.getKayit
        ? Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                hesap.girisProfilFotosu(),
                height: 128,
                width: 128,
              ),
              Padding(
                padding: DegismeyenBirimler.varsayilanPaddingHepsi * 2,
                child: CinsiyetSecimi(themeColor: themeColor),
              ),
            ],
          )
        : Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Image.asset(
              'lib/images/user.png',
              color: themeColor.primary,
              height: 128,
              width: 128,
            ),
          );
  }
}
