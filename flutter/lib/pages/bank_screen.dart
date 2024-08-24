import 'package:flutter/material.dart';
import 'package:onichan/pages/success_screen.dart';
import 'package:onichan/types/order.dart';
import 'package:reclaim_sdk/flutter_reclaim.dart';
import 'package:reclaim_sdk/types.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onichan/pd_utils.dart';
import 'package:onichan/utils.dart';

const providerId = '9efd071e-2349-437d-b5df-62345e46a682';
const applicationId = '0x5404B0B7D667cCc004b5e2886FC49D33D77FF5C0';
const applicationSecret =
    '0xaedf096d7dfbc037b59ccdaaa2c5845113a7ef2d75600bf78bac80d5dbd329c1';
// final providerId = '84f7cdab-682a-49aa-8fe9-84b3456036d8';
// final applicationId = '0x85e0D267968e12d213Ab21aE6c4467a1B59a2d08';
// final applicationSecret =
//     '0xe1c571f43414f82ee45e28a15030ab10277788886deea364cd4a6b1e008ffe8e';

const address = '0x0901549Bc297BCFf4221d0ECfc0f718932205e33';
const message = 'testing';

String data = "";

void startVerificationFlow() async {
  final proofRequest = ProofRequest(applicationId: applicationId);
  proofRequest.setAppCallbackUrl('YOUR_DEEP_LINK_HERE');
  proofRequest.addContext(address, message);

  await proofRequest.buildProofRequest(providerId);

  proofRequest.setSignature(proofRequest.generateSignature(applicationSecret));

  final verificationRequest = await proofRequest.createVerificationRequest();
  print('verificationRequest: $verificationRequest');

  final startSessionParam = StartSessionParams(
    onSuccessCallback: (proof) {
      print('proof: $proof');
      //   setState(() {
      //   // This is where you would handle the proof data
      //   data = jsonEncode(proof.claimData);
      //   print('data: $data');
      //   final contractParam = Reclaim.transformForOnchain(proof);
      //   print('contractParam: $contractParam');
      // });
    },
    onFailureCallback: (error) => {
      print('error: $error'),
      // setState(() {
      //   data = 'Error: $error';
      // })
    },
  );

  await proofRequest.startSession(startSessionParam);
}

class BankScreen extends ConsumerWidget {
  const BankScreen(this.order, {super.key});
  final Order order;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          // onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => const ProofScreen(
          //       title: '',
          //     ),
          //   ),
          // );
          // },
          onTap: startVerificationFlow,
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
                // TextButton(
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => SuccessScreen(order: order),
                //       ),
                //     );
                //   },
                //   child: Text("OK"),
                // ),
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
                          "¥${(order.amount / BigInt.from(10).pow(6)).toStringAsFixed(4)}",
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
                            fontSize:
                                100, // You can start with a large font size
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
                            fontSize:
                                100, // You can start with a large font size
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                ClipOval(
                  child: Container(
                    width: 160.0, // Set the width of the circle
                    height: 160.0, // Set the height of the circle
                    decoration: const BoxDecoration(
                      color: Color(0xFFb52b12), // Background color of the stamp
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      // Center the content inside the circle
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize
                            .min, // Make the column as small as possible
                        children: [
                          Text(
                            "支払",
                            style: GoogleFonts.delaGothicOne().copyWith(
                              fontSize: 60, // Increase the font size
                              color: Colors.white,
                              height:
                                  0.8, // Adjust the height to bring lines closer together
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "完了",
                            style: GoogleFonts.delaGothicOne().copyWith(
                              fontSize: 60, // Increase the font size
                              color: Colors.white,
                              height:
                                  0.8, // Adjust the height to bring lines closer together
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
