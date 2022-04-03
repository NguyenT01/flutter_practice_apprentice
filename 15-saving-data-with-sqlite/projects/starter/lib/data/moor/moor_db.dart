// import 'package:moor_flutter/moor_flutter.dart';
// import '../models/models.dart';
//
// // part 'moor_db.g.dart';
// //
// // // TODO: Add MoorRecipe table definition here
// // class MoorRecipe extends Table{
// //   //2
// //   IntColumn get id => integer().autoIncrement()();
// //
// //   TextColumn get label => text()();
// //   TextColumn get image => text()();
// //   TextColumn get url => text()();
// //   RealColumn get calories => real()();
// //   RealColumn get totalWeight => real()();
// //   RealColumn get totalTime => real()();
// // }
// //
// // // TODO: Add MoorIngredient table definition here
// // class MoorIngredient extends Table{
// //   IntColumn get id => integer().autoIncrement()();
// //   IntColumn get recipeId => integer()();
// //   TextColumn get name => text()();
// //   RealColumn get weight => real()();
// // }
// //
// // // TODO: Add @UseMoor() and RecipeDatabase() here
// // @UseMoor(tables: [MoorRecipe,MoorIngredient], daos: [RecipeDao, IngredientDao])
// // //2
// // class RecipeDatabase extends _$RecipeDatabase{
// //   RecipeDatabase():
// //       super(FlutterQueryExecutor.inDatabaseFolder(
// //           path: 'recipes.sqlite', logStatements: true));
// //
// //   @override
// //   int get schemaVersion =>1;
// // }
// //
// //
// //
// // // TODO: Add RecipeDao here
// // @UseDao(tables: [MoorRecipe])
// // class RecipeDao extends DatabaseAccessor<RecipeDatabase>
// //     with _$RecipeDaoMixin{
// //   //3
// //   final RecipeDatabase db;
// //   RecipeDao(this.db): super(db);
// //
// //   Future<List<MoorRecipeData>> findAllRecips()=> select(moorRecipe).get();
// //
// //   Stream<List<Recipe>> watchAllRecipes(){
// //     //TODO: Add watchAllRecipes code here
// //
// //   }
// //
// //   Future<List<MoorRecipeData>> findRecipeById(int id)=>
// //       (select(moorRecipe)..where((tbl) => tbl.id.equals(id))).get();
// //
// //   Future<int> insertRecipe(Insertable<MoorRecipeData> recipe) =>
// //       into(moorRecipe).insert(recipe);
// //
// //   Future deleteRecipe(int id)=> Future.value(
// //       (delete(moorRecipe)..where((tbl) => tbl.id.equals(id))).go());
// //
// // }
//
//
//
// // TODO: Add IngredientDao
//
//
// // TODO: Add moorRecipeToRecipe here
//
//
// // TODO: Add MoorRecipeData here
//
//
// // TODO: Add moorIngredientToIngredient and MoorIngredientCompanion here