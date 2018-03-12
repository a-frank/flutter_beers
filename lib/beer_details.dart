import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/net/beer_data.dart';
import 'package:flutter_app/net/beer_rest.dart';

class BeerDetailsPage extends StatefulWidget {
	BeerDetailsPage({Key key, this.beerId}) : super(key: key);
	final int beerId;

	@override
	_BeerDetailsPageState createState() => new _BeerDetailsPageState();
}

class _BeerDetailsPageState extends State<BeerDetailsPage> {

	static const share = const MethodChannel('beer.flutter/share');

	final rest = new BeerRest();
	BeerData beer;

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
				title: new Text('Beerdetails'),
			),
			floatingActionButton: new FloatingActionButton(
					child: new Icon(Icons.share),
					onPressed: () => _shareBeer()
			),
			body: new FutureBuilder(
				future: rest.getSingleBeer(widget.beerId),
				builder: (BuildContext context, AsyncSnapshot<BeerData> snapshot) {
					if (!snapshot.hasData) {
						return new Center(
							child: new Column(
								children: <Widget>[
									new CircularProgressIndicator(),
									new Text('Loading data...')
								],
							),
						);
					}
					beer = snapshot.data;
					return new Padding(
						padding: const EdgeInsets.all(16.0),
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
																new Text(beer.name,
																	style: Theme
																			.of(context)
																			.textTheme
																			.title,
																	softWrap: true,
																	maxLines: 1,
																	overflow: TextOverflow.ellipsis,
																),
																new Text(beer.tagLine,
																	style: Theme
																			.of(context)
																			.textTheme
																			.subhead,)
															])
											)
									)

								]),
								new Container(height: 25.0),
								new Text(beer.description),
								new Container(height: 25.0),
								new Text('Foodpairings:',
										style: new TextStyle(fontWeight: FontWeight.bold)),
								new Container(height: 10.0),
								new ListView.builder(
									shrinkWrap: true,
									itemCount: beer.fooPairing.length,
									itemBuilder: _foodPairingItem,
								)
							],
						),
					);
				},
			),
		);
	}
}