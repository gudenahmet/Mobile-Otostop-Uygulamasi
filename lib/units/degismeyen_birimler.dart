import 'package:flutter/material.dart';

class DegismeyenBirimler {
  //Padding
  static const double varsayilanDikeyPadding = 16;
  static const double varsayilanPaddingDegeri = 16;
  static const double varsayilanYatayPadding = 32;
  static const EdgeInsetsGeometry varsayilanSimetrikPadding =
      EdgeInsets.symmetric(vertical: 16, horizontal: 32);
  static const EdgeInsetsGeometry butonSimetrikPadding =
      EdgeInsets.symmetric(vertical: 12, horizontal: 24);
  static const EdgeInsetsGeometry varsayilanPaddingHepsi = EdgeInsets.all(16.0);

//Sizes
  static const double varsayilanIkonBoyutu = 24;

// Show message bar
  static void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).primaryColor,
        content: Text(
          message,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

// Borders
  static const double defaultBorderRadiusCircular = 30;
// konumlar litesi
  static final List<String> konumlar = [
    "Adana",
    "Adıyaman",
    "Afyonkarahisar",
    "Ağrı",
    "Aksaray",
    "Amasya",
    "Ankara",
    "Antalya",
    "Ardahan",
    "Artvin",
    "Aydın",
    "Balıkesir",
    "Bartın",
    "Batman",
    "Bayburt",
    "Bilecik",
    "Bingöl",
    "Bitlis",
    "Bolu",
    "Burdur",
    "Bursa",
    "Çanakkale",
    "Çankırı",
    "Çorum",
    "Denizli",
    "Diyarbakır",
    "Düzce",
    "Edirne",
    "Elazığ",
    "Erzincan",
    "Erzurum",
    "Eskişehir",
    "Gaziantep",
    "Giresun",
    "Gümüşhane",
    "Hakkâri",
    "Hatay",
    "Iğdır",
    "Isparta",
    "İstanbul",
    "İzmir",
    "Kahramanmaraş",
    "Karabük",
    "Karaman",
    "Kars",
    "Kastamonu",
    "Kayseri",
    "Kilis",
    "Kırıkkale",
    "Kırklareli",
    "Kırşehir",
    "Kocaeli",
    "Konya",
    "Kütahya",
    "Malatya",
    "Manisa",
    "Mardin",
    "Mersin",
    "Muğla",
    "Muş",
    "Nevşehir",
    "Niğde",
    "Ordu",
    "Osmaniye",
    "Rize",
    "Sakarya",
    "Samsun",
    "Şanlıurfa",
    "Siirt",
    "Sinop",
    "Sivas",
    "Şırnak",
    "Tekirdağ",
    "Tokat",
    "Trabzon",
    "Tunceli",
    "Uşak",
    "Van",
    "Yalova",
    "Yozgat",
    "Zonguldak"
  ];
}
