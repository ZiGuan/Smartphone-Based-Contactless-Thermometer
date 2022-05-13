import 'package:flutter/material.dart';
import 'package:thermometer/chewie.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';



class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  var url0 = 'https://covid19.who.int/';

  void new1() async {
    if (await canLaunch (url0)
    ){
      await launch(url0,
          universalLinksOnly: true);
    }else { throw "there was a problem";
    }
  }

  var url1 = 'http://covid-19.moh.gov.my/';

  void new2() async {
    if (await canLaunch (url1)
    ){
      await launch(url1,
          universalLinksOnly: true);
    }else { throw "there was a problem";
    }
  }

  var url2 = 'https://www.who.int/emergencies/diseases/novel-coronavirus-2019';

  void new3() async {
    if (await canLaunch (url2)
    ){
      await launch(url2,
          universalLinksOnly: true);
    }else { throw "there was a problem";
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.blueGrey,
        title: Center(
          child: Text('News'),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.black,
          ),
          Container(
              child: SingleChildScrollView(
                child: Column(

                  children: <Widget>[
                    SizedBox(height: 10),
                    Text('WHO Coronavirus Disease (Covid- 19 Dashboard)',
                        style:TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        )),
                    RaisedButton.icon(
                      onPressed: new1,
                      color: Colors.black,
                      splashColor: Colors.cyanAccent,
                      icon: Icon(Icons.arrow_back_ios, color: Colors.cyanAccent,),
                      label: Text('click here',
                        style: TextStyle(
                          color: Colors.cyanAccent,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text('Malaysia Covid-19 Coronavirus Pandamic',
                        style:TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        )),
                    RaisedButton.icon(

                      onPressed: new2,
                      color: Colors.black,
                      splashColor: Colors.cyanAccent,
                      icon: Icon(Icons.arrow_back_ios, color: Colors.cyanAccent,),
                      label: Text('click here',
                        style: TextStyle(
                          color: Colors.cyanAccent,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text('WHO Coronavirus Disease (Covid- 19) pandamic',
                        style:TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        )),
                    RaisedButton.icon(
                      onPressed: new3,
                      color: Colors.black,
                      splashColor: Colors.cyanAccent,
                      icon: Icon(Icons.arrow_back_ios, color: Colors.cyanAccent,),
                      label: Text('click here',
                        style: TextStyle(
                          color: Colors.cyanAccent,
                        ),
                      ),
                    ),

                    SizedBox(height: 10),
                    Text('About Covid-19 (WHO Official)',
                        style:TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        )),
                    Container(
                        child: ChewieListItem(
                          videoPlayerController: VideoPlayerController.asset('assets/Videos/video.mp4',
                          ),
                          looping: true,
                        )),
                    SizedBox(height: 10),
                    Text('What happens if you get CoronaVirus',
                        style:TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        )),
                    Container(
                        child: ChewieListItem(
                          videoPlayerController: VideoPlayerController.asset('assets/Videos/video2.mp4',
                          ),
                          looping: true,
                        )),
                    SizedBox(height: 10),
                    Text('CoronaVirus Myths',
                        style:TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        )),
                    Container(
                        child: ChewieListItem(
                          videoPlayerController: VideoPlayerController.asset('assets/Videos/video3.mp4',
                          ),
                          looping: true,
                        )),

                  ],
                ),
              )
          ),
        ],
      ),
    );
  }
}