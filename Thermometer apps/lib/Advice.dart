import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Advice extends StatefulWidget {
  Advice({Key key}) : super(key:key);

  @override
  _AdviceState createState() => _AdviceState();
}

class _AdviceState extends State<Advice> {
  VideoPlayerController _controllerone;
  VideoPlayerController _controllertwo;
  VideoPlayerController _controllerthree;
  Future<void> _initializeVideoPlayerFuture;
  Future<void> _initializeVideoPlayerFuture1;
  Future<void> _initializeVideoPlayerFuture2;


  @override
  void initState() {
    _controllerone = VideoPlayerController.asset('assets/Videos/page1.mp4');
    _controllertwo = VideoPlayerController.asset('assets/Videos/page2.mp4');
    _controllerthree = VideoPlayerController.asset('assets/Videos/page3.mp4');

    _initializeVideoPlayerFuture = _controllerone.initialize();
    _controllerone.setLooping(true);
    _controllerone.play();

    _initializeVideoPlayerFuture1 = _controllertwo.initialize();
    _controllertwo.play();
    _controllertwo.setLooping(true);

    _initializeVideoPlayerFuture2 = _controllerthree.initialize();
    _controllerthree.setLooping(true);
    _controllerthree.play();

    super.initState();
  }

  @override
  void dispose(){
    _controllerone.dispose();
    _controllertwo.dispose();
    _controllerthree.dispose();

    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor:Colors.blueGrey,
          title: Center(
            child: Text('Guideline'),
          ),
        ),
        body: Stack(
            children: <Widget>[
              Container(
                color: Colors.black,
              ),
              Container(
                child: SingleChildScrollView(
                  child:Column(
                    children: <Widget>[
                      SizedBox(height: 10,),
                      FutureBuilder(
                        future: _initializeVideoPlayerFuture,
                        builder: (context, snapshot){
                          if(snapshot.connectionState == ConnectionState.done) {
                            return AspectRatio(
                              aspectRatio: _controllerone.value.aspectRatio,
                              child: VideoPlayer(_controllerone),
                            );
                          }else{
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),

                      SizedBox(height: 10,),
                      FutureBuilder(
                        future: _initializeVideoPlayerFuture1,
                        builder: (context, snapshot){
                          if(snapshot.connectionState == ConnectionState.done) {
                            return AspectRatio(
                              aspectRatio: _controllertwo.value.aspectRatio,
                              child: VideoPlayer(_controllertwo),
                            );
                          }else{
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),

                      SizedBox(height: 10,),
                      FutureBuilder(
                        future: _initializeVideoPlayerFuture2,
                        builder: (context, snapshot){
                          if(snapshot.connectionState == ConnectionState.done) {
                            return AspectRatio(
                              aspectRatio: _controllerthree.value.aspectRatio,
                              child: VideoPlayer(_controllerthree),
                            );
                          }else{
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              )
            ])
    );
  }
}