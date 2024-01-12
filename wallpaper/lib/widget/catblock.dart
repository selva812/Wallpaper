import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper/page/category.dart';

class CatBlock extends StatelessWidget {
  final String categoryname;
  final String categoryImgsrc;
  const CatBlock(
      {super.key, required this.categoryImgsrc, required this.categoryname});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryPage(
                      catname: categoryname,
                      catimage: categoryImgsrc,
                    )));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Stack(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
                height: 50, width: 100, fit: BoxFit.cover, categoryImgsrc),
          ),
          Container(
            height: 50,
            width: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: Colors.black26),
          ),
          Positioned(
            left: 30,
            top: 15,
            child: Text(
              categoryname,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w600),
            ),
          )
        ]),
      ),
    );
  }
}
