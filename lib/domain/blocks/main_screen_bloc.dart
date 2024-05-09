import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket_sales/domain/api_client/api_client.dart';
import 'package:ticket_sales/domain/configuration/configuration.dart';
import 'package:ticket_sales/domain/entity/offers.dart';
import 'package:ticket_sales/domain/repository/shared_pref_repository.dart';
import 'package:ticket_sales/ui/screens/main_screen/main_event.dart';
import 'package:ticket_sales/ui/screens/main_screen/main_state.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  final IApiClient apiClient;
  MainScreenBloc(super.initialState, this.apiClient) {
    on<MainScreenEvent>((event, emit) async {
      if (event is MainScreenWriteInCountryEvent) {
        await _writeInCountry(event, emit);
      }
      if (event is MainScreenWriteOutCountryEvent) {
        await _writeOutCountry(event, emit);
      }
      if (event is MainScreenInitStateEvent) {
        await _initState(event, emit);
      }
    });
    add(MainScreenInitStateEvent());
  }

  Future<void> _initState(
    MainScreenEvent event,
    Emitter<MainScreenState> emit,
  ) async {
    List<Offer>? newOffers;
    final response = await apiClient.get(Configuration.firstEntry);
    if (response != null) {
      final List<Offer> offers = Offers.fromMap(response.data).offers;
      newOffers = offers;
    }
    final newInCountry =
        await SharedPrefferences.shared.get(SharedPrefKeys.inCountry, '');
    final newOutCountry =
        await SharedPrefferences.shared.get(SharedPrefKeys.outCountry, '');
    final newState = state.copyWith(
        inCountry: newInCountry, outCountry: newOutCountry, offers: newOffers);
    emit(newState);
  }

  Future<void> _writeInCountry(
    MainScreenWriteInCountryEvent event,
    Emitter<MainScreenState> emit,
  ) async {
    await SharedPrefferences.shared
        .set(SharedPrefKeys.inCountry, event.writeInCountry);
    final newState = state.copyWith(inCountry: event.writeInCountry);
    emit(newState);
  }

  Future<void> _writeOutCountry(
    MainScreenWriteOutCountryEvent event,
    Emitter<MainScreenState> emit,
  ) async {
    await SharedPrefferences.shared
        .set(SharedPrefKeys.outCountry, event.writeOutCountry);
    final newState = state.copyWith(outCountry: event.writeOutCountry);
    emit(newState);
  }
}
