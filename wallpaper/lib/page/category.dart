import 'package:flutter/material.dart';
import 'package:wallpaper/controller/apioper.dart';
import 'package:wallpaper/model/photomodels.dart';
import 'package:wallpaper/view/customappbar.dart';
import 'package:wallpaper/view/fullscreen.dart';

class CategoryPage extends StatefulWidget {
  final String catname;
  final String catimage;
  const CategoryPage(
      {super.key, required this.catname, required this.catimage});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late List<PhotosModel> catresult = [];
  getCatresult() async {
    catresult = await ApiOperations.searchWallpapers(widget.catname);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getCatresult();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: const Customappbar(
          name1: "Wallpaper",
          name2: " App",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(children: [
              Image.network(
                height: 150,
                width: MediaQuery.of(context).size.width,
                widget.catimage,
                fit: BoxFit.cover,
              ),
              Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black38),
              Positioned(
                left: 150,
                top: 40,
                child: Column(
                  children: [
                    const Text("Category",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w300)),
                    Text(
                      widget.catname,
                      style: const TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              )
            ]),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: MediaQuery.of(context).size.height,
              child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 400,
                      crossAxisSpacing: 13,
                      mainAxisSpacing: 10),
                  itemCount: catresult.length,
                  itemBuilder: ((context, index) => GridTile(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FullScreen(
                                        imgurl: catresult[index].imgsrc)));
                          },
                          child: Container(
                            height: 500,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.amberAccent,
                                borderRadius: BorderRadius.circular(12)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                height: 800,
                                width: 50,
                                catresult[index].imgsrc,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ))),
            )
          ],
        ),
      ),
    );
  }
}
