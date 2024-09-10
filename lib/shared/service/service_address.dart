import 'package:dio/dio.dart';
import 'package:mondooli_registration/shared/models/cities_model.dart';
import 'package:mondooli_registration/shared/models/districts_model.dart';
import 'package:mondooli_registration/shared/models/postal_code_model.dart';
import 'package:mondooli_registration/shared/models/provience_model.dart';
import 'package:mondooli_registration/shared/models/sub_disctrict_model.dart';

class AddressService {
  final Dio _dio = Dio();

  final String _baseUrl = 'https://alamat.thecloudalert.com/api';

  Future<List<Province>> getProvinces() async {
    try {
      final response = await _dio.get('$_baseUrl/provinsi/get/');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data['result'];
        return data.map((json) => Province.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load provinces');
      }
    } catch (e) {
      throw Exception('Failed to load provinces: $e');
    }
  }

  Future<List<City>> getCities(String provinceId) async {
    try {
      final response =
          await _dio.get('$_baseUrl/kabkota/get/?d_provinsi_id=$provinceId');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data['result'];
        return data.map((json) => City.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load cities');
      }
    } catch (e) {
      throw Exception('Failed to load cities: $e');
    }
  }

  Future<List<District>> getDistricts(String cityId) async {
    try {
      final response =
          await _dio.get('$_baseUrl/kecamatan/get/?d_kabkota_id=$cityId');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data['result'];
        return data.map((json) => District.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load districts');
      }
    } catch (e) {
      throw Exception('Failed to load districts: $e');
    }
  }

  Future<List<SubDistrict>> getSubDistricts(String districtId) async {
    try {
      final response =
          await _dio.get('$_baseUrl/kelurahan/get/?d_kecamatan_id=$districtId');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data['result'];
        return data.map((json) => SubDistrict.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load sub-districts');
      }
    } catch (e) {
      throw Exception('Failed to load sub-districts: $e');
    }
  }

  Future<List<PostalCode>> getPostalCodes(
      String cityId, String districtId) async {
    try {
      final response = await _dio.get(
          '$_baseUrl/kodepos/get/?d_kabkota_id=$cityId&d_kecamatan_id=$districtId');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data['result'];
        return data.map((json) => PostalCode.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load postal codes');
      }
    } catch (e) {
      throw Exception('Failed to load postal codes: $e');
    }
  }
}
