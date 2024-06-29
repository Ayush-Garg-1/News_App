import 'dart:math';
import 'package:http/http.dart';
import 'dart:convert';
List sourcesList = ["abc-news",
  "bbc-sport",
  "business-insider",
  "engadget",
  "entertainment-weekly",
  "financial-post",
  "fox-sports",
  "medical-news-today",
  "national-geographic",
  "news24",
  "new-scientist",
  "new-york-magazine",
  "next-big-future",
  "techcrunch",
  "techradar",
  "the-hindu",
  "the-wall-street-journal",
  "the-washington-times",
  "time",
  "usa-today",];
// Todo Fetch api data
Future fetchNewsApi() async{
  Random random = new Random();
  String source = sourcesList[random.nextInt(sourcesList.length)];
  String url = "https://newsapi.org/v2/top-headlines?sources=${source}&apiKey=1c86969cbd3140baab7d8c561131ec7e";
  try{
    Response response = await get(Uri.parse(url));
    if(response.statusCode == 200){
      Map<String, dynamic> bodyData = json.decode(response.body);
      List<dynamic> articles =bodyData["articles"];
      int randomNumber = random.nextInt(articles.length);
      Map<String,dynamic> singleNewsData = articles[randomNumber];
      return dataModlingFunction(singleNewsData);
    }else{
      throw DataNotFoundException();
    }
  } on DataNotFoundException catch(e){
    print(e.message);
  }
  catch(e){
    print(e);
  }
}
//Todo Data Modeled Function
NewsData dataModlingFunction(Map<String,dynamic> singleNewsData){
  NewsData singleData = NewsData(
    image:singleNewsData['urlToImage'] ?? "https://images.unsplash.com/photo-1588681664899-f142ff2dc9b1?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    title:singleNewsData['title'] ?? "Amazon mulls 5 to 10 monthly price tag for unprofitable Alexa service, AI revamp - The Indian Express",
    description:singleNewsData['description'] ?? "Amazon mulls 5 to 10 monthly price tag for unprofitable Alexa service, AI revamp - The Indian Express",
    content:singleNewsData['content'] ?? "Amazon mulls 5 to 10 monthly price tag for unprofitable Alexa service, AI revamp - The Indian Express",
    readMoreLink:singleNewsData['url'] ?? "https://news.google.com/home?hl=en-IN&gl=IN&ceid=IN:en",
  );
  return singleData;
}
//Todo Data Model Class
class NewsData{
  String image="";
  String title="";
  String description="";
  String content="";
  String readMoreLink="";
  NewsData(
      {
        required this.image,
        required this.title,
        required this.description,
        required this.content,
        required this.readMoreLink
      });
}
//Todo Exception Class
class DataNotFoundException implements Exception{
  String message = "Data Not Found";
}

