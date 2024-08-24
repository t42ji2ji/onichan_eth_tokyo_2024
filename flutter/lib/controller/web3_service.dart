import 'package:flutter/material.dart';
import 'package:onichan/controller/abi.dart';
import 'package:onichan/controller/web3_contrller.dart';
import 'package:onichan/types/order.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web3dart/web3dart.dart';

part 'web3_service.g.dart';

@riverpod
FutureOr<String> getBalance(GetBalanceRef ref, String address) async {
  final client = ref.read(web3DartControllerProvider.notifier).web3Client();

  final balance = await client.getBalance(EthereumAddress.fromHex(address));
  debugPrint('=======balance : $balance=========');
  balance.getInEther.toString();
  balance.getInWei.toString();

  debugPrint('=======address : $address=========');

  return (balance.getInWei / BigInt.from(10).pow(18)).toStringAsFixed(3);
}

@riverpod
FutureOr<String> getTokenBalance(
    GetTokenBalanceRef ref, String address, String tokenAddress) async {
  final client = ref.read(web3DartControllerProvider.notifier).web3Client();

  // ERC20 token ABI
  const abi =
      '[{"constant":true,"inputs":[{"name":"_owner","type":"address"}],"name":"balanceOf","outputs":[{"name":"balance","type":"uint256"}],"type":"function"}]';

  // Create contract instance
  final contract = DeployedContract(
    ContractAbi.fromJson(abi, 'ERC20'),
    EthereumAddress.fromHex(tokenAddress),
  );

  // Get the balance function from the ABI
  final balanceFunction = contract.function('balanceOf');

  // Call the balanceOf function
  final balance = await client.call(
    contract: contract,
    function: balanceFunction,
    params: [EthereumAddress.fromHex(address)],
  );

  return ((balance[0] as BigInt) / BigInt.from(10).pow(6)).toStringAsFixed(3);
}

const fiatOnrampAddress = '0xd570bf4598d3ccf214e288dd92222b8bd3134984';
const usdtAddress = '0xB06c44B2601AB296269dDC081492B266C49C6949';
const usdcAddress = '0x7356f4cC77168d0e6f94F1d8E28aeA1316852c0d';

@riverpod
FutureOr<List<Order>> allOrders(AllOrdersRef ref) async {
  final client = ref
      .read(web3DartControllerProvider.notifier)
      .web3Client(rpc: Rpc.scrollSepolia);

  final contract = DeployedContract(
    ContractAbi.fromJson(fiatOnrampAbi, 'FiatOnramp'),
    EthereumAddress.fromHex(fiatOnrampAddress),
  );

  final allOrders = (await client.call(
    contract: contract,
    function: contract.function('allOrders'),
    params: [],
  ))[0];

  return allOrders
      .map<Order>((e) => Order(
            id: e[0],
            from: (e[1] as EthereumAddress).hex,
            token: (e[2] as EthereumAddress).hex,
            symbol: (e[2] as EthereumAddress).hex.toLowerCase() ==
                    usdtAddress.toLowerCase()
                ? 'USDT'
                : 'USDC',
            amount: e[3],
            conditionHash: e[4],
          ))
      .toList();
}
