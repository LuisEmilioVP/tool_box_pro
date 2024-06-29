import 'package:flutter/material.dart';
import 'package:tool_box_pro/utils/styles.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildMenuItem(context, Icons.wc, 'Determinar Género', '/gender'),
          _buildMenuItem(context, Icons.cake, 'Determinar Edad', '/age'),
          _buildMenuItem(
              context, Icons.school, 'Universidades', '/universities'),
          _buildMenuItem(context, Icons.wb_sunny, 'Clima en RD', '/weather'),
          _buildMenuItem(context, Icons.web, 'Posts Webs', '/posts'),
          _buildMenuItem(context, Icons.info, 'Acerca de', '/about'),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
      BuildContext context, IconData icon, String title, String route) {
    return ListTile(
      leading: Icon(icon, color: secondaryColor),
      title: Text(title, style: subtitleStyle),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, route);
      },
    );
  }
}
