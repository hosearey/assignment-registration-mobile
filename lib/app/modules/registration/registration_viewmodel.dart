// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mondooli_registration/app/modules/login/login_screen.dart';
import 'package:mondooli_registration/shared/util/status_animation_screen.dart';

class RegistrationViewModel extends ChangeNotifier {
  bool _isLoading = false;

  int _currentStep = 0;
  final List<String> _steps = ['Step 1', 'Step 2', 'Step 3', 'Step 4'];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _provinceController = TextEditingController();
  final TextEditingController _citiesController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _subDistrictController = TextEditingController();

  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();

  final TextEditingController _emailController1 = TextEditingController();
  final TextEditingController _socialMediaController1 = TextEditingController();
  final TextEditingController _noWhatsappCodeController1 =
      TextEditingController();

  final TextEditingController _emailController2 = TextEditingController();
  final TextEditingController _socialMediaController2 = TextEditingController();
  final TextEditingController _noWhatsappCodeController2 =
      TextEditingController();

  final TextEditingController _emailController3 = TextEditingController();
  final TextEditingController _socialMediaController3 = TextEditingController();
  final TextEditingController _noWhatsappCodeController3 =
      TextEditingController();

  int get currentStep => _currentStep;
  List<String> get steps => _steps;
  bool get isLoading => _isLoading;

  GlobalKey<FormState> get formKey => _formKey;
  TextEditingController get firstNameController => _firstNameController;
  TextEditingController get lastNameController => _lastNameController;
  TextEditingController get phoneController => _phoneController;
  TextEditingController get addressController => _addressController;
  TextEditingController get countryController => _countryController;
  TextEditingController get provinceController => _provinceController;
  TextEditingController get citiesController => _citiesController;
  TextEditingController get districtController => _districtController;
  TextEditingController get subDistrictController => _subDistrictController;

  TextEditingController get postalCodeController => _postalCodeController;
  TextEditingController get dateOfBirthController => _dateOfBirthController;

  TextEditingController get emailController1 => _emailController1;
  TextEditingController get socialMediaController1 => _socialMediaController1;
  TextEditingController get noWhatsappCodeController1 =>
      _noWhatsappCodeController1;

  TextEditingController get emailController2 => _emailController2;
  TextEditingController get socialMediaController2 => _socialMediaController2;
  TextEditingController get noWhatsappCodeController2 =>
      _noWhatsappCodeController2;

  TextEditingController get emailController3 => _emailController3;
  TextEditingController get socialMediaController3 => _socialMediaController3;
  TextEditingController get noWhatsappCodeController3 =>
      _noWhatsappCodeController3;

  final Dio _dio = Dio();

  List<dynamic> _dataProv = [];
  List<dynamic> _dataDist = [];
  List<dynamic> _dataSubDist = [];

  String? _selectedProv;
  String? _selectedDist;
  String? _selectedSubDist;

  bool _disableSubDist = true;

  // Getters for data
  List<dynamic> get dataProv => _dataProv;
  List<dynamic> get dataDist => _dataDist;
  List<dynamic> get dataSubDist => _dataSubDist;

  String? get selectedProv => _selectedProv;
  String? get selectedDist => _selectedDist;
  String? get selectedSubDist => _selectedSubDist;

  bool get disableSubDist => _disableSubDist;

  // Setters for selected values
  void setSelectedProv(String? value) {
    _selectedProv = value;
    notifyListeners();
  }

  void setSelectedDist(String? value) {
    _selectedDist = value;
    notifyListeners();
  }

  void setSelectedSubDist(String? value) {
    _selectedSubDist = value;
    notifyListeners();
  }

  void setDisableSubDist(bool value) {
    _disableSubDist = value;
    notifyListeners();
  }

  // Fetch provinces
  Future<void> fetchProvinces() async {
    try {
      final response = await _dio.get(
        "https://dev.farizdotid.com/api/daerahindonesia/provinsi",
        options: Options(headers: {"Accept": "application/json"}),
      );
      _dataProv = response.data["provinsi"];
      notifyListeners();
    } catch (e) {
      throw Exception("Failed to fetch provinces: $e");
    }
  }

  // Fetch districts based on province
  Future<void> fetchDistricts(String provinceId) async {
    try {
      final response = await _dio.get(
        "https://dev.farizdotid.com/api/daerahindonesia/kota?id_provinsi=$provinceId",
        options: Options(headers: {"Accept": "application/json"}),
      );
      _dataDist = response.data["kota_kabupaten"];
      notifyListeners();
    } catch (e) {
      throw Exception("Failed to fetch districts: $e");
    }
  }

  // Fetch sub-districts based on district
  Future<void> fetchSubDistricts(String districtId) async {
    try {
      final response = await _dio.get(
        "https://dev.farizdotid.com/api/daerahindonesia/kecamatan?id_kota=$districtId",
        options: Options(headers: {"Accept": "application/json"}),
      );
      _dataSubDist = response.data["kecamatan"];
      notifyListeners();
    } catch (e) {
      throw Exception("Failed to fetch sub-districts: $e");
    }
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> nextStep(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setLoading(true);

      await Future.delayed(const Duration(seconds: 2));
      if (_currentStep < _steps.length - 1) {
        _currentStep++;
        notifyListeners();
      } else {
        submitForm(context);
      }
      setLoading(false);
    }
  }

  // Future<void> nextStep() async {
  //   if (_formKey.currentState!.validate()) {
  //     setLoading(true);

  //     await Future.delayed(const Duration(seconds: 2));
  //     if (_currentStep < _steps.length - 1) {
  //       _currentStep++;
  //       notifyListeners();
  //     } else {
  //       submitForm();
  //     }
  //     setLoading(false);
  //   }
  // }

  void previousStep(BuildContext context) {
    if (_currentStep > 0) {
      _currentStep--;
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    }
    notifyListeners();
  }

  void submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      if (kDebugMode) {
        print('Form Submitted Success');
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CustomScreen()),
      );
    }
  }
}
