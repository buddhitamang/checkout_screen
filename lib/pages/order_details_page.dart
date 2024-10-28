import 'package:checkout_demo/components/text_field_page.dart';
import 'package:checkout_demo/pages/checkout_page.dart';
import 'package:flutter/material.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Controllers for each input field
    final fullnameController = TextEditingController();
    final phoneNumberController = TextEditingController();
    final emailController = TextEditingController();
    final shippingAddressController = TextEditingController();
    final countryController = TextEditingController();

    final _formKey = GlobalKey<FormState>();

    void showSnackBar(String message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enter your Details to Process',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                ),
                const SizedBox(height: 18),

                TextFieldPage(
                  hintText: 'Full Name',
                  controller: fullnameController,
                  validator: (String? name) {
                    if (name == null || name.length < 3) {
                      return 'Enter a valid name';
                    }
                    return null; // Input is valid
                  },
                ),
                const SizedBox(height: 12),
                TextFieldPage(
                  hintText: 'Phone Number',
                  keyboardType: TextInputType.phone,
                  controller: phoneNumberController,
                  validator: (String? phone) {
                    if (phone == null || phone.isEmpty || !RegExp(r'^[0-9]+$').hasMatch(phone) || phone.length<10) {
                      return 'Enter a valid phone number';
                    }
                    return null; // Input is valid
                  },
                ),
                const SizedBox(height: 12),
                TextFieldPage(
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  validator: (String? email) {
                    if (email == null || email.isEmpty ||
                        !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFieldPage(
                  hintText: 'Shipping Address',
                  controller: shippingAddressController,
                  validator: (String? address) {
                    if (address == null || address.isEmpty) {
                      return 'Enter your shipping address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFieldPage(
                  hintText: 'Country',
                  controller: countryController,
                  validator: (String? country) {
                    if (country == null || country.isEmpty) {
                      return 'Enter your country';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Validate form before proceeding
                        if (_formKey.currentState?.validate() ?? false) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CheckoutPage(
                                shippingAddress: shippingAddressController.text,
                                email: emailController.text,
                                phoneNumber: phoneNumberController.text,
                              ),
                            ),
                          );
                        } else {
                          showSnackBar('Please fill in all fields correctly.');
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: Colors.deepPurple,
                        ),
                        child: const Text(
                          'Proceed to Checkout',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
