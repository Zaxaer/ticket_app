import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ticket_sales/domain/api_client/api_client.dart';
import 'package:ticket_sales/domain/blocks/bottom_sheet_bloc.dart';
import 'package:ticket_sales/domain/blocks/main_screen_bloc.dart';
import 'package:ticket_sales/resources/app_image.dart';
import 'package:ticket_sales/ui/navigation/navigation.dart';
import 'package:ticket_sales/ui/screens/main_screen/main_event.dart';
import 'package:ticket_sales/ui/screens/main_screen/main_state.dart';
import 'package:ticket_sales/ui/theme/theme.dart';
import 'package:ticket_sales/ui/widgets/widgets.dart';

class MainScreenScreen extends StatelessWidget {
  const MainScreenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 28),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _TitleAirTiketWidget(),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 34),
          ),
          SliverToBoxAdapter(
            child: _SearchRouteWidget(),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 34),
          ),
          SliverToBoxAdapter(
            child: _TextWidget(),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 16),
          ),
          SliverToBoxAdapter(
            child: _HorisntalListWidget(),
          ),
        ],
      ),
    );
  }
}

class _TitleAirTiketWidget extends StatelessWidget {
  const _TitleAirTiketWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Поиск дешевых авиабилетов',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: const Color(
              0xFFD9D9D9,
            )),
      ),
    );
  }
}

class _SearchRouteWidget extends StatelessWidget {
  const _SearchRouteWidget();

  @override
  Widget build(BuildContext context) {
    final state = context.select((MainScreenBloc bloc) => bloc.state);
    final bloc = context.select((MainScreenBloc bloc) => bloc);
    return GreyContainerWidget(
      padding: 16,
      color: ThemeApp.greyOne,
      radius: 16,
      widget: GreyContainerWidget(
        padding: 16,
        color: ThemeApp.greyThree,
        radius: 16,
        widget: Container(
          padding: const EdgeInsets.all(0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ThemeApp.greyThree,
          ),
          child: Row(
            children: [
              Image.asset(
                AppImages.search,
                color: ThemeApp.greySeven,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  children: [
                    TextFieldWidet(
                      readOnly: false,
                      sufixIcon: null,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]"))
                      ],
                      hintText: 'Откуда - Москва',
                      onChanged: (text) =>
                          bloc.add(MainScreenWriteInCountryEvent(
                        writeInCountry: text,
                      )),
                      onTap: () => {},
                      inputText: state.inCountry,
                      prefixIcon: null,
                    ),
                    const Divider(height: 1, color: ThemeApp.greyFive),
                    TextFieldWidet(
                      readOnly: true,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      sufixIcon: null,
                      hintText: 'Куда - Турция',
                      onChanged: (text) => {},
                      inputText: state.outCountry,
                      prefixIcon: null,
                      onTap: () async {
                        await showModalBottomSheet<void>(
                          showDragHandle: true,
                          backgroundColor: ThemeApp.greyTwo,
                          isScrollControlled: true,
                          useSafeArea: true,
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          builder: (BuildContext context) {
                            return BlocProvider(
                              create: (_) => BottomSheetScreenBloc(
                                  BottomSheetState.initState(), ApiClient()),
                              child: const _BottomSheetBody(),
                            );
                          },
                        ).then((value) => bloc.add(MainScreenInitStateEvent()));
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomSheetBody extends StatelessWidget {
  const _BottomSheetBody();

  @override
  Widget build(BuildContext context) {
    return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            _SearchCountryOnSheetWidget(),
            SizedBox(height: 24),
            _HotButtonOnSheetWidget(),
            SizedBox(height: 30),
            _PopularRoutWidget()
          ],
        ));
  }
}

class _SearchCountryOnSheetWidget extends StatelessWidget {
  const _SearchCountryOnSheetWidget();

  @override
  Widget build(BuildContext context) {
    final bloc = context.select((BottomSheetScreenBloc bloc) => bloc);
    final state = context.select((BottomSheetScreenBloc bloc) => bloc.state);
    return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ThemeApp.greyThree,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFieldWidet(
              readOnly: false,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]"))
              ],
              hintText: 'Откуда - Москва',
              onChanged: (text) => bloc.add(BottomSheetWriteInCountryEvent(
                writeInCountry: text,
              )),
              onTap: () => {},
              inputText: state.inCountry,
              prefixIcon: Image.asset(
                AppImages.airPlan,
              ),
              sufixIcon: null,
            ),
            const Divider(height: 1, color: ThemeApp.greyFive),
            TextFieldWidet(
              readOnly: false,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]"))
              ],
              hintText: 'Куда - Турция',
              onChanged: (text) => bloc.add(BottomSheetWriteOutCountryEvent(
                writeOutCountry: text,
              )),
              onTap: () => {},
              inputText: state.outCountry,
              prefixIcon: Image.asset(
                AppImages.search,
                color: Colors.white,
              ),
              sufixIcon: IconButton(
                iconSize: 24,
                padding: EdgeInsets.zero,
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                onPressed: () => bloc.add(BottomSheetWriteOutCountryEvent(
                  writeOutCountry: '',
                )),
              ),
            ),
          ],
        ));
  }
}

class _PopularRoutWidget extends StatelessWidget {
  const _PopularRoutWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ThemeApp.greyThree,
        ),
        child: const Column(
          children: [
            _PopularRoutCardWidget(
              image: AppImages.stambul,
              titleText: 'Стамбул',
            ),
            SizedBox(height: 8),
            Divider(height: 1, color: ThemeApp.greyFive),
            SizedBox(height: 16),
            _PopularRoutCardWidget(
              image: AppImages.sochi,
              titleText: 'Сочи',
            ),
            SizedBox(height: 8),
            Divider(height: 1, color: ThemeApp.greyFive),
            SizedBox(height: 16),
            _PopularRoutCardWidget(
              image: AppImages.phuket,
              titleText: 'Пхукет',
            ),
          ],
        ));
  }
}

class _PopularRoutCardWidget extends StatelessWidget {
  final String image;
  final String titleText;
  const _PopularRoutCardWidget({
    required this.image,
    required this.titleText,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Row(
        children: [
          SizedBox(
            height: 40,
            width: 40,
            child: Image.asset(image),
          ),
          const SizedBox(width: 8),
          Column(
            children: [
              Text(
                titleText,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 4),
              Text(
                'Популярное направление',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: ThemeApp.greyFive),
              ),
            ],
          )
        ],
      ),
      Positioned(
        top: 0,
        left: 0,
        right: 0,
        bottom: 0,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => Navigator.of(context).pushNamed(
                MainNavigationRouteName.selectCountryScreen,
                arguments: titleText),
          ),
        ),
      )
    ]);
  }
}

class _HotButtonOnSheetWidget extends StatelessWidget {
  const _HotButtonOnSheetWidget();

  @override
  Widget build(BuildContext context) {
    final bloc = context.select((BottomSheetScreenBloc bloc) => bloc);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                IconButton(
                  icon: Image.asset(AppImages.hardRoute),
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: ThemeApp.greyTwo,
                      title: Text(
                        'На главный экран',
                        style: Theme.of(context).textTheme.titleSmall,
                        textAlign: TextAlign.center,
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context)
                              .pushReplacementNamed(
                                  MainNavigationRouteName.navigationScreen),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  'Сложный маршрут',
                  style: Theme.of(context).textTheme.titleSmall,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Image.asset(AppImages.randomRoute),
                  onPressed: () => bloc.add(BottomSheetWriteOutCountryEvent(
                      writeOutCountry: 'Куда угодно')),
                ),
                Text(
                  'Куда угодно',
                  style: Theme.of(context).textTheme.titleSmall,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                IconButton(
                  icon: Image.asset(AppImages.weekend),
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: ThemeApp.greyTwo,
                      title: Text(
                        'На главный экран',
                        style: Theme.of(context).textTheme.titleSmall,
                        textAlign: TextAlign.center,
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context)
                              .pushReplacementNamed(
                                  MainNavigationRouteName.navigationScreen),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  'Выходные',
                  style: Theme.of(context).textTheme.titleSmall,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                IconButton(
                  icon: Image.asset(AppImages.hodTicked),
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: ThemeApp.greyTwo,
                      title: Text(
                        'На главный экран',
                        style: Theme.of(context).textTheme.titleSmall,
                        textAlign: TextAlign.center,
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context)
                              .pushReplacementNamed(
                                  MainNavigationRouteName.navigationScreen),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  'Горячие билеты',
                  style: Theme.of(context).textTheme.titleSmall,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _TextWidget extends StatelessWidget {
  const _TextWidget();

  @override
  Widget build(BuildContext context) {
    return Text(
      'Музыкально отлететь',
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}

class _HorisntalListWidget extends StatelessWidget {
  const _HorisntalListWidget();

  @override
  Widget build(BuildContext context) {
    final length =
        context.select((MainScreenBloc bloc) => bloc.state.offers?.length ?? 0);
    return SizedBox(
      height: 213.16,
      child: ListView.builder(
        itemCount: length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => _OffersListWidget(index),
      ),
    );
  }
}

class _OffersListWidget extends StatelessWidget {
  final int index;
  const _OffersListWidget(
    this.index,
  );

  @override
  Widget build(BuildContext context) {
    final offers = context.select((MainScreenBloc bloc) => bloc.state.offers);
    final image = context.select((MainScreenBloc bloc) => bloc.state.image);
    final imageAsset = image[index];
    return Container(
      width: 132,
      margin: const EdgeInsets.only(right: 67),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 133.16,
            child: imageAsset != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(imageAsset))
                : const Placeholder(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              offers?[index].title ?? '',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(height: 1.2),
            ),
          ),
          Text(
            offers?[index].town ?? '',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          _PriceWidget(offers?[index].price.value.toString() ?? ''),
        ],
      ),
    );
  }
}

class _PriceWidget extends StatelessWidget {
  final String price;
  const _PriceWidget(this.price);

  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat('#,###');
    return Row(
      children: [
        Image.asset(AppImages.air),
        Text(
          'от ',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        Text(
          '${formatter.format(int.parse(price)).replaceAll(',', ' ')} \u20bd',
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ],
    );
  }
}
