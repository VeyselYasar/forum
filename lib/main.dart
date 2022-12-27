
import 'package:flutter/material.dart';
import 'package:forum/ekranlar/baslangic_ekrani.dart';
import 'package:forum/ekranlar/chat_ekrani.dart';
import 'package:forum/ekranlar/giris_ekrani.dart';
import 'package:forum/ekranlar/kayit_ekrani.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:forum/ekranlar/kullanilar.dart';
import 'package:forum/ekranlar/yonlendirme.dart';
void main() => runApp(TalkChat());

class TalkChat extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
Firebase.initializeApp();
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      initialRoute:Baslangic_ekrani.id ,
      routes: {
         Baslangic_ekrani.id:(context) =>Baslangic_ekrani(),
        GirisEkrani.id:(context) =>GirisEkrani(),
        Kayit_ekrani.id:(context) =>Kayit_ekrani(),
        chat_ekrani.id:(context) =>chat_ekrani(),
        KullanicilarEkrani.id:(context) => KullanicilarEkrani(),
        YonlendirmeEkrani.id:(context)=>YonlendirmeEkrani()
        }
    );
  }
}