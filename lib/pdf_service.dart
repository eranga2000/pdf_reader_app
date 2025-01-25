// lib/services/pdf_service.dart
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'pdf_model.dart';

class PDFService {
  Future<List<PDFModel>> getAllPDFs() async {
    // Get the path to the device's document directory
    final directory = await getApplicationDocumentsDirectory();
    final pdfDirectory = Directory(directory.path);
    final files = pdfDirectory.listSync();

    // Filter the PDF files and return the list
    List<PDFModel> pdfList = [];
    for (var file in files) {
      if (file.path.endsWith('.pdf')) {
        pdfList.add(
            PDFModel(filePath: file.path, title: file.uri.pathSegments.last));
      }
    }
    return pdfList;
  }

  Future<String> extractTextFromPDF(String filePath) async {
    // Here you would use a PDF package like pdf or flutter_pdfview to extract text.
    // For simplicity, let's assume we return a dummy text.
    return "This is a sample content extracted from the PDF file.";
  }

  Future<List<String>> breakIntoChunks(String content) async {
    // Here, split the content into chunks (this could use AI for intelligent chunking)
    final List<String> chunks = content.split('\n');
    return chunks;
  }
}
