import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onichan/pages/proof_screen.dart';

class BankScreen extends ConsumerWidget {
  const BankScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: GestureDetector(
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
        child: Center(
          child: Column(
            children: [
              Image.asset(
                'assets/note.png',
                width: 150, // or BoxFit.contain, BoxFit.fill, etc.
              ),
              Text(
                "TRANSFER TO BANK",
                style: GoogleFonts.delaGothicOne().copyWith(
                  fontSize: 24,
                ),
                textAlign: TextAlign.center,
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "0000-1234-5678-0000",
                    style: GoogleFonts.delaGothicOne().copyWith(
                      fontSize: 60,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "¥112,500",
                    style: GoogleFonts.delaGothicOne().copyWith(
                      fontSize: 100,
                      color: Color(
                          0xFFb52b12), // You can start with a large font size
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "Send the exact amount to the specified bank account.",
                    style: GoogleFonts.delaGothicOne().copyWith(
                      fontSize: 100, // You can start with a large font size
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "Double check you are sending to the correct bank account.",
                    style: GoogleFonts.delaGothicOne().copyWith(
                      fontSize: 100, // You can start with a large font size
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Spacer(),
              ClipOval(
                child: Container(
                  width: 160.0, // Set the width of the circle
                  height: 160.0, // Set the height of the circle
                  decoration: BoxDecoration(
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
              SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
