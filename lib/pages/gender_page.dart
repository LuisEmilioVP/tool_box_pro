import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tool_box_pro/utils/styles.dart';
import 'package:tool_box_pro/components/bottom_bar.dart';
import 'package:tool_box_pro/components/top_menu.dart';

class GenderPage extends StatefulWidget {
  const GenderPage({super.key});

  @override
  _GenderPageState createState() => _GenderPageState();
}

class _GenderPageState extends State<GenderPage> {
  final TextEditingController _controller = TextEditingController();
  String? _gender;
  bool _loading = false;
  bool _isMinimized = false;

  Future<void> _predicGender(String name) async {
    setState(() {
      _loading = true;
    });

    final response =
        await http.get(Uri.parse('https://api.genderize.io/?name=$name'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _gender = data['gender'];
        _loading = false;
      });
    } else {
      setState(() {
        _loading = false;
      });
    }
  }

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
            title: 'Determinar Género',
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
                          TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              hintText: 'Ingrese su nombre',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              _predicGender(_controller.text);
                            },
                            child: const Text('Predecir Género'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          _gender == null
                              ? Container()
                              : Column(
                                  children: [
                                    Icon(
                                      _gender == 'male'
                                          ? Icons.male
                                          : Icons.female,
                                      color: _gender == 'male'
                                          ? Colors.blue
                                          : Colors.pink,
                                      size: 100,
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      _gender == 'male'
                                          ? 'Masculino'
                                          : 'Femenino',
                                      style: const TextStyle(
                                        color: textColor,
                                        fontSize: 24,
                                      ),
                                    ),
                                  ],
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
}
