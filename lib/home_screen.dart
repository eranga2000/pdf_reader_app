// lib/views/home_screen.dart
import 'package:flutter/material.dart';
import 'package:pdf_reader_app/home_view_model.dart';
import 'package:provider/provider.dart';
import 'pdf_viewing_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (_) => HomeViewModel(),
      child: Scaffold(
        appBar: AppBar(title: Text("PDFs")),
        body: Column(
          children: [
            TextField(
              onChanged: (query) {
                // Trigger filtering when text changes
                Provider.of<HomeViewModel>(context, listen: false)
                    .filterPDFs(query);
              },
              decoration: InputDecoration(hintText: "Search PDFs..."),
            ),
            Expanded(
              child: Consumer<HomeViewModel>(
                builder: (context, viewModel, _) {
                  if (viewModel.pdfList.isEmpty) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return ListView.builder(
                    itemCount: viewModel.pdfList.length,
                    itemBuilder: (context, index) {
                      final pdf = viewModel.pdfList[index];
                      return ListTile(
                        title: Text(pdf.title), // Check for null title
                        onTap: () {
                          // Navigate to PDF viewing screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PDFViewingScreen(pdf: pdf),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
