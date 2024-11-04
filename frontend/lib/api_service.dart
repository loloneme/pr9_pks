import 'package:dio/dio.dart';
import './models/drink.dart';

class ApiService {
  final Dio _dio = Dio();

  final String _baseUrl = 'http://10.0.2.2:8080/handler';

  Future<List<Drink>> getDrinks() async {
    try {
      final response = await _dio.get('$_baseUrl/drink/all');
      if (response.statusCode == 200) {
        List<Drink> drinks = (response.data as List)
            .map((drink) => Drink.fromJson(drink))
            .toList();

        drinks.sort((a, b) => a.id.compareTo(b.id));

        return drinks;
      } else {
        throw Exception('Failed to load drinks');
      }
    } catch (e) {
      throw Exception('Error fetching drinks: $e');
    }
  }

  Future<Drink> getDrinkByID(int drinkID) async {
    try {
      final response = await _dio.get('$_baseUrl/drink/$drinkID');
      if (response.statusCode == 200) {
        Drink drink = Drink.fromJson(response.data);

        return drink;
      } else {
        throw Exception('Failed to load drink');
      }
    } catch (e) {
      throw Exception('Error fetching drink: $e');
    }
  }

  Future<void> updateDrink(Drink drink) async {
    try {
      final response = await _dio.put(
        '$_baseUrl/drink/${drink.id}',
          data:{
            'name': drink.name,
            'image': drink.image,
            'description': drink.description,
            'compound': drink.compound,
            'is_cold': drink.cold,
            'is_hot': drink.hot,
            'prices': drink.prices,
            'is_favorite': drink.isFavorite
          }
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to update drink: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating drink: $e');
    }
  }


  Future<void> createDrink(Drink drink) async {
    try {
      final response = await _dio.post(
          '$_baseUrl/drink',
          data:{
              'name': drink.name,
            'image': drink.image,
            'description': drink.description,
            'compound': drink.compound,
            'is_cold': drink.cold,
            'is_hot': drink.hot,
            'prices': drink.prices,
            'is_favorite': drink.isFavorite
          }
      );
      if (response.statusCode == 201) {
        return;
      } else {
        throw Exception('Failed to create drink: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error creating drink: $e');
    }
  }

  Future<void> deleteDrink(int id) async {
    try {
      final response = await _dio.delete(
          '$_baseUrl/drink/$id',
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to delete drink: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error deleting drink: $e');
    }
  }

  Future<void> toggleFavorite(int id) async {
    try {
      final response = await _dio.patch(
        '$_baseUrl/drink/$id',
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to update drink status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating drink status: $e');
    }
  }
}