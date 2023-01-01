import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:online_otostop/models/yorumlar.dart';

import '../../controllers/profil_sayfa_yonetimi.dart';

class CustomYorumWidget extends StatelessWidget {
  final Yorumlar secilenYorum;
  final ThemeData theme;
  final Widget? widget;

  const CustomYorumWidget({
    Key? key,
    required this.secilenYorum,
    required this.theme,
    this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profile = context.read<ProfilSayfaYonetimi>();
    return Card(
      color: theme.primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundImage: AssetImage(profile
                          .profilFotosu(secilenYorum.yorumYapanKisiCinsiyet)),
                      backgroundColor: theme.primaryColor,
                    ),
                    Text(
                      secilenYorum.yorumYapanKisiAdi,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Text(
                  DateFormat.yMd().format(secilenYorum.yorumTarihi),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.all(16),
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Wrap(children: [
                Text(
                  secilenYorum.yorum,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ]),
            ),
            widget ?? const SizedBox()
          ],
        ),
      ),
    );
  }
}
