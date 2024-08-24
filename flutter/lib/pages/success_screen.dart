import 'package:flutter/material.dart';
import 'package:onichan/types/order.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key, required this.order});
  final Order order;

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    print('============order: ${widget.order.id}============');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(''),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Success!',
            ),
          ],
        ),
      ),
    );
  }
}
