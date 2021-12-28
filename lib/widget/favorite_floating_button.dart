import 'package:flutter/material.dart';
import 'package:fundamental2/data/model/favorite.dart';
import 'package:fundamental2/data/model/restaurant.dart';
import 'package:fundamental2/provider/app_provider.dart';
import 'package:provider/provider.dart';

class FavoriteButton extends StatefulWidget{
  final AppProvider provider;
  final Restaurant restaurant;

  const FavoriteButton({Key key, this.provider, this.restaurant}) : super(key: key);



  State<FavoriteButton> createState() => _FavoriteState();
}

class _FavoriteState extends State<FavoriteButton>{
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    Provider.of<AppProvider>(context, listen: false)
        .getFavoriteById(widget.restaurant.id)
        .then((value) {
      setState(() {
        _isFavorite = value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return BuildFloatingButton(widget.provider, widget.restaurant);
  }

  Widget BuildFloatingButton (AppProvider provider, Restaurant restaurant){
    return FloatingActionButton(
      child: _isFavorite
          ? Icon(
        Icons.favorite_rounded,
        color: Colors.red,
      ) : Icon(
        Icons.favorite_border_rounded,
        color: Colors.red,
      ),
      onPressed: (){
        if(_isFavorite){
          provider.removeFavorite(widget.restaurant.id);
          setState(() {
            _isFavorite = !_isFavorite;
          });
        } else {
          final favorite = Favorite(
              id: restaurant.id,
              pictureId: restaurant.pictureId,
              name: restaurant.name,
              city: restaurant.city
          );
          provider.addFavorite(favorite);
          setState(() {
            _isFavorite = !_isFavorite;
          });
        }
      },
    );
  }

}