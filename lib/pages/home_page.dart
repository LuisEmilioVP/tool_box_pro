import 'package:flutter/material.dart';
import 'package:tool_box_pro/utils/styles.dart';
import 'package:tool_box_pro/components/navigation_menu.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _showMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => const NavigationMenu(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Caja de Herramientas', style: titleStyle),
        backgroundColor: primaryColor,
      ),
      body: Center(
        // Centra el contenido en la pantalla
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Explora las herramientas',
              style: TextStyle(fontSize: 24, color: textColor),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => _showMenu(context),
              child: Image.asset(
                'assets/images/toolbox.png',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
