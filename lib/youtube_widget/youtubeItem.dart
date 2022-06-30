import 'package:flutter/material.dart';
import 'package:pertemuan15/youtube_widget/video_screen.dart';


import '../models/video_model.dart';

class YoutubeItem extends StatelessWidget {
  final Video video;
  final int piro;
  const YoutubeItem(this.piro, this.video);



  @override
  Widget build(BuildContext context) {
   

    print('build video');
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
     
      height: MediaQuery.of(context).size.height / 8.0,padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
              color: Colors.black12, offset: Offset(2, 2), blurRadius: 10.0),
        ],
      ),
      child: ListTile(contentPadding: const EdgeInsets.all(10),dense: false,
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute( builder: (context) => YoutubeAppDemo(
                id:video.id,title: video.title!,
                index:piro,
                image:video.thumbnailUrl,
              
            ))
             );
          },
          leading: Hero(
            tag:piro,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black54,
                      offset: Offset(2, 2),
                      blurRadius: 10.0),
                ],
              ),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/yg.png',
                    image:video.thumbnailUrl!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          title: Text(
          video.title!,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14.0,
            ),
          ),
          trailing:  Text(
             piro.toString(),
              style: const TextStyle(color: Colors.green,fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
             
            
          )),
    );
  }
}
