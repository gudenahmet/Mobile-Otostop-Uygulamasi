import 'package:flutter/material.dart';
import 'package:online_otostop/controllers/BaglantiliProviderYonetimi/surucu_ilan_ekleme_yonetimi.dart';
import 'package:provider/provider.dart';
import '../../../units/degismeyen_birimler.dart';

class YayinlaButonu extends StatelessWidget {
  const YayinlaButonu({super.key});

  @override
  Widget build(BuildContext context) {
    final ilan = Provider.of<SurucuIlanEklemeYonetimi>(context, listen: true);
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            ilan.getHepsiDolu &&
                    ilan.getKalkisYeriSecili &&
                    ilan.getVarisYeriSecili
                ? theme.colorScheme.primary
                : theme.colorScheme.primary.withOpacity(0.4),
          ),
        ),
        onPressed: ilan.getHepsiDolu &&
                ilan.getKalkisYeriSecili &&
                ilan.getVarisYeriSecili
            ? () {
                ilan.ilaniEkle(context);
              }
            : null,
        child: Padding(
          padding: DegismeyenBirimler.varsayilanPaddingHepsi / 2,
          child: Text(
            'Yayınla',
            style: theme.textTheme.labelLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
