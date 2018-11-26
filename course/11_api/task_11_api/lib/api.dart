// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// TODO: Import relevant packages
// Connecting to APIs can be done with the HTTP client in dart:io.
import 'dart:async';
import 'dart:convert' show json, utf8;
import 'dart:io';

/// For this app, the only [Category] endpoint we retrieve from an ApI is Currency.
///
/// If we had more, we could keep a list of [Categories] here.
const apiCategory = {
  'name': 'Currency',
  'route': 'currency',
};

/// The REST API retrieves unit conversions for [Categories] that change.
///
/// For example, the currency exchange rate, stock prices, the height of the
/// tides change often.
/// We have set up an API that retrieves a list of currencies and their current
/// exchange rate (mock data).
///   GET /currency: get a list of currencies
///   GET /currency/convert: get conversion from one currency amount to another
class Api {

  // TODO: Add any relevant variables and helper functions
  /// We use the `dart:io` HttpClient. More details: https://flutter.io/networking/
  // We specify the type here for readability. Since we're defining a final field,
  // the type is determined at initialization.
  final HttpClient _httpClient = HttpClient();

  /// The Api endpoint we want to hit
  ///
  /// This API doesn't have a key but often, APIs do require authentication
  final String _url = 'flutter.udacity.com';

  // TODO: Create getUnits()
  /// Gets all the units and conversion rates for a given category.
  ///
  /// The `category` parameter is the name of the [Category] from which to
  /// retrieve units. We pass this into the query parameter in the API call.
  ///
  /// Returns a list. Returns null on error.
  ///
  // Future: A Future represents a means for getting a value sometime in the future,
  //         used in asynchronous operations.
  Future<List> getUnits(String category) async { // category == 'currency'
    final uri = Uri.https(_url, '/$category'); // '/$var_name'

    final jsonResponse = await _getJson(uri); // ??

    if (jsonResponse == null || jsonResponse['units'] == null) {
      print('Error retrieving units.');
      return null;
    }
    return jsonResponse['units'];
  }

  // TODO: Create convert()
  /// Given two units, converts from one to another.
  ///
  /// Returns a double, which is the converted amount. Returns null on error.
  ///
  /// Note. It returns a future object a double
  /// https://flutter.udacity.com/currency/convert?from=US Dollar&to=Gold Bar&amount=500.0
  /// also add the async keyword to our convert function
  Future<double> convert(
      String category, String amount, String fromUnit, String toUnit) async {
    final uri = Uri.https(_url, '/$category/convert',
        { 'amount' : amount, 'from' : fromUnit, 'to' : toUnit});
    // hit the endpoint with query parameters to get the unit conversion that we want

    final jsonResponse = await _getJson(uri);

    if (jsonResponse == null || jsonResponse['status'] == null) {
      print('Error retrieving conversion.');
      return null;
    } else if (jsonResponse['status'] == 'error') {
      print(jsonResponse['message']);
      return null;
    }

    // return the conversion as a double.
    return jsonResponse['conversion'].toDouble();
  }

  /// Fetches and decodes a JSON object represented as a Dart [Map].
  ///
  /// Returns null if the API server is down, or the response is not JSON.
  Future<Map<String, dynamic>> _getJson(Uri uri) async {
    try {
      // Make a request to our URI
      // an asynchronous operation, so add the await keyword
      final httpRequest = await _httpClient.getUrl(uri);
      // get response
      // also an asynchronous operation, so add the await keyword
      final httpResponse = await httpRequest.close();

      if (httpResponse.statusCode != HttpStatus.OK) {
        return null;
      }

      // decode our JSON response body to before we parse it and return it to the units.
      // this is also an async operation.
      // The response is sent as a Stream of bytes that we need to convert to a 'String'.
      final responseBody = await httpResponse.transform(utf8.decoder).join();

      // Finally, the string is parsed into a JSON object.
      return json.decode(responseBody);
    } on Exception catch (e) {
      print('$e');
      return null;
    }
  }
}
