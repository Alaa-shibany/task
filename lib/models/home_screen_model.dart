import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task/models/user_model.dart';

class HomeScreenModel {
  final firestore = FirebaseFirestore.instance;

  Stream<int> getUserScore() {
    final userDoc = firestore.collection('users').doc(UserModel.id);
    return userDoc.snapshots().map((snapshot) => snapshot.data()!['score']);
  }

  void incrementScore(int score) async {
    await firestore.runTransaction(
      (transaction) async {
        final userDoc = firestore.collection('users').doc(UserModel.id);
        final docSnapshot = await transaction.get(userDoc);
        final newScore = docSnapshot.data()!['score'] + score;
        transaction.update(userDoc, {'score': newScore});
      },
    );
  }
}
