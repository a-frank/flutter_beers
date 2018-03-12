import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_app/net/beer_data.dart';

const BASE_URL = 'api.punkapi.com';
const BEERS_API = '/v2/beers';

class BeerRest {
	final httpClient = new HttpClient();

	Future<List<BeerData>> getBeers() async {
		final uri = new Uri.http(BASE_URL, BEERS_API);
		return _getBeerList(uri);
	}

	Future<BeerData> getSingleBeer(int id) async {
		final uri = new Uri.http(BASE_URL, BEERS_API + '/$id');
		var beerList = await _getBeerList(uri);
		if (beerList.length > 0) {
			return beerList[0];
		} else {
			return null;
		}
	}

	Future<List<BeerData>> _getBeerList(Uri uri) async {
		final request = await httpClient.getUrl(uri);
		final response = await request.close();
		final body = await response.transform(UTF8.decoder).join();
		final List mappedJsonData = JSON.decode(body);
		return mappedJsonData.map((entity) => new BeerData.fromMap(entity)).toList();
	}
}