import 'package:flutter/material.dart';
import 'package:forum/RoundedButton.dart';
import 'package:forum/devamlilar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:forum/ekranlar/yonlendirme.dart';
import 'package:forum/show_error_meesage.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class GirisEkrani extends StatefulWidget {
  static const String id = 'giris_ekrani';
   String? email;
   String? sifre;

   GirisEkrani({super.key,  this.email,  this.sifre});
  @override
  _GirisEkraniDurum createState() => _GirisEkraniDurum();
}

class _GirisEkraniDurum extends State<GirisEkrani> {
  final _auth = FirebaseAuth.instance;
  bool spinnerGoster = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: spinnerGoster,
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
              TextFormField(
                  initialValue: widget.email ?? '',
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    widget.email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'E-mailinizi giriniz')),
              const SizedBox(
                height: 8.0,
              ),
              TextFormField(
                  initialValue: widget.email ?? '',
                  textAlign: TextAlign.center,
                  obscureText: true,
                  onChanged: (value) {
                    widget.sifre = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Şifrenizi giriniz')),
              const SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                title: 'GİRİŞ YAP',
                colour: Colors.lightBlueAccent,
                onPressed: () async {
                  setState(() {
                    spinnerGoster = true;
                  });
                  try {
                    final kullanici = await _auth.signInWithEmailAndPassword(
                        email: widget.email ?? '', password: widget.sifre ?? '');
                    if (kullanici != null) {
                      Navigator.pushNamed(context, YonlendirmeEkrani.id);
                    }
                    setState(() {
                      spinnerGoster = false;
                    });
                  } on FirebaseAuthException catch (authException) {
                    switch (authException.code) {
                      case "invalid-email":
                        showErrorMessage(
                            context: context,
                            errorMessage:
                                "Lütfen e-mail adresinizi doğru formatta giriniz.");
                        setState(() {
                          spinnerGoster = false;
                        });

                        break;
                      case "wrong-password":
                        showErrorMessage(
                            context: context,
                            errorMessage: "Lütfen şifrenizi doğru giriniz.");
                        setState(() {
                          spinnerGoster = false;
                        });
                        break;
                      case "user-not-found":
                        showErrorMessage(
                            context: context,
                            errorMessage: "Sistem de böyle bir kullanıcı yok. Lütfen kayıt olunuz.");
                        setState(() {
                          spinnerGoster = false;
                        });
                        break;
                      default:
                        showErrorMessage(
                            context: context,
                            errorMessage: "Beklenmedik bir hata oluştu. Tekrar deneyiniz.");
                        setState(() {
                          spinnerGoster = false;
                        });
                    }
                  } catch (error) {
                    showErrorMessage(
                        context: context,
                        errorMessage: "Beklenmedik bir hata oluştu. Tekrar deneyiniz...");
                    setState(() {
                      spinnerGoster = false;
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
