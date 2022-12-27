import 'package:flutter/material.dart';
import 'package:forum/ekranlar/giris_ekrani.dart';
import 'package:forum/ekranlar/kayit_ekrani.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:forum/devamlilar.dart';
import 'package:forum/RoundedButton.dart';

class Baslangic_ekrani extends StatefulWidget {
  static const String id = 'baslangic_ekrani';
  @override
  _BaslangicekraniDurum createState() => _BaslangicekraniDurum();
}

class _BaslangicekraniDurum extends State<Baslangic_ekrani>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(controller.value),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                const SizedBox(
                  width: 70,
                ),
                Hero(
                  tag: 'logo',
                  child:  Container(
                    child: Image.asset('images/logo4.png'),
                    height: controller.value * 200,
                    width: 200,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: AnimatedTextKit(
                animatedTexts: [
                  ColorizeAnimatedText('TALK CHAT',
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 50.0,
                      ),
                      colors: colorizedColors),
                ],
                totalRepeatCount: 5,
                //  repeatForever: true,
              ),
            ),
            SizedBox(
              width: 50,
              child: RoundedButton(
                colour: Colors.lightBlueAccent,
                title: 'GİRİŞ YAP',
                onPressed: () {
                  Navigator.pushNamed(context, GirisEkrani.id);
                },
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            RoundedButton(
                title: 'KAYIT OL',
                colour: Colors.blueAccent,
                onPressed: () {
                  Navigator.pushNamed(context, Kayit_ekrani.id);
                }),
          ],
        ),
      ),
    );
  }
}
