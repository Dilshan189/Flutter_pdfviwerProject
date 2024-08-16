class PDFModelFa {
  int?  id;
  String fileName;
  String filePath;
  String size;
  String modifiedDate;

  PDFModelFa({
    this.id,
    required this.fileName,
    required this.filePath,
    required this.size,
    required this.modifiedDate,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};

    if (id != null) {
      map['id'] = id;
    }
    map['fileName'] = fileName;
    map['filePath'] = filePath;
    map['size'] = size;
    map['modifiedDate'] = modifiedDate;

    return map;
  }

  factory PDFModelFa.fromMap(Map<String, dynamic> map) {
    return PDFModelFa(
      id: map['id'],
      fileName: map['fileName'],
      filePath: map['filePath'],
      size: map['size'],
      modifiedDate: map['modifiedDate'],
    );
  }
}
