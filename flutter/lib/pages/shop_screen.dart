import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ShopScreen extends ConsumerWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Text(
          "馬上購入",
          style: GoogleFonts.delaGothicOne().copyWith(
            fontSize: 150,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
