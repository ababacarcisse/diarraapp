import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String name;
final String? id;
  const Category({required this.name, this.id});

  @override
  List<Object?> get props => [name,id];

  @override
  bool get stringify => true;
}
