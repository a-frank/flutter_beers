import 'package:flutter/material.dart';

import 'beer_details.dart';
import 'beer_list_page.dart';

void main() => runApp(new BeerApp());

class BeerApp extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return new MaterialApp(
			theme: new ThemeData(
				primarySwatch: Colors.blue,
			),
			home: new BeerListPage(title: 'The Beers App'),
			onGenerateRoute: (routeSettings) {
				var path = routeSettings.name.split('/');
				if (path[0] == 'beer_details') {
					final beerId = path.length > 1 ? int.parse(path[1]) : null;
					return new MaterialPageRoute(builder: (context) => new BeerDetailsPage(beerId: beerId), settings: routeSettings);
				}
			},
		);
	}
}

