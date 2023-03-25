
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:write/ViewModel/pdf_api.dart';
import '../ViewModel/provider.dart';
import 'diary_edit.dart';

class DiaryDetail extends StatefulWidget {
  final Map<String,dynamic> diary;
  const DiaryDetail({required this.diary,Key? key}) : super(key: key);

  @override
  State<DiaryDetail> createState() => _DiaryDetailState();
}

class _DiaryDetailState extends State<DiaryDetail> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DiaryProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EditDiary(diary: widget.diary))),
                icon: Icon(Icons.edit,color: Colors.white)
            ),
            IconButton(onPressed: (){
              provider.deleteDiary(widget.diary['id']);
              Navigator.of(context).pop();
                },
              icon:Icon(Icons.delete,color: Colors.white)),
            IconButton(onPressed: ()=>send(),
                icon:Icon(Icons.share,color: Colors.white)),
            IconButton(onPressed: () async {
              final pdfFile = await PdfApi.pdfgenerate(widget.diary['title'],widget.diary['content']);
              PdfApi.openFile(pdfFile);
            },
                icon: Icon(Icons.save,color: Colors.white))
          ],
          leading: IconButton(onPressed: ()=> Navigator.of(context).pop(), icon: Icon(Icons.arrow_back_ios,color: Colors.white)),
          backgroundColor : HexColor("#25262d"),
          elevation: 0,
          // title: Text("Diary Detail",style: TextStyle(color: Colors.white)),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Text(widget.diary["day"],style: TextStyle(color: Colors.grey,fontSize: 14,fontFamily: 'Product Sans')),
                      SizedBox(width: 2),
                      Text(widget.diary["month"]+" 2023 ",style: TextStyle(color: Colors.grey,fontSize: 14,fontFamily: 'Product Sans')),
                      VerticalDivider(
                        color: Colors.grey,
                        thickness: 2,indent: 2,endIndent: 3,
                      ),
                      SizedBox(width: 3),
                      Text(widget.diary["time"],style: TextStyle(color: Colors.grey,fontSize: 14,fontFamily: 'Product Sans')),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Text(widget.diary['title'],textAlign: TextAlign.left,style:
                TextStyle(fontFamily: 'Recoleta',fontSize: 20,fontWeight: FontWeight.w700,color: HexColor("#25262d"))),
                SizedBox(height: 10),
                Text(widget.diary['content'],textAlign: TextAlign.justify,style:
                TextStyle(fontFamily: 'Recoleta',fontSize: 15,color: HexColor("#25262d"))),

              ],
            ),
          ),
        )
      );
  }

  Future<void> send () async
  {
    await Share.share('${widget.diary['title']}\n\n${widget.diary['content']}');
  }



}

