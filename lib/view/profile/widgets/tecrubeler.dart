import 'package:flutter/material.dart';
import 'package:online_otostop/view/widgets/custom_bottom_sheet.dart';
import 'package:online_otostop/view/widgets/custom_yorum_widget.dart';
import 'package:provider/provider.dart';
import '../../../controllers/profil_sayfa_yonetimi.dart';
import '../../../main.dart';
import '../../../models/yorumlar.dart';
import '../../widgets/custom_card_widget.dart';

class Tecrubeler extends StatelessWidget {
  final String label;
  final String kullaniciAdi;
  final List<Yorumlar> yorumListesi;
  const Tecrubeler({
    Key? key,
    required this.label,
    required this.kullaniciAdi,
    required this.yorumListesi,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final profile = context.read<ProfilSayfaYonetimi>();
    final dataList = profile.tecrubeTipi(label, kullaniciAdi);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 8,
              ),
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          Divider(
            color: theme.primaryColor,
            thickness: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: dataList.isEmpty && yorumListesi.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.content_paste_search,
                        color: theme.primaryColor,
                        size: 60,
                      ),
                      Text(
                        profile.bulunamadiText(label),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  )
                : yorumListesi.isEmpty
                    ? CustomCardWidget(
                        ilan: dataList.first,
                        kosul: Kosul.profil,
                        bottomSheet: false,
                        yorumTusu: false,
                        kullaniciAdi: kullaniciAdi,
                        theme: theme,
                        onContentTap: () {
                          showModalBottomSheet(
                            backgroundColor: Colors.blue[800],
                            enableDrag: true,
                            context: context,
                            builder: (context) => CustomBottomSheet(
                              label: label,
                              theme: theme,
                              widget: ListView.builder(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                shrinkWrap: true,
                                itemCount: dataList.length,
                                itemBuilder: (context, index) =>
                                    CustomCardWidget(
                                  kosul: Kosul.profil,
                                  bottomSheet: true,
                                  yorumTusu: label == 'Yolculuklar',
                                  kullaniciAdi: kullaniciAdi,
                                  theme: theme,
                                  ilan: dataList[index],
                                  onContentTap: () {},
                                  onProfileAvatarTap: () {},
                                  cinsiyetfoto: profile.profilFotosu(
                                    dataList[index].surucuCinsiyet,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        onProfileAvatarTap: null,
                        cinsiyetfoto: profile.profilFotosu(
                          profile
                              .tecrubeTipi(label, kullaniciAdi)
                              .first
                              .surucuCinsiyet,
                        ),
                      )
                    : CustomYorumWidget(
                        secilenYorum: yorumListesi.first,
                        theme: theme,
                        widget: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[900],
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                              backgroundColor: Colors.blue[800],
                              enableDrag: true,
                              context: context,
                              builder: (context) => CustomBottomSheet(
                                label: label,
                                theme: theme,
                                widget: ListView.builder(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    shrinkWrap: true,
                                    itemCount: yorumListesi.length,
                                    itemBuilder: (context, index) =>
                                        CustomYorumWidget(
                                          secilenYorum: yorumListesi[index],
                                          theme: theme,
                                        )),
                              ),
                            );
                          },
                          child: const Text('Tümü'),
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}
