import 'package:books_app/pages/add_page.dart';
import 'package:books_app/pages/home_page.dart';
import 'package:books_app/pages/update_page.dart';
import 'package:books_app/providers/books_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => BooksProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
    );
  }

  final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/add',
        builder: (context, state) => AddPage(),
      ),
      GoRoute(
        path: '/update/:bookId',
        builder: (context, state) {
          final book = Provider.of<BooksProvider>(context).books.firstWhere(
              (book) => book.id.toString() == (state.params['bookId']!));
          return UpdatePage(book: book);
        },
      ),
    ],
  );
}
