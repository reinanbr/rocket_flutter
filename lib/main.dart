import 'package:flutter/material.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';

import 'configs/palettsColor.dart';
import 'apiRockets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rocket Launch',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Palette.purpleTheme // / Colors.purple.shade800,
          ),
      home: const MyHomePage(title: 'Rocket Launch Schedule'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  late Future<List<LaunchRocket>> futureLaunch;
  late Future<List<LaunchRocket>> data;

  @override
  void initState() {
    super.initState();
    futureLaunch = fetchLaunch();
    this.setState(() {
      data = fetchLaunch();
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white54 ,//Colors.grey,
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: FutureBuilder<List<LaunchRocket>>(
          future: fetchLaunch(),
          builder: (ctx, snapshot) {
            if (snapshot.data != null) {
              return ListView.builder(
                  itemCount: snapshot.data == null ? 0 : snapshot.data!.length,
                  itemBuilder: (context, index) {
                    print('eu N sei: ${index}');
                    return Container(
                      width: (MediaQuery.of(context).size.width),
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        height: 200,
                        // width: double.maxFinite,
                        child: Card(
                          color:Colors.white,
                          elevation: 5,
                          child: Container(
                              child: Stack(children: <Widget>[
                            Row(children: <Widget>[
                              Align(
                                alignment: Alignment.topRight,
                                child: Wrap(
                                  spacing: 60,
                                  runSpacing: 2,
                                    children:<Widget>[Text(
                                    '[${index+1}/${snapshot.data!.length}] ${snapshot.data![index].name} - ${snapshot.data![index].empire}',
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                    selectionColor: Colors.black,
                                  ),
                              ])
                              )
                            ]),
                            Row(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerRight,
                                  child:Wrap(
                                    children:<Widget>[Text(
                                    '${snapshot.data![index].mission}',
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                    selectionColor: Colors.black,
                                  ),
                              ])
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    '${snapshot.data![index].date}                   ${snapshot.data![index].hour}',
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                    selectionColor: Colors.black,
                                  ),
                                ),
                              ],
                            )
                          ])),
                        ));
                  });
            } else if (snapshot.hasError) {
              print('N fui');
              return Text(
                'Ops! A conexão com o servidor falhou! \nError: ${snapshot.error}',
                style: Theme.of(context).textTheme.headline6,
              );
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
      );
  }
}
