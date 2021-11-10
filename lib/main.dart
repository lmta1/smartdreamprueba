import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:smartdreamprueba/pages/product_page.dart';
import 'package:smartdreamprueba/pages/cart_page.dart';
import 'package:smartdreamprueba/services/firebase_api.dart';
import 'package:smartdreamprueba/services/cart_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    AppState(),
  );
}

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(lazy: false, create: (_) => FirebaseApi()),
        ChangeNotifierProvider(lazy: false, create: (_) => CartProvider())
      ],
      child: PruebaApp(),
    );
  }
}

class PruebaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SmartDream Prueba',
        initialRoute: 'home',
        routes: {
          'home': (_) => ProductPage(),
          'shoppingcart': (_) => ShoppingCartPage(),
        },
      ),
    );
  }
}
