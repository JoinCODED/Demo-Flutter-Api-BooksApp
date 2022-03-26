import 'package:image_picker/image_picker.dart';
import 'package:json_annotation/json_annotation.dart';
part 'book.g.dart';

@JsonSerializable()
class Book {
  int? id;
  String title;
  String description;
  String image;
  double price;

  Book(
      {this.id,
      required this.title,
      required this.description,
      required this.image,
      required this.price});

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);

  Map<String, dynamic> toJson() => _$BookToJson(this);
}
