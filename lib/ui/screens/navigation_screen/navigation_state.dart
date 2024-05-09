class NavigationState {
  final int currentIndex;

  NavigationState(
    this.currentIndex,
  );

  NavigationState.initialState() : currentIndex = 0;

  NavigationState copyWith({
    int? currentIndex,
  }) {
    return NavigationState(
      currentIndex ?? this.currentIndex,
    );
  }
}
