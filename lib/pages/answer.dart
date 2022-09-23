
import 'package:flutter/material.dart';

import '../ads/interstitial_ad.dart';
import '../api/fire.dart';
import '../model/file_name.dart';
import '../model/firebaseFile.dart';
import '../resoure/animated_route.dart';
import '../widget/progress_indicator.dart';
import 'view.dart';

class Answer extends StatefulWidget {
  const Answer({Key? key}) : super(key: key);

  @override
  State<Answer> createState() => _AnswerState();
}

class _AnswerState extends State<Answer> {
  late Future<List<FirebaseFile>> ansFiles;
  final List<Kcse> names = Kcse.papers();
  MyAds myAds = MyAds();
  

  @override
  void initState() {
    super.initState();
    ansFiles = FirebaseApi.listAll('ans/');
    myAds.createInterstitialAd();


  }

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder<List<FirebaseFile>>(
          future: ansFiles,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const MyLinearIndicator();
              default:
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Sorry! error occured.."),
                  );
                } else {
                  final answerPapers = snapshot.data!.reversed.toList();
                  return Expanded(
                    child: ListView.builder(
                        itemCount: answerPapers.length,
                        itemBuilder: (BuildContext context, int index) {
                          final answerPaper = answerPapers[index];
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
                                        pdffile: answerPaper,
                                        title: name.title,
                                      ))).then((_) => myAds.showInterstitialAd());
                                },
                                title: Text(name.year),
                                subtitle: const Text(
                                    "K.C.S.E Biology Paper 1 & 2 answers"),
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
