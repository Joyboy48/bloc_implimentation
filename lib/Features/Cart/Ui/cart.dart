import 'package:bloc_implemention/Features/Cart/Ui/cart_tile_dart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Home/Ui/product_tile_widget.dart';
import '../cartBloc/cart_bloc.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {

  final CartBloc cartBloc = CartBloc();

  @override
  void initState() {
    cartBloc.add(CartInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cart Items", style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        bloc: cartBloc,
        listener: (context, state) {

        },
        listenWhen: (previous,current) => current is CartActionState,
        buildWhen: (previou,current) => current is !CartActionState,
        builder: (context, state) {
          switch(state.runtimeType){
            case CartSuccessState:
              final successState = state as CartSuccessState;
              return ListView.builder(
          itemCount: successState.cartItems.length,
          itemBuilder: (context,index){
          return CartTileWidget(
          cartBloc: cartBloc,
          productDataModel: successState.cartItems[index]);
          });
          }
          return Container();
        },
      ),
    );
  }
}
