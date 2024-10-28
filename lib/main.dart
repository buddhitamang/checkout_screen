
import 'package:checkout_demo/pages/checkout_page.dart';
import 'package:checkout_demo/pages/order_details_page.dart';
import 'package:checkout_demo/pages/payment_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'const.dart';

void main() async{
  Stripe.publishableKey = stripePublicKey;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home:  OrderDetailsPage(),
    );
  }
}
