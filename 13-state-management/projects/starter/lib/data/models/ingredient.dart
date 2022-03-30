import 'package:equatable/equatable.dart';

class Ingredient extends Equatable{
  int? id;
  int? recipeId;
  final String? name;
  final double? weight;

  //3
  Ingredient({this.id, this.recipeId, this.name, this.weight});

  @override
  // TODO: implement props
  List<Object?> get props => [recipeId,name,weight];

}