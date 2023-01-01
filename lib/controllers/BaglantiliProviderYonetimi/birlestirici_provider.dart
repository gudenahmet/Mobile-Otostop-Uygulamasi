import 'package:flutter/widgets.dart';
import 'package:online_otostop/controllers/BaglantiliProviderYonetimi/abstract_provider_koprusu.dart';
import 'package:online_otostop/controllers/BaglantiliProviderYonetimi/musteri_sayfa_yonetimi.dart';
import 'package:online_otostop/controllers/BaglantiliProviderYonetimi/surucu_ilan_ekleme_yonetimi.dart';
import 'package:provider/provider.dart';

class BirlestiriciProvider extends ChangeNotifier {
  ProviderKoprusu lazimOlanProvider(BuildContext context, String tag) {
    switch (tag) {
      case 'ilan':
        return Provider.of<SurucuIlanEklemeYonetimi>(context, listen: true);

      case 'filtre':
        return Provider.of<MusteriSayfaYonetimi>(context, listen: true);
      default:
        return context.read<ProviderKoprusu>(); // dummy
    }
  }
}
