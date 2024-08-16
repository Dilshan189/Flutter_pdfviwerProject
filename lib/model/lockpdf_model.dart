class LockpdfModel {
  int? id;
  String fileName;
  String filePath;
  String filePassword;
  final bool isLocked;


  LockpdfModel({
    this.id,
    required this.fileName,
    required this.filePath,
    required this.filePassword,
    this.isLocked = false,

  });

  Map<String,dynamic> toMap()
  {
    final map = <String,dynamic> {};

    if(id != null)
      {
        map['id'] = id;
      }

    map['fileName'] = fileName;
    map['filePath'] = filePath;
    map['filePassword'] = filePassword;



    return map;
  }

  factory LockpdfModel.fromMap(Map<String,dynamic>map)
  {

    return LockpdfModel(
      id: map['id'],
      fileName: map['fileName'],
      filePath: map['filePath'],
      filePassword: map['filePassword'],
      isLocked: map['isLocked'] == 1,

    );
  }

}