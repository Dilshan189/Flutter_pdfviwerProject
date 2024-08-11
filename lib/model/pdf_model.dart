class PDFModel {
  int? id;
  String fileName;
  String filePath;

  PDFModel({
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

  factory PDFModel.fromMap(Map<String,dynamic>map)
  {

    return PDFModel(
        id: map['id'],
        fileName: map['fileName'],
        filePath: map['filePath'],
    );
  }
}