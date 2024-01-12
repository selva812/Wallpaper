import 'package:flutter/material.dart';
import 'package:wallpaper/controller/apioper.dart';
import 'package:wallpaper/model/photomodels.dart';
import 'package:wallpaper/view/customappbar.dart';
import 'package:wallpaper/view/fullscreen.dart';

class Searchpage extends StatefulWidget {
  final String query;
  const Searchpage({super.key, required this.query});

  @override
  State<Searchpage> createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
  final TextEditingController _searchcontroller = TextEditingController();
  late List<PhotosModel> searchresult = [];

  GetSearchresult() async {
    searchresult = await ApiOperations.searchWallpapers(widget.query);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    GetSearchresult();
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
                                builder: (context) => Searchpage(
                                    query: _searchcontroller.text)))),
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
                  itemCount: searchresult.length,
                  itemBuilder: ((context, index) => GridTile(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FullScreen(
                                        imgurl: searchresult[index].imgsrc)));
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
                                searchresult[index].imgsrc,
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
