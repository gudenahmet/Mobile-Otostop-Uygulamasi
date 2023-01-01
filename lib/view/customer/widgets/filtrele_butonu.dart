import 'package:flutter/material.dart';
import 'package:online_otostop/controllers/BaglantiliProviderYonetimi/musteri_sayfa_yonetimi.dart';
import 'package:provider/provider.dart';
import '../../../units/degismeyen_birimler.dart';

class FiltreleButonu extends StatelessWidget {
  const FiltreleButonu({super.key});

  @override
  Widget build(BuildContext context) {
    final filtrele = Provider.of<MusteriSayfaYonetimi>(context, listen: true);
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            filtrele.getHepsiDolu &&
                    filtrele.getKalkisYeriSecili &&
                    filtrele.getVarisYeriSecili &&
                    filtrele.getFiyatGirdileriDogru
                ? theme.colorScheme.primary
                : theme.colorScheme.primary.withOpacity(0.4),
          ),
        ),
        onPressed: filtrele.getHepsiDolu &&
                filtrele.getKalkisYeriSecili &&
                filtrele.getVarisYeriSecili &&
                filtrele.getFiyatGirdileriDogru
            ? () {
                filtrele.ilanlariFiltrele(context);
                if (filtrele.filtreliIlanlar.isEmpty) {
                  DegismeyenBirimler.showSnackbar(
                      context, 'Girilen değerlerle ilan Bulunamadı!');
                } else {
                  Navigator.of(context).pushNamed('/IlanAramaSayfasi');
                }
              }
            : null,
        child: Padding(
          padding: DegismeyenBirimler.varsayilanPaddingHepsi / 2,
          child: Text(
            'Filtrele',
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
