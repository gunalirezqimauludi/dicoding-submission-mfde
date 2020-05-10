import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CardMeals extends StatefulWidget {
  final mealId, mealName, mealThumbs, mealPrice, mealRating;
  CardMeals({
    this.mealId,
    this.mealName,
    this.mealThumbs,
    this.mealPrice,
    this.mealRating,
  });

  @override
  _CardMealsState createState() => _CardMealsState();
}

class _CardMealsState extends State<CardMeals> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        '/detail',
        arguments: {
          'mealId': widget.mealId,
          'mealThumbs': widget.mealThumbs,
          'mealPrice': widget.mealPrice,
          'mealRating': widget.mealRating,
        },
      ),

      // Meals Container
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                // Meals Image
                Hero(
                  tag: widget.mealId,
                  child: Container(
                    width: 160.0,
                    height: 160.0,
                    child: CachedNetworkImage(
                      imageUrl: widget.mealThumbs,
                      imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.9),
                            BlendMode.dstATop,
                          ),
                        ),
                        color: Colors.red[100],
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      )),
                      placeholder: (context, url) => Container(
                        decoration: BoxDecoration(
                          color: Colors.red[100],
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),

                // Meals Price
                Container(
                  margin: EdgeInsets.only(top: 126, right: 78),
                  decoration: BoxDecoration(
                    color: Color(0xffeb4747),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    padding: EdgeInsets.all(10),
                    child: Text(
                      '\$ ${widget.mealPrice}',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Meals Rating
            Container(
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.only(top: 12.0, left: 8.0),
              child: RatingBarIndicator(
                rating: widget.mealRating,
                itemCount: 5,
                itemSize: 20,
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
              ),
            ),

            // Meals Name
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(top: 14, right: 8, bottom: 8, left: 8),
              child: Text(
                widget.mealName,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16.0, height: 1.4),
              ),
            ),

            // Meals Button Add
            Container(
              margin: EdgeInsets.only(top: 10),
              child: FlatButton(
                onPressed: () {},
                padding: EdgeInsets.all(0.0),
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  width: 140,
                  child: Center(
                    child: Text(
                      'ADD',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    color: Color(0xffeb4747),
                  ),
                ),
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(25)),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.08),
              blurRadius: 5.0, // soften the shadow
              spreadRadius: 0.5, //extend the shadow
              offset: Offset(
                1.0, // Move to right 10  horizontally
                1.0, // Move to bottom 10 Vertically
              ),
            )
          ],
        ),
      ),
    );
  }
}
