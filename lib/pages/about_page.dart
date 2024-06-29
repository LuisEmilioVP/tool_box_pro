import 'package:flutter/material.dart';
import 'package:tool_box_pro/utils/styles.dart';
import 'package:tool_box_pro/components/bottom_bar.dart';
import 'package:tool_box_pro/components/top_menu.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  bool _loading = false;
  bool _isMinimized = false;

  void _onMinimize() {
    setState(() {
      _isMinimized = true;
    });
  }

  void _onRestore() {
    setState(() {
      _isMinimized = false;
    });
  }

  void _onClose() {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopMenu(
            title: 'Sobre Mí',
            isLoading: _loading,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _isMinimized
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.aspect_ratio, size: 50),
                              color: primaryColor,
                              onPressed: _onRestore,
                            ),
                            const SizedBox(height: 20),
                            TextButton(
                              onPressed: _onRestore,
                              child: const Text('Restaurar',
                                  style: TextStyle(
                                      fontSize: 16, color: textColor)),
                            ),
                            TextButton(
                              onPressed: _onClose,
                              child: const Text('Cerrar',
                                  style: TextStyle(
                                      fontSize: 16, color: textColor)),
                            ),
                          ],
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircleAvatar(
                            radius: 80,
                            backgroundImage:
                                AssetImage('assets/images/perfil.jpg'),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Luis Emilio Valenzuela',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          _buildContactInfo(
                            icon: Icons.phone,
                            text: '+1 (849) 250-4693',
                          ),
                          _buildContactInfo(
                            icon: Icons.email,
                            text: 'informluisemiliovalenzuela@gmail.com',
                          ),
                          _buildContactInfo(
                            icon: Icons.linked_camera,
                            text: 'linkedin:luisemiliovp',
                          ),
                        ],
                      ),
              ),
            ),
          ),
          BottomBar(
            onMinimize: _onMinimize,
            onRestore: _onRestore,
            onClose: _onClose,
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo({required IconData icon, required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: secondaryColor),
          const SizedBox(width: 10),
          Text(
            text,
            style: const TextStyle(color: textColor, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
