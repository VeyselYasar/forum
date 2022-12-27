import 'package:flutter/material.dart';
import 'package:forum/RoundedButton.dart';
import 'package:forum/ekranlar/chat_ekrani.dart';
import 'package:forum/ekranlar/kullanilar.dart';
import 'package:forum/films.dart';
class YonlendirmeEkrani extends StatefulWidget {
  const YonlendirmeEkrani({super.key});
    static const String id = 'YonlendirmeEkrani_ekrani';

  @override
  State<YonlendirmeEkrani> createState() => _YonlendirmeEkraniState();
}

class _YonlendirmeEkraniState extends State<YonlendirmeEkrani> {

  DateTime dateTime=DateTime.now();
  List<Film>? filmler;
  Film? gununFilmi;

  @override
  void initState() {
    super.initState();
    filmler = Film.filmleriGetir();
    gununFilmi = filmler!.firstWhere((element) => element.id == dateTime.day.toString());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SafeArea(
          child: Column(
        
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.5,width:double.infinity,child: Image.asset(gununFilmi!.resimAdresi , fit: BoxFit.fill,)),
               SizedBox(height: 8,),
               Text("Günün Filmi : ${gununFilmi!.baslik}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
             Spacer(),
              RoundedButton(colour: Colors.blue, onPressed: () {
                Navigator.pushNamed(context, KullanicilarEkrani.id);
              }, title: 'Kullanıcılar',),
              RoundedButton(colour: Colors.blue, onPressed: () { 
                Navigator.pushNamed(context, chat_ekrani.id);
               }, title: 'Chat',),
            ],
          ),
        ),
      ),
    );
  }
}

