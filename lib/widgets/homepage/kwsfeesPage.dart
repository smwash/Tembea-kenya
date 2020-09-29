import 'package:flutter/material.dart';
import '../../shared/categoryAppbar.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';

class KwsEntryFeesPg extends StatefulWidget {
  @override
  _KwsEntryFeesPgState createState() => _KwsEntryFeesPgState();
}

class _KwsEntryFeesPgState extends State<KwsEntryFeesPg> {
  bool _isLoading = false;
  PDFDocument _doc;
  @override
  void initState() {
    _loadPdf();
    super.initState();
  }

  _loadPdf() async {
    try {
      setState(() => _isLoading = true);
      final doc = await PDFDocument.fromAsset('assets/images/kwsfees.pdf');
      setState(() {
        _doc = doc;
        _isLoading = false;
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: categoryAppBar(context: context, title: 'KWS Entry Park Fees'),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : PDFViewer(
              document: _doc,
            ),
    );
  }
}
