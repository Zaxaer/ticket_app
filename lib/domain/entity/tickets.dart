import 'dart:convert';

import 'package:flutter/foundation.dart';

class Tickets {
  final List<Ticket> tickets;
  Tickets({
    required this.tickets,
  });

  Tickets copyWith({
    List<Ticket>? tickets,
  }) {
    return Tickets(
      tickets: tickets ?? this.tickets,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tickets': tickets.map((x) => x.toMap()).toList(),
    };
  }

  factory Tickets.fromMap(Map<String, dynamic> map) {
    return Tickets(
      tickets: List<Ticket>.from(map['tickets']?.map((x) => Ticket.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Tickets.fromJson(String source) =>
      Tickets.fromMap(json.decode(source));

  @override
  String toString() => 'Tickets(tickets: $tickets)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Tickets && listEquals(other.tickets, tickets);
  }

  @override
  int get hashCode => tickets.hashCode;
}

class Ticket {
  final int id;
  final String? badge;
  final Price price;
  final String providerName;
  final String company;
  final Departure departure;
  final Arrival arrival;
  final bool hasTransfer;
  final bool hasVisaTransfer;
  final Luggage luggage;
  final HandLuggage handLuggage;
  final bool isReturnable;
  final bool isExchangable;
  Ticket({
    required this.id,
    required this.badge,
    required this.price,
    required this.providerName,
    required this.company,
    required this.departure,
    required this.arrival,
    required this.hasTransfer,
    required this.hasVisaTransfer,
    required this.luggage,
    required this.handLuggage,
    required this.isReturnable,
    required this.isExchangable,
  });

  Ticket copyWith({
    int? id,
    String? badge,
    Price? price,
    String? providerName,
    String? company,
    Departure? departure,
    Arrival? arrival,
    bool? hasTransfer,
    bool? hasVisaTransfer,
    Luggage? luggage,
    HandLuggage? handLuggage,
    bool? isReturnable,
    bool? isExchangable,
  }) {
    return Ticket(
      id: id ?? this.id,
      badge: badge ?? this.badge,
      price: price ?? this.price,
      providerName: providerName ?? this.providerName,
      company: company ?? this.company,
      departure: departure ?? this.departure,
      arrival: arrival ?? this.arrival,
      hasTransfer: hasTransfer ?? this.hasTransfer,
      hasVisaTransfer: hasVisaTransfer ?? this.hasVisaTransfer,
      luggage: luggage ?? this.luggage,
      handLuggage: handLuggage ?? this.handLuggage,
      isReturnable: isReturnable ?? this.isReturnable,
      isExchangable: isExchangable ?? this.isExchangable,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'badge': badge,
      'price': price.toMap(),
      'provider_name': providerName,
      'company': company,
      'departure': departure.toMap(),
      'arrival': arrival.toMap(),
      'has_transfer': hasTransfer,
      'has_visa_transfer': hasVisaTransfer,
      'luggage': luggage.toMap(),
      'hand_luggage': handLuggage.toMap(),
      'is_returnable': isReturnable,
      'is_exchangable': isExchangable,
    };
  }

  factory Ticket.fromMap(Map<String, dynamic> map) {
    return Ticket(
      id: map['id']?.toInt() ?? 0,
      badge: map['badge'] ?? '',
      price: Price.fromMap(map['price']),
      providerName: map['provider_name'] ?? '',
      company: map['company'] ?? '',
      departure: Departure.fromMap(map['departure']),
      arrival: Arrival.fromMap(map['arrival']),
      hasTransfer: map['has_transfer'] ?? false,
      hasVisaTransfer: map['has_visa_transfer'] ?? false,
      luggage: Luggage.fromMap(map['luggage']),
      handLuggage: HandLuggage.fromMap(map['hand_luggage']),
      isReturnable: map['is_returnable'] ?? false,
      isExchangable: map['is_exchangable'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Ticket.fromJson(String source) => Ticket.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Ticket(id: $id, badge: $badge, price: $price, provider_name: $providerName, company: $company, departure: $departure, arrival: $arrival, has_transfer: $hasTransfer, has_visa_transfer: $hasVisaTransfer, luggage: $luggage, hand_luggage: $handLuggage, is_returnable: $isReturnable, is_exchangable: $isExchangable)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Ticket &&
        other.id == id &&
        other.badge == badge &&
        other.price == price &&
        other.providerName == providerName &&
        other.company == company &&
        other.departure == departure &&
        other.arrival == arrival &&
        other.hasTransfer == hasTransfer &&
        other.hasVisaTransfer == hasVisaTransfer &&
        other.luggage == luggage &&
        other.handLuggage == handLuggage &&
        other.isReturnable == isReturnable &&
        other.isExchangable == isExchangable;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        badge.hashCode ^
        price.hashCode ^
        providerName.hashCode ^
        company.hashCode ^
        departure.hashCode ^
        arrival.hashCode ^
        hasTransfer.hashCode ^
        hasVisaTransfer.hashCode ^
        luggage.hashCode ^
        handLuggage.hashCode ^
        isReturnable.hashCode ^
        isExchangable.hashCode;
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

class Departure {
  final String town;
  final String date;
  final String airport;
  Departure({
    required this.town,
    required this.date,
    required this.airport,
  });

  Departure copyWith({
    String? town,
    String? date,
    String? airport,
  }) {
    return Departure(
      town: town ?? this.town,
      date: date ?? this.date,
      airport: airport ?? this.airport,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'town': town,
      'date': date,
      'airport': airport,
    };
  }

  factory Departure.fromMap(Map<String, dynamic> map) {
    return Departure(
      town: map['town'] ?? '',
      date: map['date'] ?? '',
      airport: map['airport'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Departure.fromJson(String source) =>
      Departure.fromMap(json.decode(source));

  @override
  String toString() => 'Departure(town: $town, date: $date, airport: $airport)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Departure &&
        other.town == town &&
        other.date == date &&
        other.airport == airport;
  }

  @override
  int get hashCode => town.hashCode ^ date.hashCode ^ airport.hashCode;
}

class Arrival {
  final String town;
  final String date;
  final String airport;
  Arrival({
    required this.town,
    required this.date,
    required this.airport,
  });

  Arrival copyWith({
    String? town,
    String? date,
    String? airport,
  }) {
    return Arrival(
      town: town ?? this.town,
      date: date ?? this.date,
      airport: airport ?? this.airport,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'town': town,
      'date': date,
      'airport': airport,
    };
  }

  factory Arrival.fromMap(Map<String, dynamic> map) {
    return Arrival(
      town: map['town'] ?? '',
      date: map['date'] ?? '',
      airport: map['airport'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Arrival.fromJson(String source) =>
      Arrival.fromMap(json.decode(source));

  @override
  String toString() => 'Arrival(town: $town, date: $date, airport: $airport)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Arrival &&
        other.town == town &&
        other.date == date &&
        other.airport == airport;
  }

  @override
  int get hashCode => town.hashCode ^ date.hashCode ^ airport.hashCode;
}

class Luggage {
  final bool hasLuggage;

  Luggage({
    required this.hasLuggage,
  });

  Luggage copyWith({
    bool? hasLuggage,
    Price? price,
  }) {
    return Luggage(
      hasLuggage: hasLuggage ?? this.hasLuggage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'has_luggage': hasLuggage,
    };
  }

  factory Luggage.fromMap(Map<String, dynamic> map) {
    return Luggage(
      hasLuggage: map['has_luggage'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Luggage.fromJson(String source) =>
      Luggage.fromMap(json.decode(source));

  @override
  String toString() => 'Luggage(has_luggage: $hasLuggage)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Luggage && other.hasLuggage == hasLuggage;
  }

  @override
  int get hashCode => hasLuggage.hashCode;
}

class HandLuggage {
  final bool hasHandLuggage;
  final String size;
  HandLuggage({
    required this.hasHandLuggage,
    required this.size,
  });

  HandLuggage copyWith({
    bool? hasHandLuggage,
    String? size,
  }) {
    return HandLuggage(
      hasHandLuggage: hasHandLuggage ?? this.hasHandLuggage,
      size: size ?? this.size,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'has_hand_luggage': hasHandLuggage,
      'size': size,
    };
  }

  factory HandLuggage.fromMap(Map<String, dynamic> map) {
    return HandLuggage(
      hasHandLuggage: map['has_hand_luggage'] ?? false,
      size: map['size'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory HandLuggage.fromJson(String source) =>
      HandLuggage.fromMap(json.decode(source));

  @override
  String toString() =>
      'Hand_luggage(has_hand_luggage: $hasHandLuggage, size: $size)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HandLuggage &&
        other.hasHandLuggage == hasHandLuggage &&
        other.size == size;
  }

  @override
  int get hashCode => hasHandLuggage.hashCode ^ size.hashCode;
}
