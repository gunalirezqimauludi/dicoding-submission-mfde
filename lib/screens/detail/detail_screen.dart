import 'package:flutter/material.dart';
import 'package:flutter_app/config/future.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

const kExpandedHeight = 270.0;

class DetailScreen extends StatefulWidget {
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()..addListener(() => setState(() {}));
  }

  bool get _scrolled {
    return _scrollController.hasClients &&
        _scrollController.offset > kExpandedHeight - kToolbarHeight;
  }

  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context).settings.arguments as Map;

    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool inner) {
          return <Widget>[
            SliverAppBar(
              title: _scrolled ? Text('Product Detail') : Text(''),
              leading: Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _scrolled
                      ? Colors.transparent
                      : Color.fromRGBO(0, 0, 0, 0.3),
                ),
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: args['mealId'],
                  child: Container(
                    width: 500,
                    height: 250,
                    child: CachedNetworkImage(
                      imageUrl: args['mealThumbs'],
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
                        ),
                      ),
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              backgroundColor: Color(0xffeb4747),
              expandedHeight: kExpandedHeight,
              elevation: 0,
              pinned: true,
            ),
          ];
        },
        body: detailMeal(args['mealId'], args['mealPrice'], args['mealRating']),
      ),
    );
  }
}

Widget detailMeal(mealId, mealPrice, mealRating) {
  return FutureBuilder(
    future: getDetail(mealId),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        if (snapshot.data.meals != null) {
          var meal = snapshot.data.meals[0];
          return ListView(
            children: <Widget>[
              // Food Name
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(
                  left: 24,
                  right: 24,
                ),
                child: Text(
                  meal.strMeal,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ),

              // Food Price
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(top: 14, left: 24),
                child: Text(
                  '\$ ${mealPrice.toString()}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xffeb4747)),
                ),
              ),

              // Food Rating
              Container(
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.only(top: 8, left: 23),
                child: RatingBarIndicator(
                  rating: mealRating.toDouble(),
                  itemCount: 5,
                  itemSize: 18,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                ),
              ),

              // Divider
              Container(
                margin: EdgeInsets.only(top: 12, left: 24, right: 24),
                child: Divider(
                  color: Colors.black38,
                ),
              ),

              // Label Details
              Container(
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.only(top: 12, left: 24),
                child: Text(
                  'Details',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),

              // Food Description
              Container(
                alignment: Alignment.bottomLeft,
                padding:
                    EdgeInsets.only(top: 12, left: 24, right: 24, bottom: 24),
                child: Text('${meal.strInstructions}'),
              )
            ],
          );
        }
      } else if (snapshot.hasError) {
        Text('${snapshot.error}');
      }
      return Center(child: CircularProgressIndicator());
    },
  );
}
