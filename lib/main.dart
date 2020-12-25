import 'package:flutter/material.dart';
import 'package:rgbapp/bt.dart';
import 'package:rgbapp/globals.dart' as globals;
import 'package:flutter_blue/flutter_blue.dart';
import 'dart:io';

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
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double SVR = 0;
  double SVG = 0;
  double SVB = 0;

  double Smin = 0;
  double Smax = 255;
  int Sdiv = 255;

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    void _onItemTapped(int index) {
      if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => _btpicker()),
        );
      }
    }

    return MaterialApp(
      title: 'RGBApp',
      home: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bluetooth),
              label: 'Bluetooth Settings',
            ),
            //BottomNavigationBarItem(
            //icon: Icon(Icons.school),
            //label: 'School',
            //),
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
          height: 250,
          margin: EdgeInsets.all(24),
          padding: EdgeInsets.only(top: 10, left: 15),
          //alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Row(children: <Widget>[
                Text("R"),
                Container(
                  width: width - 75,
                  child: Slider(
                    value: SVR,
                    min: Smin,
                    max: Smax,
                    divisions: Sdiv,
                    label: SVR.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        SVR = value;
                      });
                    },
                  ),
                ),
              ]),
              Row(children: <Widget>[
                Text("G"),
                Container(
                  width: width - 75,
                  child: Slider(
                    value: SVG,
                    min: Smin,
                    max: Smax,
                    divisions: Sdiv,
                    label: SVG.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        SVG = value;
                      });
                    },
                  ),
                ),
              ]),
              Row(children: <Widget>[
                Text("B"),
                Container(
                  width: width - 75,
                  child: Slider(
                    value: SVB,
                    min: Smin,
                    max: Smax,
                    divisions: Sdiv,
                    label: SVB.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        SVB = value;
                      });
                    },
                  ),
                ),
              ]),
              //Row(
              //Container(

              //),
              //),
            ],
          ),
        ),
      ),
    );
  }
}

class _btpicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var deviceName = [""];

    void getDevices() {
      FlutterBlue flutterBlue = FlutterBlue.instance;
      flutterBlue.startScan(timeout: Duration(seconds: 4));

      // this line will start scanning bluetooth devices
      // ignore: cancel_subscriptions
      flutterBlue.scanResults.listen((results) {
        for (ScanResult r in results) {
          deviceName.add(r.device.name);
        }
      });
      flutterBlue.stopScan();

      print(deviceName);
    }

    void setState() {}
      //deviceName.add('');

    //void _onItemTapped(int index) {
    //if (index == 0) {
    //Navigator.push(
    //context,
    //MaterialPageRoute(builder: (context) => _MyHomePageState()),
    //);
    //}
    //}

    return MaterialApp(
        title: "RGBApp",
        home: Scaffold(
            appBar: AppBar(title: const Text("RGBApp")),
            body: Column(children: <Widget>[
              Container(
                  width: double.infinity,
                  child: ElevatedButton(
                      child: Text('SCAN'), onPressed: () => {getDevices()})),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text('Show list'),
                  onPressed: () {
                     setState();
                  }
                ),
              ),
              Container(
                  height: 200,
                  width: double.infinity,
                  child: ListView.builder(
                      itemCount: deviceName.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(deviceName[index]),
                        );
                      }))
            ])));
  }
}
