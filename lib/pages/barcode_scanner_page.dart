import 'package:fzc_global_app/api/product_api.dart';
import 'package:fzc_global_app/models/product_model.dart';
import 'package:fzc_global_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class BarcodeScannerPage extends StatefulWidget {
  const BarcodeScannerPage({super.key});

  @override
  State<BarcodeScannerPage> createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  late Future<List<ProductModel>> _products;
  String barcode = '000000000001';

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
          if (res != "-1") {
            barcode = res;
            _products = getProducts(barcode);
          }
        }
      });
    });
    _products = getProducts(barcode);
  }

  Future<void> _refreshProducts() async {
    setState(() {
      _products = getProducts(barcode);
    });
  }

  Widget productCartd(ProductModel product) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 3),
            ),
          ],
          color: Constants.secondaryColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.customerName,
            style: const TextStyle(
                color: Constants.whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Item Code",
                style: TextStyle(color: Constants.whiteColor),
              ),
              Text(
                product.itemCode,
                style: const TextStyle(color: Constants.whiteColor),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Item Name",
                style: TextStyle(color: Constants.whiteColor),
              ),
              Text(
                product.itemName,
                style: const TextStyle(color: Constants.whiteColor),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Price",
                style: TextStyle(color: Constants.whiteColor),
              ),
              Text(
                '${product.price.toString()} AED',
                style: const TextStyle(color: Constants.whiteColor),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Qty",
                style: TextStyle(color: Constants.whiteColor),
              ),
              Text(
                product.quantity.toString(),
                style: const TextStyle(color: Constants.whiteColor),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total Amount",
                style: TextStyle(color: Constants.whiteColor),
              ),
              Text(
                '${(product.quantity * product.price).toDouble()} AED',
                style: const TextStyle(color: Constants.whiteColor),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, "/boxallotment",
                      arguments: product);
                },
                label: const Text("View Details"),
                icon: const Icon(Icons.arrow_forward),
                iconAlignment: IconAlignment.end,
                style: TextButton.styleFrom(
                    // textStyle: const TextStyle(fontSize: 16),
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Parts')),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: FutureBuilder(
            future: _products,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text("Error ${snapshot.error}");
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Text("No data found!");
              } else {
                return RefreshIndicator(
                  onRefresh: _refreshProducts,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return productCartd(snapshot.data![index]);
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                  ),
                );
              }
            }),
      ),
    );
  }
}
