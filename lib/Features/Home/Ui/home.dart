import 'package:bloc_implemention/Features/Cart/Ui/cart.dart';
import 'package:bloc_implemention/Features/Home/Ui/product_tile_widget.dart';
import 'package:bloc_implemention/Features/Wishlist/Ui/wishlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Bloc/home_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  final HomeBloc homeBloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Cart()));
        } else if (state is HomeNavigateToWishlistPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Wishlist()));
        } else if( state is HomeProductItemWishlistedActionState){
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Item added to wishlist')));
        }else if( state is HomeProductItemCartedActionState){
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Item added to Cart')));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return Scaffold(
                body: Center(
              child: CircularProgressIndicator(),
            ));
          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  "Home Page",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      homeBloc.add(HomeWishlistButtonNavigateEvent());
                    },
                    icon: Icon(Icons.favorite),
                  ),
                  IconButton(
                    onPressed: () {
                      homeBloc.add(HomeCartButtonNavigateEvent());
                    },
                    icon: Icon(Icons.shopping_cart),
                  ),
                ],
              ),
              body: ListView.builder(
                  itemCount: successState.products.length,
                  itemBuilder: (context,index){
                return ProductTileWidget(
                    homeBloc: homeBloc,
                    productDataModel: successState.products[index]);
              }),
            );
          case HomeErrorState:
            return Scaffold(
              body: Center(child: Text('Error'),),
            );
          default:
            return SizedBox();
        }
      },
    );
  }
}
