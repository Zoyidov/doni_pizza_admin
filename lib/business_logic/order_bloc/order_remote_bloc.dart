import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doni_pizza_admin/business_logic/model/order_model.dart';
import 'package:doni_pizza_admin/business_logic/repositories/order_repo.dart';
import 'package:doni_pizza_admin/presentation/utils/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'order_remote_event.dart';

part 'order_remote_state.dart';

class OrderRemoteBloc extends Bloc<OrderRemoteEvent, OrderRemoteState> {
  final OrderRepository orderRepository = OrderRepository();

  OrderRemoteBloc() : super(OrderRemoteInitial()) {
    on<CreateOrderEvent>(createOrderEventToState);
    on<FetchOrdersEvent>(fetchOrdersEventToState);
    on<UpdateOrderEvent>(updateOrderEventToState);
    on<DeleteOrderEvent>(deleteOrderEventToState);
    on<UpdateOrdersEvent>(updateOrdersEventToState);
    on<LoadAllOrdersEvent>(loadAllOrdersEventToState);
    on<ChangeOrderStatusEvent>(changeOrderStatusEventToState);

    init();
  }

  init() {
    FirebaseFirestore.instance
        .collection('orders')
        .orderBy("timestamp", descending: true)
        .snapshots()
        .listen((event) {
      final orders = event.docs.map((e) {
        return OrderModel.fromJson(e.data());
      }).toList();
      add(UpdateOrdersEvent(orders));
    });
  }

  void updateOrdersEventToState(UpdateOrdersEvent event, Emitter<OrderRemoteState> emit) async {
    emit(OrdersFetchedState(event.orders));
  }

  // user order repository listen order list from stream and change when it changes
  void loadAllOrdersEventToState(LoadAllOrdersEvent event, Emitter<OrderRemoteState> emit) async {
    orderRepository.getUsersOrders().listen((event) {
      emit(OrdersFetchedState(event));
    });
  }

  void createOrderEventToState(CreateOrderEvent event, Emitter<OrderRemoteState> emit) async {
    emit(OrderRemoteLoading());
    try {
      await orderRepository.createOrder(event.order);
      emit(OrderCreatedState(event.order));
    } catch (e) {
      emit(OrderRemoteErrorState('Error creating order: $e'));
    }
  }

  void fetchOrdersEventToState(FetchOrdersEvent event, Emitter<OrderRemoteState> emit) async {
    emit(OrderRemoteLoading());
    try {
      final orders = await orderRepository.getOrdersForUser(event.userId);
      emit(OrdersFetchedState(orders));
    } catch (e) {
      emit(OrderRemoteErrorState('Error fetching orders: $e'));
    }
  }

  void updateOrderEventToState(UpdateOrderEvent event, Emitter<OrderRemoteState> emit) async {
    emit(OrderRemoteLoading());
    try {
      await orderRepository.updateOrder(event.order);
      emit(OrderUpdatedState(event.order));
    } catch (e) {
      emit(OrderRemoteErrorState('Error updating order: $e'));
    }
  }

  void deleteOrderEventToState(DeleteOrderEvent event, Emitter<OrderRemoteState> emit) async {
    emit(OrderRemoteLoading());
    try {
      await orderRepository.deleteOrder(event.orderId);
      emit(OrderDeletedState(event.orderId));
    } catch (e) {
      emit(OrderRemoteErrorState('Error deleting order: $e'));
    }
  }

  void changeOrderStatusEventToState(
      ChangeOrderStatusEvent event, Emitter<OrderRemoteState> emit) async {
    try {
      await orderRepository.changeOrderStatus(event.orderId, event.newStatus);
    } catch (e) {
      emit(OrderRemoteErrorState('Error changing order status: $e'));
    }
  }
}
