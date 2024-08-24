import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onichan/pages/proof_screen.dart';
import 'package:onichan/pd_utils.dart';

class BankScreen extends ConsumerWidget {
  const BankScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProofScreen(
                  title: '',
                ),
              ),
            );
          },
          child: Padding(
            padding: pd24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Image(image: AssetImage('assets/images/bank.png')),
                Text(
                  "銀行振込",
                  style: GoogleFonts.delaGothicOne().copyWith(
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.center,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "銀行口座",
                        style: GoogleFonts.delaGothicOne().copyWith(
                          fontSize: 24,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "0000-1234-5678-0000",
                          style: GoogleFonts.delaGothicOne().copyWith(
                            fontSize: 60,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      FittedBox(
                        child: Text(
                          "¥112,500",
                          style: GoogleFonts.delaGothicOne().copyWith(
                            fontSize: 100,
                            color: const Color(
                                0xFFb52b12), // You can start with a large font size
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      FittedBox(
                        child: Text(
                          "指定された銀行口座に、ぴったりの金額を送金してね。",
                          style: GoogleFonts.lilitaOne().copyWith(
                            fontSize:
                                100, // You can start with a large font size
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "もう一度確認してね。",
                          style: GoogleFonts.lilitaOne().copyWith(
                            fontSize:
                                100, // You can start with a large font size
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                ClipOval(
                  child: Container(
                    width: 160.0, // Set the width of the circle
                    height: 160.0, // Set the height of the circle
                    decoration: const BoxDecoration(
                      color: Color(0xFFb52b12), // Background color of the stamp
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      // Center the content inside the circle
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize
                            .min, // Make the column as small as possible
                        children: [
                          Text(
                            "支払",
                            style: GoogleFonts.delaGothicOne().copyWith(
                              fontSize: 60, // Increase the font size
                              color: Colors.white,
                              height:
                                  0.8, // Adjust the height to bring lines closer together
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "完了",
                            style: GoogleFonts.delaGothicOne().copyWith(
                              fontSize: 60, // Increase the font size
                              color: Colors.white,
                              height:
                                  0.8, // Adjust the height to bring lines closer together
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
