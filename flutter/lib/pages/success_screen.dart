import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onichan/pd_utils.dart';
import 'package:onichan/types/order.dart';
import 'package:onichan/utils.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key, required this.order});
  final Order order;

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  bool isSuccess = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          isSuccess = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: pd24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isSuccess)
                SuccessWidget(order: widget.order)
              else
                const LoadingWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class SuccessWidget extends ConsumerStatefulWidget {
  const SuccessWidget({super.key, required this.order});
  final Order order;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SuccessWidgetState();
}

class _SuccessWidgetState extends ConsumerState<SuccessWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/success.png',
          width: 200,
        )
            .animate()
            .scale(
              curve: Curves.easeInOut,
              begin: const Offset(1, 1),
              delay: const Duration(milliseconds: 300),
              duration: const Duration(milliseconds: 300),
              end: const Offset(1.2, 1.2),
            )
            .fadeIn(),
        h12,
        Text(
          "${widget.order.amount / BigInt.from(10).pow(6)} ${widget.order.symbol} の請求に成功しました！",
          style: GoogleFonts.lilitaOne().copyWith(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        h12,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Tx Hash:  0x0a7a...da4B",
              style: GoogleFonts.lilitaOne().copyWith(
                fontSize: 24,
              ),
            ),
            w24,
            GestureDetector(
              onTap: () {
                Clipboard.setData(
                  const ClipboardData(
                    text: "0x0a7a51B8887ca23B13d692eC8Cb1CCa4100eda4B",
                  ),
                );
                okToast("コピーしました");
              },
              child: const Icon(Icons.copy),
            ),
          ],
        ),
      ],
    );
  }
}

class LoadingWidget extends ConsumerWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Stack(
          clipBehavior: Clip.none,
          children: [
            Image.asset(
              'assets/fighter.png',
              width: 200,
            ),
            Positioned(
              bottom: 40,
              right: 20,
              child: Image.asset(
                'assets/riot.png',
                width: 50,
              )
                  .animate(
                    onPlay: (controller) => controller.repeat(reverse: true),
                  )
                  .blur(
                    begin: const Offset(0.0, 0.0),
                    delay: const Duration(milliseconds: 500),
                    curve: Curves.bounceInOut,
                    duration: const Duration(milliseconds: 300),
                    end: const Offset(2, 2),
                  )
                  .scale(
                    curve: Curves.bounceInOut,
                    begin: const Offset(1, 1),
                    delay: const Duration(milliseconds: 300),
                    duration: const Duration(milliseconds: 300),
                    end: const Offset(1.2, 1.2),
                  ),
            ),
            Positioned(
              bottom: 40,
              left: 20,
              child: Transform.flip(
                flipX: true,
                child: Image.asset(
                  'assets/riot.png',
                  width: 50,
                )
                    .animate(
                      onPlay: (controller) => controller.repeat(reverse: true),
                    )
                    .blur(
                      begin: const Offset(0.0, 0.0),
                      delay: const Duration(milliseconds: 500),
                      curve: Curves.bounceInOut,
                      duration: const Duration(milliseconds: 300),
                      end: const Offset(2, 2),
                    )
                    .scale(
                      curve: Curves.bounceInOut,
                      begin: const Offset(1, 1),
                      delay: const Duration(milliseconds: 500),
                      duration: const Duration(milliseconds: 300),
                      end: const Offset(1.6, 1.6),
                    ),
              ),
            ),
          ],
        )
            .animate(
              onPlay: (controller) => controller.repeat(reverse: true),
            )
            .moveX(
              begin: -12,
              end: 12,
              curve: Curves.easeInOutCirc,
              duration: const Duration(milliseconds: 800),
            ),
        Text(
          "待ってね...",
          style: GoogleFonts.lilitaOne().copyWith(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
