import 'dart:math';

import 'package:http/http.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web3dart/web3dart.dart';

part 'web3_contrller.g.dart';

typedef Vault = ({
  String address,
  String privateKey,
});

@Riverpod(keepAlive: true)
class Web3DartController extends _$Web3DartController {
  @override
  Vault build() {
    // Or generate a new key randomly
    var rng = Random.secure();
    Credentials randomCred = EthPrivateKey.createRandom(rng);

    // In either way, the library can derive the public key and the address
    // from a private key:
    var address = randomCred.address;
    return (
      address: address.hex,
      privateKey: randomCred.toString(),
    );
  }

  Web3Client web3Client({Rpc rpc = Rpc.eth}) {
    var sepoliaApiUrl = "https://eth-sepolia.api.onfinality.io/public";
    var ethApiUrl = "https://eth.llamarpc.com";
    var url = rpc == Rpc.sepolia ? sepoliaApiUrl : ethApiUrl;
    var httpClient = Client();
    return Web3Client(url, httpClient);
  }
}

enum Rpc {
  sepolia,
  eth,
}
