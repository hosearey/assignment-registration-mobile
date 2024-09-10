// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mondooli_registration/app/modules/registration/registration_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class Form4 extends StatefulWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController dateOfBirthController;
  final TextEditingController phoneController;
  final TextEditingController countryController;
  final TextEditingController provinceController;
  final TextEditingController citiesController;
  final TextEditingController districController;
  final TextEditingController subdistricController;
  final TextEditingController postalCodeController;
  final TextEditingController addressController;

  const Form4({
    Key? key,
    required this.firstNameController,
    required this.lastNameController,
    required this.dateOfBirthController,
    required this.phoneController,
    required this.countryController,
    required this.provinceController,
    required this.citiesController,
    required this.districController,
    required this.subdistricController,
    required this.postalCodeController,
    required this.addressController,
  }) : super(key: key);

  @override
  _Form4State createState() => _Form4State();
}

class _Form4State extends State<Form4> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RegistrationViewModel>(context, listen: false)
          .fetchProvinces();
    });
  }

  @override
  Widget build(BuildContext context) {
    final registrationViewModel = Provider.of<RegistrationViewModel>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Container for personal data fields
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: Container(
            padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 36),
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
                _buildSectionHeader("Data Personal"),
                _buildTextField("Nama Depan", "Masukkan Nama Depan",
                    widget.firstNameController, "Nama depan wajib diisi"),
                _buildTextField("Nama Belakang", "Masukkan Nama Belakang",
                    widget.lastNameController, "Nama belakang wajib diisi"),
                _buildDateField(context, "Tanggal Lahir", "Pilih Tanggal Lahir",
                    widget.dateOfBirthController, "Tanggal lahir wajib diisi"),
                _buildPhoneField(widget.phoneController),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: Container(
            padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 36),
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
                _buildSectionHeader("Data Alamat"),
                _provinsi(
                  registrationViewModel,
                  "Provinsi",
                  "Pilih Provinsi",
                  "Provinsi wajib diisi",
                ),
                // SizedBox(height: 20),
                _district(registrationViewModel, "Kota", "Pilih Kota",
                    "Kota wajib diisi"),
                // SizedBox(height: 20),
                _subDistrict(
                    registrationViewModel.disableSubDist,
                    registrationViewModel,
                    "Kecamatan",
                    "Pilih Kecamatan",
                    "Kecamatan wajib diisi"),
                _buildTextField("Kode Pos", "Masukkan Kode Pos",
                    widget.postalCodeController, "Kode Pos wajib diisi"),
                _buildTextField("Detail Alamat", "Masukkan Detail Alamat",
                    widget.addressController, "Detail alamat wajib diisi",
                    maxLines: 3),
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
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
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

  Widget _buildDateField(BuildContext context, String label, String hint,
      TextEditingController controller, String errorMessage) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        Text(label, style: TextStyle(fontSize: 16, color: Colors.grey)),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          readOnly: true,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
          ),
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (pickedDate != null) {
              controller.text = DateFormat('dd MMMM yyyy').format(pickedDate);
            }
          },
          validator: (value) =>
              value == null || value.isEmpty ? errorMessage : null,
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
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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

  Widget _provinsi(
    RegistrationViewModel viewModel,
    String label,
    String hint,
    String errorMessage,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          Text(label, style: TextStyle(fontSize: 16, color: Colors.grey)),
          SizedBox(height: 8),
          DropdownButtonFormField(
            validator: (value) =>
                value == null || value.isEmpty ? errorMessage : null,
            decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            value: viewModel.selectedProv,
            items: viewModel.dataProv.map((item) {
              return DropdownMenuItem(
                value: item['id'].toString(),
                child: Text(item['nama']),
              );
            }).toList(),
            onChanged: (value) {
              viewModel.setSelectedProv(value.toString());
              viewModel.setDisableSubDist(true);
              viewModel.setSelectedDist(null);
              viewModel.setSelectedSubDist(null);
              viewModel.fetchDistricts(value.toString());
            },
          ),
        ],
      ),
    );
  }

  Widget _district(
    RegistrationViewModel viewModel,
    String label,
    String hint,
    String errorMessage,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          Text(label, style: TextStyle(fontSize: 16, color: Colors.grey)),
          SizedBox(height: 8),
          DropdownButtonFormField(
            validator: (value) =>
                value == null || value.isEmpty ? errorMessage : null,
            decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            value: viewModel.selectedDist,
            items: viewModel.dataDist.map((item) {
              return DropdownMenuItem(
                value: item['id'].toString(),
                child: Text(item['nama']),
              );
            }).toList(),
            onChanged: (value) {
              viewModel.setSelectedDist(value.toString());
              viewModel.setDisableSubDist(false);
              viewModel.setSelectedSubDist(null);
              viewModel.fetchSubDistricts(value.toString());
            },
          ),
        ],
      ),
    );
  }

  Widget _subDistrict(
    bool enableSubDist,
    RegistrationViewModel viewModel,
    String label,
    String hint,
    String errorMessage,
  ) {
    return IgnorePointer(
      ignoring: enableSubDist,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Text(label, style: TextStyle(fontSize: 16, color: Colors.grey)),
            SizedBox(height: 8),
            DropdownButtonFormField(
              validator: (value) =>
                  value == null || value.isEmpty ? errorMessage : null,
              decoration: InputDecoration(
                hintText: hint,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              value: viewModel.selectedSubDist,
              items: viewModel.dataSubDist.map((item) {
                return DropdownMenuItem(
                  value: item['id'].toString(),
                  child: Text(item['nama']),
                );
              }).toList(),
              onChanged: (value) {
                viewModel.setSelectedSubDist(value.toString());
              },
            ),
          ],
        ),
      ),
    );
  }
}
