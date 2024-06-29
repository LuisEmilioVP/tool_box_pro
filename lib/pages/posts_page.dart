import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:tool_box_pro/utils/styles.dart';
import 'package:tool_box_pro/components/bottom_bar.dart';
import 'package:tool_box_pro/components/top_menu.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  List<dynamic> _posts = [];
  bool _loading = false;
  bool _isMinimized = false;

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  Future<void> _fetchPosts() async {
    setState(() {
      _loading = true;
    });

    final response = await http
        .get(Uri.parse('https://noticiassin.com/wp-json/wp/v2/posts'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _posts = data.take(3).toList();
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
            title: 'Últimas Noticias',
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
                          Image.asset(
                            'assets/images/noticiassin-logo.png',
                            height: 100,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Noticias Recientes',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          _posts.isEmpty
                              ? const Text(
                                  'No se encontraron noticias.',
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 18,
                                  ),
                                )
                              : Column(
                                  children: _posts.map((post) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            post['title']['rendered'],
                                            style: const TextStyle(
                                              color: textColor,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            post['excerpt']['rendered']
                                                .replaceAll(
                                                    RegExp(r'<[^>]*>'), ''),
                                            style: const TextStyle(
                                              color: textColor,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          TextButton(
                                            onPressed: () {
                                              final url = post['link'];
                                              if (Uri.parse(url).isAbsolute) {
                                                launch(url);
                                              }
                                            },
                                            child: const Text(
                                              'Ir a la noticia',
                                              style: TextStyle(
                                                  color: primaryColor),
                                            ),
                                          ),
                                          const Divider(),
                                        ],
                                      ),
                                    );
                                  }).toList(),
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
