import 'package:flutter/material.dart';

import '../ads/interstitial_ad.dart';
import '../api/fire.dart';
import '../model/file_name.dart';
import '../model/firebaseFile.dart';
import '../resoure/animated_route.dart';
import '../resoure/color.dart';
import 'view.dart';


class PaperTwo extends StatefulWidget {
  const PaperTwo({Key? key}) : super(key: key);

  @override
  State<PaperTwo> createState() => _PaperTwoState();
}

class _PaperTwoState extends State<PaperTwo> {
  late Future<List<FirebaseFile>> pp2Files;
  final List<Kcse> names = Kcse.papers();
  MyAds myAds = MyAds();
  @override
  void initState(){
    super.initState();
    pp2Files = FirebaseApi.listAll('pp2/');
    myAds.createInterstitialAd();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FirebaseFile>>(
      future: pp2Files,
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
              final PaperTwoPapers = snapshot.data!.reversed.toList();
              return Expanded(
            child: ListView.builder(
            itemCount: PaperTwoPapers.length,
            itemBuilder: (BuildContext context, int index) {
              final paperTwoPaper = PaperTwoPapers[index];
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
                                pdffile: paperTwoPaper, title: name.title,
                              ))).then((_) => myAds.showInterstitialAd());
                    },
                    title: Text(
                      name.year
                    ),
                    subtitle: const Text("K.C.S.E Biology Paper 2"),
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