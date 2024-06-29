import 'package:fzc_global_app/api/product_api.dart';
import 'package:fzc_global_app/models/product_model.dart';
import 'package:fzc_global_app/utils/constants.dart';
import 'package:flutter/material.dart';

class BarcodeScannerPage extends StatefulWidget {
  const BarcodeScannerPage({super.key});

  @override
  State<BarcodeScannerPage> createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  late Future<List<ProductModel>> _products;

  @override
  void initState() {
    super.initState();
    _products = getProducts();
  }

  Future<void> _refreshProducts() async {
    setState(() {
      _products = getProducts();
    });
  }

  Widget productCartd(String title, String itemCode, double price, int qty,
      double totalAmount) {
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
            title,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Item Code",
                style: TextStyle(color: Colors.white),
              ),
              Text(
                itemCode,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Price",
                style: TextStyle(color: Colors.white),
              ),
              Text(
                '${price.toString()} AED',
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Qty",
                style: TextStyle(color: Colors.white),
              ),
              Text(
                qty.toString(),
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total Amount",
                style: TextStyle(color: Colors.white),
              ),
              Text(
                '${totalAmount.toString()} AED',
                style: const TextStyle(color: Colors.white),
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
                      arguments: itemCode);
                },
                label: const Text("Scan"),
                icon: const Icon(Icons.qr_code),
                iconAlignment: IconAlignment.start,
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
                      return productCartd(
                          snapshot.data![index].title,
                          snapshot.data![index].itemcode.toString(),
                          snapshot.data![index].price,
                          snapshot.data![index].qty,
                          snapshot.data![index].totalAmount);
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
