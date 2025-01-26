// lib/viewmodels/home_view_model.dart
import 'package:flutter/material.dart';
import 'package:pdf_reader_app/pdf_model.dart';
import 'package:pdf_reader_app/pdf_service.dart';

class HomeViewModel extends ChangeNotifier {
  final PDFService _pdfService = PDFService();
  List<PDFModel> _pdfList = [];
  List<PDFModel> get pdfList => _pdfList;

  // Fetch PDFs from device
  Future<void> fetchPDFs() async {
    // Ensure you fetch only once and avoid unnecessary calls
    if (_pdfList.isEmpty) {
      _pdfList = await _pdfService.getAllPDFs();
      notifyListeners(); // Notify listeners after fetching PDFs
    }
  }

  // Filter PDFs (you can add custom filtering logic here)
  void filterPDFs(String query) {
    _pdfList = _pdfList
        .where((pdf) => pdf.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners(); // Notify listeners after filtering
  }
}
