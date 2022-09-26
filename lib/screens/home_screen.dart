import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(
          Icons.menu,
          color: Colors.black,
        ),
        title: Text(
          'Movies'.toUpperCase(),
          style: Theme.of(context).textTheme.caption!.copyWith(
                color: Colors.black45,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Muli',
              ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(
              right: 15,
            ),
            child: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/logo.jpg'),
            ),
          )
        ],
      ),
      body: Center(
        child: Text('This is movie app'),
      ),
    );
  }
}
