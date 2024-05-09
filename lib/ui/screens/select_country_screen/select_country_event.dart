abstract class SelectCountryEvent {}

class SelectCountryInitEvent extends SelectCountryEvent {}

class SelectCountryCombackDayEvent extends SelectCountryEvent {
  final DateTime date;
  SelectCountryCombackDayEvent({
    required this.date,
  });
}

class SelectCountryDepartureDayEvent extends SelectCountryEvent {
  final DateTime date;
  SelectCountryDepartureDayEvent({
    required this.date,
  });
}

class SelectCountrySwapCountryEvent extends SelectCountryEvent {
  SelectCountrySwapCountryEvent();
}

class SelectCountryWriteInCountryEvent extends SelectCountryEvent {
  final String inCountry;
  SelectCountryWriteInCountryEvent({
    required this.inCountry,
  });
}

class SelectCountryWriteOutCountryEvent extends SelectCountryEvent {
  final String outCountry;
  SelectCountryWriteOutCountryEvent({
    required this.outCountry,
  });
}
