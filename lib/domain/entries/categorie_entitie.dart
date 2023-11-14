import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final String name;
final String? id;
  const CategoryEntity({required this.name, this.id});

  @override
  List<Object?> get props => [name,id];

  @override
  bool get stringify => true;
}
