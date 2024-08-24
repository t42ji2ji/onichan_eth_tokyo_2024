import 'package:flutter/material.dart';
import 'package:onichan/pages/success_screen.dart';
import 'package:onichan/reclaim.dart';
import 'package:onichan/types/order.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onichan/pd_utils.dart';
import 'package:onichan/utils.dart';

class BankScreen extends ConsumerStatefulWidget {
  const BankScreen({super.key, required this.order});
  final Order order;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BankScreenState();
}

class _BankScreenState extends ConsumerState<BankScreen> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: pd24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Image(
                image: AssetImage(
                  'assets/neco.png',
                ),
                height: 160,
              ),
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
                      child: Row(
                        children: [
                          Text(
                            "0000-1234-5678-0000",
                            style: GoogleFonts.delaGothicOne().copyWith(
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          w8,
                          GestureDetector(
                            onTap: () {
                              Clipboard.setData(
                                const ClipboardData(
                                  text: "0000-1234-5678-0000",
                                ),
                              );
                              HapticFeedback.lightImpact();
                              okToast("コピーしました");
                            },
                            child: const Icon(
                              Icons.copy,
                              size: 32,
                            ),
                          ),
                        ],
                      ),
                    ),
                    FittedBox(
                      child: Text(
                        "¥${(widget.order.amount * BigInt.from(144) / BigInt.from(10).pow(6)).toStringAsFixed(2)}",
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
                          fontSize: 100, // You can start with a large font size
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
                          fontSize: 100, // You can start with a large font size
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  setState(() {
                    loading = true;
                  });
                  startVerificationFlow();
                  await Future.delayed(const Duration(seconds: 30));
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SuccessScreen(order: widget.order),
                    ),
                  );
                },
                child: ClipOval(
                  child: Container(
                    width: 160.0,
                    height: 160.0,
                    decoration: const BoxDecoration(
                      color: Color(0xFFb52b12),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: loading
                          ? const CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                              strokeWidth: 6.0,
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "支払",
                                  style: GoogleFonts.delaGothicOne().copyWith(
                                    fontSize: 60,
                                    color: Colors.white,
                                    height: 0.8,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  "完了",
                                  style: GoogleFonts.delaGothicOne().copyWith(
                                    fontSize: 60,
                                    color: Colors.white,
                                    height: 0.8,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
