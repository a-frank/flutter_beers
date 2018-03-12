import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class BeerLocalization {

	final Locale locale;

	BeerLocalization(this.locale);

	static BeerLocalization of(BuildContext context) {
		return Localizations.of<BeerLocalization>(context, BeerLocalization);
	}

	static Map<String, Map<String, String>> _localizedData = {
		'en': {
			'title': 'The Beer App',
			'loading': 'Loading data...',
			'details': 'Beerdetails',
			'food_pairing': 'Foodpairings:'
		},
		'de': {
			'title': 'Die Bier App',
			'loading': 'Lade Daten...',
			'details': 'Bierdetails',
			'food_pairing': 'Essenspaarungen:'
		}
	};

	String get title {
		return _localizedData[locale.languageCode]['title'];
	}

	String get loading {
		return _localizedData[locale.languageCode]['loading'];
	}

	String get details {
		return _localizedData[locale.languageCode]['details'];
	}

	String get foodPairings {
		return _localizedData[locale.languageCode]['food_pairing'];
	}
}

class BeerLocalizationDelegate extends LocalizationsDelegate<BeerLocalization> {

	const BeerLocalizationDelegate();

	@override
	bool isSupported(Locale locale) => ['en', 'de'].contains(locale.languageCode);

	@override
	Future<BeerLocalization> load(Locale locale) {
		return new SynchronousFuture<BeerLocalization>(new BeerLocalization(locale));
	}

	@override
	bool shouldReload(LocalizationsDelegate<BeerLocalization> old) => false;
}