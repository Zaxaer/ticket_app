import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ticket_sales/domain/blocks/watch_all_ticket_bloc.dart';
import 'package:ticket_sales/domain/entity/tickets.dart';
import 'package:ticket_sales/resources/app_fonts.dart';
import 'package:ticket_sales/resources/app_image.dart';
import 'package:ticket_sales/ui/theme/theme.dart';
import 'package:ticket_sales/ui/widgets/widgets.dart';

class WatchAllTicketScreenWidget extends StatelessWidget {
  const WatchAllTicketScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _RoutNameWidget(),
            SizedBox(height: 34),
            _TicketBuilderWidget(),
          ],
        ),
      ),
    );
  }
}

class _RoutNameWidget extends StatelessWidget {
  const _RoutNameWidget();

  @override
  Widget build(BuildContext context) {
    final state = context.select((WatchAllTicketScreenBloc bloc) => bloc.state);
    return GreyContainerWidget(
      color: ThemeApp.greyTwo,
      padding: 8,
      radius: 0,
      widget: Row(
        children: [
          Stack(
            children: [
              const Icon(
                Icons.arrow_back_rounded,
                color: ThemeApp.specialBlue,
              ),
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
            ],
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${state.inCountry}-${state.outCountry}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 4),
              Text(
                '${state.dateDeparture}, 1 пассажир',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontStyle: FontStyle.italic,
                      color: ThemeApp.greySix,
                    ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _TicketBuilderWidget extends StatelessWidget {
  const _TicketBuilderWidget();

  @override
  Widget build(BuildContext context) {
    final state = context.select((WatchAllTicketScreenBloc bloc) => bloc.state);
    return Column(
      children: state.ticket
          .map((ticket) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: _TicketRoutWidget(ticket: ticket),
              ))
          .toList(),
    );
  }
}

class _TicketRoutWidget extends StatelessWidget {
  final Ticket ticket;
  const _TicketRoutWidget({required this.ticket});

  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat('#,###');
    DateTime departureDate = DateTime.parse(ticket.departure.date);
    DateTime arrivalDate = DateTime.parse(ticket.arrival.date);
    var formatt = DateFormat('HH:mm');
    var depatrure = formatt.format(departureDate);
    var arrival = formatt.format(arrivalDate);
    final difference = arrivalDate.difference(departureDate).inHours;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GreyContainerWidget(
          radius: 8,
          color: ThemeApp.greyOne,
          padding: 16,
          widget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              Text(
                '${formatter.format(ticket.price.value).replaceAll(',', ' ')} \u20bd',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(),
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(AppImages.redCircle),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  depatrure,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                        fontFamily: AppFonts.sfProMedium,
                                        fontStyle: FontStyle.italic,
                                      ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  ticket.departure.airport,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                        fontFamily: AppFonts.sfProMedium,
                                        fontStyle: FontStyle.italic,
                                        color: ThemeApp.greySix,
                                      ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '-',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    fontFamily: AppFonts.sfProMedium,
                                    fontStyle: FontStyle.italic,
                                    color: ThemeApp.greySix,
                                  ),
                            ),
                            const SizedBox(width: 4),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  arrival,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                        fontFamily: AppFonts.sfProMedium,
                                        fontStyle: FontStyle.italic,
                                      ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  ticket.arrival.airport,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                        fontFamily: AppFonts.sfProMedium,
                                        fontStyle: FontStyle.italic,
                                        color: ThemeApp.greySix,
                                      ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Text(
                              '$difference часа в пути ${ticket.hasTransfer == false ? '' : '/ без пересадок'}',
                              maxLines: 1,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    fontFamily: AppFonts.sfProRegular,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        ticket.badge == null || ticket.badge == ''
            ? const SizedBox.shrink()
            : Positioned(
                top: -7.5,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: ThemeApp.specialPriceBlue,
                  ),
                  height: 22,
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  child: Text(
                    ticket.badge ?? '',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontFamily: AppFonts.sfProMedium, fontSize: 14),
                  ),
                ),
              ),
      ],
    );
  }
}
