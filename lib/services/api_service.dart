import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quizflutter/models/question.dart';

class ApiService {
  static const String baseUrl = 'https://opentdb.com';

  Future<List<String>> fetchCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/api_category.php'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['trivia_categories'] as List)
          .map((category) => category['name'].toString())
          .toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<List<Question>> fetchQuestions({
    required String category,
    required String difficulty,
    required int amount,
  }) async {
    final categoryIndex = await _getCategoryIndex(category);
    final response = await http.get(Uri.parse(
        '$baseUrl/api.php?amount=$amount&category=$categoryIndex&difficulty=$difficulty&type=multiple'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['results'] as List)
          .map((json) => Question.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load questions');
    }
  }

  Future<int> _getCategoryIndex(String categoryName) async {
    final response = await http.get(Uri.parse('$baseUrl/api_category.php'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final category = (data['trivia_categories'] as List)
          .firstWhere((cat) => cat['name'] == categoryName);
      return category['id'];
    } else {
      throw Exception('Failed to load category index');
    }
  }
}