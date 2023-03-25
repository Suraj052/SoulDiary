
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../ViewModel/provider.dart';
import 'diary_list.dart';
import 'new_diary.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState()
  {
    super.initState();
    final provider = Provider.of<DiaryProvider>(context,listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      provider.getDiary();
    });
    print("LENGTH : ${provider.diaryList.length}");
  }


  Future<bool> _onWillPop() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: HexColor("#25262d"),
              statusBarIconBrightness: Brightness.light),
          backgroundColor: HexColor("#25262d"),
          automaticallyImplyLeading: false,
          title: Center(child: Text(' " In the pages of my diary, I find myself " ',style: TextStyle(fontFamily: 'Product Sans',color: Colors.white,fontSize: 14))),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 2),
          child: DiaryList(),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add,color: Colors.white,),
          onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NewDiary())),
          backgroundColor: HexColor("#25262d"),
        ),

    );
  }
}
