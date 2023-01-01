import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:online_otostop/controllers/profil_sayfa_yonetimi.dart';
import 'package:online_otostop/main.dart';
import 'package:online_otostop/models/surucu_ilan.dart';
import 'package:online_otostop/view/widgets/yorum_yazma_dialog.dart';

class CustomCardWidget extends StatelessWidget {
  final SurucuIlan ilan;
  final String? kullaniciAdi;
  final Kosul kosul;
  final bool bottomSheet;
  final bool yorumTusu;
  final ThemeData theme;
  final VoidCallback onContentTap;
  final VoidCallback? onProfileAvatarTap;
  final String cinsiyetfoto;

  const CustomCardWidget({
    Key? key,
    required this.ilan,
    this.kullaniciAdi,
    required this.kosul,
    required this.bottomSheet,
    required this.yorumTusu,
    required this.theme,
    required this.onContentTap,
    this.onProfileAvatarTap,
    required this.cinsiyetfoto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profile = context.read<ProfilSayfaYonetimi>();
    return Card(
      color: theme.primaryColor,
      child: ListTile(
        onTap: onContentTap,
        leading: GestureDetector(
          onTap: onProfileAvatarTap,
          child: SizedBox(
            width: 80,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage(cinsiyetfoto),
                    backgroundColor: theme.backgroundColor,
                  ),
                  Text(
                    ilan.kullaniciAdi,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        title: FittedBox(
          child: Text(
            '${ilan.kalkisYeri}-${ilan.varisYeri}',
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        subtitle: Text(
          kosul == Kosul.profil
              ? 'Tarih: ${DateFormat.yMd().format(ilan.tarih)}'
              : ilan.aciklama,
          style: TextStyle(
            fontSize: 18,
            overflow: TextOverflow.ellipsis,
            color: Colors.grey[200],
          ),
        ),
        trailing: kosul == Kosul.arama || bottomSheet
            ? FittedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'fiyat: ${ilan.fiyat}₺',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[100],
                      ),
                    ),
                    if (yorumTusu &&
                        profile.kullaniciAyni(
                          context,
                          profile.getkullanici(kullaniciAdi!),
                        ))
                      IconButton(
                        onPressed: () => showDialog(
                          context: context,
                          builder: (context) => YorumYazmaDialog(
                            yorumYapilanKisiAdi: ilan.kullaniciAdi,
                            yorumTarihi: ilan.tarih,
                            theme: theme,
                          ),
                        ),
                        icon: Icon(
                          Icons.message,
                          color: Colors.grey[800],
                        ),
                      ),
                  ],
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Tümü',
                    style: TextStyle(
                      fontSize: 18,
                      overflow: TextOverflow.ellipsis,
                      color: Colors.grey[200],
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                  ),
                ],
              ),
      ),
    );
  }
}
