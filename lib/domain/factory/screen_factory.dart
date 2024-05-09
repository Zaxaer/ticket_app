import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket_sales/domain/api_client/api_client.dart';
import 'package:ticket_sales/domain/blocks/main_screen_bloc.dart';
import 'package:ticket_sales/domain/blocks/navigation_bloc.dart';
import 'package:ticket_sales/domain/blocks/select_country_bloc.dart';
import 'package:ticket_sales/domain/blocks/watch_all_ticket_bloc.dart';
import 'package:ticket_sales/ui/screens/main_screen/main_state.dart';
import 'package:ticket_sales/ui/screens/navigation_screen/navigation_widget.dart';
import 'package:ticket_sales/ui/screens/navigation_screen/navigation_state.dart';
import 'package:ticket_sales/ui/screens/main_screen/main_widget.dart';
import 'package:ticket_sales/ui/screens/mock_screen/mock_screen.dart';
import 'package:ticket_sales/ui/screens/select_country_screen/select_country_state.dart';
import 'package:ticket_sales/ui/screens/select_country_screen/select_country_widget.dart';
import 'package:ticket_sales/ui/screens/watch_all_ticked/watch_all_ticked_widget.dart';
import 'package:ticket_sales/ui/screens/watch_all_ticked/watch_all_ticket_state.dart';

class ScreenFactory {
  Widget mainScreen() {
    return BlocProvider(
        create: (_) => MainScreenBloc(MainScreenState.initState(), ApiClient()),
        child: const MainScreenScreen());
  }

  Widget navigationScreen() {
    return BlocProvider(
        create: (_) => NavigationScreenBloc(NavigationState.initialState()),
        child: NavigationScreenWidget(screenFactory: this));
  }

  Widget mockScreen() {
    return const MockScreen();
  }

  Widget selectCountryScreen(final String selectCountry) {
    return BlocProvider(
        create: (_) => SelectCountryScreenBloc(
            SelectCountryState.initState(), ApiClient(),
            selectCountry: selectCountry),
        child: const SelectCountryScreenWidget());
  }

  Widget watchAllTicketScreen(final String data) {
    return BlocProvider(
        create: (_) => WatchAllTicketScreenBloc(
            WatchAllTicketState.initState(), ApiClient(),
            dataDeparture: data),
        child: const WatchAllTicketScreenWidget());
  }
}
