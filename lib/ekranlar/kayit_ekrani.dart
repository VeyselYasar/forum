import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forum/RoundedButton.dart';
import 'package:forum/devamlilar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:forum/ekranlar/giris_ekrani.dart';
import 'package:forum/show_error_meesage.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Kayit_ekrani extends StatefulWidget {
  static const String id = 'kayit_ekrani';
  @override
  _KayitekraniDurum createState() => _KayitekraniDurum();
}

class _KayitekraniDurum extends State<Kayit_ekrani> {
  bool spinnergoster = false;
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  late String email;
  late String sifre;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: spinnergoster,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo4.png'),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'E-mailinizi giriniz')),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  sifre = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: ' Şifrenizi giriniz'),
              ),
              const SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                title: 'KAYIT OL',
                colour: Colors.blueAccent,
                onPressed: () async {
                  setState(() {
                    spinnergoster = true;
                  });
                  try {
                    final newuser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: sifre);
                    await _firestore.collection('kullanicilar').add({
                        'e-mail': email,

                      });    
                    if (newuser != null) {
                      Navigator.push(context, MaterialPageRoute(builder: ((context) => GirisEkrani(email: email,sifre: sifre,))));
                      
                     // Navigator.pushNamed(context, GirisEkrani.id,arguments: {email,sifre});
                    }
                    setState(() {
                      spinnergoster = false;
                    });
                  } on FirebaseAuthException catch (authException) {
                    switch (authException.code) {
                      case "email-already-in-use":
                        showErrorMessage(
                            context: context,
                            errorMessage:
                                "Zaten kayıt oldunuz lütfen giriş yapınız.");
                        setState(() {
                          spinnergoster = false;
                        });

                        break;
                      case "invalid-email":
                        showErrorMessage(
                            context: context,
                            errorMessage:
                                "Lütfen e-mail adresinizi doğru formatta giriniz..");
                        setState(() {
                          spinnergoster = false;
                        });
                        break;
                      default:
                        showErrorMessage(
                            context: context,
                            errorMessage:
                                "Beklenmedik bir hata oluştu. Tekrar deneyiniz.");
                        setState(() {
                          spinnergoster = false;
                        });
                    }
                  } catch (error) {
                    showErrorMessage(
                        context: context,
                        errorMessage:
                            "Beklenmedik bir hata oluştu. Tekrar deneyiniz...");
                    setState(() {
                      spinnergoster = false;
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
