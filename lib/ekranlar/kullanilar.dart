import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class KullanicilarEkrani extends StatefulWidget {
  static const String id = 'KullanicilarEkrani_ekrani';

  @override
  State<KullanicilarEkrani> createState() => _KullanicilarEkraniState();
}

class _KullanicilarEkraniState extends State<KullanicilarEkrani> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('kullanicilar').snapshots(),
        builder: (context, querySnapshot) {
          if (!querySnapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          }
          var kullanicilar = querySnapshot.data?.docs;

          List<String> kullaniciEmails = [];
          for (var mesaj in kullanicilar!) {
            kullaniciEmails.add(mesaj.get('e-mail'));
          }
          return ListView.builder(
              itemCount: kullaniciEmails.length,
              itemBuilder: ((context, index) {
                return Card(
                    child: ListTile(
                  leading: const Icon(Icons.person),
                  title: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(kullaniciEmails[index])),
                ));
              }));
        },
      ),
    );
  }
}