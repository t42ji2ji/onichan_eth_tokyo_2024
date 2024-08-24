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
  String data = "";

  ProofRequest proofRequest =
      ProofRequest(applicationId: '0x85e0D267968e12d213Ab21aE6c4467a1B59a2d08');

  void startVerificationFlow() async {
    final providerIds = [
      '84f7cdab-682a-49aa-8fe9-84b3456036d8', // PayPal Tx
    ];
    proofRequest.setAppCallbackUrl('YOUR_DEEP_LINK_HERE');

    await proofRequest.buildProofRequest(providerIds[0]);

    proofRequest.setSignature(proofRequest.generateSignature(
        '0xe1c571f43414f82ee45e28a15030ab10277788886deea364cd4a6b1e008ffe8e'));

    final verificationRequest = await proofRequest.createVerificationRequest();

    final startSessionParam = StartSessionParams(
      onSuccessCallback: (proof) => setState(() {
        // This is where you would handle the proof data
        data = jsonEncode(proof.claimData);
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
              'Prove that you have Steam ID By clicking on Verify button:',
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
