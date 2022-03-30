import 'package:chopper/chopper.dart';
import 'recipe_model.dart';
import 'model_response.dart';
import 'model_converter.dart';

part 'recipe_service.chopper.dart';

const String apiKey = '4b020e8b667b943e8a9f57953884e8c7';
const String apiId = 'f271824c';
const String apiUrl = 'https://api.edamam.com';

// TODO: Add @ChopperApi() here
@ChopperApi()
abstract class RecipeService extends ChopperService{
  //3
  @Get(path:'search')
  //4
  Future<Response<Result<APIRecipeQuery>>> queryRecipes(
      @Query('q') String query,
      @Query('from') int from,
      @Query('to') int to
  );
  // TODO: Add create()
  static RecipeService create(){
    final client = ChopperClient(
      baseUrl: apiUrl,
      interceptors: [_addQuery, HttpLoggingInterceptor()],
      converter: ModelConverter(),
      errorConverter: const JsonConverter(),
      services: [
        _$RecipeService(),
      ]
    );
    //7
    return _$RecipeService(client);
  }

}

//TODO: Add _addQuery()
Request _addQuery(Request req){
  final params = Map<String, dynamic>.from(req.parameters);
  //2
  params['app_id'] = apiId;
  params['app_key'] = apiKey;
  //3
  return req.copyWith(parameters: params);
}
