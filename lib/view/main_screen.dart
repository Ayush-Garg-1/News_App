
import 'package:flutter/material.dart';
import 'package:news_app/view/widgets/news_container.dart';

import '../controller/fetch_news_api.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}
class _MainScreenState extends State<MainScreen> {
  NewsData? newsData;
  bool isLoading=false;
  void getNews() async{
    try{
      var data = await fetchNewsApi();
      setState(() {
        newsData = data;
        isLoading=false;
      });
    }catch(e){
      isLoading=true;
      print("Error To fetching data : "+e.toString());
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title:const Center(
          child:Padding(
            padding: EdgeInsets.only(top: 5),
            child: Text("ONETIME NEWS",style:TextStyle(fontSize:25,color:Colors.white,fontWeight:FontWeight.bold)),
          ),
        ),
      ),
      body:
      isLoading || newsData==null ? Center(
        child: Container(
            width:100,
            height: 100,
            child: CircularProgressIndicator(color: Colors.orangeAccent,strokeWidth: 10,)),
      )
      :PageView.builder(
          controller: PageController(initialPage: 0),
          scrollDirection: Axis.vertical,
          onPageChanged: (value){
            getNews();
          },
          itemBuilder: (context,index){
            return NewsContainer(
              image:newsData!.image,
              title:newsData!.title,
              description:newsData!.description,
              content:newsData!.content,
              readMoreLink:newsData!.readMoreLink,
            );
          }
      ),
    );
  }
}
