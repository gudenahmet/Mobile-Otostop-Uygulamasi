import 'package:flutter/material.dart';

class CustomBottomSheet extends StatelessWidget {
  final String label;
  final ThemeData theme;
  final Widget widget;
  const CustomBottomSheet({
    Key? key,
    required this.label,
    required this.theme,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 25,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Divider(
                thickness: 6,
                color: theme.primaryColor,
              ),
            ),
            Expanded(
              flex: 10,
              child: widget,
            ),
          ],
        ),
      ),
    );
  }
}
