import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartdreamprueba/models/product_model.dart';
import 'package:smartdreamprueba/services/firebase_api.dart';
import 'package:smartdreamprueba/widgets/product_card.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    final fbprovider = Provider.of<FirebaseApi>(context);
    List<Product> listadoProductos = [];

    return Scaffold(
        appBar: AppBar(
          title: Text('Productos'),
        ),
        backgroundColor: Colors.blue[50],
        body: FutureBuilder<List<Product>>(
            future: fbprovider.loadProducts(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                listadoProductos = snapshot.data;

                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: listadoProductos.length,
                    itemBuilder: (context, index) {
                      return ProductCard(product: listadoProductos[index]);
                    });
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }
}
