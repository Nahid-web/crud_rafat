import 'dart:convert';
import 'package:crud_rafat/style/style.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddNewProduct extends StatefulWidget {
  const AddNewProduct({super.key});
  @override
  State<AddNewProduct> createState() => _AddNewProductState();
}

class _AddNewProductState extends State<AddNewProduct> {
  final TextEditingController _productName = TextEditingController();
  final TextEditingController _productCode = TextEditingController();
  final TextEditingController _productImage = TextEditingController();
  final TextEditingController _unitPrice = TextEditingController();
  final TextEditingController _quantity = TextEditingController();
  final TextEditingController _totalPrice = TextEditingController();
  final TextEditingController _description = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  Future<void> addNewProduct() async {
    setState(() {
      isLoading = true;
    });

    Map<String, dynamic> productMapInput = {
      "Img": _productImage.text.trim(),
      "ProductCode": _productCode.text.trim(),
      "ProductName": _productName.text.trim(),
      "Qty": _quantity.text.trim(),
      "TotalPrice": _totalPrice.text.trim(),
      "UnitPrice": _unitPrice.text.trim(),
    };

    http.Response response = await http.post(
      Uri.parse('https://crud.teamrabbil.com/api/v1/CreateProduct'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(productMapInput),
    );

    setState(() {
      isLoading = false;
    });

    if(response.statusCode == 200){
      _productName.clear();
      _productCode.clear();
      _productImage.clear();
      _unitPrice.clear();
      _quantity.clear();
      _totalPrice.clear();
      _description.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('added new product successfully'),
        ),
      );
    }
    else if (response.statusCode == 400) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Product Code should be unique'),
        ),
      );
    }

  }

  //from validation method
  String? isValidate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter some value';
    }
    return null;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                //Product Name
                TextFormField(
                  controller: _productName,
                  validator: isValidate,
                  decoration: textInputDecoration('Product Name'),
                ),
                const SizedBox(height: 10),
                //Product Code
                TextFormField(
                  controller: _productCode,
                  validator: isValidate,
                  keyboardType: TextInputType.number,
                  decoration: textInputDecoration('Product Code'),
                ),
                const SizedBox(height: 10),
                //product image
                TextFormField(
                  controller: _productImage,
                  validator: isValidate,
                  decoration: textInputDecoration('Product Image'),
                ),
                const SizedBox(height: 10),
                //Unit Price
                TextFormField(
                  controller: _unitPrice,
                  validator: isValidate,
                  keyboardType: TextInputType.number,
                  decoration: textInputDecoration('Unit Price'),
                ),
                const SizedBox(height: 10),
                //Quantity
                TextFormField(
                  controller: _quantity,
                  validator: isValidate,
                  keyboardType: TextInputType.number,
                  decoration: textInputDecoration('Quantity'),
                ),
                const SizedBox(height: 10),
                //Total Price
                TextFormField(
                  controller: _totalPrice,
                  validator: isValidate,
                  keyboardType: TextInputType.number,
                  decoration: textInputDecoration('Total Price'),
                ),
                const SizedBox(height: 10),
                //Description
                TextFormField(
                  controller: _description,
                  decoration: textInputDecoration('Description'),
                ),
                const SizedBox(height: 10),
                isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            addNewProduct();
                          }
                        },
                        style: buttonStyle(),
                        child: const Text('Submit'),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _productName.dispose();
    _productCode.dispose();
    _productImage.dispose();
    _unitPrice.dispose();
    _quantity.dispose();
    _totalPrice.dispose();
    _description.dispose();
    super.dispose();
  }
}
