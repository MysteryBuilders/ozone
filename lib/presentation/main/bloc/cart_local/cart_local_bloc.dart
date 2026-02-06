import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ozon/domain/model/local_cart_model.dart';

import '../../../../domain/model/order_model.dart';

part 'cart_local_event.dart';
part 'cart_local_state.dart';

class CartLocalBloc extends Bloc<CartLocalEvent, CartLocalState> {
  CartLocalBloc() : super(CartLocalInitial()) {
    on<AddCartLocalItem>((event, emit) {
      if (state is CartLocalLoaded) {
        List<OrderItemModel>items  =(state as CartLocalLoaded).cart.items;
        if(items.isEmpty){
          final updatedCart = LocalCartModel(
              items: List.from((state as CartLocalLoaded).cart.items)..add(event.orderItemModel));
          emit(CartLocalLoaded(cart: updatedCart));
        }else{
          bool isItemExists = false;
          int index = 0;
          for(int i =0;i<items.length;i++){
            if(event.orderItemModel.itemId == items[i].itemId){
              isItemExists = true;
              index = i;
              break;



            }
          }
          if(isItemExists){
            OrderItemModel orderItemModel = items[index];
            orderItemModel.qty= event.orderItemModel.qty;
            items[index]= orderItemModel;

          }else{
            items = items..add(event.orderItemModel);
          }

          emit(CartLocalLoaded(cart: LocalCartModel(items: items)));
        }


      } else {
        emit(CartLocalLoaded(cart: LocalCartModel(items: [event.orderItemModel])));
      }
    });

    on<RemoveCartLocalItem>((event, emit) {
      if (state is CartLocalLoaded) {
        final updatedCart = LocalCartModel(
            items: List.from((state as CartLocalLoaded).cart.items)
              ..remove(event.orderItemModel));
        emit(CartLocalLoaded(cart: updatedCart));
      }
    });
    on<AddCartLocalListItems>((event, emit) {
      emit(CartLocalLoaded(cart: LocalCartModel(items: event.orderList)));

    });
    on<RemoveCartLocal>((event, emit) {


        final updatedCart = LocalCartModel(
            items: []);
        emit(CartLocalLoaded(cart: updatedCart));

    });

    on<DecreaseCartLocalItem>((event, emit) {
      if (state is CartLocalLoaded) {
        List<OrderItemModel>items  =(state as CartLocalLoaded).cart.items;
        for(int i =0;i<items.length;i++){
          if(event.orderItemModel.itemId == items[i].itemId){
            if(items[i].qty == 1){
              add(RemoveCartLocalItem(event.orderItemModel));
              break;

            }else{
              OrderItemModel  orderItemModel = items[i];
              orderItemModel.qty = orderItemModel.qty!-1;
              items[i] = orderItemModel;
              emit(CartLocalLoaded(cart: LocalCartModel(items: items)));
              break;



            }
          }
        }

      }
    });
  }
}
