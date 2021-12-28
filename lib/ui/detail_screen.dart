import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fundamental2/data/model/restaurant.dart';
import 'package:fundamental2/provider/app_provider.dart';
import 'package:fundamental2/widget/detail_item.dart';
import 'package:fundamental2/widget/favorite_floating_button.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatelessWidget {
  static final routeName = '/detail_screen';
  final String restaurant;

  DetailScreen({@required this.restaurant});

  @override
  Widget build(BuildContext context) {
    AppProvider provider;
    return ChangeNotifierProvider(
      create: (_) {
        provider = AppProvider();
        return provider.getRestaurant(restaurant);
      },
      child: Scaffold(
        body: Consumer<AppProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.Loading) {
              return Center(child: CircularProgressIndicator());
            } else if (state.state == ResultState.HasData) {
              if(state.restaurant.restaurant == null){
                return Center(child: CircularProgressIndicator());
              } else {
                return _DetailScreen(provider, state.restaurant.restaurant);
              }
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
}


  Widget _DetailScreen(AppProvider provider, Restaurant restaurant){
    return Scaffold(
      body: DetailItem(restaurant: restaurant),
      floatingActionButton: FavoriteButton(provider: provider, restaurant: restaurant)
    );
  }
