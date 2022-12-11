import 'package:flutter/material.dart';

import 'package:online_otostop/units/degismeyen_birimler.dart';

class IlanGirdiAlani extends StatelessWidget {
  final String baslikText;
  final TextEditingController kontrolcu;
  final FocusNode? focusNode;
  final String textAlign;
  final TextInputType textInputType;
  final double textAlanGenisligi;
  final double textAlanYuksekligi;
  final int maxSatirSayisi;
  final bool readOnly;
  final int? maxKarakterSayisi;
  final VoidCallback? onTap;
  final Function(String value)? onChanged;
  const IlanGirdiAlani({
    Key? key,
    required this.baslikText,
    required this.kontrolcu,
    this.focusNode,
    required this.textAlign,
    required this.textInputType,
    required this.textAlanGenisligi,
    required this.textAlanYuksekligi,
    required this.maxSatirSayisi,
    required this.readOnly,
    this.maxKarakterSayisi,
    this.onTap,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeColor = theme.colorScheme;
    return Padding(
      padding: DegismeyenBirimler.varsayilanPaddingHepsi / 2,
      child: Card(
        color: themeColor.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: DegismeyenBirimler.varsayilanPaddingHepsi / 4,
                child: Text(
                  baslikText,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: DegismeyenBirimler.varsayilanPaddingHepsi / 4,
                child: TextField(
                  controller: kontrolcu,
                  focusNode: focusNode,
                  textAlign: TextAlign.values.byName(textAlign),
                  maxLength: maxKarakterSayisi,
                  keyboardType: textInputType,
                  maxLines: maxSatirSayisi,
                  readOnly: readOnly,
                  onTap: onTap,
                  onChanged: onChanged,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    counterStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    constraints: BoxConstraints(
                      minHeight: 0,
                      maxHeight: textAlanYuksekligi,
                      minWidth: 0,
                      maxWidth: textAlanGenisligi,
                    ),
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
