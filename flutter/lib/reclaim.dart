import 'package:reclaim_sdk/flutter_reclaim.dart';
import 'package:reclaim_sdk/types.dart';

// const providerId = '9efd071e-2349-437d-b5df-62345e46a682';
// const applicationId = '0x5404B0B7D667cCc004b5e2886FC49D33D77FF5C0';
// const applicationSecret =
//     '0xaedf096d7dfbc037b59ccdaaa2c5845113a7ef2d75600bf78bac80d5dbd329c1';
const providerId = '15641aeb-73ad-4c19-99f8-762d063d34ad';
const applicationId = '0x875075E903957eE04a38485cC1B33D96080EFAe8';
const applicationSecret =
    '0x7a3812a4610275c1b9377d45b4e8c1b4893dc805cad1b69b65fa33ad9c658886';

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
