import 'package:flutter/material.dart';
import '../services/stripe_service.dart';

class PaymentPage extends StatefulWidget {
  final double totalPrice;
  const PaymentPage({super.key, required this.totalPrice});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String? _selectedMethod;

  void _onMethodSelected(String method) {
    setState(() {
      _selectedMethod = (_selectedMethod == method) ? null : method;
    });
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _placeOrder() {
    if (_selectedMethod == null) {
      showSnackBar('Please select a payment option.');
    } else if (_selectedMethod == 'Cash on Delivery') {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Order Placed"),
          content: const Text("Your order has been placed successfully."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    } else if (_selectedMethod == 'Debit/Credit Card') {
      _openStripePayment();
    }
  }

  void _openStripePayment() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Payment using"),
        content: SizedBox(
          height: 220,
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 60,
                    width: 80,
                    child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRURIPRhKOlMe7cw2N9IzXTwUICDh0EVLvcCw&s'),
                  ),
                  const SizedBox(width: 20),
                  const Text('Esewa', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                ],
              ),
              Row(
                children: [
                  Container(
                    height: 60,
                    width: 80,
                    child: Image.network('https://blog.khalti.com/wp-content/uploads/2021/01/khalti-icon.png'),
                  ),
                  const SizedBox(width: 20),
                  const Text('Khalti', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context); // Close the dialog
                  _stripePayment(); // Call the Stripe payment method
                },
                child: Row(
                  children: [
                    Container(
                      height: 60,
                      width: 80,
                      child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSTtt-aAH_ueJ-OLtfJYAnm77Oy74np2CgIOQ&s'),
                    ),
                    const SizedBox(width: 20),
                    const Text('Stripe', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _stripePayment() async {
    // Call the StripeService to make a payment
    bool success = await StripeService.instance.makePayment(widget.totalPrice); // Set amount as needed
    if (success) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Payment Successful"),
          content: const Text("Your payment was successful. Thank you!"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    } else {
      showSnackBar("Payment failed. Please try again.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                  ),
                  const Text(
                    'Payment',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
              const SizedBox(height: 30),
              PaymentMethodRow(
                icon: Icons.attach_money,
                label: 'Cash on Delivery',
                isSelected: _selectedMethod == 'Cash on Delivery',
                onTap: () => _onMethodSelected('Cash on Delivery'),
              ),
              const SizedBox(height: 10),
              PaymentMethodRow(
                icon: Icons.credit_card,
                label: 'Debit/Credit Card',
                isSelected: _selectedMethod == 'Debit/Credit Card',
                onTap: () => _onMethodSelected('Debit/Credit Card'),
              ),
              const Spacer(),
              GestureDetector(
                onTap: _placeOrder,
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Colors.deepPurple,
                  ),
                  child: Center(
                    child: Text(
                      'Place your order',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey.shade300,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}


class PaymentMethodRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const PaymentMethodRow({
    Key? key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey.shade300,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, size: 28),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            if (isSelected)
              const Icon(Icons.check, color: Colors.green, size: 28), // Show checkmark if selected
          ],
        ),
      ),
    );
  }
}
