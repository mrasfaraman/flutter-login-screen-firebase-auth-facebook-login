import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_screen/constants.dart';
import 'package:flutter_login_screen/model/user.dart';
import 'package:flutter_login_screen/services/helper.dart';
import 'package:flutter_login_screen/ui/auth/authentication_bloc.dart';
import 'package:flutter_login_screen/ui/auth/welcome/welcome_screen.dart';
import 'detail_screen.dart'; // Import the new screen

class HomeScreen extends StatefulWidget {
  final User user;

  const HomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  State createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  late User user;

  final List<Map<String, dynamic>> cardData = [
    {
      'image': 'https://i.pinimg.com/originals/13/0a/fa/130afa3cf6cda0602825b56d43538da5.png',
      'name': 'Painter',
      'rating': 4.5,
      'description': 'Express your creativity through colors and shapes. Learn the basics of painting and create your own masterpieces.',
      'videoLink': 'https://www.example.com/video1',
    },
    {
      'image': 'https://t4.ftcdn.net/jpg/02/96/39/07/360_F_296390769_oGcoHtXWpjFoSPj83d50QMNDRzSJPkK4.jpg',
      'name': 'Gardener',
      'rating': 3.8,
      'description': 'Explore the joy of gardening. Learn how to plant, nurture, and grow beautiful flowers and tasty vegetables.',
      'videoLink': 'https://www.example.com/video2',
    },
    {
      'image': 'https://www.shutterstock.com/image-vector/little-girl-hugging-baby-600nw-553555087.jpg',
      'name': 'Babysitter',
      'rating': 3.8,
      'description': 'Learn the essentials of babysitting. Understand how to take care of young children, play with them, and ensure their safety.',
      'videoLink': 'https://www.example.com/video3',
    },
    {
      'image': 'https://img.freepik.com/free-vector/cartoon-character-chef-boy-cooking-food_1308-54445.jpg?size=626&ext=jpg&ga=GA1.1.1369675164.1715731200&semt=ais_user',
      'name': 'Cooking',
      'rating': 3.8,
      'description': 'Discover the fun of cooking. Learn simple and delicious recipes that you can make at home and share with your family.',
      'videoLink': 'https://www.example.com/video4',
    },
  ];

  @override
  void initState() {
    super.initState();
    user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state.authState == AuthState.unauthenticated) {
          pushAndRemoveUntil(context, const WelcomeScreen(), false);
        }
      },
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(colorPrimary),
                ),
                child: Text(
                  'Drawer Header',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ListTile(
                title: Text(
                  'Logout',
                  style: TextStyle(
                      color: isDarkMode(context)
                          ? Colors.grey.shade50
                          : Colors.grey.shade900),
                ),
                leading: Transform.rotate(
                  angle: pi / 1,
                  child: Icon(
                    Icons.exit_to_app,
                    color: isDarkMode(context)
                        ? Colors.grey.shade50
                        : Colors.grey.shade900,
                  ),
                ),
                onTap: () {
                  context.read<AuthenticationBloc>().add(LogoutEvent());
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text(
            'Home',
            style: TextStyle(
              color: isDarkMode(context) ? Colors.grey.shade50 : Colors.grey.shade900,
            ),
          ),
          iconTheme: IconThemeData(
            color: isDarkMode(context) ? Colors.grey.shade50 : Colors.grey.shade900,
          ),
          backgroundColor: isDarkMode(context) ? Colors.grey.shade900 : Colors.grey.shade50,
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              // Display user profile info
              Center(
                child: Column(
                  children: [
                    user.profilePictureURL == ''
                        ? CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.grey.shade400,
                            child: ClipOval(
                              child: SizedBox(
                                width: 70,
                                height: 70,
                                child: Image.asset(
                                  'assets/images/placeholder.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                        : CircleAvatar(
                            radius: 35,
                            backgroundImage: NetworkImage(user.profilePictureURL),
                          ),
                    SizedBox(height: 8),
                    Text(
                      user.fullName(),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      user.email,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),
              // Display recommended section title
              Center(
                child: Column(
                  children: [
                    Text(
                      'Kids Job',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
              // Display list of cards
              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: cardData.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailScreen(
                                cardData: cardData[index],
                              ),
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                                child: Image.network(
                                  cardData[index]['image'],
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                cardData[index]['name'],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
