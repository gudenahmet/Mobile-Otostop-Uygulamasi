import 'package:flutter/material.dart';
import 'package:online_otostop/controllers/hesap_veri_yonetimi.dart';
import 'package:provider/provider.dart';

class KayitModDegistirmeYazisi extends StatelessWidget {
  const KayitModDegistirmeYazisi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hesap = Provider.of<HesapVeriYonetimi>(context, listen: true);
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 8,
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Text(
              hesap.getKayit
                  ? 'Zaten hesabınız var mı?'
                  : 'Henüz bir hesabınız yok mu?',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ),
        Center(
          child: GestureDetector(
            onTap: () {
              hesap.setKayit();
            },
            child: Text(
              hesap.getKayit ? 'Giriş Yap' : 'Kaydol',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
