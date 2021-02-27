const String lang_en = "English";
const String lang_en_us = "USA";
const String lang_sl = "slovenščina";
const String lang_sl_si = "Slovenija";
const String lang_tr = "Turkish";
const String lang_tr_tr = "Turkey";
const String lang_pt_br = "Português"

String lang_v = "en_us";

String wnl;
String yes;
String no;
String disconnect;
String res;
String lang;
String r;
String g;
String b;
String btSettings;
String settings;
String home;

void updateGlobals() {
  if (lang_v == "en_us") {
    wnl = "With new line?";
    yes = "Yes";
    no = "No";
    lang = "Language";
    res = "Resolution (in bits)";
    disconnect = "DISCONNECT";
    r = "R";
    g = "G";
    b = "B";
    btSettings = "Bluetooth Devices";
    settings = "Settings";
    home = "Home";
  } else if (lang_v == "sl_si") {
    wnl = "Z novo vrstico?";
    yes = "Ja";
    no = "Ne";
    lang = "Jezik";
    res = "Resolucija (v bitih)";
    disconnect = "PREKINI POVEZAVO";
    r = "R";
    g = "G";
    b = "B";
    btSettings = "Bluetooth naprave";
    settings = "Nastavitve";
    home = "Domov";
  } else if (lang_v == "tr_tr") {
    wnl = "Yeni hat ile?";
    yes = "Evet";
    no = "Hayır";
    lang = "Dil";
    res = "Çözünürlük (bit bazında)";
    disconnect = "BAĞLANTIYI KES";
    r = "R";
    g = "G";
    b = "B";

    // New strings to translate
    btSettings = "Bluetooth Settings";
    settings = "Settings";
    home = "Home";
  } else if (lang_v == 'pt_br') {
    wnl = "Com nova linha?";
    yes = "Sim";
    no = "Não";
    lang = "Idioma";
    res = "Resolução (em bits)";
    disconnect = "DESCONECTAR";
    r = "R";
    g = "G";
    b = "B";
    btSettings = "Dispositivos Bluetooth";
    settings = "Configurações";
    home = "Início";
  }
}
