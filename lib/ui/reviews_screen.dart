import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fundamental2/data/api/api_service.dart';
import 'package:fundamental2/data/model/restaurant.dart';
import 'package:fundamental2/data/model/review.dart';
import 'package:fundamental2/provider/app_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'review_dialog.dart';

class ReviewScreen extends StatelessWidget {
  final Restaurant restaurant;

  const ReviewScreen({@required this.restaurant});

  @override
  Widget build(BuildContext context) {
    AppProvider _provider;

    return Scaffold(
      appBar: AppBar(
        title: Text("Reviews"),
      ),
      body: Container(
        child: ChangeNotifierProvider(
          create: (_) => AppProvider(apiService: ApiService()).getRestaurant(restaurant.id),
          child: Consumer<AppProvider>(builder: (context, provider, _) {
            _provider = provider;
            switch (provider.state) {
              case ResultState.Loading:
                return Center(child: CircularProgressIndicator());
                break;
              case ResultState.NoData:
                return Center(child: Text(provider.message));
                break;
              case ResultState.HasData:
                Restaurant _restaurant = provider.restaurant.restaurant;
                return ListView.builder(
                    itemCount: _restaurant.customerReviews.length,
                    itemBuilder: (context, index) {
                      Review review = _restaurant.customerReviews[index];
                      return item(review);
                    });
                break;
              case ResultState.Error:
                return Center(
                  child: Lottie.asset('assets/json/no_internet.json'),
                );
                break;
            }
            return Container();
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => ReviewDialog(provider: _provider, id: restaurant.id),
          );
        },
        child: Icon(Icons.add_comment),
      ),
    );
  }

  Widget item(Review review) {
    return Card(
        margin: EdgeInsets.all(8),
        child: Container(
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                child: Text(
                  review.name[0] ?? "X",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        review.date,
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      Text(
                        review.review,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
