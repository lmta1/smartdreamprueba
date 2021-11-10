import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:smartdreamprueba/models/product_model.dart';
import 'package:smartdreamprueba/services/cart_provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ShoppingCartPage extends StatefulWidget {
  final Product productSeleccionado;
  const ShoppingCartPage({Key key, this.productSeleccionado}) : super(key: key);

  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  List<Product> productsCart = [];
  double total = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('Carro de la Compra'),
        ),
        body: _linesCart());
  }

  Widget _linesCart() {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    setState(() {
      productsCart = cartProvider.products;
    });

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: productsCart.length > 0
          ? Column(
              children: [
                //* Mensaje de Ayuda
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text('Para borrar artículo deslize a la derecha'),
                ),
                //* Lineas Pedido
                Container(
                  width: double.infinity,
                  height: 440,
                  child: SingleChildScrollView(
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      reverse: true,
                      itemCount: productsCart.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Slidable(
                          actionPane: SlidableDrawerActionPane(),
                          actions: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: IconSlideAction(
                                color: Colors.red,
                                iconWidget: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.delete_forever_outlined,
                                      color: Colors.white,
                                      size: 45,
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  setState(() {
                                    cartProvider
                                        .removeFromCart(productsCart[index]);
                                  });
                                },
                              ),
                            ),
                          ],
                          child: Card(
                            color: Colors.blue,
                            elevation: 3,
                            child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Stack(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        //* Fotografía Artículo
                                        Container(
                                          height: 50,
                                          width: 50,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: productsCart[index]
                                                        .picture ==
                                                    null
                                                ? Image(
                                                    image: AssetImage(
                                                        'assets/no-image.png'),
                                                    fit: BoxFit.cover)
                                                : FadeInImage(
                                                    placeholder: AssetImage(
                                                        'assets/jar-loading.gif'),
                                                    image: NetworkImage(
                                                        productsCart[index]
                                                            .picture),
                                                    fit: BoxFit.cover,
                                                  ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        //* Descripción y precio artículo
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              productsCart[index].name,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              productsCart[index]
                                                      .price
                                                      .toString() +
                                                  ' €',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    //* Boton +
                                    Positioned(
                                      right: -5,
                                      child: IconButton(
                                        iconSize: 30,
                                        onPressed: () {
                                          setState(() {
                                            cartProvider.incrementProduct(
                                                productsCart[index]);
                                          });
                                        },
                                        icon: Icon(
                                          Icons.add_circle,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    //* Contador
                                    Positioned(
                                        right: 43,
                                        top: 4,
                                        child: Container(
                                          color: Colors.white,
                                          width: 40,
                                          height: 40,
                                          child: Center(
                                              child: Text(
                                                  '${productsCart[index].count}')),
                                        )),
                                    //* -
                                    Positioned(
                                      right: 80,
                                      child: IconButton(
                                        iconSize: 30,
                                        onPressed: () {
                                          setState(() {
                                            cartProvider.derementProduct(
                                                productsCart[index]);
                                          });
                                        },
                                        icon: Icon(
                                          Icons.remove_circle,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                //* Resumen pedido
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 3),
                          borderRadius: BorderRadius.circular(25)),
                      width: double.infinity,
                      height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Artículos: ${cartProvider.totalProduct}',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            'Importe Total: ${cartProvider.total.toStringAsFixed(2)}€',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          MaterialButton(
                            height: 50,
                            color: Colors.blue,
                            shape: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(5.0)),
                            onPressed: () async {
                              cartProvider.removeListCart();
                              showSimpleNotification(
                                  Text('Compra realizada correctamente',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                  leading: Icon(
                                    Icons.check_circle,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                  contentPadding: EdgeInsets.all(18),
                                  duration: Duration(seconds: 3),
                                  background: Colors.green);

                              Navigator.pop(context);
                            },
                            child: Text(
                              'COMPRAR',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )
          : Center(
              child: Text(
                'Su carro está vacío',
                style: TextStyle(color: Colors.black),
              ),
            ),
    );
  }
}
