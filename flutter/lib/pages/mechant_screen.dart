import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onichan/color_utils.dart';
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
      body: SafeArea(
        child: Padding(
          padding: pd16,
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset('assets/onii.png', width: 30),
                  Expanded(
                    child: Text(
                      "残高: ${totalAmount / BigInt.from(10).pow(6)} USD",
                      style: GoogleFonts.delaGothicOne().copyWith(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              h24,
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
            ],
          ),
        ),
      ),
    );
  }
}
