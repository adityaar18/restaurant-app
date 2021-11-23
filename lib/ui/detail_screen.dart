import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fundamental2/data/api/api_service.dart';
import 'package:fundamental2/data/model/menus.dart';
import 'package:fundamental2/data/model/restaurant.dart';
import 'package:fundamental2/provider/app_provider.dart';

import 'package:fundamental2/widget/detail_sliver_appbar.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatelessWidget {
  final Restaurant restaurant;
  DetailScreen({@required this.restaurant});

  @override
  Widget build(BuildContext context) {
    AppProvider provider;
    return ChangeNotifierProvider(
      create: (_) {
        provider = AppProvider(apiService: ApiService());
        return provider.getRestaurant(restaurant.id);
      },
      child: Scaffold(
        body: Consumer<AppProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.Loading) {
              return Center(child: CircularProgressIndicator());
            } else if (state.state == ResultState.HasData) {
              return screen(context, state.restaurant.restaurant, provider);
            } else if (state.state == ResultState.NoData) {
              return Center(child: Text(state.message));
            } else if (state.state == ResultState.Error) {
              return Center(
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Lottie.asset('assets/json/no_internet.json'),
                ),
              );
            } else {
              return Center(
                child: Text('No data to displayed'),
              );
            }
          },
        ),
      ),
    );
  }

  menuList(List<dynamic> menus, MenuType menuType) {
    return SliverPadding(
      padding: EdgeInsets.all(4),
      sliver: SliverGrid.count(
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: menus.map((e) {
          return Container(
            margin: EdgeInsets.all(4),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 1)],
            ),
            child: Column(
              children: [
                Expanded(
                  child: (menuType == MenuType.food)
                      ? Image.asset('assets/images/food.png')
                      : Image.asset('assets/images/drink.png'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    e.name,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  screen(BuildContext context, Restaurant restaurant, AppProvider provider) {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
            delegate: DetailSliverAppBar(expandedHeight: 250, restaurant: restaurant, provider: provider)),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 250,
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.all(4),
          sliver: SliverToBoxAdapter(
              child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.fastfood,
                  color: Colors.orange,
                ),
              ),
              Text(
                'Foods',
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          )),
        ),
        menuList(restaurant.menus.foods, MenuType.food),
        SliverPadding(
          padding: EdgeInsets.all(4),
          sliver: SliverToBoxAdapter(
              child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.local_drink,
                  color: Colors.orange,
                ),
              ),
              Text(
                'Drinks',
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          )),
        ),
        menuList(restaurant.menus.drinks, MenuType.drink),
      ],
    );
  }
}
