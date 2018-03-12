import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/i8n/BeerLocalization.dart';
import 'package:flutter_app/net/beer_data.dart';

class BeerDetailsPage extends StatelessWidget {
	static const share = const MethodChannel('beer.flutter/share');

	final BeerData beer;

	BeerDetailsPage({Key key, this.beer}) : super(key: key);

	Widget _foodPairingItem(BuildContext context, int index) {
		final pairing = beer.fooPairing[index];
		return new Text(pairing);
	}

	void _shareBeer() {
		final args = new HashMap<String, String>();
		args['name'] = beer.name;
		args['tagLine'] = beer.tagLine;
		share.invokeMethod('shareBeer', args);
	}

	@override
	Widget build(BuildContext context) {
		return new Scaffold(
				appBar: new AppBar(
						title: new Text(BeerLocalization
								.of(context)
								.details)
				),
				floatingActionButton: new FloatingActionButton(
						child: new Icon(Icons.share),
						onPressed: () => _shareBeer()
				),
				body: new Padding(
					padding: const EdgeInsets.all(16.0),
					child: new SingleChildScrollView(
							child: new Column(
								children: <Widget>[
									new Row(children: <Widget>[
										new Image(image: new NetworkImage(beer.imageUrl), width: 150.0, height: 150.0),
										new Expanded(
												child: new FittedBox(
														fit: BoxFit.fitWidth,
														child: new Column(
																crossAxisAlignment: CrossAxisAlignment.start,
																mainAxisSize: MainAxisSize.min,
																children: <Widget>[
																	new Text(
																			beer.name,
																			style: Theme
																					.of(context)
																					.textTheme
																					.title,
																			softWrap: true,
																			maxLines: 1,
																			overflow: TextOverflow.ellipsis
																	),
																	new Text(beer.tagLine,
																			style: Theme
																					.of(context)
																					.textTheme
																					.subhead)
																])
												)
										)
									]),
									new Container(height: 25.0),
									new Text(beer.description),
									new Container(height: 25.0),
									new Text(
											BeerLocalization
													.of(context)
													.foodPairings,
											style: new TextStyle(fontWeight: FontWeight.bold)
									),
									new Container(height: 10.0),
									new ListView.builder(
											shrinkWrap: true,
											itemCount: beer.fooPairing.length,
											itemBuilder: _foodPairingItem
									)
								],
							)
					),
				));
	}
}