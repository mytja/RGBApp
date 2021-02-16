const String lang_en = "English";
const String lang_en_us = "USA";
const String lang_sl = "slovenščina";
const String lang_sl_si = "Slovenija";
const String lang_tr = "Turkish";
const String lang_tr_tr = "Turkey";

String lang_v = "en_us";
String lang_v = "tr_tr"; 

String wnl;
String yes;
String no;
String disconnect;
String res;
String lang;
String r;
String g;
String b;

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
 } 
}
