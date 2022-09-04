import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:twitter_ui/models/post.dart';

class PostService {
  Future savePost(text) async {
    await FirebaseFirestore.instance.collection("posts").add({
      'text': text,
      'creator': FirebaseAuth.instance.currentUser?.uid,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  List<PostModel> postListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return PostModel(
        id: doc.id,
        creator: data["creator"] ?? '',
        text: data["text"] ?? '',
        timestamp: data["timestamp"] ?? 0,
      );
    }).toList();
  }

  Stream<List<PostModel>> getPostsByUser(uid) {
    return FirebaseFirestore.instance
        .collection("posts")
        .where('creator', isEqualTo: uid)
        .snapshots()
        .map((postListFromSnapshot));
  }
}
