import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fzc_global_app/api/product_api.dart';
import 'package:fzc_global_app/models/product_model.dart';
import 'package:fzc_global_app/utils/constants.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class BoxAllotmentPage extends StatefulWidget {
  const BoxAllotmentPage({super.key});

  @override
  State<BoxAllotmentPage> createState() => _BoxAllotmentPageState();
}

class _BoxAllotmentPageState extends State<BoxAllotmentPage> {
  String result = "";
  bool _isLoading = false;
  final TextEditingController _updatedQuantityController =
      TextEditingController();

  String message = "";
  late ProductModel product;

  @override
  void initState() {
    super.initState();
  }

  Widget productCartd(ProductModel product) {
    _updatedQuantityController.text = product.quantity.toString();
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
              SizedBox(
                width: 100,
                child: TextFormField(
                  textDirection: TextDirection.rtl,
                  controller: _updatedQuantityController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                      fontSize: 14, color: Constants.whiteColor),
                  decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Constants.secondaryColor),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Constants.primaryColor),
                      ),
                      fillColor: Constants.bgColor,
                      filled: true,
                      hintText: "Qty",
                      hintStyle: TextStyle(color: Colors.grey[500])),
                ),
              )
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
                onPressed: _isLoading
                    ? null
                    : () async {
                        var res = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const SimpleBarcodeScannerPage(),
                          ),
                        );
                        if (res is String) {
                          setState(() {
                            result = res;
                            _isLoading = true;
                          });

                          try {
                            var response = await addProduct(product, result,
                                int.parse(_updatedQuantityController.text));

                            if (response.success) {
                              Fluttertoast.showToast(
                                msg: "Alloted successfully!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.TOP_RIGHT,
                                timeInSecForIosWeb: 1,
                                backgroundColor:
                                    const Color.fromARGB(20, 23, 143, 49),
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                              Navigator.pushNamed(context, "/dashboard");
                            } else {
                              Fluttertoast.showToast(
                                msg: response.error,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor:
                                    const Color.fromARGB(255, 238, 4, 16),
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                            }
                          } catch (e) {
                            setState(() {
                              message = "$e";
                            });
                          } finally {
                            setState(() {
                              _isLoading = false;
                            });
                          }
                        }
                      },
                label: const Text("Scan"),
                icon: const Icon(Icons.qr_code),
                iconAlignment: IconAlignment.start,
                style: TextButton.styleFrom(
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
    product = ModalRoute.of(context)?.settings.arguments as ProductModel;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.itemCode),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [productCartd(product)],
          ),
        ),
      ),
    );
  }
}
