import 'package:flutter/material.dart';
import 'package:flutter_app/net/beer_data.dart';
import 'package:flutter_app/net/beer_rest.dart';

class BeerListPage extends StatefulWidget {
	BeerListPage({Key key, this.title}) : super(key: key);
	final String title;

	@override
	_BeerListPageState createState() => new _BeerListPageState();
}

class _BeerListPageState extends State<BeerListPage> {

	final rest = new BeerRest();
	List<BeerData> beerList = new List();

	void _itemClicked(BuildContext context, int index) async {
		Navigator.of(context).pushNamed('beer_details/${beerList[index].id}');
	}

	Widget _createItemBuilder(BuildContext context, int index) {
		return new InkWell(
			child: new Padding(
				padding: const EdgeInsets.all(8.0),
				child: new ListTile(
					leading: new CircleAvatar(
							backgroundColor: new Color.fromARGB(255, 200, 200, 200),
							child: new Image(image: new NetworkImage(beerList[index].imageUrl))
					),
					title: new Text(beerList[index].name),
					subtitle: new Text(beerList[index].tagLine, maxLines: 1, overflow: TextOverflow.ellipsis),
				),
			),
			onTap: () => _itemClicked(context, index),
		);
	}

	@override
	Widget build(BuildContext context) {
		return new Scaffold(
				appBar: new AppBar(
					title: new Text(widget.title),
				),
				body: new FutureBuilder(
						future: rest.getBeers(),
						builder: (BuildContext context, AsyncSnapshot<List<BeerData>> snapshot) {
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
							beerList = snapshot.data;
							return new ListView.builder(
								itemBuilder: _createItemBuilder,
								itemCount: beerList.length,
							);
						})
		);
	}
}
