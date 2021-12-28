import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fundamental2/data/model/favorite.dart';
import 'package:fundamental2/data/model/restaurant.dart';
import 'package:fundamental2/provider/app_provider.dart';
import 'package:fundamental2/widget/config.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'detail_screen.dart';

class FavoriteScreen extends StatelessWidget{
  const FavoriteScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Favorite'),
        centerTitle: true,
      ),
      body: ChangeNotifierProvider(
        create: (BuildContext context) => AppProvider().listFavorite(),
        child: Consumer<AppProvider>(
          builder: (context, provider, _){
            if(provider.state == ResultState.Loading){
              return Center(child: CircularProgressIndicator());
            } else if(provider.state == ResultState.NoData){
              return Center(
                      child: Column(
                        children: [
                          Lottie.asset('assets/json/no_favorite.json'),
                          Text(provider.message)
                        ],
                      ),
              );
            } else if(provider.state == ResultState.HasData){
              List<Favorite> restaurants = provider.favorites;
                  return ListView.builder(
                    itemCount: restaurants.length,
                      itemBuilder: (BuildContext context, int index){
                      return item(context, restaurants[index]);
                      },
                  );
            }
            // switch(provider.state){
            //   case ResultState.loading:
            //     return const Center(child: CircularProgressIndicator());
            //     break;
            //   case ResultState.noData:
            //     return Center(
            //       child: Column(
            //         children: [
            //           Lottie.asset('assets/json/no_favorite.json'),
            //           Text(provider.message)
            //         ],
            //       ),
            //     );
            //     break;
            //   case ResultState.hasData:
            //     List<Restaurant> restaurants = provider.favoriteRestaurants;
            //     return ListView.builder(
            //       itemCount: restaurants.length,
            //         itemBuilder: (BuildContext context, int index){
            //         return RestaurantItem(
            //           restaurant: restaurants[index],
            //           provider: provider,
            //         );
            //         },
            //     );
            //     break;
            //   case ResultState.error:
            //     return Center(child: Text(provider.message));
            // }
            return Container();
          },
        ),
      ),
    );
  }

  Widget item(BuildContext context, Favorite restaurant) {
    return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return DetailScreen(restaurant: restaurant.id);
          }));
        },
        child: Container(
          height: 110,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Container(
                  padding: EdgeInsets.all(5),
                  width: 110,
                  height: 110,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: imgSmall + restaurant.pictureId,
                      fit: BoxFit.fitHeight,
                    ),
                  )
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 20, right: 10, left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            restaurant.name,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1.5
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_outlined,
                            size: 15,
                          )
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 20,
                            color: Colors.red,
                          ),
                          Text(restaurant.city),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
}