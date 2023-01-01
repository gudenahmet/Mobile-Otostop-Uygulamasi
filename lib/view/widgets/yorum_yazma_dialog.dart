import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:online_otostop/controllers/BaglantiliProviderYonetimi/musteri_sayfa_yonetimi.dart';

class YorumYazmaDialog extends StatelessWidget {
  final String yorumYapilanKisiAdi;
  final ThemeData theme;
  final DateTime yorumTarihi;
  const YorumYazmaDialog({
    Key? key,
    required this.yorumYapilanKisiAdi,
    required this.theme,
    required this.yorumTarihi,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dialog = TextEditingController();
    return Dialog(
      backgroundColor: theme.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              yorumYapilanKisiAdi,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 26,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Kullanıcı hakkındaki fikirleriniz:',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
                controller: dialog,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Vazgeç'),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<MusteriSayfaYonetimi>().yorumuEkleme(
                          context: context,
                          yorumYapilanKisiAdi: yorumYapilanKisiAdi,
                          yorumTarihi: yorumTarihi,
                          yazilanYorum: dialog.text,
                        );
                    Navigator.of(context).pop();
                  },
                  child: const Text('Gönder'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
