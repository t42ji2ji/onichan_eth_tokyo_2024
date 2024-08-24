import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oktoast/oktoast.dart';
import 'package:onichan/color_utils.dart';
import 'package:onichan/controller/web3_contrller.dart';
import 'package:onichan/controller/web3_service.dart';
import 'package:onichan/pages/mechant_screen.dart';
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
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: colorBackGround),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final address = ref.watch(web3DartControllerProvider).address;
    final usdtAmount = ref.watch(getTokenBalanceProvider(address, usdtAddress));
    final usdcAmount = ref.watch(getTokenBalanceProvider(address, usdcAddress));
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
            usdtAmount.when(
              data: (data) => Text(
                "總残高: $data USDT",
                style: GoogleFonts.delaGothicOne().copyWith(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Text(
                "$error",
                style: GoogleFonts.delaGothicOne().copyWith(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            h4,
            usdcAmount.when(
              data: (data) => Text(
                "總残高: $data USDC",
                style: GoogleFonts.delaGothicOne().copyWith(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Text(
                "$error",
                style: GoogleFonts.delaGothicOne().copyWith(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
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
                          builder: (context) => const MerchantScreen(),
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
