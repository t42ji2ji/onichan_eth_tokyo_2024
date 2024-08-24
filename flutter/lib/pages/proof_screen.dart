import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:reclaim_sdk/flutter_reclaim.dart';
import 'package:reclaim_sdk/types.dart';

class ProofScreen extends StatefulWidget {
  const ProofScreen({super.key, required this.title});
  final String title;

  @override
  State<ProofScreen> createState() => _ProofScreenState();
}

class _ProofScreenState extends State<ProofScreen> {
  final providerId = '9efd071e-2349-437d-b5df-62345e46a682';
  final applicationId = '0x5404B0B7D667cCc004b5e2886FC49D33D77FF5C0';
  final applicationSecret =
      '0xaedf096d7dfbc037b59ccdaaa2c5845113a7ef2d75600bf78bac80d5dbd329c1';
  // final providerId = '84f7cdab-682a-49aa-8fe9-84b3456036d8';
  // final applicationId = '0x85e0D267968e12d213Ab21aE6c4467a1B59a2d08';
  // final applicationSecret =
  //     '0xe1c571f43414f82ee45e28a15030ab10277788886deea364cd4a6b1e008ffe8e';

  final address = '0x0901549Bc297BCFf4221d0ECfc0f718932205e33';
  final message = 'testing';

  String data = "";

  void startVerificationFlow() async {
    final proofRequest = ProofRequest(applicationId: applicationId);
    proofRequest.setAppCallbackUrl('YOUR_DEEP_LINK_HERE');
    proofRequest.addContext(address, message);

    await proofRequest.buildProofRequest(providerId);

    proofRequest
        .setSignature(proofRequest.generateSignature(applicationSecret));

    final verificationRequest = await proofRequest.createVerificationRequest();
    print('verificationRequest: $verificationRequest');

    final startSessionParam = StartSessionParams(
      onSuccessCallback: (proof) => setState(() {
        // This is where you would handle the proof data
        data = jsonEncode(proof.claimData);
        print('data: $data');
        final contractParam = Reclaim.transformForOnchain(proof);
        print('contractParam: $contractParam');
      }),
      onFailureCallback: (error) => {
        setState(() {
          data = 'Error: $error';
        })
      },
    );

    await proofRequest.startSession(startSessionParam);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Prove your bank transfer by clicking on Verify button:',
            ),
            Text(
              data,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: startVerificationFlow,
        tooltip: 'Verify ',
        child: const Text('Verify'),
      ),
    );
  }
}
