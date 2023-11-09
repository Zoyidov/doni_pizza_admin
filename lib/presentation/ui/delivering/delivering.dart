import 'package:doni_pizza_admin/business_logic/order_bloc/order_remote_bloc.dart';
import 'package:doni_pizza_admin/presentation/utils/enums.dart';
import 'package:doni_pizza_admin/presentation/utils/helpers/time_heplers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import 'package:doni_pizza_admin/presentation/ui/widgets/call.dart';

class DeliveringScreen extends StatefulWidget {
  const DeliveringScreen({super.key});

  @override
  State<DeliveringScreen> createState() => _DeliveringScreenState();
}

class _DeliveringScreenState extends State<DeliveringScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const Text(
          'Yetkazilmoqda',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Sora',
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<OrderRemoteBloc, OrderRemoteState>(
        builder: (context, state) {
          if (state is OrdersFetchedState) {
            final onRoute =
                state.orders.where((element) => element.status == OrderStatus.onRoute).toList();
            return onRoute.isEmpty
                ? const Center(child: Text("Hech narsa yo'q"))
                : Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.all(16),
                          itemCount: onRoute.length,
                          itemBuilder: (BuildContext context, int index) {
                            final order = onRoute[index];

                            return Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(),
                                  color: Colors.amber.withOpacity(0.1)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(order.name,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold, fontFamily: 'Sora')),
                                          Text(
                                              '${TTimeHelpers.dateTimeToString(order.timestamp)} da',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 10,
                                                  fontFamily: 'Sora')),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text('ID: #${order.id.toString().split('-')[0]}',
                                              style: const TextStyle(color: Colors.black)),
                                          Text('Summa:  ${order.totalPrice} sum',
                                              style: TextStyle(color: Colors.amber[900])),
                                          Text('${order.paymentMethod}',
                                              style: TextStyle(color: Colors.blue[900])),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                    color: Colors.black,
                                    thickness: 1,
                                  ),
                                  ...List.generate(
                                    order.items.length,
                                    (index) => Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(order.items[index].food.name,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold, fontFamily: 'Sora')),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Soni: ${order.items[index].quantity} ta',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: 'Sora')),
                                            Text('Narxi:  ${order.items[index].totalPrice} sum',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: 'Sora')),
                                          ],
                                        ),
                                        Divider(
                                          color: Colors.black.withOpacity(0.3),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    color: Colors.black,
                                    thickness: 1,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: 'Manzil: ',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Sora'),
                                        ),
                                        TextSpan(
                                          text: order.address,
                                          style: const TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Sora'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    color: Colors.black,
                                    thickness: 1,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      ZoomTapAnimation(
                                        onTap: () {
                                          final phoneNumber = order.phone;
                                          launchPhoneCall(phoneNumber);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(10.0),
                                          margin: const EdgeInsets.all(5.0),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.white,
                                              border: Border.all()),
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.call,
                                                color: Colors.green,
                                              ),
                                              Text(order.phone),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          ZoomTapAnimation(
                                            onTap: () => context.read<OrderRemoteBloc>().add(
                                                ChangeOrderStatusEvent(
                                                    order.id!, OrderStatus.delivered)),
                                            child: Container(
                                              padding: const EdgeInsets.all(10.0),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: Colors.green),
                                              child: const Center(
                                                child: Text(
                                                  'Buyurtma Yetkazildi',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: 'Sora'),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const Gap(16);
                          },
                        ),
                      ),
                      const Gap(kBottomNavigationBarHeight * 1.5)
                    ],
                  );
          }

          return Center(
            child: Text(
              'Current state is $state',
              textAlign: TextAlign.center,
            ),
          );
        },
      ),
    );
  }
}
