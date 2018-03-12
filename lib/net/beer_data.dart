import 'dart:collection';

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

	Map<String, dynamic> toMap() {
		final map = new HashMap<String, dynamic>();
		map['id'] = id;
		map['name'] = name;
		map['tagline'] = tagLine;
		map['image_url'] = imageUrl;
		map['description'] = description;
		map['food_pairing'] = fooPairing;
		return map;
	}
}