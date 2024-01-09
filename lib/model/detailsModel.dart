class DetailsModel{
  String name;
  int number;
  String place;
  String bloodGroup;
  String id;
  DateTime date;


  DetailsModel({
    required this.name,
    required this.number,
    required this.place,
    required this.bloodGroup,
    required this.id,
    required this.date
  });

  DetailsModel copyWith({
    String? name,
    int? number,
    String? place,
    String? bloodGroup,
    String? id,
    DateTime? date
  }) {
    return DetailsModel(
      name: name ?? this.name,
      number: number ?? this.number,
      place: place ?? this.place,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      id: id ?? this.id,
      date: date ?? this.date
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'number': number,
      'place': place,
      'bloodGroup': bloodGroup,
      'id': id,
      'date':date
    };
  }

  factory DetailsModel.fromMap(Map<String, dynamic> map) {
    return DetailsModel(
      name: map['name'] as String,
      number: map['number'] as int,
      place: map['place'] as String,
      bloodGroup: map['bloodGroup'] as String,
      id: map['id'] as String,
      date:map['date'].toDate(),
    );
  }

}