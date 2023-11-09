import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:doni_pizza_admin/business_logic/order_bloc/order_remote_bloc.dart';
import 'package:doni_pizza_admin/presentation/ui/admin_page/tab_box/tab_box_admin.dart';
import 'package:doni_pizza_admin/presentation/utils/enums.dart';
import 'package:doni_pizza_admin/presentation/utils/helpers/time_heplers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:gap/gap.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import 'package:doni_pizza_admin/presentation/ui/widgets/call.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: const Text(
            'Buyurtmalar',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Sora',
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: ShapeBorder.lerp(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                        0.5,
                      ),
                      title: const Text(
                        'Admin bo\'limiga o\'tish',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Sora',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      content: const Text('Admin profiliga  o\'tmoqchimisiz?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Yo\'q',
                            style: TextStyle(color: Colors.black, fontFamily: 'Sora'),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ScreenLock(
                                      correctString: '1809',
                                      title: const Text(
                                          'Admin sahifasiga o\'tish uchun parolni kiriting'),
                                      onUnlocked: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => const TabBoxAdmin()));
                                      }),
                                ));
                          },
                          child: const Text(
                            'Ha',
                            style: TextStyle(color: Colors.red, fontFamily: 'Sora'),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(Icons.compare_arrows),
              color: Colors.red,
            )
          ]),
      body: BlocBuilder<OrderRemoteBloc, OrderRemoteState>(
        builder: (context, state) {
          if (state is OrdersFetchedState) {
            final pendingOrders =
                state.orders.where((element) => element.status == OrderStatus.pending).toList();

            return pendingOrders.isEmpty
                ? const Center(child: Text('Buyurtmalar mavjud emas!'))
                : Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.all(16),
                          itemCount: pendingOrders.length,
                          itemBuilder: (BuildContext context, int index) {
                            final order = pendingOrders[index];

                            return Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.amber.withOpacity(0.1),
                              ),
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
                                            onTap: () {
                                              AwesomeDialog(
                                                context: context,
                                                dialogType: DialogType.error,
                                                animType: AnimType.bottomSlide,
                                                title: 'Bekor qilish',
                                                desc: 'Bekor qilishni xohlaysizmi?',
                                                btnOkOnPress: () {
                                                  context.read<OrderRemoteBloc>().add(
                                                      ChangeOrderStatusEvent(
                                                          order.id!, OrderStatus.canceled));
                                                },
                                                btnOkText: 'Ha',
                                                btnOkColor: Colors.green,
                                              ).show();
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(10.0),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: Colors.red),
                                              child: const Center(
                                                child: Text(
                                                  'Bekor qilish',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: 'Sora'),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          ZoomTapAnimation(
                                            onTap: () {
                                              context.read<OrderRemoteBloc>().add(
                                                  ChangeOrderStatusEvent(
                                                      order.id!, OrderStatus.preparing));
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(10.0),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: Colors.green),
                                              child: const Center(
                                                child: Text(
                                                  'Qabul qilish',
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
          } else if (state is OrderRemoteInitial) {
            return const Center(child: CircularProgressIndicator(color: Colors.black));
          }
          return Center(
            child: Text(
              'Something went wrong.Current state is $state',
              textAlign: TextAlign.center,
            ),
          );
        },
      ),
    );
  }
}
