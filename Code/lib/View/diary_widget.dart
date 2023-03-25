
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class DiaryWidget extends StatelessWidget {
  final Map<String,dynamic> diary;
  const DiaryWidget({required this.diary,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height*0.12,
      width: size.width,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                color: HexColor("#25262d")
            ),
            width: size.width*0.20,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 25, 10, 15),
              child: Column(
                children: [
                  Text(diary['month'].toUpperCase(),style:
                  TextStyle(fontFamily: 'Product Sans',fontSize: 15,fontWeight: FontWeight.w500,color: Colors.white)),
                  SizedBox(height: 5),
                  Text(diary['day'],style:
                  TextStyle(fontFamily: 'Product Sans',fontSize: 22,fontWeight: FontWeight.bold,color: Colors.white) )
                ],
              ),
            ),
          ),
          Container(
              decoration: BoxDecoration(
                  color: HexColor("#25262d").withOpacity(0.7)
              ),
            width: size.width*0.80,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(diary['title'],textAlign: TextAlign.left,maxLines: 1,overflow: TextOverflow.ellipsis,style:
                  TextStyle(fontFamily: 'Recoleta',fontSize: 20,fontWeight: FontWeight.w700,color: Colors.white,)),
                  SizedBox(height: 8),
                  Text(diary['content'],textAlign: TextAlign.left,maxLines: 2,overflow: TextOverflow.ellipsis,style:
                  TextStyle(fontFamily: 'Recoleta',fontSize: 10,color: Colors.white) )
                ],
              ),
            ),
          )
        ],
      ),
    );




    //   Container( 6bd3c8, cbf2f1, 1bfaf5
    //   decoration: BoxDecoration(
    //     color: Colors.white,
    //     borderRadius: BorderRadius.circular(5),
    //     boxShadow: [BoxShadow(
    //       color: HexColor("#25262d"),
    //       blurRadius: 5,
    //       offset: Offset(1.0,1.0)
    //     )]
    //   ),
    //   child: Column(
    //     children: [
    //       Text(diary['title']),
    //       Text(diary['content']),
    //       Text(diary['day']),
    //       Text(diary['month']),
    //       Text(diary['time'])
    //     ],
    //   ),
    // )
  }
}
