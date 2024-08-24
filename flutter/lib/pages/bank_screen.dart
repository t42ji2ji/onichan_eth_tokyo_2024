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
          child: Text(
            "支払完了",
            style: GoogleFonts.delaGothicOne().copyWith(
              fontSize: 150,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
