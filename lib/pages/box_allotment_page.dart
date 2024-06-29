import 'package:flutter/material.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class BoxAllotmentPage extends StatefulWidget {
  const BoxAllotmentPage({super.key});

  @override
  State<BoxAllotmentPage> createState() => _BoxAllotmentPageState();
}

class _BoxAllotmentPageState extends State<BoxAllotmentPage> {
  String result = "";

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      var res = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SimpleBarcodeScannerPage(),
        ),
      );
      setState(() {
        if (res is String) {
          result = res;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final String itemCode =
        ModalRoute.of(context)?.settings.arguments as String? ?? 'No Item Code';
    return Scaffold(
      appBar: AppBar(
        title: Text(itemCode),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(result),
          ],
        ),
      ),
    );
  }
}
