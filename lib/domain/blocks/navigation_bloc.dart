import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket_sales/ui/screens/navigation_screen/navigation_event.dart';
import 'package:ticket_sales/ui/screens/navigation_screen/navigation_state.dart';

class NavigationScreenBloc
    extends Bloc<NavigationScreenEvent, NavigationState> {
  NavigationScreenBloc(super.initialState) {
    on<NavigationScreenEvent>((event, emit) {
      if (event is NavigationSelectScreen) {
        _selectScreen(event, emit);
      }
    });
  }

  void _selectScreen(
    NavigationSelectScreen event,
    Emitter<NavigationState> emit,
  ) {
    if (event.currentIndex == state.currentIndex) return;
    final newState = state.copyWith(currentIndex: event.currentIndex);
    emit(newState);
  }
}
