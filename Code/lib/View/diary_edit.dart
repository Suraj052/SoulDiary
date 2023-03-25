
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../ViewModel/provider.dart';


class EditDiary extends StatefulWidget {
  final Map<String,dynamic> diary;
  const EditDiary({required this.diary,Key? key}) : super(key: key);

  @override
  State<EditDiary> createState() => _EditDiaryState();
}

class _EditDiaryState extends State<EditDiary> {

  TextEditingController titlecontroller = TextEditingController();
  TextEditingController contentcontroller = TextEditingController();

  @override
  void initState()
  {
    super.initState();
    titlecontroller.text = widget.diary['title'];
    contentcontroller.text = widget.diary['content'];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final provider = Provider.of<DiaryProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("#25262d"),
        leading: IconButton(onPressed: ()=> Navigator.of(context).pop(), icon: Icon(Icons.arrow_back_ios,color: Colors.white)),
        actions: [
          IconButton(
              onPressed: () {

                final String title =  titlecontroller.text.toString();
                final String content= contentcontroller.text.toString();
                if(titlecontroller.text.toString()=="" || contentcontroller.text.toString()=="")
                {
                  showToast("Empty Fields!");
                }
                else
                {
                  provider.updateDiary(widget.diary['id'],title, content);
                  Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
                }
              },
              icon: Icon(Icons.check_circle_rounded)
          )
        ],
        title: Center(child: Text(' Edit your page ! ',style: TextStyle(fontFamily: 'Product Sans',color: Colors.white,fontSize: 15))),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: size.width*0.5,
                      child: Row(
                          children: [
                            Text(DateFormat.d().format(DateTime.now()),style: TextStyle(fontSize: 45,fontFamily: 'Product Sans',color: Colors.black87)),
                            SizedBox(width: 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(DateFormat('EEEE').format(DateTime.now()),style: TextStyle(fontSize: 15,fontFamily: 'Product Sans',color: Colors.black45)),
                                Text(DateFormat('MMMM yyyy').format(DateTime.now()),style: TextStyle(fontSize: 15,fontFamily: 'Product Sans',color: Colors.black45)),
                              ],
                            )
                          ]
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Time",style: TextStyle(fontSize: 15,fontFamily: 'Product Sans',color: Colors.black45)),
                        Text(DateFormat.jm().format(DateTime.now()),style: TextStyle(fontSize: 15,fontFamily: 'Product Sans',color: Colors.black87)),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
              TextField(
                style: TextStyle(fontFamily: 'Recoleta',fontSize: 20,fontWeight: FontWeight.w700,color: HexColor("#25262d")),
                textAlign: TextAlign.justify,
                controller: titlecontroller,
                maxLines: 1,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Edit your title..."
                ),
              ),
              TextField(
                style: TextStyle(fontFamily: 'Recoleta',fontSize: 17,color: HexColor("#25262d")),
                textAlign: TextAlign.justify,
                controller: contentcontroller,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: "Edit your diary...",
                  border: InputBorder.none,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void showToast(String text) => Fluttertoast.showToast
  (
  msg: text,
  fontSize: 13.0,
  backgroundColor: Colors.black,
  textColor: Colors.white,
  gravity: ToastGravity.BOTTOM,
);
