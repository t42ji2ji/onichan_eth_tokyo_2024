import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ProofScreen extends ConsumerWidget {
  const ProofScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Text(
          "証明作成",
          style: GoogleFonts.delaGothicOne().copyWith(
            fontSize: 150,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
