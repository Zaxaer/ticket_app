abstract class MainScreenEvent {}

class MainScreenWriteInCountryEvent extends MainScreenEvent {
  final String writeInCountry;
  MainScreenWriteInCountryEvent({
    required this.writeInCountry,
  });
}

class MainScreenWriteOutCountryEvent extends MainScreenEvent {
  final String writeOutCountry;
  MainScreenWriteOutCountryEvent({
    required this.writeOutCountry,
  });
}

class MainScreenInitStateEvent extends MainScreenEvent {}

abstract class BottomSheetEvent {}

class BottomSheetWriteInCountryEvent extends BottomSheetEvent {
  final String writeInCountry;
  BottomSheetWriteInCountryEvent({
    required this.writeInCountry,
  });
}

class BottomSheetWriteOutCountryEvent extends BottomSheetEvent {
  final String writeOutCountry;
  BottomSheetWriteOutCountryEvent({
    required this.writeOutCountry,
  });
}

class BottomSheetInitStateEvent extends BottomSheetEvent {}
