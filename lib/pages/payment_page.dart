import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<PaymentPage> {
  String? _selectedMethod;

  void _onMethodSelected(String method) {
    setState(() {
      _selectedMethod = (_selectedMethod == method) ? null : method;
    });
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
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                  ),
                  Text(
                    'Payment',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 48),
                ],
              ),
              SizedBox(height: 30),
              PaymentMethodRow(
                icon: Icons.attach_money,
                label: 'Cash on Delivery',
                isSelected: _selectedMethod == 'Cash on Delivery',
                onTap: () => _onMethodSelected('Cash on Delivery'),
              ),
              SizedBox(height: 10),
              PaymentMethodRow(
                icon: Icons.credit_card,
                label: 'Debit/Credit Card',
                isSelected: _selectedMethod == 'Debit/Credit Card',
                onTap: () => _onMethodSelected('Debit/Credit Card'),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  // Place order logic here
                },
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
              SizedBox(height: 20),
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
        padding: EdgeInsets.symmetric(horizontal: 16),
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
                SizedBox(width: 12),
                Text(
                  label,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            if (isSelected)
              Icon(Icons.check, color: Colors.green, size: 28), // Show checkmark if selected
          ],
        ),
      ),
    );
  }
}
