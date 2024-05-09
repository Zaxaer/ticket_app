import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket_sales/domain/api_client/api_client.dart';
import 'package:ticket_sales/domain/configuration/configuration.dart';
import 'package:ticket_sales/domain/entity/tickets.dart';
import 'package:ticket_sales/domain/repository/shared_pref_repository.dart';
import 'package:ticket_sales/ui/screens/watch_all_ticked/watch_all_ticket_event.dart';

import '../../ui/screens/watch_all_ticked/watch_all_ticket_state.dart';

class WatchAllTicketScreenBloc
    extends Bloc<WatchAllTicketEvent, WatchAllTicketState> {
  final IApiClient apiClient;
  final String dataDeparture;
  WatchAllTicketScreenBloc(super.initialState, this.apiClient,
      {required this.dataDeparture}) {
    on<WatchAllTicketEvent>((event, emit) async {
      if (event is WatchAllTicketInitStateEvent) {
        await _initState(event, emit);
      }
    });
    add(WatchAllTicketInitStateEvent());
  }

  Future<void> _initState(
    WatchAllTicketInitStateEvent event,
    Emitter<WatchAllTicketState> emit,
  ) async {
    List<Ticket>? newTicketsOffer;
    final response = await apiClient.get(Configuration.allTicked);
    if (response != null) {
      final List<Ticket> ticketsOffers = Tickets.fromMap(response.data).tickets;
      newTicketsOffer = ticketsOffers;
    }
    final newInCountry =
        await SharedPrefferences.shared.get(SharedPrefKeys.inCountry, '');
    final newOutCountry =
        await SharedPrefferences.shared.get(SharedPrefKeys.outCountry, '');
    final newState = state.copyWith(
      inCountry: newInCountry,
      outCountry: newOutCountry,
      ticket: newTicketsOffer,
      dateDeparture: dataDeparture,
    );
    emit(newState);
  }
}
