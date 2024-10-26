
import 'package:checkout_demo/pages/payment_page.dart';
import 'package:flutter/material.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

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
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                  Text(
                    'Checkout',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 48),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Shipping Address',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.edit,
                      color: Colors.blue.shade300,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey.shade200,
                    ),
                    child: Icon(Icons.location_on),
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Thaiba, Lalitpur',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Contact Information',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.edit, color: Colors.blue.shade300),
                  ),
                ],
              ),
              SizedBox(height: 8),
              ContactInfoRow(icon: Icons.email, text: 'Email@gmail.com'),
              SizedBox(height: 8),
              ContactInfoRow(icon: Icons.phone, text: '9818690333'),
              SizedBox(height: 20),
              Text(
                'Voucher',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter voucher code',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 16,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Apply'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              SizedBox(height: 12),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.grey.shade300,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order Summary',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    OrderSummaryRow(label: 'Item Name', amount: '\$200'),
                    Divider(),
                    OrderSummaryRow(label: 'Shipping Charge', amount: '\$20'),
                    Divider(),
                    OrderSummaryRow(label: 'Total', amount: '\$220', isBold: true),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentPage()));
                },
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.deepPurple
                  ),
                  child: Center(child: Text('Continue to Payement',style: TextStyle(fontSize: 18,color: Colors.grey.shade300),)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ContactInfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const ContactInfoRow({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.grey.shade200,
          ),
          child: Icon(icon),
        ),
        SizedBox(width: 12),
        Text(
          text,
          style: TextStyle(fontSize: 15),
        ),
      ],
    );
  }
}

class OrderSummaryRow extends StatelessWidget {
  final String label;
  final String amount;
  final bool isBold;

  const OrderSummaryRow({
    Key? key,
    required this.label,
    required this.amount,
    this.isBold = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: 16,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
