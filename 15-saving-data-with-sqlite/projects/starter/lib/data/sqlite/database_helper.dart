import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlbrite/sqlbrite.dart';
import 'package:synchronized/synchronized.dart';
import '../models/models.dart';

class DatabaseHelper {
  //1
  static const _databaseName = 'MyRecipes.db';
  static const _databaseVersion = 1;

  //2
  static const recipeTable = 'Recipe';
  static const ingredientTable = 'Ingredient';
  static const recipeId = 'recipeId';
  static const ingredientId = 'ingredientId';

  //3
  static late BriteDatabase _streamDatabase;

  //4 - SINGLETON
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  //5
  static var lock = Lock();

  //6
  static Database? _database;

  //TODO: Add create database code here
  Future _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE $recipeTable(
          $recipeId INTEGER PRIMARY KEY,
          label TEXT,
          image TEXT,
          url TEXT,
          calories REAL,
          totalWeigt REAL,
          totalTime REAL
        )''');

    //3
    await db.execute('''
      CREATE TABLE $ingredientTable(
        $ingredientId INTEGER PRIMARY KEY,
        $recipeId INTEGER,
        name TEXT,
        weight REAL,
        )''');
  }

  //TODO: Add code to open database
  Future<Database> _initDatabase() async {
    //2
    final documentDirectory = await getApplicationDocumentsDirectory();
    //3
    final path = join(documentDirectory.path, _databaseName);
    //4
    //TODO: Remember to turn off debugging before deploying app to store
    Sqflite.setDebugModeOn(true);

    //5
    return openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  //TODO: Add initialize getter here
  Future<Database> get database async {
    //2
    if (_database != null) return _database!;
    //Use this object to prevent concurrent access to data
    //3
    await lock.synchronized(() async {
      //lazily instance the db the first time it is accessed
      //4
      if (_database == null) {
        //5
        _database = await _initDatabase();
        //6
        _streamDatabase = BriteDatabase(_database!);
      }
    });
    return database;
  }

  //TODO: Add getter for streamDatabase
  Future<BriteDatabase> get streamDatabase async {
    //2
    await database;
    return _streamDatabase;
  }

  //TODO: AddparseRecipes here
  List<Recipe> parseRecipes(List<Map<String, dynamic>> recipeList) {
    final recipes = <Recipe>[];
    //1
    recipeList.forEach((recipeMap) {
      //2
      final recipe = Recipe.fromJson(recipeMap);
      //3
      recipes.add(recipe);
    });
    //4
    return recipes;
  }

  List<Ingredient> parseIngredients(List<Map<String, dynamic>> ingredientList) {
    final ingredients = <Ingredient>[];
    ingredientList.forEach((ingredientMap) {
      //5
      final ingredient = Ingredient.fromJson(ingredientMap);
      ingredients.add(ingredient);
    });
    return ingredients;
  }

  //TODO: Add findAppRecipes here
  Future<List<Recipe>> findAllRecipes() async {
    //1
    final db = await instance.streamDatabase;
    //2
    final recipeList = await db.query(recipeTable);
    //3
    final recipes = parseRecipes(recipeList);
    return recipes;
  }

  //TODO: Add watchAllRecipes() here
  Stream<List<Recipe>> watchAllRecipes() async* {
    final db = await instance.streamDatabase;
    //1
    yield* db.createQuery(recipeTable).mapToList((row) => Recipe.fromJson(row));
  }

  //TODO: Add watchAllIngredients() here
  Stream<List<Ingredient>> watchAllIngredients() async* {
    final db = await instance.streamDatabase;
    yield* db
        .createQuery(ingredientTable)
        .mapToList((row) => Ingredient.fromJson(row));
  }

  //TODO: Add findRecipeById here
  Future<Recipe> findRecipeById(int id) async {
    final db = await instance.streamDatabase;
    final recipeList = await db.query(recipeTable, where: 'id=$id');
    final recipes = parseRecipes(recipeList);
    return recipes.first;
  }

  //TODO: findAllIngredients() goes here
  Future<List<Ingredient>> findAllIngredients() async {
    final db = await instance.streamDatabase;
    final ingredientList = await db.query(ingredientTable);
    final ingredients = parseIngredients(ingredientList);
    return ingredients;
  }

  // TODO: findRecipeIngredients() goes here
  Future<List<Ingredient>> findRecipeIngredients(int id) async {
    final db = await instance.streamDatabase;
    final ingredientList =
        await db.query(ingredientTable, where: 'recipeId=$recipeId');
    final ingredients = parseIngredients(ingredientList);
    return ingredients;
  }

  //TODO: Insert methods goes here
  Future<int> insert(String table, Map<String, dynamic> row) async {
    final db = await instance.streamDatabase;
    return db.insert(table, row);
  }

  Future<int> insertRecipe(Recipe recipe) {
    return insert(recipeTable, recipe.toJson());
  }

  Future<int> insertIngredient(Ingredient ingredient) {
    return insert(recipeTable, ingredient.toJson());
  }

  //TODO: Delete method goes here
  Future<int> _delete(String table, String columnId, int id) async {
    final db = await instance.streamDatabase;
// 2
    return db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> deleteRecipe(Recipe recipe) async {
// 3
    if (recipe.id != null) {
      return _delete(recipeTable, recipeId, recipe.id!);
    } else {
      return Future.value(-1);
    }
  }

  Future<int> deleteIngredient(Ingredient ingredient) async {
    if (ingredient.id != null) {
      return _delete(ingredientTable, ingredientId, ingredient.id!);
    } else {
      return Future.value(-1);
    }
  }

  Future<void> deleteIngredients(List<Ingredient> ingredients) {
// 4
    ingredients.forEach((ingredient) {
      if (ingredient.id != null) {
        _delete(ingredientTable, ingredientId, ingredient.id!);
      }
    });
    return Future.value();
  }

  Future<int> deleteRecipeIngredients(int id) async {
    final db = await instance.streamDatabase;
// 5
    return db.delete(ingredientTable, where: '$recipeId = ?', whereArgs: [id]);
  }

  // TODO: Add close() here
  void close()
  {
    _streamDatabase.close();
  }
}
