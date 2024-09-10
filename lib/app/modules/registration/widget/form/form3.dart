// ignore_for_file: prefer_const_constructors, use_super_parameters, unused_element

import 'package:flutter/material.dart';

class Form3 extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController socialMediaController;
  final TextEditingController noWhatsappCodeController;

  const Form3({
    Key? key,
    required this.emailController,
    required this.socialMediaController,
    required this.noWhatsappCodeController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Container(
            padding: EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 36),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 1,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeader("Contact Info 3"),
                _buildTextField("Email", "Masukkan Alamat Email",
                    emailController, "Email wajib diisi"),
                _buildTextField("Sosial Media", "Masukkan Sosial Media",
                    socialMediaController, "Social Media wajib diisi"),
                _buildTextField("NO. Whatsapp", "Masukkan Nomor",
                    noWhatsappCodeController, "Nomor wajib diisi"),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    );
  }

  Widget _buildTextField(String label, String hint,
      TextEditingController controller, String errorMessage,
      {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        Text(label, style: TextStyle(fontSize: 16, color: Colors.grey)),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
          ),
          validator: (value) =>
              value == null || value.isEmpty ? errorMessage : null,
          maxLines: maxLines,
        ),
      ],
    );
  }

  Widget _buildPhoneField(TextEditingController phoneController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        Text("Nomor Telepon",
            style: TextStyle(fontSize: 16, color: Colors.grey)),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: '+62',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? '' : null,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              flex: 3,
              child: TextFormField(
                controller: phoneController,
                decoration: InputDecoration(
                  hintText: 'Masukkan Nomor Telepon',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Nomor telepon wajib diisi'
                    : null,
              ),
            ),
          ],
        ),
      ],
    );
  }
}


// // ignore_for_file: prefer_const_constructors, use_super_parameters

// import 'package:flutter/material.dart';

// class Form3 extends StatelessWidget {
//   final TextEditingController addressController;

//   const Form3({
//     Key? key,
//     required this.addressController,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('Address Info', style: TextStyle(fontSize: 18)),
//         SizedBox(height: 8),
//         TextFormField(
//           controller: addressController,
//           decoration: InputDecoration(labelText: 'Address'),
//           validator: (value) {
//             if (value!.isEmpty) return 'Please enter your address';
//             return null;
//           },
//         ),
//       ],
//     );
//   }
// }
