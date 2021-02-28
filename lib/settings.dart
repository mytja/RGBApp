import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart' as main;
import 'strings.dart' as s;

enum BitRes { seven, eight, nine, ten, eleven }
enum Lang { en_us, sl_si, tr_tr, pt_br }
enum WNL { y, n }

class SettingsPage extends StatefulWidget {
  _settings createState() => _settings();
}

class _settings extends State<SettingsPage> {
  BitRes bitres = BitRes.seven;
  Lang lng = Lang.en_us;
  WNL wnl1 = WNL.y;

  int _selectedIndex = 2;

  Future<int> factoryDefault() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('name', "RGBApp");
    prefs.setInt('res', 8);
    prefs.setString('lang', "en_us");
    prefs.setBool('wnl', true);
    return 0;
  }

  Future returnAll() async {
    final prefs = await SharedPreferences.getInstance();
    final name1 = prefs.getString('name') ?? 0;
    final res1 = prefs.getInt('res') ?? 0;
    final lang1 = prefs.getString('lang') ?? 0;
    final wnl1 = prefs.getBool('wnl') ?? 0;
    return [name1, res1, lang1, wnl1];
  }

  Future changeKey(String key, var newVal) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
    if (newVal is int) {
      prefs.setInt(key, newVal);
    } else if (newVal is String) {
      prefs.setString(key, newVal);
    } else if (newVal is bool) {
      prefs.setBool(key, newVal);
    }
  }

  Future getJson() async {
    final List prefs = await returnAll();
    if (prefs[0] == 0) {
      print("No prefs have been set! Setting defaults");
      await factoryDefault();
      setState(() {});
    }
    print(prefs);
    return prefs;
  }

  @override
  Widget build(BuildContext context) {
    s.updateGlobals();
    double width = MediaQuery.of(context).size.width;

    void _onItemTapped(int index) {
      if (index == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => main.MyHomePage()),
        );
      }
    }

    return MaterialApp(
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
                  icon: Icon(Icons.settings),
                  label: s.settings,
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.amber[800],
              onTap: _onItemTapped,
            ),
            appBar: AppBar(
              title: const Text('Settings'),
            ),
            body: FutureBuilder(
              future: getJson(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                List<Widget> children;
                if (snapshot.hasData) {
                  var snapJSON = snapshot.data;

                  main.Smax = pow(2, snapJSON[1].toDouble()) - 1;
                  main.Sdiv = pow(2, snapJSON[1].toInt()) - 1;

                  List<BitRes> bitlist = [
                    BitRes.seven,
                    BitRes.eight,
                    BitRes.nine,
                    BitRes.ten,
                    BitRes.eleven
                  ];
                  int bitint = snapJSON[1] - 7;
                  print(bitint);
                  bitres = bitlist[bitint];
                  print(bitres);

                  if (snapJSON[2] == "sl_si") {
                    lng = Lang.sl_si;
                  }
                  if (snapJSON[2] == "en_us") {
                    lng = Lang.en_us;
                  }

                  if (snapJSON[2] == "tr_tr") {
                    lng = Lang.tr_tr;
                  }
                  if (snapJSON[2] == "pt_br") {
                    lng = Lang.pt_br;
                  }

                  if (snapJSON[3] == true) {
                    wnl1 = WNL.y;
                  }
                  if (snapJSON[3] == false) {
                    wnl1 = WNL.n;
                  }

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
                            onChanged: (BitRes value) async {
                              await changeKey("res", 7);
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
                            onChanged: (BitRes value) async {
                              await changeKey("res", 8);
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
                            onChanged: (BitRes value) async {
                              await changeKey("res", 9);
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
                            onChanged: (BitRes value) async {
                              await changeKey("res", 10);
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
                            onChanged: (BitRes value) async {
                              await changeKey("res", 11);
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
                            onChanged: (Lang value) async {
                              await changeKey("lang", "en_us");
                              setState(() {
                                lng = value;
                                s.lang_v = "en_us";
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text(s.lang_pt),
                          subtitle: const Text(s.lang_pt_br),
                          leading: Radio(
                            value: Lang.pt_br,
                            groupValue: lng,
                            onChanged: (Lang value) async {
                              await changeKey("lang", "pt_br");
                              setState(() {
                                lng = value;
                                s.lang_v = "pt_br";
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text(s.lang_tr),
                          subtitle: const Text(s.lang_tr_tr),
                          leading: Radio(
                            value: Lang.tr_tr,
                            groupValue: lng,
                            onChanged: (Lang value) async {
                              await changeKey("lang", "tr_tr");
                              setState(() {
                                lng = value;
                                s.lang_v = "tr_tr";
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
                            onChanged: (Lang value) async {
                              await changeKey("lang", "sl_si");
                              setState(() {
                                lng = value;
                                s.lang_v = "sl_si";
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
                          title: Text(s.yes),
                          leading: Radio(
                            value: WNL.y,
                            groupValue: wnl1,
                            onChanged: (WNL value) async {
                              await changeKey("wnl", true);
                              setState(() {
                                wnl1 = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: Text(s.no),
                          leading: Radio(
                            value: WNL.n,
                            groupValue: wnl1,
                            onChanged: (WNL value) async {
                              await changeKey("wnl", false);
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
