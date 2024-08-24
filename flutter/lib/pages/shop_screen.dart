import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onichan/pages/amount_screen.dart';
import 'package:onichan/pd_utils.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

class ShopScreen extends ConsumerWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              "assets/usdt.png",
              height: 100,
            ),
            Text(
              "USDT",
              style: GoogleFonts.delaGothicOne().copyWith(
                fontSize: 72,
              ),
              textAlign: TextAlign.center,
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.topCenter,
              child: Text(
                "1 USDT = ¥ 144",
                style: GoogleFonts.delaGothicOne().copyWith(
                  fontSize: 32,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SimpleCircularProgressBar(
              backStrokeWidth: 0,
              mergeMode: true,
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AmountScreen(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green,
                  ),
                  padding: pdW12,
                  child: Text(
                    "即時購入",
                    style: GoogleFonts.delaGothicOne().copyWith(
                      fontSize: 52,
                      height: 1,
                    ),
                    textAlign: TextAlign.center,
                  )
                      .animate(
                          onPlay: (controller) =>
                              controller.repeat(reverse: true))
                      .scale(
                        curve: Curves.easeInOut,
                        begin: const Offset(1.0, 1.0),
                        end: const Offset(1.1, 1.1),
                        duration: const Duration(
                          milliseconds: 300,
                        ),
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
