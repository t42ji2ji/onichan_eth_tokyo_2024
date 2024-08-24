import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onichan/color_utils.dart';
import 'package:onichan/pages/amount_screen.dart';
import 'package:onichan/pages/bank_screen.dart';
import 'package:onichan/pd_utils.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ShopScreen extends ConsumerStatefulWidget {
  const ShopScreen(this.maxAmount, {super.key});
  final BigInt maxAmount;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ShopScreenState();
}

class _ShopScreenState extends ConsumerState<ShopScreen>
    with SingleTickerProviderStateMixin {
  var value = 0.0;
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    // final res = ref.watch(
    //     getBalanceProvider("0x63128AEaBd2b402d7eAAf14d0c486d0D850d72Dd"));
    final maxAmount = widget.maxAmount / BigInt.from(10).pow(6);
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            h60,
            // Image.asset(
            //   "assets/usdt.png",
            //   height: 100,
            // ),
            // res.when(
            //   data: (data) {
            //     return Text(
            //       "残高: $data ETH",
            //       style: GoogleFonts.delaGothicOne().copyWith(
            //         fontSize: 20,
            //       ),
            //       textAlign: TextAlign.center,
            //     );
            //   },
            //   loading: () => const Center(child: CircularProgressIndicator()),
            //   error: (error, stack) => Text(
            //     "エラー: $error",
            //     style: GoogleFonts.delaGothicOne().copyWith(
            //       fontSize: 20,
            //     ),
            //     textAlign: TextAlign.center,
            //   ),
            // ),

            h24,

            Stack(
              children: [
                Positioned(
                  right: 20,
                  child: Opacity(
                    opacity: value < maxAmount ? 0 : 1,
                    child: Text(
                      "すごい",
                      style: GoogleFonts.delaGothicOne().copyWith(
                        fontSize: 30,
                        color: colorBlack,
                      ),
                      textAlign: TextAlign.center,
                    )
                        .animate(
                          controller: _controller,
                        )
                        .scale(
                          curve: Curves.easeInOut,
                          begin: const Offset(1.0, 1.0),
                          end: const Offset(1.1, 1.1),
                          delay: const Duration(
                            milliseconds: 300,
                          ),
                          duration: const Duration(
                            milliseconds: 300,
                          ),
                        )
                        .fade(
                          begin: 0,
                          end: 1.0,
                        )
                        .rotate(
                          curve: Curves.easeInOut,
                          begin: 0.0,
                          end: 0.1,
                          delay: const Duration(
                            milliseconds: 200,
                          ),
                          duration: const Duration(
                            milliseconds: 300,
                          ),
                        )
                        .move(
                          curve: Curves.easeInOut,
                          begin: const Offset(-30, 0.0),
                          end: const Offset(0, -10),
                          duration: const Duration(
                            milliseconds: 300,
                          ),
                        ),
                  ),
                ),
                Center(
                  child: CircularPercentIndicator(
                    radius: 75.0,
                    lineWidth: 6.0,
                    percent: value / maxAmount,
                    progressColor: Colors.black,
                    backgroundColor: Colors.transparent,
                  )
                      .animate(
                        onPlay: (controller) =>
                            controller.repeat(reverse: true),
                      )
                      .scale(
                        curve: Curves.easeInOut,
                        begin: const Offset(1.0, 1.0),
                        end: value < maxAmount
                            ? const Offset(1.0, 1.0)
                            : const Offset(1.1, 1.1),
                        duration: const Duration(
                          milliseconds: 300,
                        ),
                      ),
                ),
                if (value > 0)
                  Center(
                    child: Image.asset(
                      'assets/face.png',
                      width: 150,
                    ),
                  )
              ],
            ),
            Text(
              "USDT",
              style: GoogleFonts.delaGothicOne().copyWith(
                fontSize: 70,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              "max: $maxAmount USDT",
              style: GoogleFonts.delaGothicOne().copyWith(
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Text(
                    "${(value).toStringAsFixed(2)} USDT",
                    style: GoogleFonts.delaGothicOne().copyWith(
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "= ¥ ${(value * 144).toStringAsFixed(2)}",
                    style: GoogleFonts.delaGothicOne().copyWith(
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            Expanded(
              child: Padding(
                padding: pd16,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "いくら買いたいの？",
                      style: GoogleFonts.lilitaOne().copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Slider(
                      min: 0.0,
                      max: maxAmount,
                      value: value,
                      thumbColor: colorGreen,
                      activeColor: colorGreen.withOpacity(0.5),
                      onChanged: (value) {
                        if (value == maxAmount) {
                          SystemSound.play(SystemSoundType.alert);
                          HapticFeedback.heavyImpact();
                        } else {
                          HapticFeedback.lightImpact();
                        }
                        setState(() {
                          this.value = value;
                        });
                        _controller.repeat(reverse: true);
                      },
                    ),
                  ],
                ),
              ),
            ),
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
                child: GestureDetector(
                  onTap: () {
                    final amount = (Decimal.parse(value.toString()) *
                            Decimal.fromBigInt(BigInt.from(10).pow(6))) *
                        Decimal.fromInt(144);

                    debugPrint('=======amount : $amount=========');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BankScreen(amount.toBigInt()),
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
            ),
            h12,
          ],
        ),
      ),
    );
  }
}
