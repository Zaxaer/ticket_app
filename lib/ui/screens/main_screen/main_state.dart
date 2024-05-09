import 'package:ticket_sales/domain/entity/offers.dart';
import 'package:ticket_sales/resources/app_image.dart';

class MainScreenState {
  final List<Offer>? offers;
  final String? inCountry;
  final String? outCountry;
  MainScreenState({
    required this.inCountry,
    required this.outCountry,
    required this.offers,
  });
  MainScreenState.initState()
      : inCountry = '',
        outCountry = '',
        offers = [];

  MainScreenState copyWith({
    String? inCountry,
    String? outCountry,
    List<Offer>? offers,
  }) {
    return MainScreenState(
      inCountry: inCountry ?? this.inCountry,
      outCountry: outCountry ?? this.outCountry,
      offers: offers ?? this.offers,
    );
  }

  final Map<int, String> image = {
    0: AppImages.mainImageOne,
    1: AppImages.mainImageTwo,
    2: AppImages.mainImageThree,
  };
}

class BottomSheetState {
  final String? inCountry;
  final String? outCountry;
  BottomSheetState({
    this.inCountry,
    this.outCountry,
  });

  BottomSheetState.initState()
      : inCountry = '',
        outCountry = '';

  BottomSheetState copyWith({
    String? inCountry,
    String? outCountry,
  }) {
    return BottomSheetState(
      inCountry: inCountry ?? this.inCountry,
      outCountry: outCountry ?? this.outCountry,
    );
  }
}
