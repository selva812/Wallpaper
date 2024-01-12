import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:wallpaper/model/photomodels.dart';
import 'package:wallpaper/model/categorymodel.dart';

class ApiOperations {
  static List<PhotosModel> trendingwallpapers = [];
  static List<PhotosModel> searchwallpaperslist = [];
  static List<CategoryModel> cateogryModelList = [];
  static Future<List<PhotosModel>> getTrendingwallpaper() async {
    await http.get(Uri.parse("https://api.pexels.com/v1/curated?"), headers: {
      "Authorization":
          "AptIGXxilz3K8X5Vdh9G7rFPaZu022sLM4FRMotxzUOgyhlTLZ3Js7lA"
    }).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      List photos = jsonData['photos'];
      for (var element in photos) {
        trendingwallpapers.add(PhotosModel.fromAPI2app(element));
      }
    });
    return trendingwallpapers;
  }

  static Future<List<PhotosModel>> searchWallpapers(String query) async {
    await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=$query&per_page=30&page=1"),
        headers: {
          "Authorization":
              "AptIGXxilz3K8X5Vdh9G7rFPaZu022sLM4FRMotxzUOgyhlTLZ3Js7lA"
        }).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      List photos = jsonData['photos'];
      searchwallpaperslist.clear();
      for (var element in photos) {
        searchwallpaperslist.add(PhotosModel.fromAPI2app(element));
      }
    });
    return searchwallpaperslist;
  }

  static List<CategoryModel> getcategoriesList() {
    List categoryName = [
      "cars",
      "Nature",
      "Bikes",
      "City",
      "Flowers",
      " Games",
      "Moon"
    ];
    cateogryModelList.clear();
    categoryName.forEach((catName) async {
      final _random = Random();
      PhotosModel photosModel =
          (await searchWallpapers(catName))[0 + _random.nextInt(11)];
      print("Img soruce is here");
      print(photosModel.imgsrc);
      cateogryModelList
          .add(CategoryModel(catImgUrl: photosModel.imgsrc, catName: catName));
    });
    return cateogryModelList;
  }
}
