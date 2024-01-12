class PhotosModel {
  String imgsrc;
  String photoname;
  PhotosModel({required this.imgsrc, required this.photoname});
  static PhotosModel fromAPI2app(Map<String, dynamic> photoMap) {
    return PhotosModel(
        photoname: photoMap["photographer"],
        imgsrc: (photoMap["src"])["portrait"]);
  }
}
