import 'package:flutter/material.dart';
import 'package:galaxies_http_api_app/details_page.dart';
import 'package:galaxies_http_api_app/user_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<User>> futureUsers;

  @override
  void initState() {
    super.initState();
    futureUsers = UserService().getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('People Page'),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            var users = await UserService().getUser();
            setState(() {
              futureUsers = Future.value(users);
            });
          },
          child: Center(
            child: FutureBuilder<List<User>>(
              future: futureUsers,
              builder: ((context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      User user = snapshot.data?[index];
                      return Padding(
                        padding: EdgeInsets.fromLTRB(12, 2, 12, 2),
                        child: Card(
                          child: ListTile(
                            title: Text(user.email),
                            subtitle: Text(user.name.first),
                            trailing: const Icon(Icons.chevron_right_outlined),
                            onTap: (() => {openPage(context, user)}),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 4,
                      );
                    },
                    itemCount: snapshot.data!.length,
                  );
                } else if (snapshot.hasError) {
                  return Text('data failed to load ${snapshot.error}');
                }
                return const CircularProgressIndicator();
              }),
            ),
          ),
        ));
  }

  openPage(context, User user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsPage(
          user: user,
        ),
      ),
    );
  }
}


// ListView.builder(
//         itemCount: items.length,
//         itemBuilder: (context, index) {
//           final item = items[index];
//           return ListTile(
//             title: Text('Item $item'),
//             subtitle: const Text('my subtitle'),
//             onTap: () => openPage(context),
//             trailing: const Icon(Icons.chevron_right_outlined),
//           );
//         },
//       ),

