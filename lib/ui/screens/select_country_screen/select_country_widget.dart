import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:ticket_sales/domain/blocks/select_country_bloc.dart';
import 'package:ticket_sales/domain/entity/ticked_offers.dart';
import 'package:ticket_sales/resources/app_fonts.dart';
import 'package:ticket_sales/resources/app_image.dart';
import 'package:ticket_sales/ui/navigation/navigation.dart';
import 'package:ticket_sales/ui/screens/select_country_screen/select_country_event.dart';
import 'package:ticket_sales/ui/theme/theme.dart';
import 'package:ticket_sales/ui/widgets/widgets.dart';

class SelectCountryScreenWidget extends StatelessWidget {
  const SelectCountryScreenWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Material(
        color: Colors.black,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 28),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: _TextFieldCardWidget(),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: 13),
              ),
              SliverToBoxAdapter(
                child: _HorisontalListWidget(),
              ),
              SliverToBoxAdapter(
                child: _PriceListWidget(),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: 23),
              ),
              SliverToBoxAdapter(
                child: _WatchAllTicketButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TextFieldCardWidget extends StatelessWidget {
  const _TextFieldCardWidget();

  @override
  Widget build(BuildContext context) {
    final bloc = context.select((SelectCountryScreenBloc bloc) => bloc);
    final state = context.select((SelectCountryScreenBloc bloc) => bloc.state);
    return GreyContainerWidget(
        padding: 16,
        color: ThemeApp.greyOne,
        radius: 16,
        widget: Row(
          children: [
            Stack(children: [
              Image.asset(AppImages.back),
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                bottom: 0,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                  ),
                ),
              ),
            ]),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                children: [
                  TextFieldWidet(
                    readOnly: false,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]"))
                    ],
                    hintText: 'Минск',
                    inputText: state.inCountry,
                    onChanged: (text) => bloc
                        .add(SelectCountryWriteInCountryEvent(inCountry: text)),
                    onTap: () => {},
                    prefixIcon: null,
                    sufixIcon: SizedBox(
                      height: 24,
                      width: 24,
                      child: IconButton(
                        splashRadius: 24,
                        iconSize: 24,
                        padding: EdgeInsets.zero,
                        icon: const Icon(
                          Icons.swap_vert,
                          color: Colors.white,
                        ),
                        onPressed: () =>
                            bloc.add(SelectCountrySwapCountryEvent()),
                      ),
                    ),
                  ),
                  const Divider(height: 1, color: ThemeApp.greyFive),
                  TextFieldWidet(
                    readOnly: false,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]"))
                    ],
                    hintText: 'Сочи',
                    inputText: state.outCountry,
                    onChanged: (text) => bloc.add(
                        SelectCountryWriteOutCountryEvent(outCountry: text)),
                    onTap: () => {},
                    prefixIcon: null,
                    sufixIcon: SizedBox(
                      height: 24,
                      width: 24,
                      child: IconButton(
                        splashRadius: 24,
                        iconSize: 24,
                        padding: EdgeInsets.zero,
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                        onPressed: () => bloc.add(
                            SelectCountryWriteOutCountryEvent(outCountry: '')),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

class _HorisontalListWidget extends StatelessWidget {
  const _HorisontalListWidget();

  @override
  Widget build(BuildContext context) {
    final bloc = context.select((SelectCountryScreenBloc bloc) => bloc);
    final state = context.select((SelectCountryScreenBloc bloc) => bloc.state);
    var dayComback = state.dayComback;
    if (state.dayComback == '') {
      dayComback = 'Обратно';
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _ButtonListWidget(
            function: () async {
              final date = await _selectDate(context);
              if (date != null) {
                bloc.add(SelectCountryCombackDayEvent(date: date));
              }
            },
            child: Row(
              children: [
                dayComback == 'Обратно'
                    ? const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 16,
                      )
                    : const SizedBox.shrink(),
                Text(
                  dayComback ?? '',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontFamily: AppFonts.sfProMedium,
                        fontStyle: FontStyle.italic,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          _ButtonListWidget(
            function: () async {
              final date = await _selectDate(context);
              if (date != null) {
                bloc.add(SelectCountryDepartureDayEvent(date: date));
              }
            },
            child: Row(
              children: [
                Text(
                  "${state.dayNumber ?? ''}, ",
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontFamily: AppFonts.sfProMedium,
                        fontStyle: FontStyle.italic,
                      ),
                ),
                Text(
                  state.dayWeek ?? '',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontFamily: AppFonts.sfProMedium,
                        fontStyle: FontStyle.italic,
                        color: ThemeApp.greySix,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          _ButtonListWidget(
            function: () => {},
            child: Row(
              children: [
                Image.asset(
                  AppImages.profile,
                  height: 16,
                  width: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  '1, эконом',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontFamily: AppFonts.sfProMedium,
                        fontStyle: FontStyle.italic,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          _ButtonListWidget(
            function: () {},
            child: Row(
              children: [
                Image.asset(
                  AppImages.micsher,
                  height: 16,
                  width: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  'Фильтр',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontFamily: AppFonts.sfProMedium,
                        fontStyle: FontStyle.italic,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<DateTime?> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    return picked;
  }
}

class _ButtonListWidget extends StatelessWidget {
  final void Function() function;
  final Widget child;
  const _ButtonListWidget({
    required this.function,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: function,
      style: ButtonStyle(
          padding: const MaterialStatePropertyAll(
            EdgeInsets.all(
              8,
            ),
          ),
          backgroundColor: const MaterialStatePropertyAll(
            ThemeApp.greyOne,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          minimumSize: const MaterialStatePropertyAll(Size(89, 33))),
      child: child,
    );
  }
}

class _PriceListWidget extends StatelessWidget {
  const _PriceListWidget();

  @override
  Widget build(BuildContext context) {
    return GreyContainerWidget(
      padding: 16,
      color: ThemeApp.greyOne,
      radius: 16,
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Прямые рейсы',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 20,
                ),
          ),
          const SizedBox(height: 16),
          const _PriceCardWidget(),
        ],
      ),
    );
  }
}

class _PriceCardWidget extends StatelessWidget {
  const _PriceCardWidget();

  @override
  Widget build(BuildContext context) {
    final state = context.select((SelectCountryScreenBloc bloc) => bloc.state);
    final ticketsOffers = state.ticketsOffers;
    if (ticketsOffers == null) return const SizedBox.shrink();
    return Column(
        children: ticketsOffers
            .map((ticketsOffer) => _PriceTicketWidget(
                  ticketsOffer: ticketsOffer,
                ))
            .toList());
  }
}

class _PriceTicketWidget extends StatelessWidget {
  final TicketsOffer ticketsOffer;

  const _PriceTicketWidget({
    required this.ticketsOffer,
  });

  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat('#,###');
    final price = ticketsOffer.price.value;
    return SizedBox(
      height: 56,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(AppImages.redCircle),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        ticketsOffer.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontFamily: AppFonts.sfProMedium,
                              fontStyle: FontStyle.italic,
                            ),
                      ),
                    ),
                    Text(
                      '${formatter.format(price).replaceAll(',', ' ')} \u20bd',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontFamily: AppFonts.sfProMedium,
                            fontStyle: FontStyle.italic,
                            color: ThemeApp.specialPriceBlue,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  ticketsOffer.timeRange.join(' '),
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontFamily: AppFonts.sfProRegular),
                ),
                const SizedBox(height: 10),
                const Divider(height: 1, color: ThemeApp.greyFive),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WatchAllTicketButton extends StatelessWidget {
  const _WatchAllTicketButton();

  @override
  Widget build(BuildContext context) {
    final dayNumber =
        context.select((SelectCountryScreenBloc bloc) => bloc.state.dayNumber);
    return ElevatedButton(
      onPressed: () => Navigator.of(context).pushNamed(
          MainNavigationRouteName.watchAllTicket,
          arguments: dayNumber),
      style: ButtonStyle(
        backgroundColor: const MaterialStatePropertyAll(
          ThemeApp.specialPriceBlue,
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      child: Text(
        'Показать все билеты',
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontFamily: AppFonts.sfProMedium,
              fontStyle: FontStyle.italic,
            ),
      ),
    );
  }
}
