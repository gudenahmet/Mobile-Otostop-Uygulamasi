import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:online_otostop/controllers/surucu_ilan_ekleme_yonetimi.dart';

class KonumListesi extends StatelessWidget {
  final String yer;
  const KonumListesi({
    Key? key,
    required this.yer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    final ilan = Provider.of<SurucuIlanEklemeYonetimi>(context, listen: true);
    return Container(
      constraints: const BoxConstraints(
        minHeight: 0,
        maxHeight: 200,
        minWidth: 0,
        maxWidth: 150,
      ),
      child: RawScrollbar(
        controller: scrollController,
        thumbVisibility: true,
        thickness: 6,
        thumbColor: Colors.grey[700],
        minThumbLength: 30,
        radius: const Radius.circular(30),
        child: ListView.builder(
          shrinkWrap: true,
          controller: scrollController,
          itemCount: ilan.uyusanKonumListesi.length,
          itemBuilder: (context, index) => ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(150, 50),
            ),
            onPressed: () {
              if (yer == 'kalkis') {
                ilan.kalkisYeri.text = ilan.uyusanKonumListesi[index];
                ilan.setKalkisYeriSecili = true;
                ilan.kalkisYeriFocus.unfocus();
                ilan.uyusanKonumListesi.clear();
              }
              if (yer == 'varis') {
                ilan.varisYeri.text = ilan.uyusanKonumListesi[index];
                ilan.setVarisYeriSecili = true;
                ilan.varisYeriFocus.unfocus();
                ilan.uyusanKonumListesi.clear();
              }
            },
            child: Center(
              child: Text(ilan.uyusanKonumListesi[index]),
            ),
          ),
        ),
      ),
    );
  }
}
