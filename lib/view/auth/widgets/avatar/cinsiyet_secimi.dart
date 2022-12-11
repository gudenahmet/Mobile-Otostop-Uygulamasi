import 'package:flutter/material.dart';
import 'package:online_otostop/controllers/hesap_veri_yonetimi.dart';
import 'package:online_otostop/main.dart';
import 'package:provider/provider.dart';

class CinsiyetSecimi extends StatelessWidget {
  final ColorScheme themeColor;
  const CinsiyetSecimi({
    Key? key,
    required this.themeColor,
  }) : super(key: key);

  final double radius = 16;
  final Radius defualtRadius = const Radius.circular(16);

  @override
  Widget build(BuildContext context) {
    final hesap = Provider.of<HesapVeriYonetimi>(context);
    return Container(
      width: double.infinity,
      height: 45,
      decoration: BoxDecoration(
        color: themeColor.primary.withOpacity(0.4),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                hesap.setCinsiyet = Cinsiyet.erkek;
              },
              borderRadius: BorderRadius.only(
                topLeft: defualtRadius,
                bottomLeft: defualtRadius,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: hesap.getCinsiyet == Cinsiyet.erkek
                      ? themeColor.primary
                      : null,
                  borderRadius: BorderRadius.only(
                    topLeft: defualtRadius,
                    bottomLeft: defualtRadius,
                  ),
                ),
                child: const Center(
                  child: Text(
                    "Erkek",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              borderRadius: BorderRadius.only(
                topRight: defualtRadius,
                bottomRight: defualtRadius,
              ),
              onTap: () {
                hesap.setCinsiyet = Cinsiyet.kadin;
              },
              child: Container(
                decoration: BoxDecoration(
                  color: hesap.getCinsiyet == Cinsiyet.kadin
                      ? themeColor.primary
                      : null,
                  borderRadius: BorderRadius.only(
                    topRight: defualtRadius,
                    bottomRight: defualtRadius,
                  ),
                ),
                child: const Center(
                  child: Text(
                    "Kadın",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
