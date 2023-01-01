import 'package:flutter/material.dart';
import 'package:online_otostop/controllers/BaglantiliProviderYonetimi/musteri_sayfa_yonetimi.dart';
import 'package:online_otostop/controllers/profil_sayfa_yonetimi.dart';
import 'package:online_otostop/main.dart';
import 'package:online_otostop/view/widgets/custom_card_widget.dart';
import 'package:provider/provider.dart';

class IlanAramaSayfasi extends StatelessWidget {
  const IlanAramaSayfasi({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MusteriSayfaYonetimi>(context, listen: true);
    final profilProvider = context.read<ProfilSayfaYonetimi>();
    final theme = Theme.of(context);
    final themeColor = theme.colorScheme;
    return Scaffold(
      backgroundColor: themeColor.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
            provider.filtreliIlanlar.clear();
          },
          icon: const Icon(Icons.arrow_back_outlined),
        ),
        title: const Text('İlan Arama Sayfası'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              shrinkWrap: true,
              itemCount: provider.filtreliIlanlar.length,
              itemBuilder: (context, index) => CustomCardWidget(
                ilan: provider.filtreliIlanlar[index],
                kosul: Kosul.arama,
                bottomSheet: false,
                yorumTusu: false,
                theme: theme,
                cinsiyetfoto: profilProvider.profilFotosu(
                  profilProvider
                      .getkullanici(
                          provider.filtreliIlanlar[index].kullaniciAdi)
                      .cinsiyet,
                ),
                onContentTap: () => Navigator.of(context).pushNamed(
                  '/SecilenIlanSayfasi',
                  arguments: provider.filtreliIlanlar[index],
                ),
                onProfileAvatarTap: () => Navigator.of(context).pushNamed(
                  '/ProfilSayfasi',
                  arguments: profilProvider.getkullanici(
                      provider.filtreliIlanlar[index].kullaniciAdi),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
