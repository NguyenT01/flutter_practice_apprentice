import 'dart:core';
import 'package:flutter/foundation.dart';

import 'repository.dart';
import 'models/models.dart';

class MemoryRepository extends Repository with ChangeNotifier{
  //4
  final List<Recipe> _currentRecipes = <Recipe>[];
  //5
  final List<Ingredient> _currentIngredients = <Ingredient>[];

  //TODO: Add find methods
  @override
  List<Recipe> findAllRecipes() {
    return _currentRecipes;
  }

  @override
  Recipe findRecipeById(int id) {
    return _currentRecipes.firstWhere((recipe) => recipe.id==id);
  }

  @override
  List<Ingredient> findAllIngredients() {
    return _currentIngredients;
  }

  @override
  List<Ingredient> findRecipeIngredients(int recipeId) {
    final recipe = _currentIngredients.
      firstWhere((recipe) => recipe.id== recipeId);

    //11
    final recipeIngredients = _currentIngredients.
      where((ingredient) => ingredient.recipeId== recipe.id).toList();

    return recipeIngredients;
  }


  //TODO: Add insert methods
  @override
  int insertRecipe(Recipe recipe) {
    _currentRecipes.add(recipe);
    //13
    if(recipe.ingredients!=null)
      insertIngredients(recipe.ingredients!);

    //14
    notifyListeners();
    //15
    return 0;
  }

  //16
  @override
  List<int> insertIngredients(List<Ingredient> ingredients) {
    if(ingredients.length!=0){
      _currentIngredients.addAll(ingredients);
      notifyListeners();
    }
    return<int>[];
  }


  //TODO: Add delete methods
  @override
  void deleteRecipe(Recipe recipe) {
    _currentRecipes.remove(recipe);

    if(recipe.id!=null)
      deleteRecipeIngredients(recipe.id!);

    notifyListeners();
  }

  @override
  void deleteIngredient(Ingredient ingredient) {
    _currentIngredients.remove(ingredient);
  }

  @override
  void deleteIngredients(List<Ingredient> ingredients) {
    _currentIngredients.
      removeWhere((ingredient) => ingredients.contains(ingredient));

    notifyListeners();
  }

  @override
  void deleteRecipeIngredients(int recipeId) {
    //25
    _currentIngredients.
      removeWhere((ingredient) => ingredient.recipeId== recipeId);

    notifyListeners();
  }



  //6
  @override
  Future init() {
    // TODO: implement init
    return Future.value(null);
  }

  @override
  void close() {
    // TODO: implement close
  }

}