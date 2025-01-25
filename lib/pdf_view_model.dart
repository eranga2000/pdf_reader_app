// lib/viewmodels/pdf_view_model.dart
import 'package:flutter/material.dart';
import 'package:pdf_reader_app/pdf_service.dart';

class PDFViewModel extends ChangeNotifier {
  final PDFService _pdfService = PDFService();
  String _pdfTextContent = '';
  String get pdfTextContent => _pdfTextContent;

  // Fetch the PDF content
  Future<void> fetchPDFContent(String filePath) async {
    _pdfTextContent = await _pdfService.extractTextFromPDF(filePath);
    notifyListeners();
  }

  // Break PDF content into chunks
  Future<void> breakContentIntoChunks(String content) async {
    final chunks = await _pdfService.breakIntoChunks(content);
    _pdfTextContent = chunks.join('\n'); // Join the chunks with new lines
    notifyListeners();
  }
}
