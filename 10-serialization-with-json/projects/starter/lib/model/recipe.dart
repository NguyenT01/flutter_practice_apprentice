
class Recipe{
  final String uri;
  final String label;

  Recipe( this.uri, this.label);

  factory Recipe.fromJson(Map<String, dynamic> json){
    return Recipe(json['uri'] as String, json['label'] as String);
  }

  Map<String, dynamic> toJson(){
    return <String,dynamic> {'uri': uri, 'label': label};
  }

}
