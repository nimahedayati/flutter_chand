import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/currency.dart';

class CurrencyRepository {
  static const String baseUrl = 'http://192.168.149.213:5000';

  Future<List<Currency>> getCurrencies() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/currencies'));
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['success'] == true) {
          final List<dynamic> currencies = data['data'];
          final List<Currency> allCurrencies = currencies.map((json) => Currency.fromJson(json)).toList();
          return allCurrencies.where((currency) => false).toList();
        }
      }
      throw Exception('Failed to load currencies');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
} 