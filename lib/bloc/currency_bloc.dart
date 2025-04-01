import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../models/currency.dart';
import 'currency_event.dart';
import 'currency_state.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  CurrencyBloc() : super(CurrencyInitial()) {
    on<FetchCurrencies>(_onFetchCurrencies);
  }

  Future<void> _onFetchCurrencies(
    FetchCurrencies event,
    Emitter<CurrencyState> emit,
  ) async {
    try {
      emit(CurrencyLoading());
      final response = await http.get(Uri.parse('http://192.168.149.213:5000/currencies'));
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['success'] == true) {
          final List<dynamic> currencies = data['data'];
          emit(CurrencyLoaded(
            currencies.map((json) => Currency.fromJson(json)).where((currency) => !currency.name.contains('متفرقه')).toList(),
          ));
        } else {
          emit(const CurrencyError('Failed to load currencies'));
        }
      } else {
        emit(const CurrencyError('Failed to load currencies'));
      }
    } catch (e) {
      emit(CurrencyError(e.toString()));
    }
  }
} 