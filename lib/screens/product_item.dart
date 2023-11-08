import 'package:crud_rafat/screens/delete_product.dart';
import 'package:crud_rafat/screens/update_product.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});

  final Map<String, dynamic> product;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product["ProductName"]),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          product["Img"],
          width: 60,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(product["ProductCode"]),
          Text('Total Price : ${product["TotalPrice"]}')
        ],
      ),
      trailing: Text(product["UnitPrice"]),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Select Action'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //edit item
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateProduct(product: product),
                        ),
                      );
                    },
                    leading: const Icon(Icons.edit),
                    title: const Text('Edit'),
                  ),
                  //delete item
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DeleteProduct(product: product),));

                    },
                    leading: const Icon(Icons.delete),
                    title: const Text('Delete'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
