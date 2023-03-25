import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class PdfApi
{
  static Future<File> pdfgenerate (String title, String content) async
  {
    final pdf = Document();
    pdf.addPage(
        MultiPage(
        build : (context) => <Widget>
            [
              customHeader(title),
              Paragraph(text: content)
        ],
          footer: (context)
            {
              final text = 'Page ${context.pageNumber} of ${context.pagesCount}';
              return Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(top: 1*PdfPageFormat.cm),
                  child:Text(text));
            }
    ));
    return saveDocument(name:'${title}.pdf',pdf:pdf);
  }

  static Widget customHeader(String title) => Header(
    padding: EdgeInsets.only(bottom: 3*PdfPageFormat.mm),
    child: Text(title,
    style: TextStyle(color: PdfColor.fromHex("#40cde8"),fontSize: 20,fontWeight: FontWeight.bold)
    )
  );

  static Future<File> saveDocument({
      required String name,
      required Document pdf}) async {
    final bytes  = await pdf.save();
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');
    await file.writeAsBytes(bytes) ;
    return file;
  }

  static Future openFile(File file) async
  {
    final url = file.path;
    await OpenFile.open(url);

  }
}