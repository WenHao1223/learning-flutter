import 'package:flutter/material.dart';
import 'package:gamify_app/data.dart';

class ScrollableGamesWidget extends StatelessWidget {
  final double height, width;
  final bool showTitle;
  final List<Game> gamesData;

  const ScrollableGamesWidget({
    super.key,
    required this.height,
    required this.width,
    required this.showTitle,
    required this.gamesData,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: gamesData.map((game) {
          return Container(
            height: height,
            width: width * 0.30,
            padding: EdgeInsets.only(right: width * 0.03),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: height * 0.80,
                  width: width * 0.45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(game.coverImage.url),
                    ),
                  ),
                ),
                showTitle ? Text(
                  game.title,
                  maxLines: 2,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: height * 0.08,
                  ),
                ) : Container(),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
