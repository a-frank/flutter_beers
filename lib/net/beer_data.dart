class BeerData {
	final int id;
	final String name;
	final String tagLine;
	final String imageUrl;
	final String description;
	final List<String> fooPairing;

	BeerData.fromMap(Map<String, dynamic> map)
			:
				id = map['id'],
				name = map['name'],
				tagLine = map['tagline'],
				imageUrl = map['image_url'],
				description = map['description'],
				fooPairing = map['food_pairing'];
}