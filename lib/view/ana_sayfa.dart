import 'package:flutter/material.dart';
import 'package:online_otostop/units/degismeyen_birimler.dart';

class AnaSayfa extends StatelessWidget {
  const AnaSayfa({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
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
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}
