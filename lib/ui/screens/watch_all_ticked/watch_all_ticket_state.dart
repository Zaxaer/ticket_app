import 'package:ticket_sales/domain/entity/tickets.dart';

class WatchAllTicketState {
  final String inCountry;
  final String outCountry;
  final String dateDeparture;
  final List<Ticket> ticket;
  WatchAllTicketState({
    required this.inCountry,
    required this.outCountry,
    required this.dateDeparture,
    required this.ticket,
  });
  WatchAllTicketState.initState()
      : inCountry = '',
        outCountry = '',
        dateDeparture = '',
        ticket = [];

  WatchAllTicketState copyWith({
    String? inCountry,
    String? outCountry,
    String? dateDeparture,
    List<Ticket>? ticket,
  }) {
    return WatchAllTicketState(
      inCountry: inCountry ?? this.inCountry,
      outCountry: outCountry ?? this.outCountry,
      dateDeparture: dateDeparture ?? this.dateDeparture,
      ticket: ticket ?? this.ticket,
    );
  }
}
