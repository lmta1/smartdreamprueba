import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartdreamprueba/models/product_model.dart';
import 'package:smartdreamprueba/pages/cart_page.dart';
import 'package:smartdreamprueba/services/cart_provider.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: EdgeInsets.only(top: 30, bottom: 50),
        width: double.infinity,
        height: 400,
        decoration: _cardBorders(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            _BackgroundImage(product.picture),
            _ProductDetails(
              productSelect: product,
              title: product.name,
            ),
            Positioned(top: 0, right: 0, child: _PriceTag(product.price)),
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardBorders() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 7), blurRadius: 10)
          ]);
}

class _PriceTag extends StatelessWidget {
  final double price;

  const _PriceTag(this.price);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text('$price \€',
                style: TextStyle(color: Colors.white, fontSize: 20))),
      ),
      width: 100,
      height: 70,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(25), bottomLeft: Radius.circular(25))),
    );
  }
}

class _ProductDetails extends StatelessWidget {
  final String title;
  final Product productSelect;

  const _ProductDetails({
    this.title,
    this.productSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 50),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        height: 70,
        decoration: _buildBoxDecoration(),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(width: 50),
            Expanded(
              flex: 1,
              child: Container(
                width: 70,
                height: 50,
                child: MaterialButton(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        side: BorderSide(color: Colors.white)),
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      size: 35,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      final cartProvider =
                          Provider.of<CartProvider>(context, listen: false);

                      cartProvider.addToCart(productSelect);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ShoppingCartPage(
                                  productSeleccionado: productSelect)));
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
      color: Colors.indigo,
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25), topRight: Radius.circular(25)));
}

class _BackgroundImage extends StatelessWidget {
  final String url;

  const _BackgroundImage(this.url);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: double.infinity,
        height: 400,
        child: url == null
            ? Image(image: AssetImage('assets/no-image.png'), fit: BoxFit.cover)
            : FadeInImage(
                placeholder: AssetImage('assets/jar-loading.gif'),
                image: NetworkImage(url),
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
