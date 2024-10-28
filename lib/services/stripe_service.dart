
import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../const.dart';

class StripeService {
  StripeService._();

  static final StripeService instance = StripeService._();

  Future<bool> makePayment(double amount) async {
    try {
      String? paymentIntentClientSecret = await _createIntentPayment(amount, "usd");
      if (paymentIntentClientSecret == null) {
        print("Failed to create payment intent.");
        return false; // Payment intent creation failed
      }

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentClientSecret,
          merchantDisplayName: "Checkout Demo",
        ),
      );

      await _processPayment();
      return true; // Payment success
    } catch (e) {
      print("Payment error: $e");
      return false; // Payment failed
    }
  }

  Future<String?> _createIntentPayment(double amount, String currency) async {
    try {
      final Dio dio = Dio();
      Map<String, dynamic> data = {
        "amount": _calculateAmount(amount),
        "currency": currency,
      };

      var response = await dio.post(
        'https://api.stripe.com/v1/payment_intents',
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": "Bearer $stripeSecretKey",
            "Content-Type": 'application/x-www-form-urlencoded',
          },
        ),
      );

      // Ensure that the response data is correctly parsed as a Map
      if (response.data != null && response.data is Map<String, dynamic>) {
        return response.data["client_secret"] as String?;
      } else {
        print("Unexpected response format: ${response.data}");
        return null;
      }
    } catch (e) {
      print("Error creating payment intent: $e");
      return null;
    }
  }

  Future<void> _processPayment() async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      print("Error presenting payment sheet: $e");
      throw e; // Re-throw error to indicate failure
    }
  }

  String _calculateAmount(double amount) {
    final calculatedAmount = (amount * 100).toInt(); // Convert to cents
    return calculatedAmount.toString();
  }
}
