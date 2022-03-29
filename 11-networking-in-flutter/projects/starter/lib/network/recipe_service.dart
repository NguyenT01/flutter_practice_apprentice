import 'package:http/http.dart' as http;

const String apiKey = '4b020e8b667b943e8a9f57953884e8c7';
const String apiId = 'f271824c';
const String apiUrl = 'https://api.edamam.com/search';

class RecipeService{
  Future getData(String url) async{
    //2
    print('Calling url: $url');

    final response = await http.get(Uri.parse(url));
    //4
    if(response.statusCode==200)
      return response.body;
    else
      print(response.statusCode);
  }

  //TODO: Add getRecipes
  Future<dynamic> getRecipes(String query, int from, int to) async{
    //2
    final recipeData = await getData(
        '$apiUrl?app_id=$apiId&app_key=$apiKey&q=$query&from=$from&to=$to');
    //3
    return recipeData;
  }

}