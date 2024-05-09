import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ticket_sales/domain/api_client/api_client.dart';
import 'package:ticket_sales/domain/configuration/configuration.dart';
import 'package:ticket_sales/domain/entity/ticked_offers.dart';
import 'package:ticket_sales/domain/repository/shared_pref_repository.dart';
import 'package:ticket_sales/ui/screens/select_country_screen/select_country_event.dart';
import 'package:ticket_sales/ui/screens/select_country_screen/select_country_state.dart';

class SelectCountryScreenBloc
    extends Bloc<SelectCountryEvent, SelectCountryState> {
  final IApiClient apiClient;
  final String selectCountry;
  SelectCountryScreenBloc(super.initialState, this.apiClient,
      {required this.selectCountry}) {
    on<SelectCountryEvent>((event, emit) async {
      if (event is SelectCountryInitEvent) {
        await _initState(event, emit);
      }
      if (event is SelectCountryCombackDayEvent) {
        _combackDay(event, emit);
      }
      if (event is SelectCountryDepartureDayEvent) {
        _combackDeparture(event, emit);
      }
      if (event is SelectCountrySwapCountryEvent) {
        await _swapCountry(event, emit);
      }
      if (event is SelectCountryWriteInCountryEvent) {
        await _writeInCountry(event, emit);
      }
      if (event is SelectCountryWriteOutCountryEvent) {
        await _writeOutCountry(event, emit);
      }
    });
    add(SelectCountryInitEvent());
  }

  Future<void> _initState(
    SelectCountryEvent event,
    Emitter<SelectCountryState> emit,
  ) async {
    List<TicketsOffer>? newTicketsOffer;
    final response = await apiClient.get(Configuration.selectCountry);
    if (response != null) {
      final List<TicketsOffer> ticketsOffers =
          TickedOffers.fromMap(response.data).ticketsOffers;
      newTicketsOffer = ticketsOffers;
    }
    final newInCountry =
        await SharedPrefferences.shared.get(SharedPrefKeys.inCountry, '');
    await SharedPrefferences.shared
        .set(SharedPrefKeys.outCountry, selectCountry);
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd MMMM', 'ru').format(now);
    String formattedWeek = DateFormat('EE', 'ru').format(now);
    final newState = state.copyWith(
      inCountry: newInCountry,
      outCountry: selectCountry,
      ticketsOffers: newTicketsOffer,
      dayComback: '',
      dayNumber: formattedDate,
      dayWeek: formattedWeek,
    );
    emit(newState);
  }

  Future<void> _writeInCountry(
    SelectCountryWriteInCountryEvent event,
    Emitter<SelectCountryState> emit,
  ) async {
    await SharedPrefferences.shared
        .set(SharedPrefKeys.inCountry, event.inCountry);
    final newState = state.copyWith(inCountry: event.inCountry);
    emit(newState);
  }

  Future<void> _writeOutCountry(
    SelectCountryWriteOutCountryEvent event,
    Emitter<SelectCountryState> emit,
  ) async {
    await SharedPrefferences.shared
        .set(SharedPrefKeys.outCountry, event.outCountry);
    final newState = state.copyWith(outCountry: event.outCountry);
    emit(newState);
  }

  Future<void> _swapCountry(
    SelectCountrySwapCountryEvent event,
    Emitter<SelectCountryState> emit,
  ) async {
    final String inCountry = state.inCountry ?? '';
    final String outCountry = state.outCountry ?? '';
    await SharedPrefferences.shared.set(SharedPrefKeys.outCountry, inCountry);
    await SharedPrefferences.shared.set(SharedPrefKeys.inCountry, outCountry);
    final newState = state.copyWith(
        outCountry: state.inCountry, inCountry: state.outCountry);
    emit(newState);
  }

  void _combackDay(
    SelectCountryCombackDayEvent event,
    Emitter<SelectCountryState> emit,
  ) {
    String formattedCombackDay =
        DateFormat('dd MMMM, EE', 'ru').format(event.date);
    final newState = state.copyWith(
      dayComback: formattedCombackDay,
    );
    emit(newState);
  }

  void _combackDeparture(
    SelectCountryDepartureDayEvent event,
    Emitter<SelectCountryState> emit,
  ) {
    String formattedDate = DateFormat('dd MMMM', 'ru').format(event.date);
    String formattedWeek = DateFormat('EE', 'ru').format(event.date);
    final newState = state.copyWith(
      dayNumber: formattedDate,
      dayWeek: formattedWeek,
    );
    emit(newState);
  }
}
