import 'package:flutter/material.dart';
import 'package:online_otostop/controllers/BaglantiliProviderYonetimi/musteri_sayfa_yonetimi.dart';
import 'package:online_otostop/view/customer/widgets/filtrele_butonu.dart';
import 'package:provider/provider.dart';
import '../widgets/konum_listesi.dart';
import '../widgets/girdi_alani.dart';

class MusteriTercihSayfasi extends StatelessWidget {
  const MusteriTercihSayfasi({super.key});

  @override
  Widget build(BuildContext context) {
    final filtre = Provider.of<MusteriSayfaYonetimi>(context, listen: true);
    final theme = Theme.of(context);
    final themeColor = theme.colorScheme;
    return SafeArea(
      child: Scaffold(
        backgroundColor: themeColor.background,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              filtre.degiskenleriSifirla();
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: const Text("Tercih Belirleme Sayfası"),
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
                        kontrolcu: filtre.kalkisYeri,
                        focusNode: filtre.kalkisYeriFocus,
                        textAlanGenisligi: 150,
                        textAlanYuksekligi: 50,
                        maxSatirSayisi: 1,
                        onTap: () {
                          filtre.setKalkisYeriSecili = false;
                          filtre.kalkisYeri.clear();
                        },
                        onChanged: (_) {
                          filtre.bilgiGirdilerikontrolu();
                          filtre.uyusanKonumlar(filtre.kalkisYeri);
                        },
                      ),
                      if (filtre.kalkisYeri.text.isNotEmpty &&
                          !filtre.getKalkisYeriSecili)
                        const KonumListesi(yer: 'kalkis', tag: 'filtre'),
                    ],
                  ),
                  Column(
                    children: [
                      GirdiAlani(
                        baslikText: 'Varış Yeri',
                        textAlign: 'center',
                        textInputType: TextInputType.text,
                        readOnly: false,
                        kontrolcu: filtre.varisYeri,
                        focusNode: filtre.varisYeriFocus,
                        textAlanGenisligi: 150,
                        textAlanYuksekligi: 50,
                        maxSatirSayisi: 1,
                        onTap: () {
                          filtre.setVarisYeriSecili = false;
                          filtre.varisYeri.clear();
                        },
                        onChanged: (_) {
                          filtre.bilgiGirdilerikontrolu();
                          filtre.uyusanKonumlar(filtre.varisYeri);
                        },
                      ),
                      if (filtre.varisYeri.text.isNotEmpty &&
                          !filtre.getVarisYeriSecili)
                        const KonumListesi(yer: 'varis', tag: 'filtre'),
                    ],
                  ),
                  GirdiAlani(
                    baslikText: 'Tarih',
                    textAlign: 'center',
                    textInputType: TextInputType.text,
                    readOnly: true,
                    kontrolcu: filtre.tarih,
                    textAlanGenisligi: 120,
                    textAlanYuksekligi: 60,
                    maxSatirSayisi: 1,
                    onTap: () {
                      filtre.tarihSecimi(context);
                    },
                  ),
                  GirdiAlani(
                    baslikText: 'Kişi Sayısı',
                    textAlign: 'center',
                    textInputType: TextInputType.number,
                    readOnly: false,
                    kontrolcu: filtre.koltukSayisi,
                    textAlanGenisligi: 120,
                    textAlanYuksekligi: 60,
                    maxSatirSayisi: 1,
                    onChanged: (_) {
                      filtre.bilgiGirdilerikontrolu();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GirdiAlani(
                          baslikText: 'Minimum Fiyat',
                          textAlign: 'center',
                          textInputType: TextInputType.number,
                          readOnly: false,
                          kontrolcu: filtre.fiyatMin,
                          textAlanGenisligi: 120,
                          textAlanYuksekligi: 60,
                          maxSatirSayisi: 1,
                          onChanged: (_) {
                            filtre.bilgiGirdilerikontrolu();
                            filtre.fiyatGirdileriKontrolu();
                          },
                        ),
                        GirdiAlani(
                          baslikText: 'Maximum Fiyat',
                          textAlign: 'center',
                          textInputType: TextInputType.number,
                          readOnly: false,
                          kontrolcu: filtre.fiyatMax,
                          textAlanGenisligi: 120,
                          textAlanYuksekligi: 60,
                          maxSatirSayisi: 1,
                          onChanged: (_) {
                            filtre.bilgiGirdilerikontrolu();
                            filtre.fiyatGirdileriKontrolu();
                          },
                        ),
                      ],
                    ),
                  ),
                  const FiltreleButonu(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
