import 'package:flutter/material.dart';
import 'package:news_app/view/newsDetails_screen.dart';

class NewsContainer extends StatelessWidget {
  String image;
  String title;
  String description;
  String content;
  String readMoreLink;
  NewsContainer({required this.image,
    required this.title,
    required this.description,
    required this.content,
    required this.readMoreLink});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
             FadeInImage.assetNetwork(
               placeholder:"assets/images/news.jpg",
               image: image!,
               height:300,
               fit:BoxFit.cover,
             ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(title.length  > 120 ? "${title.substring(0,120)}..." : title,
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(description,style: TextStyle(fontSize: 11,fontWeight: FontWeight.w600),),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text("${content.substring(0,(content.length)-17)} . . .",style: TextStyle(fontSize: 12,fontWeight:FontWeight.w600),),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.push(context,MaterialPageRoute(
                            builder: (context)=>NewsDetailsScreen(newsUrl:readMoreLink!)));
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 40),
                        height: 60,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(child: Text("Read More",style: TextStyle(fontSize: 22,color:Colors.white,fontWeight: FontWeight.bold),)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
