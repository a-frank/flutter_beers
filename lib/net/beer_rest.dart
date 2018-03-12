import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_app/net/beer_data.dart';

const BASE_URL = 'api.punkapi.com';
const BEERS_API = '/v2/beers';

class BeerRest {
	final httpClient = new HttpClient();

	Future<List<BeerData>> getBeers() async {
		final uri = new Uri.http(BASE_URL, BEERS_API);
		return _getBeerList(uri);
	}

	Future<List<BeerData>> _getBeerList(Uri uri) async {
		var beerData = await _fromWeb(uri);
		// var beerData = await _fromAssets();
		final List mappedJsonData = JSON.decode(beerData);
		return mappedJsonData.map((entity) => new BeerData.fromMap(entity)).toList();
	}

	Future<String> _fromWeb(Uri uri) async {
		final request = await httpClient.getUrl(uri);
		final response = await request.close();
		return response.transform(UTF8.decoder).join();
	}

	Future<String> _fromAssets() async {
		return rootBundle.loadString('assets/beers.jon');
	}
}