import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onichan/color_utils.dart';
import 'package:onichan/controller/web3_contrller.dart';
import 'package:onichan/controller/web3_service.dart';
import 'package:onichan/pages/shop_screen.dart';
import 'package:onichan/pd_utils.dart';

class MerchantScreen extends ConsumerWidget {
  const MerchantScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allOrders = ref.watch(allOrdersProvider).valueOrNull ?? [];
    final totalAmount =
        allOrders.fold(BigInt.from(0), (sum, order) => sum + order.amount);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context, builder: (_) => const CreateOrderDialog());
        },
        backgroundColor: colorGreen,
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
          padding: pd16,
          child: Column(
            children: [
              Text(
                "注文一覧",
                style: GoogleFonts.delaGothicOne().copyWith(
                  fontSize: 32,
                ),
              ),
              h12,
              Expanded(
                child: ListView.builder(
                  itemCount: allOrders.length,
                  itemBuilder: (_, index) {
                    final order = allOrders[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShopScreen(order),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 30,
                        shadowColor: colorBackGround.withOpacity(0.4),
                        child: Padding(
                          padding: pd12,
                          child: Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                  splashColor: Colors.transparent,
                                  selectedColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  title: Text(
                                    "注文番号: ${order.id}",
                                    style: GoogleFonts.delaGothicOne().copyWith(
                                      fontSize: 20,
                                    ),
                                  ),
                                  subtitle: Text(
                                    "金額: ${order.amount / BigInt.from(10).pow(6)} ${order.symbol}\n状態: 未受取",
                                    style: GoogleFonts.delaGothicOne().copyWith(
                                      fontSize: 16,
                                    ),
                                  ),
                                  onTap: () {},
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: colorGreen,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  "注文",
                                  style: GoogleFonts.delaGothicOne().copyWith(
                                    fontSize: 20,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Divider(
                height: 24,
              ),
              Row(
                children: [
                  Image.asset(
                    "assets/usdt.png",
                    width: 32,
                    height: 32,
                  ),
                  w8,
                  Expanded(
                    child: Text(
                      "總残高: ${totalAmount / BigInt.from(10).pow(6)} USDT",
                      style: GoogleFonts.delaGothicOne().copyWith(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CreateOrderDialog extends ConsumerStatefulWidget {
  const CreateOrderDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateOrderDialogState();
}

class _CreateOrderDialogState extends ConsumerState<CreateOrderDialog> {
  double value = 0.0;
  bool isUsdt = true;
  @override
  Widget build(
    BuildContext context,
  ) {
    final address = ref.watch(web3DartControllerProvider).address;

    final amount = ref.watch(
        getTokenBalanceProvider(address, isUsdt ? usdtAddress : usdcAddress));
    return Dialog(
      child: Padding(
        padding: pd12,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "注文を作成",
              style: GoogleFonts.delaGothicOne().copyWith(
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
            const Divider(),
            Text(
              "残高: ${amount.valueOrNull} ${isUsdt ? "USDT" : "USDC"}",
              style: GoogleFonts.delaGothicOne().copyWith(
                fontSize: 16,
              ),
            ),
            Text(
              isUsdt ? "USDT" : "USDC",
              style: GoogleFonts.delaGothicOne().copyWith(
                fontSize: 16,
              ),
              textAlign: TextAlign.start,
            ),
            Text(
              value.toStringAsFixed(3),
              style: GoogleFonts.delaGothicOne().copyWith(
                fontSize: 32,
              ),
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "USDC",
                  style: GoogleFonts.delaGothicOne().copyWith(
                    fontSize: 16,
                  ),
                ),
                Switch(
                    value: isUsdt,
                    activeColor: colorGreen,
                    onChanged: (value) {
                      HapticFeedback.lightImpact();
                      setState(() {
                        isUsdt = value;
                      });
                    }),
                Text(
                  "USDT",
                  style: GoogleFonts.delaGothicOne().copyWith(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Slider(
              min: 0.0,
              max: double.tryParse(amount.valueOrNull ?? "0") ?? 0.0,
              value: value,
              thumbColor: colorGreen,
              activeColor: colorGreen.withOpacity(0.5),
              onChanged: (value) {
                HapticFeedback.lightImpact();
                setState(() {
                  this.value = value;
                });
              },
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green,
                  ),
                  padding: pdW12,
                  child: Text(
                    "Add Liquidity",
                    style: GoogleFonts.delaGothicOne().copyWith(
                      fontSize: 42,
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
          ],
        ),
      ),
    );
  }
}
