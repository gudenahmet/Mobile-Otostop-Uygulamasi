import 'package:flutter/material.dart';
import 'package:online_otostop/controllers/hesap_veri_yonetimi.dart';
import 'package:provider/provider.dart';

class ProfilSayfasi extends StatelessWidget {
  const ProfilSayfasi({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hesap = Provider.of<HesapVeriYonetimi>(context, listen: true);
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(),
            Text(hesap.getKullaniciProfil.kullaniciAdi),
          ],
        ),
      ),
    );
  }
}
