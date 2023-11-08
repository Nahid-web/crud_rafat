import 'package:crud_rafat/screens/product_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DeleteProduct extends StatefulWidget {
  const DeleteProduct({super.key, required this.product});

  final Map<String, dynamic> product;

  @override
  State<DeleteProduct> createState() => _DeleteProductState();
}

class _DeleteProductState extends State<DeleteProduct> {
  String? productId;

  Future deleteProduct() async {
    http.Response response = await http.get(
      Uri.parse("https://crud.teamrabbil.com/api/v1/DeleteProduct/$productId"),
      headers: {"Content-Type": "application/json"},
    );

    if(response.statusCode == 200){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Delete product successfully'),
        ),
      );
    }
    else if (response.statusCode == 400) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('delete product cannto be sucefull'),
        ),
      );
    }
  }

  @override
  void initState() {
    productId = widget.product[("_id")];
    deleteProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const ProductListScreen();
  }
}
