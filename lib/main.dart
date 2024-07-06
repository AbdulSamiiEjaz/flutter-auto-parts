import "dart:io";

import "package:fzc_global_app/pages/barcode_scanner_page.dart";
import "package:fzc_global_app/pages/box_allotment_page.dart";
import "package:fzc_global_app/pages/login_page.dart";
import "package:fzc_global_app/screens/splash_screen.dart";
import "package:fzc_global_app/utils/constants.dart";
import "package:flutter/material.dart";
import "package:simple_barcode_scanner/simple_barcode_scanner.dart";

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "FZC Global App",
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      theme: ThemeData(
          scaffoldBackgroundColor: Constants.bgColor,
          textTheme: const TextTheme(
              bodyMedium: TextStyle(color: Constants.whiteColor)),
          appBarTheme: const AppBarTheme(
              backgroundColor: Constants.secondaryColor,
              titleTextStyle: TextStyle(
                  color: Constants.whiteColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              centerTitle: true,
              iconTheme: IconThemeData(color: Constants.whiteColor))),
      routes: {
        "/": (context) => const CustomSplashScreen(),
        "/auth/login": (context) => const LoginPage(),
        "/barcodescanner": (context) => const BarcodeScannerPage(),
        "/saleinvoice": (context) => const SaleInvoicePage(),
        "/purchaseinvoice": (context) => const PurchaseInvoicePage(),
        "/boxallotment": (context) => const BoxAllotmentPage(),
      },
    );
  }
}

class SaleInvoicePage extends StatefulWidget {
  const SaleInvoicePage({super.key});

  @override
  State<SaleInvoicePage> createState() => _SaleInvoicePageState();
}

class _SaleInvoicePageState extends State<SaleInvoicePage> {
  String result = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scanner')),
      body: Center(
          child: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              var res = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SimpleBarcodeScannerPage(),
                  ));
              setState(() {
                if (res is String) {
                  result = res;
                }
              });
            },
            child: const Text('Open Scanner'),
          ),
          Text(result),
        ],
      )),
    );
  }
}

class PurchaseInvoicePage extends StatelessWidget {
  const PurchaseInvoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Purchase Invoice')),
      body: const Center(child: Text('Purchase Invoice Page')),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
