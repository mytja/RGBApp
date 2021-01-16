import 'package:flutter/material.dart';

import 'main.dart';
import 'strings.dart' as s;

import 'dart:io';
import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

enum BitRes { seven, eight, nine, ten, eleven }
enum Lang { en_us, sl_si }
enum WNL { y, n }

class FileModifier {
  Future<String> getJson() async {
    var file = await File('settings.json').readAsString();
    String jsonString = file;
    return jsonDecode(jsonString);
  }
}

class SettingsPage extends StatefulWidget {
  _settings createState() => _settings();
}

class _settings extends State<SettingsPage> {
  BitRes bitres = BitRes.seven;
  Lang lng = Lang.en_us;
  WNL wnl1 = WNL.y;

  int _selectedIndex = 2;

  Future<String> getJson() async {
    final file = await rootBundle.loadString('assets/settings.json');
    String jsonString = file;
    print(jsonString);
    return jsonString;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    void _onItemTapped(int index) {
      if (index == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
        );
      }
    }

    return MaterialApp(
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
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.amber[800],
              onTap: _onItemTapped,
            ),
            appBar: AppBar(
              title: const Text('Settings'),
            ),
            body: FutureBuilder<String>(
              future: getJson(),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                List<Widget> children;
                if (snapshot.hasData) {
                  var snapJSON = jsonDecode(snapshot.data);

                  List<BitRes> bitlist = [
                    BitRes.seven,
                    BitRes.eight,
                    BitRes.nine,
                    BitRes.ten,
                    BitRes.eleven
                  ];
                  int bitint = snapJSON["res"] - 7;
                  print(bitint);
                  bitres = bitlist[bitint];
                  print(bitres);

                  children = <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          height: 25,
                        ),
                        Text(s.res,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        ListTile(
                          title: const Text('7'),
                          leading: Radio(
                            value: BitRes.seven,
                            groupValue: bitres,
                            onChanged: (BitRes value) {
                              setState(() {
                                bitres = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('8'),
                          leading: Radio(
                            value: BitRes.eight,
                            groupValue: bitres,
                            onChanged: (BitRes value) {
                              setState(() {
                                bitres = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('9'),
                          leading: Radio(
                            value: BitRes.nine,
                            groupValue: bitres,
                            onChanged: (BitRes value) {
                              setState(() {
                                bitres = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('10'),
                          leading: Radio(
                            value: BitRes.ten,
                            groupValue: bitres,
                            onChanged: (BitRes value) {
                              setState(() {
                                bitres = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('11'),
                          leading: Radio(
                            value: BitRes.eleven,
                            groupValue: bitres,
                            onChanged: (BitRes value) {
                              setState(() {
                                bitres = value;
                              });
                            },
                          ),
                        ),
                        Container(
                          height: 50,
                        ),
                        Text(s.lang,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        ListTile(
                          title: const Text(s.lang_en),
                          subtitle: const Text(s.lang_en_us),
                          leading: Radio(
                            value: Lang.en_us,
                            groupValue: lng,
                            onChanged: (Lang value) {
                              setState(() {
                                lng = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text(s.lang_sl),
                          subtitle: const Text(s.lang_sl_si),
                          leading: Radio(
                            value: Lang.sl_si,
                            groupValue: lng,
                            onChanged: (Lang value) {
                              setState(() {
                                lng = value;
                              });
                            },
                          ),
                        ),
                        Container(
                          height: 50,
                        ),
                        Text(s.wnl,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        ListTile(
                          title: const Text(s.yes),
                          leading: Radio(
                            value: WNL.y,
                            groupValue: wnl1,
                            onChanged: (WNL value) {
                              setState(() {
                                wnl1 = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text(s.no),
                          leading: Radio(
                            value: WNL.n,
                            groupValue: wnl1,
                            onChanged: (WNL value) {
                              setState(() {
                                wnl1 = value;
                              });
                            },
                          ),
                        ),
                      ],
                    )
                  ];
                } else {
                  Container(
                    width: width,
                    child: Text("Please wait!"),
                  );
                }
                return SingleChildScrollView(
                  child: Column(children: children),
                );
              },
            )));
  }
}
