import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task/models/user_model.dart';
import 'package:task/style/app_colors.dart';
import 'package:task/views/widgets/home_screen_widgets/menu_button_widget.dart';

class MarksScreen extends StatefulWidget {
  const MarksScreen({super.key});

  @override
  State<MarksScreen> createState() => _MarksScreenState();
}

class _MarksScreenState extends State<MarksScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [MenuButtonWidget(mediaQuery: mediaQuery)],
      ),
      body: Stack(
        children: [
          const SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Image(
              image: AssetImage('assets/images/home.png'),
              fit: BoxFit.fill,
            ),
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .orderBy('score', descending: true)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView(
                children: snapshot.data!.docs.map((document) {
                  return Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: mediaQuery.width / 30,
                        vertical: mediaQuery.height / 100),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      color: document.id == UserModel.id
                          ? Colors.amber
                          : Colors.white,
                    ),
                    child: ListTile(
                      title: Text(
                        document.id == UserModel.id ? 'You' : document['email'],
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(
                        'Score: ${document['score']}',
                        style: TextStyle(
                            color: AppColors.main, fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
