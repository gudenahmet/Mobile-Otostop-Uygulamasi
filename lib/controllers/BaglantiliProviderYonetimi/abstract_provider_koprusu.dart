import 'package:flutter/material.dart';

abstract class ProviderKoprusu {
  late List<String> uyusanKonumListesi;
  late FocusNode kalkisYeriFocus;
  late FocusNode varisYeriFocus;
  TextEditingController get kalkisYeri;
  TextEditingController get varisYeri;
  set setKalkisYeriSecili(bool kosul);
  set setVarisYeriSecili(bool kosul);
}
