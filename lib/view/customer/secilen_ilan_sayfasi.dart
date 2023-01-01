import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:online_otostop/controllers/BaglantiliProviderYonetimi/musteri_sayfa_yonetimi.dart';
import 'package:online_otostop/controllers/profil_sayfa_yonetimi.dart';
import 'package:online_otostop/models/surucu_ilan.dart';
import 'package:online_otostop/view/widgets/girdi_alani.dart';
import 'package:provider/provider.dart';

import '../../units/degismeyen_birimler.dart';

class SecilenIlanSayfasi extends StatefulWidget {
  const SecilenIlanSayfasi({super.key});

  @override
  State<SecilenIlanSayfasi> createState() => _SecilenIlanSayfasiState();
}

class _SecilenIlanSayfasiState extends State<SecilenIlanSayfasi> {
  final simdikiIlanAdres = TextEditingController();
  final simdikiIlanAciklama = TextEditingController();
  late final SurucuIlan ilan;
  bool tekSeferlik = true;

  @override
  void didChangeDependencies() {
    if (tekSeferlik) {
      ilan = ModalRoute.of(context)!.settings.arguments as SurucuIlan;
      simdikiIlanAdres.text = ilan.adres;
      simdikiIlanAciklama.text = ilan.aciklama;
      tekSeferlik = false;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    simdikiIlanAciklama.dispose();
    simdikiIlanAdres.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final profil = context.read<ProfilSayfaYonetimi>();
    final musteri = context.read<MusteriSayfaYonetimi>();
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
            '${ilan.kalkisYeri.toUpperCase()}-${ilan.varisYeri.toUpperCase()}'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(
                        DegismeyenBirimler.varsayilanPaddingDegeri,
                      ),
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).pushNamed(
                          '/ProfilSayfasi',
                          arguments: profil.getkullanici(ilan.kullaniciAdi),
                        ),
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: AssetImage(
                              profil.profilFotosu(ilan.surucuCinsiyet)),
                          backgroundColor: theme.primaryColor,
                        ),
                      ),
                    ),
                    Text(
                      ilan.kullaniciAdi,
                      style: const TextStyle(
                        fontSize: 18,
                        overflow: TextOverflow.ellipsis,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Tarih: ${DateFormat.yMd().format(ilan.tarih)}',
                      style: TextStyle(
                        fontSize:
                            1.8 * (MediaQuery.of(context).size.height / 100),
                        overflow: TextOverflow.ellipsis,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Tahmini yol süresi: ${ilan.tahminiYolSuresi} saat',
                      style: TextStyle(
                        fontSize:
                            1.8 * (MediaQuery.of(context).size.height / 100),
                        overflow: TextOverflow.ellipsis,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              GirdiAlani(
                baslikText: 'Adres',
                kontrolcu: simdikiIlanAdres,
                textAlign: 'start',
                textInputType: TextInputType.text,
                textAlanGenisligi: double.maxFinite,
                maxSatirSayisi: 3,
                readOnly: true,
              ),
              GirdiAlani(
                baslikText: 'Açıklama',
                kontrolcu: simdikiIlanAciklama,
                textAlign: 'start',
                textInputType: TextInputType.text,
                textAlanGenisligi: double.maxFinite,
                maxSatirSayisi: 4,
                readOnly: true,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'Fiyat: ${ilan.fiyat}₺',
                  style: const TextStyle(
                    fontSize: 22,
                    overflow: TextOverflow.ellipsis,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(theme.colorScheme.primary),
                  ),
                  onPressed: () {
                    musteri.ilanOnay(context, ilan);
                    musteri.filtreliIlanlar.clear();
                    musteri.degiskenleriSifirla();
                    DegismeyenBirimler.showSnackbar(context, 'İşlem başarılı!');
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/AnaSayfa', (Route<dynamic> route) => false);
                  },
                  child: Padding(
                    padding: DegismeyenBirimler.varsayilanPaddingHepsi / 2,
                    child: Text(
                      'Onayla',
                      style: theme.textTheme.labelLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
