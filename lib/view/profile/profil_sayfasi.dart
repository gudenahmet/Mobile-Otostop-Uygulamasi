import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online_otostop/controllers/profil_sayfa_yonetimi.dart';
import 'package:online_otostop/models/kullanici.dart';
import 'package:online_otostop/units/degismeyen_birimler.dart';
import 'package:online_otostop/view/profile/widgets/tecrubeler.dart';
import 'package:online_otostop/view/widgets/girdi_alani.dart';
import 'package:provider/provider.dart';

class ProfilSayfasi extends StatefulWidget {
  const ProfilSayfasi({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfilSayfasi> createState() => _ProfilSayfasiState();
}

class _ProfilSayfasiState extends State<ProfilSayfasi> {
  late Kullanici hesap;
  bool tekSeferlik =
      true; // tek seferlik ilk basta profil verilerinin olusturulmasi icin.

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (tekSeferlik) {
      final profil = context.read<ProfilSayfaYonetimi>();
      hesap = ModalRoute.of(context)!.settings.arguments as Kullanici;
      profil.getKullaniciAdi.text = hesap.kullaniciAdi;
      profil.setTelGizli = hesap.telGizli;
      profil.getIletisimTel.text = hesap.iletisimTel!;
      profil.getWebIletisim.text = hesap.iletisimWeb!;
      profil.getBio.text = hesap.bio!;
      tekSeferlik = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final hesapKontrol =
        Provider.of<ProfilSayfaYonetimi>(context, listen: true);
    final theme = Theme.of(context);
    final deviceSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: const Text('Profil Sayfasi'),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(
                      DegismeyenBirimler.varsayilanPaddingDegeri,
                    ),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage:
                          AssetImage(hesapKontrol.profilFotosu(hesap.cinsiyet)),
                      backgroundColor: theme.primaryColor,
                    ),
                  ),
                  hesapKontrol.kullaniciAyni(context, hesap)
                      ? GirdiAlani(
                          baslikText: 'Kullanıcı Adı',
                          kontrolcu: hesapKontrol.getKullaniciAdi,
                          textAlign: 'center',
                          textInputType: TextInputType.name,
                          textAlanGenisligi: deviceSize.width / 2,
                          textAlanYuksekligi: 70,
                          maxSatirSayisi: 1,
                          maxKarakterSayisi: 15,
                          readOnly: !hesapKontrol.kullaniciAyni(context, hesap),
                          onChanged: (_) {
                            hesap.kullaniciAdi =
                                hesapKontrol.getKullaniciAdi.text;
                          },
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Card(
                            color: theme.primaryColor,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  const Text(
                                    'Kullanıcı Adı:',
                                    style: TextStyle(
                                      fontSize: 18,
                                      overflow: TextOverflow.ellipsis,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    hesap.kullaniciAdi,
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
                          ),
                        ),
                  hesapKontrol.kullaniciAyni(context, hesap)
                      ? GirdiAlani(
                          baslikText: 'Tel',
                          kontrolcu: hesapKontrol.getIletisimTel,
                          textAlign: 'center',
                          textInputType: TextInputType.phone,
                          textAlanYuksekligi: 50,
                          textAlanGenisligi: deviceSize.width / 2,
                          maxSatirSayisi: 1,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                          ],
                          onChanged: (_) {
                            hesap.iletisimTel =
                                hesapKontrol.getIletisimTel.text;
                          },
                          readOnly: !hesapKontrol.kullaniciAyni(context, hesap),
                          suffix: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Gizli',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(width: 4),
                              GestureDetector(
                                onTap: () {
                                  hesap.telGizli = !hesap.telGizli;
                                  hesapKontrol.telGizliDegis();
                                },
                                child: Container(
                                  constraints: const BoxConstraints(
                                    minHeight: 0,
                                    minWidth: 0,
                                    maxHeight: 20,
                                    maxWidth: 20,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                  ),
                                  child: FittedBox(
                                    fit: BoxFit.cover,
                                    child: Icon(
                                      hesapKontrol.getTelGizli
                                          ? Icons.close
                                          : null,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : !hesap.telGizli &&
                              hesap.iletisimTel!.isNotEmpty &&
                              hesap.iletisimTel!.length == 10
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Card(
                                color: theme.primaryColor,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      const Text(
                                        'Tel:',
                                        style: TextStyle(
                                          fontSize: 18,
                                          overflow: TextOverflow.ellipsis,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        hesap.iletisimTel!.length == 10
                                            ? hesap.iletisimTel!
                                                .replaceRange(0, 3, 'xxx')
                                            : '',
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
                              ),
                            )
                          : const SizedBox(),
                  GirdiAlani(
                    baslikText: 'Web',
                    kontrolcu: hesapKontrol.getWebIletisim,
                    textAlign: 'left',
                    textInputType: TextInputType.url,
                    textAlanGenisligi: double.maxFinite,
                    textAlanYuksekligi: 60,
                    maxSatirSayisi: 1,
                    readOnly: !hesapKontrol.kullaniciAyni(context, hesap),
                    onChanged: (_) {
                      hesap.iletisimWeb = hesapKontrol.getWebIletisim.text;
                    },
                  ),
                  GirdiAlani(
                    baslikText: 'Bio',
                    kontrolcu: hesapKontrol.getBio,
                    textAlign: 'left',
                    textInputType: TextInputType.text,
                    textAlanGenisligi: double.maxFinite,
                    // textAlanYuksekligi: 200,
                    maxSatirSayisi: 9,
                    maxKarakterSayisi:
                        hesapKontrol.kullaniciAyni(context, hesap) ? 300 : null,
                    readOnly: !hesapKontrol.kullaniciAyni(context, hesap),
                    onChanged: (_) {
                      hesap.bio = hesapKontrol.getBio.text;
                    },
                  ),
                  if (hesapKontrol.kullaniciAyni(context, hesap))
                    Tecrubeler(
                      label: 'Yolculuklar',
                      kullaniciAdi: hesap.kullaniciAdi,
                      yorumListesi: const [],
                    ),
                  Tecrubeler(
                    label: 'İlanlar',
                    kullaniciAdi: hesap.kullaniciAdi,
                    yorumListesi: const [],
                  ),
                  Tecrubeler(
                    label: 'Yorumlar',
                    kullaniciAdi: hesap.kullaniciAdi,
                    yorumListesi: hesap.yorumlar!,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
