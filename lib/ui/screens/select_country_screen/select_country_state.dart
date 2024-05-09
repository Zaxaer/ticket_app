import 'package:ticket_sales/domain/entity/ticked_offers.dart';

class SelectCountryState {
  final String? inCountry;
  final String? outCountry;
  final String? dayNumber;
  final String? dayWeek;
  final String? dayComback;
  final List<TicketsOffer>? ticketsOffers;
  SelectCountryState({
    this.inCountry,
    this.outCountry,
    this.dayNumber,
    this.dayWeek,
    this.dayComback,
    this.ticketsOffers,
  });
  SelectCountryState.initState()
      : inCountry = '',
        outCountry = '',
        dayNumber = '',
        dayWeek = '',
        dayComback = '',
        ticketsOffers = [];

  SelectCountryState copyWith({
    String? inCountry,
    String? outCountry,
    String? dayNumber,
    String? dayWeek,
    String? dayComback,
    List<TicketsOffer>? ticketsOffers,
  }) {
    return SelectCountryState(
      inCountry: inCountry ?? this.inCountry,
      outCountry: outCountry ?? this.outCountry,
      dayNumber: dayNumber ?? this.dayNumber,
      dayWeek: dayWeek ?? this.dayWeek,
      dayComback: dayComback ?? this.dayComback,
      ticketsOffers: ticketsOffers ?? this.ticketsOffers,
    );
  }
}
