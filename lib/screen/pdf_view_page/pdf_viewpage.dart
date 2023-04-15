import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sn_progress_dialog/options/cancel.dart';
import 'package:sn_progress_dialog/options/completed.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:http/http.dart'as http;
import 'package:path/path.dart'as path;
class PdfViewPage extends StatefulWidget {
  final String name;
  final String pdf;
  const PdfViewPage({Key? key, required this.name, required this.pdf}) : super(key: key);

  @override
  State<PdfViewPage> createState() => _PdfViewPageState();
}

class _PdfViewPageState extends State<PdfViewPage> {

  PdfViewerController? pdfViewerController;



  double _progress = 0.0;
  List<int> bytes = [];
  Future<File> _getFile(String filename) async {
    final dir = await getApplicationDocumentsDirectory();
    return File(path.join(dir.path, filename));
  }
  Future<void> downloadFile(String url, String savePath,context) async {
    ProgressDialog pd = ProgressDialog(context: context);
    const url = 'https://www.ssa.gov/oact/babynames/names.zip';
    final request = Request('GET', Uri.parse(url));
    final StreamedResponse response = await Client().send(request);

    final contentLength = response.contentLength;

    final file = await _getFile(savePath);
    response.stream.listen(
          (List<int> newBytes) {
        bytes.addAll(newBytes);
        final downloadedLength = bytes.length;
       setState(() {
         _progress= downloadedLength / contentLength!;
       });

       print(">>>>>$response");

        pd.show(
          max: 100,
          cancel: Cancel(
            cancelClicked: () {
              pd.close();
              /// ex: cancel the download
            },
          ),
          msg: "$_progress",
          completed: Completed(),
          // Completed values can be customized
          // Completed(completedMsg: "Downloading Done !", completedImage: AssetImage("images/completed.png"), completionDelay: 2500,),
          progressBgColor: Colors.transparent,
        );
        pd.update(value: _progress.toInt());

      },
      onDone: () async {

        _progress = 0;
        await file.writeAsBytes(bytes);
        pd.close();
      },
      onError: (e) {
        debugPrint(e);
        pd.close();
      },
      cancelOnError: true,
    );
    await file.writeAsBytes(bytes);
  }



  @override
  void initState() {
    pdfViewerController = PdfViewerController();
    super.initState();
  }

  OverlayEntry? overlayEntry;
  void _showContextMenu(BuildContext context,PdfTextSelectionChangedDetails details) {
    final OverlayState _overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: details.globalSelectedRegion!.center.dy - 55,
        left: details.globalSelectedRegion!.bottomLeft.dx,
        child:
        ElevatedButton(child: Text('Copy',style: TextStyle(fontSize: 17)),onPressed: (){
          Clipboard.setData(ClipboardData(text: details.selectedText));
          pdfViewerController!.clearSelection();
        }),
      ),
    );
    _overlayState.insert(overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text("${widget.name}",style: TextStyle(fontSize: 14,color: Colors.white),),
        // leading: Icon(Icons.arrow_back_ios,color: Colors.black,size: 31,),
        actions: [
          InkWell(
            onTap: (){
              pdfViewerController!.nextPage();
            },
              child: Icon(Icons.arrow_circle_down_outlined,color: Colors.white,size: 24,)),
          SizedBox(width: 10,),
          InkWell(
            onTap: (){
              pdfViewerController!.previousPage();
            },
              child: Icon(Icons.arrow_circle_up,color: Colors.white,size: 24,)),
          SizedBox(width: 10,),
          InkWell(
            onTap: ()async{
              final url = widget.pdf;
              final savePath = '${DateTime.now().microsecondsSinceEpoch}.pdf';
              await downloadFile(url, savePath,context);
            },
              child: Icon(Icons.download,color: Colors.white,size: 24,)),

        ],
      ),
      body: SfPdfViewer.network(
      '${widget.pdf}',
        onTextSelectionChanged:
            (PdfTextSelectionChangedDetails details) {
          if (details.selectedText == null && overlayEntry != null) {
            overlayEntry!.remove();
            overlayEntry = null;
          } else if (details.selectedText != null && overlayEntry == null) {
            _showContextMenu(context, details);
          }
        },
      controller: pdfViewerController,

    ),
    );
  }
}
