import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class AmountScreen extends ConsumerWidget {
  const AmountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {},
          child: Text(
            "振込処理",
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
