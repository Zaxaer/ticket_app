import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket_sales/domain/api_client/api_client.dart';
import 'package:ticket_sales/domain/configuration/configuration.dart';
import 'package:ticket_sales/domain/repository/shared_pref_repository.dart';
import 'package:ticket_sales/ui/screens/main_screen/main_event.dart';
import 'package:ticket_sales/ui/screens/main_screen/main_state.dart';

class BottomSheetScreenBloc extends Bloc<BottomSheetEvent, BottomSheetState> {
  final IApiClient apiClient;
  BottomSheetScreenBloc(super.initialState, this.apiClient) {
    on<BottomSheetEvent>((event, emit) async {
      if (event is BottomSheetWriteInCountryEvent) {
        await _writeInCountry(event, emit);
      }
      if (event is BottomSheetWriteOutCountryEvent) {
        await _writeOutCountry(event, emit);
      }
      if (event is BottomSheetInitStateEvent) {
        await _initState(event, emit);
      }
    });
    add(BottomSheetInitStateEvent());
  }

  Future<void> _initState(
    BottomSheetInitStateEvent event,
    Emitter<BottomSheetState> emit,
  ) async {
    final newInCountry =
        await SharedPrefferences.shared.get(SharedPrefKeys.inCountry, '');
    final newState = state.copyWith(inCountry: newInCountry);
    emit(newState);
  }

  Future<void> _writeInCountry(
    BottomSheetWriteInCountryEvent event,
    Emitter<BottomSheetState> emit,
  ) async {
    await SharedPrefferences.shared
        .set(SharedPrefKeys.inCountry, event.writeInCountry);
    final newState = state.copyWith(inCountry: event.writeInCountry);
    emit(newState);
  }

  Future<void> _writeOutCountry(
    BottomSheetWriteOutCountryEvent event,
    Emitter<BottomSheetState> emit,
  ) async {
    await SharedPrefferences.shared
        .set(SharedPrefKeys.outCountry, event.writeOutCountry);
    final newState = state.copyWith(outCountry: event.writeOutCountry);
    emit(newState);
  }
}
