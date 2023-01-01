import 'package:flutter/material.dart';
import 'package:online_otostop/controllers/hesap_veri_yonetimi.dart';
import 'package:online_otostop/units/degismeyen_birimler.dart';
import 'package:provider/provider.dart';

class AnaSayfa extends StatelessWidget {
  const AnaSayfa({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: const Text('Ana Sayfa'),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                  right: DegismeyenBirimler.varsayilanPaddingDegeri / 2),
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      '/ProfilSayfasi',
                      arguments:
                          context.read<HesapVeriYonetimi>().getSimdikiKullanici,
                    );
                  },
                  icon: const Icon(
                    Icons.manage_accounts_sharp,
                  )),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Spacer(flex: 3),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/MusteriTercihSayfasi');
                },
                child: const Padding(
                  padding: DegismeyenBirimler.varsayilanPaddingHepsi,
                  child: Text(
                    'Otostop',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const Spacer(flex: 1),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/IlanEklemeSayfasi');
                },
                child: const Padding(
                  padding: DegismeyenBirimler.varsayilanPaddingHepsi,
                  child: Text(
                    'İlan Oluştur',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const Spacer(flex: 1),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/GirisSayfasi',
                    (Route<dynamic> route) => false,
                  );
                },
                child: const Padding(
                  padding: DegismeyenBirimler.varsayilanPaddingHepsi,
                  child: Text(
                    'Hesaptan Çık',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}
