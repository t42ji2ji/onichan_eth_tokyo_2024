import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onichan/pages/amount_screen.dart';

class ShopScreen extends ConsumerWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AmountScreen(),
              ),
            );
          },
          child: Text(
            "即時購入",
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
