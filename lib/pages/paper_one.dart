
import 'package:flutter/material.dart';
import '../ads/interstitial_ad.dart';
import '../api/fire.dart';
import '../model/file_name.dart';
import '../model/firebaseFile.dart';
import '../resoure/animated_route.dart';
import '../resoure/color.dart';

import 'view.dart';


class PaperOne extends StatefulWidget {
  const PaperOne({Key? key}) : super(key: key);

  @override
  State<PaperOne> createState() => _PaperOneState();
}

class _PaperOneState extends State<PaperOne> {
  late Future<List<FirebaseFile>> pp1Files;
  final List<Kcse> names = Kcse.papers();
  MyAds myAds = MyAds();
 
  @override
  void initState(){
    super.initState();
    pp1Files = FirebaseApi.listAll('pp1/');
    myAds.createInterstitialAd();

    
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FirebaseFile>>(
      future: pp1Files,
      builder: (context, snapshot){
        switch(snapshot.connectionState){
          case ConnectionState.waiting:
            return const Padding(
              padding:  EdgeInsets.symmetric(horizontal: 22),
              child: LinearProgressIndicator(
              color: Colors.yellow,
              backgroundColor: mainColor,
              
              ),);
          default:
            if(snapshot.hasError){
              return const Center(child: Text("Sorry! error occured.."),);
            }else{
              final paperOnePapers = snapshot.data!.reversed.toList();
              return Expanded(
            child: ListView.builder(
            itemCount: paperOnePapers.length,
            itemBuilder: (BuildContext context, int index) {
              final paperOnePaper = paperOnePapers[index];
              final name = names[index];
              return Column(
                children: [
                  ListTile(
                    style: ListTileStyle.list,
                    onTap: () {
                        
                        Navigator.push(
                              context,
                              CustomRoute(
                                page: ViewPdf(
                                pdffile: paperOnePaper, title: name.title,
                              ))).then((_) => myAds.showInterstitialAd());
                    },
                    title: Text(
                      name.year
                    ),
                    subtitle: const Text("K.C.S.E Biology Paper 1"),
                  ),
                  const Divider(),
                ],
              );
            }),
      );
            }
        }
      });
    
  }
}