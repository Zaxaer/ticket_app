import 'dart:convert';

import 'package:flutter/foundation.dart';

class Offers {
  final List<Offer> offers;
  Offers({
    required this.offers,
  });

  Offers copyWith({
    List<Offer>? offers,
  }) {
    return Offers(
      offers: offers ?? this.offers,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'offers': offers.map((x) => x.toMap()).toList(),
    };
  }

  factory Offers.fromMap(Map<String, dynamic> map) {
    return Offers(
      offers: List<Offer>.from(map['offers']?.map((x) => Offer.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Offers.fromJson(String source) => Offers.fromMap(json.decode(source));

  @override
  String toString() => 'Offers(offers: $offers)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Offers && listEquals(other.offers, offers);
  }

  @override
  int get hashCode => offers.hashCode;
}

class Offer {
  final int id;
  final String title;
  final String town;
  final Price price;
  Offer({
    required this.id,
    required this.title,
    required this.town,
    required this.price,
  });

  Offer copyWith({
    int? id,
    String? title,
    String? town,
    Price? price,
  }) {
    return Offer(
      id: id ?? this.id,
      title: title ?? this.title,
      town: town ?? this.town,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'town': town,
      'price': price.toMap(),
    };
  }

  factory Offer.fromMap(Map<String, dynamic> map) {
    return Offer(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      town: map['town'] ?? '',
      price: Price.fromMap(map['price']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Offer.fromJson(String source) => Offer.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Offer(id: $id, title: $title, town: $town, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Offer &&
        other.id == id &&
        other.title == title &&
        other.town == town &&
        other.price == price;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ town.hashCode ^ price.hashCode;
  }
}

class Price {
  final int value;
  Price({
    required this.value,
  });

  Price copyWith({
    int? value,
  }) {
    return Price(
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'value': value,
    };
  }

  factory Price.fromMap(Map<String, dynamic> map) {
    return Price(
      value: map['value']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Price.fromJson(String source) => Price.fromMap(json.decode(source));

  @override
  String toString() => 'Price(value: $value)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Price && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}
