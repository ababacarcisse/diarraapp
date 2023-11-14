import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String title;
final String description;
final String price;
  final List<String> imageUrls;  // new field
final String? id;
  const ProductEntity({required this.title,
   this.id,
   required this.description,
    required this.price,
    required this.imageUrls,
   });

  @override
  List<Object?> get props => [title,id,description,price,imageUrls];

  @override
  bool get stringify => true;
}
