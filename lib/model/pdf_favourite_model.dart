class PdfFavouriteModel {
  int? id;
  String fileName;
  String filePath;

  PdfFavouriteModel({
    this.id,
    required this.fileName,
    required this.filePath,
  });


  Map<String,dynamic> toMap()
  {
    final  map = <String,dynamic> {};

    if(id != null)
    {
      map['id'] = id;
    }

    map['fileName'] = fileName;
    map['filePath'] = filePath;

    return map;
  }

  factory PdfFavouriteModel.fromMap(Map<String,dynamic>map)
  {

    return PdfFavouriteModel(
      id: map['id'],
      fileName: map['fileName'],
      filePath: map['filePath'],
    );
  }
}