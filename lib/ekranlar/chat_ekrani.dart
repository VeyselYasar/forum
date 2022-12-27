import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:forum/devamlilar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
late User girisyapmiskullanici;

class chat_ekrani extends StatefulWidget {
  static const String id = 'chat_ekrani';

  @override
  _chatEkraniDurum createState() => _chatEkraniDurum();
}

class _chatEkraniDurum extends State<chat_ekrani> {
  final MesajTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  late String mesajText;
  String searchValue = "";
  bool internetDurumu = false;
  late StreamSubscription internetBaglantiDinleyicisi;

  @override
  void initState() {
    super.initState();
    KullaniciyiGetir();
     internetBaglantiDinleyicisi = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult sonuc) {
      if (sonuc == ConnectivityResult.mobile ||
          sonuc == ConnectivityResult.wifi) {
       setState(() {
         internetDurumu = true;
       });
      } else {
        setState(() {
          internetDurumu=false;
        });
      }
    });
  }

  void KullaniciyiGetir() async {
    try {
      final kullanici = await _auth.currentUser;
      if (kullanici != null) {
        girisyapmiskullanici = kullanici;
      }
    } catch (e) {
      print(e);
    }
  }

  void mesajlarStream() async {
    await for (var snapshot in _firestore.collection('mesajlar').snapshots()) {
      for (var mesaj in snapshot.docs) {
        print(mesaj.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('TALK  CHAT'),
            Row(children: [
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  color: internetDurumu ? Colors.green :Colors.red,
                  borderRadius: BorderRadius.circular(50)
                ),
              ),
              SizedBox(width: 8,),
              Text(internetDurumu ? "Bağlantınız Mevcut" : "Bağlantınız Kesildi" ,style: TextStyle(color: Colors.white,),)
            ],)
          ],
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(hintText: "Search"),
              onChanged: ((value) {
                setState(() {
                  searchValue = value;
                });
              }),
            ),
            SizedBox(
              height: 4,
            ),
            MesajStream(
              searchValue: searchValue,
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: MesajTextController,
                      onChanged: (value) {
                        mesajText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      MesajTextController.clear();
                      _firestore.collection('mesajlar').add({
                        'mesaj': mesajText,
                        'sender': girisyapmiskullanici.email,
                        'date': DateTime.now().toIso8601String().toString(),
                      });
                    },
                    child: const Text(
                      'Gönder',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MesajStream extends StatelessWidget {
  final String searchValue;

  const MesajStream({super.key, required this.searchValue});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('mesajlar').orderBy('date').snapshots(),
      builder: (context, QuerySnapshot) {
        if (!QuerySnapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        var mesajlar = QuerySnapshot.data?.docs.reversed;

        List<MesajBubble> mesajBubbles = [];
        for (var mesaj in mesajlar!) {
          final mesajText = mesaj.get('mesaj');
          final mesajGonderici = mesaj.get('sender');
          final suankikullanici = girisyapmiskullanici.email;

          final mesajBubble = MesajBubble(
            gonderici: mesajGonderici,
            aratildiMi: mesajText== searchValue,
            mesaj: mesajText,
            benMi: suankikullanici == mesajGonderici,
          );
          mesajBubbles.add(mesajBubble);
        }
        return Expanded(
            child: ListView(
          reverse: true,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          children: mesajBubbles,
        ));
      },
    );
  }
}

class MesajBubble extends StatelessWidget {
  MesajBubble(
      {required this.gonderici, required this.mesaj, required this.benMi,required this.aratildiMi});
  final bool benMi;
  final String gonderici;
  final String mesaj;
  final bool aratildiMi;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            benMi ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            gonderici,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
          Material(
            borderRadius: benMi
                ? const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))
                : const BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
            elevation: 5.0,
            color: benMi ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                '$mesaj ',
                style: TextStyle(
                  fontSize: 15.0,
                  color:aratildiMi ? Colors.yellow :   benMi ? Colors.white : Colors.black54,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
