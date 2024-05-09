import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket_sales/domain/blocks/navigation_bloc.dart';
import 'package:ticket_sales/domain/factory/screen_factory.dart';
import 'package:ticket_sales/resources/app_image.dart';
import 'package:ticket_sales/ui/screens/navigation_screen/navigation_event.dart';

class NavigationScreenWidget extends StatelessWidget {
  final ScreenFactory screenFactory;
  const NavigationScreenWidget({super.key, required this.screenFactory});

  @override
  Widget build(BuildContext context) {
    final model = context.select((NavigationScreenBloc value) => value);
    final currentIndex = context
        .select((NavigationScreenBloc value) => value.state.currentIndex);
    return SafeArea(
      child: Scaffold(
        body: <Widget>[
          screenFactory.mainScreen(),
          screenFactory.mockScreen(),
          screenFactory.mockScreen(),
          screenFactory.mockScreen(),
          screenFactory.mockScreen(),
        ][currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) =>
              model.add(NavigationSelectScreen(currentIndex: value)),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage(
                    AppImages.air,
                  ),
                ),
                label: 'Авиабилеты'),
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage(
                    AppImages.hotel,
                  ),
                ),
                label: 'Отели'),
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage(
                    AppImages.short,
                  ),
                ),
                label: 'Короче'),
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage(
                    AppImages.subscription,
                  ),
                ),
                label: 'Подписки'),
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage(
                    AppImages.profile,
                  ),
                ),
                label: 'Профиль'),
          ],
          currentIndex: currentIndex,
        ),
      ),
    );
  }
}
