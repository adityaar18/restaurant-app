import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fundamental2/data/model/restaurant.dart';
import 'package:fundamental2/provider/app_provider.dart';
import 'package:fundamental2/ui/detail_screen.dart';
import 'package:fundamental2/widget/search_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  static const String routeName = "/main_screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ChangeNotifierProvider(
      create: (_) => AppProvider().getRestaurants(),
      child: CustomScrollView(
        slivers: [
          Consumer<AppProvider>(
            builder: (context, provider, _) {
              return SliverPersistentHeader(
                delegate: searchBar(expandedHeight: 200, provider: provider),
              );
            },
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 30,
            ),
          ),
          Consumer<AppProvider>(
            builder: (context, state, _) {
              if (state.state == ResultState.Loading) {
                return SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (state.state == ResultState.HasData) {
                return SliverList(
                    delegate: SliverChildListDelegate(
                        state.result.restaurants.map((restaurant) => item(context, restaurant)).toList()));
              } else if (state.state == ResultState.Error) {
                return SliverFillRemaining(
                  child: Center(
                    child: Lottie.asset('assets/json/no_internet.json'),
                  ),
                );
              } else {
                return SliverFillRemaining(
                  child: Center(child: Lottie.asset('assets/json/not_found.json')),
                );
              }
            },
          )
        ],
      ),
    ));
  }

  Widget item(BuildContext context, Restaurant restaurant) {
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
                imageUrl: restaurant.getSmallPicture(),
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
                    SizedBox(height: 5,),
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
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 20,
                          color: Colors.amber,
                        ),
                        Text(
                          "${restaurant.rating}",
                        )
                      ],
                    )
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
