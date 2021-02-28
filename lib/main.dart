import 'dart:convert';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';

import 'strings.dart' as s;
import 'settings.dart';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({this.connected, this.globalDev, this.c, key, this.title})
      : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final BluetoothDevice globalDev;
  final bool connected;
  final c;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// ignore: non_constant_identifier_names
double Smin = 0;
// ignore: non_constant_identifier_names
double Smax = 255;
// ignore: non_constant_identifier_names
int Sdiv = 255;

class _MyHomePageState extends State<MyHomePage> {
  // ignore: non_constant_identifier_names
  double SVR = 0;
  // ignore: non_constant_identifier_names
  double SVG = 0;
  // ignore: non_constant_identifier_names
  double SVB = 0;

  @override
  Widget build(BuildContext context) {
    s.updateGlobals();

    int _selectedIndex = 0;

    double width = MediaQuery.of(context).size.width;

    void _onItemTapped(int index) {
      if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => _btpicker()),
        );
      }
      if (index == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SettingsPage()),
        );
      }
    }

    Future returnAll() async {
      final prefs = await SharedPreferences.getInstance();
      final name1 = prefs.getString('name') ?? 0;
      final res1 = prefs.getInt('res') ?? 0;
      final lang1 = prefs.getString('lang') ?? 0;
      final wnl1 = prefs.getBool('wnl') ?? 0;
      return [name1, res1, lang1, wnl1];
    }

    return MaterialApp(
      title: 'RGBApp',
      home: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: s.home,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bluetooth),
              label: s.btSettings,
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: s.settings),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
        appBar: AppBar(
          title: Text('RGBApp'),
        ),
        body: Container(
          width: double.infinity,
          height: 254,
          margin: EdgeInsets.all(24),
          padding: EdgeInsets.only(top: 10, left: 15),
          //alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Row(children: <Widget>[
                Text(s.r),
                Container(
                  width: width - 75,
                  child: Slider(
                      value: SVR,
                      min: Smin,
                      max: Smax,
                      inactiveColor: Colors.red,
                      activeColor: Colors.red,
                      divisions: Sdiv,
                      label: SVR.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          SVR = value;
                        });
                      },
                      onChangeEnd: (double value) async {
                        SVR = value;
                        var retrn = await returnAll();
                        Smax = pow(2, retrn[1]).toDouble();
                        await BTConnect.send(SVR.toInt(), SVG.toInt(),
                            SVB.toInt(), widget.c, retrn[3]);
                      }),
                ),
              ]),
              Row(children: <Widget>[
                Text(s.g),
                Container(
                  width: width - 75,
                  child: Slider(
                      value: SVG,
                      min: Smin,
                      max: Smax,
                      inactiveColor: Colors.green,
                      activeColor: Colors.green,
                      divisions: Sdiv,
                      label: SVG.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          SVG = value;
                        });
                      },
                      onChangeEnd: (double value) async {
                        SVG = value;
                        var retrn = await returnAll();
                        Smax = pow(2, retrn[1]).toDouble();
                        await BTConnect.send(SVR.toInt(), SVG.toInt(),
                            SVB.toInt(), widget.c, retrn[3]);
                      }),
                ),
              ]),
              Row(children: <Widget>[
                Text(s.b),
                Container(
                  width: width - 75,
                  child: Slider(
                      value: SVB,
                      min: Smin,
                      max: Smax,
                      inactiveColor: Colors.blue,
                      activeColor: Colors.blue,
                      divisions: Sdiv,
                      label: SVB.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          SVB = value;
                        });
                      },
                      onChangeEnd: (double value) async {
                        SVB = value;
                        var retrn = await returnAll();
                        Smax = pow(2, retrn[1]).toDouble();
                        await BTConnect.send(SVR.toInt(), SVG.toInt(),
                            SVB.toInt(), widget.c, retrn[3]);
                      }),
                ),
              ]),
              Container(height: 50),
              Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          widget.globalDev.disconnect();
                        });
                      },
                      child: Text(s.disconnect)))
            ],
          ),
        ),
      ),
    );
  }
}

class BTConnect {
  static void connectTo(BluetoothDevice snapdata) async {
    print("Trying to connect!");
    BluetoothDevice device = snapdata;
    await device.connect();
  }

  static void connectTo2(int index, List snapdata) {
    print("Trying to connect!");
    BluetoothDevice device = snapdata[index];
    device.connect();
  }

  static Future<void> send(int r, int g, int b, var c, bool nl) async {
    String toSend;
    if (nl == false) {
      toSend = r.toString() + " " + g.toString() + " " + b.toString();
    } else if (nl == true) {
      toSend = r.toString() + " " + g.toString() + " " + b.toString() + "\n";
    }
    print("Values to send: ");
    print(toSend);
    var utfChar = utf8.encode(toSend);
    for (BluetoothCharacteristic chars in c) {
      await chars.write(utfChar);
    }
  }
}

// ignore: camel_case_types
class _btpicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    Future<List> _getData() async {
      List deviceName = [];
      FlutterBlue flutterBlue = FlutterBlue.instance;

      await flutterBlue.startScan(timeout: Duration(seconds: 5));

      flutterBlue.scanResults.listen((results) {
        for (ScanResult r in results) {
          deviceName.add(r.device);
        }
      });

      //flutterBlue.stopScan();

      return deviceName;
    }

    return DefaultTextStyle(
      style: Theme.of(context).textTheme.headline2,
      textAlign: TextAlign.center,
      child: FutureBuilder<List>(
        future: _getData(), // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            var snapdata = snapshot.data;
            print(snapdata);
            children = <Widget>[
              Material(
                child: Container(
                  height: height,
                  width: double.infinity,
                  child: ListView.builder(
                    itemCount: snapdata.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          '${snapdata[index].name}',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        onTap: () async {
                          BluetoothDevice btdevice = snapdata[index];
                          await BTConnect.connectTo(btdevice);
                          List<BluetoothService> services =
                              await btdevice.discoverServices();
                          var c;
                          services.forEach((service) {
                            c = service.characteristics;
                          });

                          bool connected = true;

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyHomePage(
                                  connected: connected,
                                  globalDev: btdevice,
                                  c: c),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ];
          } else if (snapshot.hasError) {
            children = <Widget>[
              Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  'Error: ${snapshot.error}',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
            ];
          } else {
            children = <Widget>[
              SizedBox(
                child: CircularProgressIndicator(),
                width: 60,
                height: 60,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  'Searching for devices! Please wait...',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
            ];
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            ),
          );
        },
      ),
    );
  }
}
