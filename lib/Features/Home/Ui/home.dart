import 'package:bloc_implemention/Features/Cart/Ui/cart.dart';
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
  final HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous,current) => current is HomeActionState,
      buildWhen: (previous,current)=> current is !HomeActionState,
      listener: (context, state) {
        if(state is HomeNavigateToCartPageActionState){
          Navigator.push(context,MaterialPageRoute(builder: (context)=>Cart()));
        }
        else if(state is HomeNavigateToWishlistPageActionState){
          Navigator.push(context,MaterialPageRoute(builder: (context)=>Wishlist()));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Home Page",style: TextStyle(fontWeight: FontWeight.bold),),
            actions: [
              IconButton(onPressed: (){
                homeBloc.add(HomeWishlistButtonNavigateEvent());
              }, icon:Icon(Icons.favorite),),
              IconButton(onPressed: (){
                homeBloc.add(HomeCartButtonNavigateEvent());
              }, icon:Icon(Icons.shopping_cart),),
            ],
          ),
        );
      },
    );
  }
}
