
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ViewModel/provider.dart';
import 'diary_detail.dart';
import 'diary_widget.dart';

class DiaryList extends StatefulWidget {
  const DiaryList({Key? key}) : super(key: key);

  @override
  State<DiaryList> createState() => _DiaryListState();
}

class _DiaryListState extends State<DiaryList> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<DiaryProvider>(
        builder: (context,value,child)
            {
              if(value.isLoading)
                {
                  return const Center( child: CircularProgressIndicator(color: Colors.black54));
                }
              final data = value.diaryList;

              return data.isEmpty?
                  Container(
                      height: size.height*0.7,
                      child:
                      Center(
                        child: Text(
                          'Please write your first Diary',
                          style: TextStyle(fontSize: 17),
                        ),
                      )
                  ):
              ListView.separated(
                physics: BouncingScrollPhysics(),
                separatorBuilder: (context, index)=>Container(height: 1),
                itemCount: data.length,
                itemBuilder: (context,index)
                {
                  final diary = data[index];
                  return GestureDetector(
                      onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DiaryDetail(diary: diary))),
                      child: DiaryWidget(diary: diary));
                },

              );

            }
    );
  }
}
