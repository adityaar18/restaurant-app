import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fundamental2/data/model/restaurant.dart';
import 'package:fundamental2/provider/app_provider.dart';

class DetailSliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final Restaurant restaurant;
  final AppProvider provider;

  DetailSliverAppBar({@required this.expandedHeight, @required this.restaurant, this.provider});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        Hero(
          tag: restaurant.id,
          child: CachedNetworkImage(
            imageUrl: restaurant.getMediumPicture(),
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 0,
          child: SafeArea(
              child: Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.red,
                ),
                onPressed: () => Navigator.pop(context),
              )
            ],
          )),
        ),
        Positioned(
          top: 150 - shrinkOffset,
          left: 8,
          right: 8,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [BoxShadow(blurRadius: 2, spreadRadius: 0.1, color: Colors.grey)]),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          restaurant.name,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 18,
                          color: Colors.red,
                        ),
                        Text("${restaurant.address}, ${restaurant.city}",
                            style: Theme.of(context).textTheme.bodyText1),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 18,
                            color: Colors.amber,
                          ),
                          Text("${restaurant.rating}"),
                          SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: restaurant.categories
                          .map(
                            (cat) => Transform(
                              transform: Matrix4.identity()..scale(0.8),
                              child: Chip(
                                label: Text(cat.name),
                                backgroundColor: Colors.white,
                                shape: StadiumBorder(side: BorderSide(color: Colors.red)),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    Text(
                      restaurant.description,
                      textAlign: TextAlign.justify,
                      style: TextStyle(color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;

  setState(AppProvider provider) {
    provider.getRestaurant(restaurant.id);
  }
}
