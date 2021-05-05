import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class VacationLoaderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[100],
        highlightColor: Colors.grey[200],
        child: Column(
          children: [1, 2, 3, 4, 5, 6, 7, 8]
              .map(
                (idx) => Padding(
              padding: EdgeInsets.all(10.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Container(
                  padding: EdgeInsets.all(26),
                  height: 96,
                ),
              ),
            ),
          )
              .toList(),
        )
      ),
    );
  }
}
