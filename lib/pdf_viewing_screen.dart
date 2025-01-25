// lib/views/pdf_viewing_screen.dart
import 'package:flutter/material.dart';
import 'package:pdf_reader_app/pdf_model.dart';
import 'package:pdf_reader_app/pdf_view_model.dart';
import 'package:provider/provider.dart';

class PDFViewingScreen extends StatelessWidget {
  final PDFModel pdf;
  const PDFViewingScreen({super.key, required this.pdf});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PDFViewModel>(
      create: (_) => PDFViewModel(),
      child: Scaffold(
        appBar: AppBar(title: Text(pdf.title)),
        body: Column(
          children: [
            Consumer<PDFViewModel>(
              builder: (context, viewModel, _) {
                if (viewModel.pdfTextContent.isEmpty) {
                  viewModel.fetchPDFContent(pdf.filePath);
                  return Center(child: CircularProgressIndicator());
                }

                return Text(viewModel.pdfTextContent);
              },
            ),
            ElevatedButton(
              onPressed: () {
                // Break the PDF content into chunks
                context.read<PDFViewModel>().breakContentIntoChunks(
                    context.read<PDFViewModel>().pdfTextContent);
              },
              child: Text("Break Into Chunks"),
            ),
          ],
        ),
      ),
    );
  }
}
