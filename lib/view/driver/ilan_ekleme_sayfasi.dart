import 'package:flutter/material.dart';
import 'package:online_otostop/controllers/BaglantiliProviderYonetimi/surucu_ilan_ekleme_yonetimi.dart';
import 'package:online_otostop/view/widgets/girdi_alani.dart';
import 'package:online_otostop/view/widgets/konum_listesi.dart';
import 'package:online_otostop/view/driver/widgets/yayinla_butonu.dart';
import 'package:provider/provider.dart';

class IlanEklemeSayfasi extends StatelessWidget {
  const IlanEklemeSayfasi({super.key});

  @override
  Widget build(BuildContext context) {
    final ilan = Provider.of<SurucuIlanEklemeYonetimi>(context, listen: true);
    final theme = Theme.of(context);
    final themeColor = theme.colorScheme;
    return SafeArea(
      child: Scaffold(
        backgroundColor: themeColor.background,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              ilan.ilanGirdileriVeDegiskenleriSifirla();
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: const Text("İlan Ekle"),
          centerTitle: true,
        ),
        body: Center(
          child: ListView(
            children: [
              Column(
                children: [
                  Column(
                    children: [
                      GirdiAlani(
                        baslikText: 'Kalkış Yeri',
                        textAlign: 'center',
                        textInputType: TextInputType.text,
                        readOnly: false,
                        kontrolcu: ilan.kalkisYeri,
                        focusNode: ilan.kalkisYeriFocus,
                        textAlanGenisligi: 150,
                        textAlanYuksekligi: 50,
                        maxSatirSayisi: 1,
                        onTap: () {
                          ilan.setKalkisYeriSecili = false;
                          ilan.kalkisYeri.clear();
                        },
                        onChanged: (_) {
                          ilan.bilgiGirdilerikontrolu();
                          ilan.uyusanKonumlar(ilan.kalkisYeri);
                        },
                      ),
                      if (ilan.kalkisYeri.text.isNotEmpty &&
                          !ilan.getKalkisYeriSecili)
                        const KonumListesi(yer: 'kalkis', tag: 'ilan'),
                    ],
                  ),
                  Column(
                    children: [
                      GirdiAlani(
                        baslikText: 'Varış Yeri',
                        textAlign: 'center',
                        textInputType: TextInputType.text,
                        readOnly: false,
                        kontrolcu: ilan.varisYeri,
                        focusNode: ilan.varisYeriFocus,
                        textAlanGenisligi: 150,
                        textAlanYuksekligi: 50,
                        maxSatirSayisi: 1,
                        onTap: () {
                          ilan.setVarisYeriSecili = false;
                          ilan.varisYeri.clear();
                        },
                        onChanged: (_) {
                          ilan.bilgiGirdilerikontrolu();
                          ilan.uyusanKonumlar(ilan.varisYeri);
                        },
                      ),
                      if (ilan.varisYeri.text.isNotEmpty &&
                          !ilan.getVarisYeriSecili)
                        const KonumListesi(yer: 'varis', tag: 'ilan'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GirdiAlani(
                        baslikText: 'Tarih',
                        textAlign: 'center',
                        textInputType: TextInputType.text,
                        readOnly: true,
                        kontrolcu: ilan.tarih,
                        textAlanGenisligi: 120,
                        textAlanYuksekligi: 60,
                        maxSatirSayisi: 1,
                        onTap: () {
                          ilan.tarihSecimi(context);
                        },
                      ),
                      GirdiAlani(
                        baslikText: 'Koltuk Sayısı',
                        textAlign: 'center',
                        textInputType: TextInputType.number,
                        readOnly: false,
                        kontrolcu: ilan.koltukSayisi,
                        textAlanGenisligi: 120,
                        textAlanYuksekligi: 60,
                        maxSatirSayisi: 1,
                        onChanged: (_) {
                          ilan.bilgiGirdilerikontrolu();
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      GirdiAlani(
                        baslikText: 'Tahmini Saat',
                        textAlign: 'center',
                        textInputType: TextInputType.number,
                        readOnly: false,
                        kontrolcu: ilan.tahminiSaat,
                        textAlanGenisligi: 120,
                        textAlanYuksekligi: 60,
                        maxSatirSayisi: 1,
                        onChanged: (_) {
                          ilan.bilgiGirdilerikontrolu();
                        },
                      ),
                      GirdiAlani(
                        baslikText: 'Fiyat',
                        textAlign: 'center',
                        textInputType: TextInputType.number,
                        readOnly: false,
                        kontrolcu: ilan.fiyat,
                        textAlanGenisligi: 120,
                        textAlanYuksekligi: 60,
                        maxSatirSayisi: 1,
                        onChanged: (_) {
                          ilan.bilgiGirdilerikontrolu();
                        },
                      ),
                    ],
                  ),
                  GirdiAlani(
                    baslikText: 'Adres',
                    textAlign: 'start',
                    textInputType: TextInputType.text,
                    readOnly: false,
                    kontrolcu: ilan.adres,
                    textAlanGenisligi: 350,
                    textAlanYuksekligi: 150,
                    maxSatirSayisi: 3,
                    maxKarakterSayisi: 300,
                    onChanged: (_) {
                      ilan.bilgiGirdilerikontrolu();
                    },
                  ),
                  GirdiAlani(
                    baslikText: 'Açıklama',
                    textAlign: 'start',
                    textInputType: TextInputType.text,
                    readOnly: false,
                    kontrolcu: ilan.aciklama,
                    textAlanGenisligi: 350,
                    textAlanYuksekligi: 150,
                    maxSatirSayisi: 3,
                    maxKarakterSayisi: 300,
                    onChanged: (_) {
                      ilan.bilgiGirdilerikontrolu();
                    },
                  ),
                  const YayinlaButonu(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
