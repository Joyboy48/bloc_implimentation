import 'package:bloc_implemention/Features/Home/Bloc/home_bloc.dart';
import 'package:bloc_implemention/Features/Home/models/home_product_data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductTileWidget extends StatelessWidget {
  const ProductTileWidget({
    super.key,
    required this.productDataModel,
    required this.homeBloc
  });

  final ProductDataModel productDataModel;
  final HomeBloc homeBloc;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.maxFinite,
            decoration: BoxDecoration(
              image: productDataModel.image.isNotEmpty
                  ? DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(productDataModel.image))
                  : null,
            ),
            child: productDataModel.image.isEmpty
                ? Center(child: Text('No Image Available'))
                : null,
          ),
          SizedBox(height: 10,),
          Text(productDataModel.name,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
          Text(productDataModel.Description),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("\$ "+productDataModel.price.toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                     homeBloc.add(HomeProductWishlistButtonClickedEvent(
                       clickedProduct: productDataModel
                     ));
                    },
                    icon: Icon(Icons.favorite),
                  ),
                  IconButton(
                    onPressed: () {
                      homeBloc.add(HomeProductCartButtonClickedEvent(
                        clickedProduct: productDataModel
                      ));
                    },
                    icon: Icon(Icons.shopping_cart),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
