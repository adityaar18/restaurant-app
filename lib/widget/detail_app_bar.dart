import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fundamental2/ui/favorite_screen.dart';

class DetailAppBar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        left: 25,
        right: 25
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new),
              color: Colors.black,
              onPressed: () => Navigator.pop(context)
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white
            ),
            child: IconButton(
              icon: Icon(Icons.favorite),
              color: Colors.red,
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => FavoriteScreen()));
              },
            ),
          )
        ],
      ),
    );
  }
  
}