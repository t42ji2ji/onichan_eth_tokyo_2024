import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oktoast/oktoast.dart';
import 'package:onichan/color_utils.dart';
import 'package:onichan/pages/shop_screen.dart';
import 'package:onichan/pd_utils.dart';
import 'package:onichan/utils.dart';
import 'package:rive/rive.dart';
import 'package:text_to_speech/text_to_speech.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: colorBackGround),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    okToast('You have pushed the button this many times: $_counter');
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Stack(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "ONI",
                        style: GoogleFonts.lilitaOne().copyWith(
                          fontSize: 30,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 250,
                      ),
                      Text(
                        "CHAN",
                        style: GoogleFonts.lilitaOne().copyWith(
                          fontSize: 30,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const RiveAnimation.asset(
                    'assets/onichan.riv',
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        try {
                          String text = "よし、心配しないで。これからお兄ちゃんがちゃんと助けてあげるからね。";
                          TextToSpeech tts = TextToSpeech();
                          tts.setLanguage('ja-JP');
                          tts.setVolume(1.0);

                          tts.speak(text);
                        } catch (e) {
                          okToast(e.toString());
                        }
                      },
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        padding: pd12,
                        margin: pdH20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'よし、心配しないで。これからお兄ちゃんがちゃんと助けてあげるからね。',
                          style: GoogleFonts.lilitaOne().copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  w12,
                  DefautBtn(
                    text: "GO",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ShopScreen(),
                        ),
                      );
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DefautBtn extends ConsumerWidget {
  const DefautBtn({required this.text, required this.onPressed, super.key});
  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.bottomCenter,
        padding: pdW24H16,
        margin: pdH20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: colorGreen,
        ),
        child: Text(
          text,
          style: GoogleFonts.lilitaOne().copyWith(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
