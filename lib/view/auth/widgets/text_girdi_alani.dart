import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:online_otostop/controllers/hesap_veri_yonetimi.dart';
import 'package:online_otostop/units/degismeyen_birimler.dart';

class TextGirdiAlani extends StatelessWidget {
  final TextEditingController kontrolcu;
  final bool sifreGoster;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final String baslikText;
  final bool errorKontrol;
  final String errorText;
  const TextGirdiAlani({
    Key? key,
    required this.kontrolcu,
    required this.sifreGoster,
    this.suffixIcon,
    required this.baslikText,
    required this.errorKontrol,
    required this.errorText,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hesap = Provider.of<HesapVeriYonetimi>(context, listen: true);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: DegismeyenBirimler.varsayilanSimetrikPadding,
          child: TextField(
            controller: kontrolcu,
            obscureText: sifreGoster,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              suffixIcon: suffixIcon,
              border: const OutlineInputBorder(),
              labelText: baslikText,
            ),
            inputFormatters: inputFormatters,
            onChanged: (_) {
              hesap.bilgiGirdilerikontrolu();
              hesap.girdiKontrolu();
            },
          ),
        ),
        if (errorKontrol)
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              errorText,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }
}
