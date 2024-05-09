import 'dart:convert';

import 'package:flutter/foundation.dart';

class TickedOffers {
  final List<TicketsOffer> ticketsOffers;
  TickedOffers({
    required this.ticketsOffers,
  });

  TickedOffers copyWith({
    List<TicketsOffer>? ticketsOffers,
  }) {
    return TickedOffers(
      ticketsOffers: ticketsOffers ?? this.ticketsOffers,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tickets_offers': ticketsOffers.map((x) => x.toMap()).toList(),
    };
  }

  factory TickedOffers.fromMap(Map<String, dynamic> map) {
    return TickedOffers(
      ticketsOffers: List<TicketsOffer>.from(
          map['tickets_offers']?.map((x) => TicketsOffer.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory TickedOffers.fromJson(String source) =>
      TickedOffers.fromMap(json.decode(source));

  @override
  String toString() => 'TickedOffers(tickets_offers: $ticketsOffers)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TickedOffers &&
        listEquals(other.ticketsOffers, ticketsOffers);
  }

  @override
  int get hashCode => ticketsOffers.hashCode;
}

class TicketsOffer {
  final int id;
  final String title;
  final List<String> timeRange;
  final Price price;
  TicketsOffer({
    required this.id,
    required this.title,
    required this.timeRange,
    required this.price,
  });

  TicketsOffer copyWith({
    int? id,
    String? title,
    List<String>? timeRange,
    Price? price,
  }) {
    return TicketsOffer(
      id: id ?? this.id,
      title: title ?? this.title,
      timeRange: timeRange ?? this.timeRange,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'time_range': timeRange,
      'price': price.toMap(),
    };
  }

  factory TicketsOffer.fromMap(Map<String, dynamic> map) {
    return TicketsOffer(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      timeRange: List<String>.from(map['time_range']),
      price: Price.fromMap(map['price']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TicketsOffer.fromJson(String source) =>
      TicketsOffer.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Tickets_offer(id: $id, title: $title, time_range: $timeRange, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TicketsOffer &&
        other.id == id &&
        other.title == title &&
        listEquals(other.timeRange, timeRange) &&
        other.price == price;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ timeRange.hashCode ^ price.hashCode;
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
