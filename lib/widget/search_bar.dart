import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fundamental2/provider/app_provider.dart';
import 'package:fundamental2/ui/favorite_screen.dart';
import 'package:fundamental2/ui/settings_screen.dart';

class searchBar extends  SliverPersistentHeaderDelegate{
  final double expandedHeight;
  final AppProvider provider;

  searchBar({@required this.expandedHeight, @required this.provider});
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    var searchBarOffset = expandedHeight - shrinkOffset - 20;
    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: [
        Image.asset(
          'assets/images/backgorund_restaurant.jpg',
          fit: BoxFit.cover,
        ),
        Positioned(
          top: 0,
          right: 16,
          child: SafeArea(
            child: IconButton(
              icon: Icon(Icons.settings),
              color: Colors.amber,
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SettingsScreen()));
              },
            ),
          ),
        ),
        Positioned(
          top: 29,
          right: 60,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: SizedBox(
              height: 50,
              width: 50,
              child: IconButton(
                icon: const Icon(Icons.favorite),
                color: Colors.red,
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => const FavoriteScreen()));
                },
              ),
            ),
          ),
        ),
        (shrinkOffset < expandedHeight - 20) ? Positioned(
          top: searchBarOffset,
          left: MediaQuery.of(context).size.width / 4,
          child: Card(
            elevation: 10,
            child: SizedBox(
              height: 40,
              width: MediaQuery.of(context).size.width / 2,
              child: CupertinoTextField(
                onChanged: (value) {
                  if (value.length >= 3) {
                    provider.onSearch(value);
                  } else if (value.isEmpty) {
                    provider.onSearch(value);
                  }
                },
                keyboardType: TextInputType.text,
                placeholder: "Search Restaurant",
                placeholderStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 15
                ),
                prefix: Padding(
                  padding: const EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 5.0),
                  child: Icon(
                    Icons.search,
                    size: 18,
                    color: Colors.black,
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ) : Container(
          margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 4,
            vertical: (kToolbarHeight - 40) / 4
          ),
          child: Card(
            elevation: 10,
            child: CupertinoTextField(
              onChanged: (value) {
                if (value.length >= 3) {
                  provider.onSearch(value);
                } else if (value.isEmpty) {
                  provider.onSearch(value);
                }
              },
              keyboardType: TextInputType.text,
              placeholder: 'Search Restaurant',
              placeholderStyle: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
              prefix: Padding(
                padding: const EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 5.0),
                child: Icon(
                  Icons.search,
                  size: 18,
                  color: Colors.black,
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}