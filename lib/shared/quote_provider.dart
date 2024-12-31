import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart'; // For loading the local JSON file
import 'package:http/http.dart' as http;

class QuoteProvider {
  static const String apiUrl = "https://qapi.vercel.app/api/random"; // API URL

  /// Fetch the daily quote
  static Future<String> fetchDailyQuote() async {
    try {
      // Check for internet connection by attempting to fetch the API
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['quote'];
      } else {
        throw Exception('Failed to fetch quote from API');
      }
    } on SocketException {
      // No internet connection, load from local JSON
      return await _fetchQuoteFromLocal();
    } catch (e) {
      return "An error occurred while fetching the quote.";
    }
  }

  /// Fetch a random quote from the local JSON file
  static Future<String> _fetchQuoteFromLocal() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/quotes.json');
      final List<dynamic> quotes = jsonDecode(jsonString);

      // Return a random quote
      quotes.shuffle();
      return quotes.first['quote'];
    } catch (e) {
      return "An error occurred while loading the local quotes.";
    }
  }
}
