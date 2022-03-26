import 'package:books_app/models/book.dart';
import 'package:books_app/widgets/update_form.dart';
import 'package:flutter/material.dart';

class UpdatePage extends StatelessWidget {
  final Book book;
  const UpdatePage({Key? key, required this.book}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update a book"),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text("Fill those field to update a book"),
            UpdateBookForm(
              book: book,
            ),
          ],
        ),
      ),
    );
  }
}
