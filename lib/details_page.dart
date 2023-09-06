import 'package:flutter/material.dart';
import 'package:galaxies_http_api_app/user_service.dart';

class DetailsPage extends StatelessWidget {
  final User user;

  const DetailsPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: const Text('Details Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${user.name.first} ${user.name.last}',
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 12,
            ),
            CircleAvatar(
              radius: 50,
              child: Image.network(user.picture),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(user.email),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () => goBack(context),
              child: const Text('GoBack!'),
            ),
          ],
        ),
      ),
    );
  }

  goBack(context) {
    Navigator.pop(context);
    //print('go back object pressed...');
  }
}
