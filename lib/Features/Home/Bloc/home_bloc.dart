import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_implemention/Data/cart_items.dart';
import 'package:bloc_implemention/Data/grocery_data.dart';
import 'package:bloc_implemention/Data/wishlist_items.dart';
import 'package:bloc_implemention/Features/Home/models/home_product_data_model.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeProductWishlistButtonClickedEvent>(
        homeProductWishlistButtonClickedEvent);
    on<HomeProductCartButtonClickedEvent>(homeProductCartButtonClickedEvent);
    on<HomeWishlistButtonNavigateEvent>(homeWishlistButtonNavigateEvent);
    on<HomeCartButtonNavigateEvent>(homeCartButtonNavigateEvent);
  }

  Future<void> homeInitialEvent(HomeInitialEvent event,
      Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(Duration(seconds: 3));
    emit(HomeLoadedSuccessState(products: GroceryData.groceryProducts.map((e) =>
        ProductDataModel(
          id: e['id'] != null ? e['id'] as String : '', // Handle null for id
          name: e['name'] != null ? e['name'] as String : '', // Handle null for name
          Description: e['description'] != null ? e['description'] as String : '', // Handle null for description
          price: e['price'] != null ? e['price'] as double : 0, // Handle null for price
          image: e['image'] != null ? e['image'] as String : '', // Handle null for imageUrl
        )).toList()));
  }

  FutureOr<void> homeProductWishlistButtonClickedEvent(
      HomeProductWishlistButtonClickedEvent event, Emitter<HomeState> emit) {
    print("Wishlist product Clicked");
    wishlistItems.add(event.clickedProduct);
    emit(HomeProductItemWishlistedActionState());
  }

  FutureOr<void> homeProductCartButtonClickedEvent(
      HomeProductCartButtonClickedEvent event, Emitter<HomeState> emit) {
    print("Cart product clicked");
    cartItems.add(event.clickedProduct);
    emit(HomeProductItemCartedActionState());
  }

  FutureOr<void> homeWishlistButtonNavigateEvent(
      HomeWishlistButtonNavigateEvent event, Emitter<HomeState> emit) {
    print("wishlist clicked");
    emit(HomeNavigateToWishlistPageActionState());
  }

  FutureOr<void> homeCartButtonNavigateEvent(HomeCartButtonNavigateEvent event,
      Emitter<HomeState> emit) {
    print("Cart clicked");
    emit(HomeNavigateToCartPageActionState());
  }

}
