

import 'package:crud_rafat/screens/add_new_product_screen.dart';
import 'package:crud_rafat/screens/product_item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {

  List productList = [];
  bool isLoading = true;

  getProductList() async {
    isLoading = true;
    productList.clear();
    const url = "https://crud.teamrabbil.com/api/v1/ReadProduct";
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      setState(() {
        isLoading = false;
      });
      if (jsonData['status'] == 'success') {

        for (var productJsonList in jsonData['data']) {
          productList.add(productJsonList);
        }
      }
    }
  }

  @override
  void initState() {
   getProductList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
        actions: [
          IconButton(onPressed: (){
            setState(() {
              getProductList();
            });
          },
              icon: const Icon(Icons.refresh))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddNewProduct(),
              ));
        },
        child: const Icon(Icons.add),
      ),
      body: isLoading?const Center(child:CircularProgressIndicator())
          : Padding(
            padding: const EdgeInsets.all(20),
            child: ListView.separated(
        itemCount: productList.length,
        itemBuilder: (context, index) {
            return ProductItem(product: productList[index]);
        },
        separatorBuilder: (_, __) => const Divider(),
      ),
          ),
    );
  }
}

