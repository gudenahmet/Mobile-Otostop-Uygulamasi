import 'package:flutter/material.dart';
import 'package:online_otostop/controllers/BaglantiliProviderYonetimi/birlestirici_provider.dart';
import 'package:provider/provider.dart';

class KonumListesi extends StatelessWidget {
  final String yer;
  final String tag;
  const KonumListesi({
    Key? key,
    required this.yer,
    required this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    final provider =
        context.read<BirlestiriciProvider>().lazimOlanProvider(context, tag);
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
          itemCount: provider.uyusanKonumListesi.length,
          itemBuilder: (context, index) => ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(150, 50),
            ),
            onPressed: () {
              if (yer == 'kalkis') {
                provider.kalkisYeri.text = provider.uyusanKonumListesi[index];
                provider.setKalkisYeriSecili = true;
                provider.kalkisYeriFocus.unfocus();
                provider.uyusanKonumListesi.clear();
              }
              if (yer == 'varis') {
                provider.varisYeri.text = provider.uyusanKonumListesi[index];
                provider.setVarisYeriSecili = true;
                provider.varisYeriFocus.unfocus();
                provider.uyusanKonumListesi.clear();
              }
            },
            child: Center(
              child: Text(provider.uyusanKonumListesi[index]),
            ),
          ),
        ),
      ),
    );
  }
}
