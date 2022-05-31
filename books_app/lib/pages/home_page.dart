import 'package:books_app/providers/books_provider.dart';
import 'package:books_app/providers/user_provider.dart';
import 'package:books_app/widgets/book_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Store"),
      ),
      body: SingleChildScrollView(
          child: Consumer<UserProvider>(
        builder: (context, userProvider, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            userProvider.isAuths
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        userProvider.logout();
                      },
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        //${userProvider.user.username}
                        child: Text("LOGOUT "),
                      ),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            GoRouter.of(context).push('/signup');
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text("Sign up"),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            GoRouter.of(context).push('/signin');
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text("Sign in"),
                          ),
                        ),
                      ),
                    ],
                  ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  GoRouter.of(context).push('/add');
                },
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text("Add a new Book"),
                ),
              ),
            ),
            FutureBuilder(
              future:
                  Provider.of<BooksProvider>(context, listen: false).getBooks(),
              builder: (context, dataSnapshot) {
                if (dataSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (dataSnapshot.error != null) {
                    return const Center(
                      child: Text('An error occurred'),
                    );
                  } else {
                    return Consumer<BooksProvider>(
                      builder: (context, booksProvider, child) =>
                          ListView.builder(
                              shrinkWrap: true,
                              physics:
                                  const NeverScrollableScrollPhysics(), // <- Here
                              itemCount: booksProvider.books.length,
                              itemBuilder: (context, index) =>
                                  BookCard(book: booksProvider.books[index])),
                    );
                  }
                }
              },
            ),
          ],
        ),
      )),
    );
  }
}
