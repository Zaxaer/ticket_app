import 'package:flutter/material.dart';
import 'package:ticket_sales/domain/factory/screen_factory.dart';

class MainNavigationRouteName {
  static const navigationScreen = 'navigation';
  static const mainScreen = 'main_screen';
  static const filtrScreen = 'filtr_screen';
  static const selectCountryScreen = 'select_country_screen';
  static const watchAllTicket = 'watch_all_ticked';
}

class MainNavigation {
  static final _screenFactory = ScreenFactory();

  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteName.navigationScreen: (_) =>
        _screenFactory.navigationScreen(),
    MainNavigationRouteName.mainScreen: (_) => _screenFactory.mainScreen(),
  };
  Route<Object>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteName.selectCountryScreen:
        final arguments = settings.arguments;
        final selectCountry = arguments is String ? arguments : '';
        return MaterialPageRoute(
          builder: (_) => _screenFactory.selectCountryScreen(selectCountry),
        );
      case MainNavigationRouteName.watchAllTicket:
        final arguments = settings.arguments;
        final data = arguments is String ? arguments : '';
        return MaterialPageRoute(
          builder: (_) => _screenFactory.watchAllTicketScreen(data),
        );
      default:
        return MaterialPageRoute(
            builder: (_) => _screenFactory.navigationScreen());
    }
  }
}
