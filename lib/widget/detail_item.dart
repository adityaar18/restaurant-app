import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fundamental2/data/model/menus.dart';
import 'package:fundamental2/data/model/restaurant.dart';
import 'package:fundamental2/widget/detail_app_bar.dart';
import 'package:fundamental2/widget/detail_img.dart';

class DetailItem extends StatelessWidget{
  final Restaurant restaurant;

  const DetailItem({Key key,@required this.restaurant}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<String> _listCategory = <String>[];
    restaurant.categories.forEach((element) {
      _listCategory.add(element.name);
    });
    final _categories = _listCategory.join(", ");
    return Scaffold(
      backgroundColor: Colors.amber,
      body: SingleChildScrollView(
        child: Column(
          children: [
            DetailAppBar(),
            DetailImg(restaurant: restaurant),
            Container(
              padding: EdgeInsets.all(25),
              color: Colors.white,
              child: Column(
                children: [
                  Text(
                    restaurant.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22
                    ),
                  ),
                  SizedBox(height: 15),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _Icon(Icons.location_on, Colors.red, "${restaurant.address}, ${restaurant.city}"),
                      _Icon(Icons.star, Colors.yellow, "${restaurant.rating}"),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Text(
                        'Categories',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 100,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Column(
                            children: [
                              Transform(
                                transform: Matrix4.identity()..scale(1.0),
                                child: Chip(
                                  label: Text(_categories),
                                  backgroundColor: Colors.white,
                                  shape: StadiumBorder(
                                    side: BorderSide(color: Colors.amber)
                                  ),
                                ),
                              )
                            ]
                          ),
                        ),
                        separatorBuilder: (context, index) => SizedBox(width: 15),
                        itemCount: restaurant.categories.length),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        'Description',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    restaurant.description,
                    style: TextStyle(
                      wordSpacing: 1.2,
                      height: 1.5,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 10),
                  MenuList(context, "foods",
                      Icon(
                        Icons.lunch_dining_rounded,
                        color: Colors.orange,
                      ), restaurant.menus.foods, MenuType.food),
                  SizedBox(height: 10),
                  MenuList(context, "drink",
                      Icon(
                        Icons.local_drink,
                        color: Colors.orange,
                      ), restaurant.menus.drinks, MenuType.drink)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _Icon(IconData iconData, Color color, String string){
    return Row(
      children: [
        Icon(
          iconData,
          color: color,
          size: 20,
        ),
        Text(
          string,
          style: TextStyle(
              fontSize: 16,
            fontWeight: FontWeight.w500
          ),
        )
      ],
    );
  }

Widget MenuList(BuildContext context, String string, Icon icon, List<dynamic> menus, MenuType menuType){
  return Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            icon,
            SizedBox(width: 10),
            Text(
              string,
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
        SizedBox(width: 8.0),
        Column(
          children: [
            for (var item in menus)
              Container(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Container(
                      height: 48.0,
                      width: 48.0,
                      decoration: BoxDecoration(
                        color:Colors.grey[50],
                        borderRadius:BorderRadius.circular(8.0),
                      ),
                      child: Expanded(
                        child: (menuType == MenuType.food)
                            ? Image.asset('assets/images/food.png')
                            : Image.asset('assets/images/drink.png'),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Text(
                      item.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal
                      ),
                    )
                  ],
                ),
              )
          ],
        )
      ],
    ),
  );
  }
}