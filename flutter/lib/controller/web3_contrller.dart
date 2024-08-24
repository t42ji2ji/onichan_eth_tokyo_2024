import 'package:http/http.dart';
import 'package:onichan/controller/abi.dart';
import 'package:onichan/controller/web3_service.dart';
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

  Future<void> deposit(BigInt value, String token) async {
    var client = web3Client(rpc: Rpc.scrollSepolia);
    Credentials cred = EthPrivateKey.fromHex(
        '0xbc3d9a9557fda31dc4bfba1e2597808f2990f46b6cc321c45555c3482ab744e8');
    final contract = DeployedContract(
      ContractAbi.fromJson(fiatOnrampAbi, 'FiatOnramp'),
      EthereumAddress.fromHex(fiatOnrampAddress),
    );
    final function = contract.function('createOrder');
    final params = [EthereumAddress.fromHex(token), value, BigInt.from(5)];
    final result = await client.sendTransaction(
      cred,
      Transaction.callContract(
        contract: contract,
        function: function,
        parameters: params,
      ),
      chainId: 534351,
    );
    await Future.delayed(const Duration(milliseconds: 1500));
  }
}

enum Rpc {
  sepolia,
  eth,
  scrollSepolia,
}
