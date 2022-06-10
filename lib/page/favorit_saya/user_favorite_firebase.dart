import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  static CollectionReference userfavoriteCollection = FirebaseFirestore.instance.collection('user_favorite');

  static Future<void> AddUserFavorite({String? user_email, int? movie_id, String? status})
async {
  await FirebaseFirestore.instance
    .collection('user_favorite')
    .add({'user_email' : 'ria@gmail.com', 
          'movie_id' : 1,
         'status' : 'Kamu sudah memberikan review'});
  }

  static Future<void> UpdateUserFavorite({String? user_email, int? movie_id}) async{
    await FirebaseFirestore.instance.collection('user_favorite').doc(user_email).set({
      'user_email' : user_email,
      'movie_id' : movie_id
    });
  }
}
