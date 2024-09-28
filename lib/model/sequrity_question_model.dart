class SecurityQuestionModel{
  int? id;
  String textName;
  String textAnswer;

  SecurityQuestionModel({
    this.id,
    required this.textName,
    required this.textAnswer,
});

  Map<String,dynamic> toMap()
  {
    final map = <String,dynamic> {};

    if(id != null)
      {
        map['id'] = id;
      }

    map['textName'] = textName;
    map['textAnswer'] = textAnswer;

    return map;
  }
  factory SecurityQuestionModel.fromMap(Map<String,dynamic>map)
  {
    return SecurityQuestionModel(
        id: map['id'],
        textName: map['textName'],
        textAnswer: map['textAnswer'],
    );
  }
}