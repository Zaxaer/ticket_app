abstract class NavigationScreenEvent {}

class NavigationSelectScreen extends NavigationScreenEvent {
  final int currentIndex;

  NavigationSelectScreen({required this.currentIndex});
}
