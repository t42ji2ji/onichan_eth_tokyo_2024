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
    Credentials cred = EthPrivateKey.fromHex(
        '0xbc3d9a9557fda31dc4bfba1e2597808f2990f46b6cc321c45555c3482ab744e8');

    // In either way, the library can derive the public key and the address
    // from a private key:
    var address = cred.address;
    return (
      address: address.hex,
      privateKey: cred.toString(),
    );
  }

  Web3Client web3Client({Rpc rpc = Rpc.eth}) {
    var sepoliaApiUrl = "https://eth-sepolia.api.onfinality.io/public";
    var ethApiUrl = "https://eth.llamarpc.com";
    var scrollSepoliaApiUrl = "https://sepolia-rpc.scroll.io";
    var url = rpc == Rpc.sepolia
        ? sepoliaApiUrl
        : rpc == Rpc.scrollSepolia
            ? scrollSepoliaApiUrl
            : ethApiUrl;
    var httpClient = Client();
    return Web3Client(url, httpClient);
  }
}

enum Rpc {
  sepolia,
  eth,
  scrollSepolia,
}
