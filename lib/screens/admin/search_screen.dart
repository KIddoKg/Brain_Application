import 'package:brain_application/data/user_data.dart';
import 'package:brain_application/models/user.dart';
import 'package:brain_application/theme_color/light_colors.dart';
import 'package:brain_application/widgets/components/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:brain_application/screens/admin/user_page.dart';

class FilterLocalListPage extends StatefulWidget {
  @override
  FilterLocalListPageState createState() => FilterLocalListPageState();
}

class FilterLocalListPageState extends State<FilterLocalListPage> {
  late List<User> users;
  String query = '';

  @override
  void initState() {
    super.initState();

    users = allUser;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: LightColors.kLightYellow,
        body: Column(
          children: <Widget>[
            buildSearch(),
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];

                  return buildUser(user);
                },
              ),
            ),
          ],
        ),
      );

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Title or Author Name',
        onChanged: searchUser,
      );

  Widget buildUser(User user) => ListTile(
      leading: Image.network(
        user.urlImage,
        fit: BoxFit.cover,
        width: 50,
        height: 50,
      ),
      title: Text(user.name),
      subtitle: Text(user.dob),
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => UserPage(user: user))));

  void searchUser(String query) {
    final users = allUser.where((user) {
      final titleLower = user.dob.toLowerCase();
      final authorLower = user.name.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower) ||
          authorLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.users = users;
    });
  }
}
