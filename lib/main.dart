import 'dart:io';
import 'package:flutter/material.dart';

import 'configs/palettsColor.dart';
import 'apiRockets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rocket Launch',
      theme: ThemeData(
        primarySwatch: Palette.purpleTheme,
      ),
      home: const MyHomePage(title: 'Rocket Launch Schedule'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<LaunchRocket>> futureLaunch;
  bool _errorDialogShown = false;

  @override
  void initState() {
    super.initState();
    futureLaunch = fetchLaunch();
  }

  void _showErrorAndClose(String error) {
    if (_errorDialogShown) return;
    _errorDialogShown = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: const Text('Erro ao carregar dados'),
        content: Text('Ocorreu um erro: $error'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              exit(0);
            },
            child: const Text('Fechar App'),
          ),
        ],
      ),
    );

    Future.delayed(const Duration(seconds: 4), () {
      Navigator.of(context).pop();
      exit(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder<List<LaunchRocket>>(
          future: futureLaunch,
          builder: (ctx, snapshot) {
            if (snapshot.hasError) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _showErrorAndClose(snapshot.error.toString());
              });
              return const SizedBox();
            }

            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final rocket = snapshot.data![index];
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    height: 200,
                    child: Card(
                      color: Colors.white,
                      elevation: 5,
                      child: Row(
                        children: [
                          // Imagem com bordas arredondadas
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                            ),
                            child: Image.network(
                              rocket.imgUrl,
                              width: 120,
                              height: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (ctx, error, stackTrace) =>
                                  const Icon(Icons.broken_image, size: 80),
                            ),
                          ),
                          const SizedBox(width: 10),
                          // Conteúdo textual
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '🚀 Lançamento #${index + 1}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                            fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Rocket: ${rocket.name}',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    'Empire: ${rocket.empire}',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    'Mission: ${rocket.mission}',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const Spacer(),
                                  Text(
                                    '${rocket.date}    ${rocket.hour}',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
