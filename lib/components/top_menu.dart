import 'package:flutter/material.dart';
import 'package:tool_box_pro/utils/styles.dart';

class TopMenu extends StatelessWidget {
  final String title;
  final bool isLoading;

  const TopMenu({super.key, required this.title, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: secondaryColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            title,
            style: titleStyle,
          ),
          backgroundColor: primaryColor,
        ),
        if (isLoading)
          const LinearProgressIndicator(
            backgroundColor: backgroundColor,
            valueColor: AlwaysStoppedAnimation<Color>(secondaryColor),
          )
      ],
    );
  }
}
