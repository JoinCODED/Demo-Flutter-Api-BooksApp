import 'package:books_app/models/book.dart';
import 'package:books_app/providers/books_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class BookCard extends StatelessWidget {
  final Book book;
  const BookCard({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Image.network(
                book.image,
                fit: BoxFit.fill,
                height: 150,
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  ListTile(
                    title: Text(book.title),
                    // subtitle: Text(book.description),
                    trailing: Chip(
                      label: Text("${book.price} KWD"),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {
                            GoRouter.of(context).push('/update/${book.id}');
                          },
                          icon: const Icon(Icons.edit)),
                      IconButton(
                          onPressed: () {
                            Provider.of<BooksProvider>(context, listen: false)
                                .deleteBook(book.id!);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ))
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
