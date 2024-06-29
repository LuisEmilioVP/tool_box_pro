import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tool_box_pro/utils/styles.dart';
import 'package:tool_box_pro/components/bottom_bar.dart';
import 'package:tool_box_pro/components/top_menu.dart';

class AgePage extends StatefulWidget {
  const AgePage({super.key});

  @override
  _AgePageState createState() => _AgePageState();
}

class _AgePageState extends State<AgePage> {
  final TextEditingController _controller = TextEditingController();
  int? _age;
  String? _ageCategory;
  bool _loading = false;
  bool _isMinimized = false;

  Future<void> _predictAge(String name) async {
    setState(() {
      _loading = true;
    });

    final response =
        await http.get(Uri.parse('https://api.agify.io/?name=$name'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _age = data['age'];
        _loading = false;

        if (_age != null) {
          if (_age! < 18) {
            _ageCategory = 'Joven';
          } else if (_age! < 60) {
            _ageCategory = 'Adulto/a';
          } else {
            _ageCategory = 'Anciano/a';
          }
        }
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
            title: 'Determinar Edad',
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
                              _predictAge(_controller.text);
                            },
                            child: const Text('Predecir Edad'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          _age == null
                              ? Container()
                              : Column(
                                  children: [
                                    Text(
                                      'Edad: $_age',
                                      style: const TextStyle(
                                        color: textColor,
                                        fontSize: 24,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      _ageCategory ?? '',
                                      style: const TextStyle(
                                        color: textColor,
                                        fontSize: 24,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Image.asset(
                                      _ageCategory == 'Joven'
                                          ? 'assets/images/young.png'
                                          : _ageCategory == 'Adulto/a'
                                              ? 'assets/images/adult.png'
                                              : 'assets/images/senior.png',
                                      height: 100,
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
