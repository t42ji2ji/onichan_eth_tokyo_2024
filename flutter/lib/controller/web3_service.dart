import 'package:flutter/material.dart';
import 'package:onichan/controller/web3_contrller.dart';
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
