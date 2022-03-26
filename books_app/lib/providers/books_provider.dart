import 'package:books_app/services/books.dart';
import 'package:books_app/models/book.dart';
import 'package:flutter/material.dart';

class BooksProvider extends ChangeNotifier {
  List<Book> books = [];

  Future<void> getBooks() async {
    books = await DioClient().getBooks();
    notifyListeners();
  }

  Future<void> createBook(Book book) async {
    Book newBook = await DioClient().createBook(book: book);
    books.insert(0, newBook);
    notifyListeners();
  }

  Future<void> updateBook(Book book) async {
    Book newBook = await DioClient().updateBook(book: book);
    int index = books.indexWhere((book) => book.id == newBook.id);
    books[index] = newBook;
    notifyListeners();
  }

  Future<void> deleteBook(int bookId) async {
    await DioClient().deleteBook(bookId: bookId);
    books.removeWhere((book) => book.id == bookId);
    notifyListeners();
  }
}
