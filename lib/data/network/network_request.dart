import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_flutter_test_app1/config/server_addresses.dart';
import 'package:my_flutter_test_app1/data/error/exceptions.dart';
import 'package:my_flutter_test_app1/utils/constants/strings.dart';

abstract class NetworkRequestAbstract{
  Future<dynamic> getCandlesticksResult({
    String limit,
  });
  Future<dynamic> getCubicsResult({
    String limit,
  });
  Future<dynamic> getStacksResult({
    String limit,
  });
}



class NetworkRequest implements NetworkRequestAbstract{

  final http.Client client;

  NetworkRequest({@required this.client});

  @override
  Future<dynamic> getCandlesticksResult({
    String limit,
  }) async {
    var body = {
      'api_key':Strings.api_key,
      'limit':Strings.limit,
      'fsym':Strings.fsym,
      'tsym':Strings.tsym,
    };
    return _getApiRequest(ServerAddresses.candlesticks, body);
  }

  @override
  Future<dynamic> getCubicsResult({
    String limit,
  }) async {
    var body = {
      'api_key':Strings.api_key,
      'limit':limit,
      'tsym':Strings.tsym,
    };
    return _postApiRequest(ServerAddresses.cubic, body);
  }

  @override
  Future<dynamic> getStacksResult({
    String limit,
  }) async {
    var body = {
      'api_key':Strings.api_key,
      'limit':limit,
      'fsym':Strings.fsym,
      'tsym':Strings.tsym,
      'e':Strings.binance,
    };
    return _getApiRequest(ServerAddresses.stack, body);
  }







  Future<dynamic> _getApiRequest(String url, body) async {
    String queryString = Uri(queryParameters: body).query;
    var requestUrl = url + '?' + queryString;
    final response = await client.get(requestUrl,
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw HttpRequestException();
    }
  }

  Future<dynamic> _postApiRequest(String url, body) async {
    Map<String,String> headers = {'Content-Type': 'application/json',};
    final response = await client.post(
        url,
        headers: headers,
        body: json.encode(body));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw HttpRequestException();
    }
  }


}