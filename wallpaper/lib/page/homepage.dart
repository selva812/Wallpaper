import 'package:flutter/material.dart';
import 'package:wallpaper/controller/apioper.dart';
import 'package:wallpaper/model/categorymodel.dart';
import 'package:wallpaper/model/photomodels.dart';
import 'package:wallpaper/page/Search.dart';
import 'package:wallpaper/view/customappbar.dart';
import 'package:wallpaper/view/fullscreen.dart';
import 'package:wallpaper/widget/catblock.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late List<PhotosModel> trendingwallList = [];
  late List<CategoryModel> catModList = [];
  GetTrendingwallpaper() async {
    trendingwallList = await ApiOperations.getTrendingwallpaper();
    setState(() {});
  }

  GetCatDetails() async {
    catModList = await ApiOperations.getcategoriesList();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    GetTrendingwallpaper();
    GetCatDetails();
  }

  final TextEditingController _searchcontroller = TextEditingController();
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(25)),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchcontroller,
                      decoration: const InputDecoration(
                        hintText: "Search Wallpaper",
                        errorBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        border: OutlineInputBorder(),
                      ),
                      style: const TextStyle(color: Colors.black87),
                      onSubmitted: (value) => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Searchpage(query: _searchcontroller.text))),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Searchpage(query: _searchcontroller.text)));
                    },
                    child: const Icon(
                      Icons.search,
                      color: Colors.black38,
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: SizedBox(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: catModList.length,
                    itemBuilder: ((context, index) => CatBlock(
                          categoryImgsrc: catModList[index].catImgUrl,
                          categoryname: catModList[index].catName,
                        )),
                  )),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 500,
              child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 400,
                      crossAxisSpacing: 13,
                      mainAxisSpacing: 10),
                  itemCount: trendingwallList.length,
                  itemBuilder: ((context, index) => GridTile(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FullScreen(
                                        imgurl:
                                            trendingwallList[index].imgsrc)));
                          },
                          child: Hero(
                            tag: trendingwallList[index].imgsrc,
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
                                  trendingwallList[index].imgsrc,
                                  fit: BoxFit.cover,
                                ),
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
