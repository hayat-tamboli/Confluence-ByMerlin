import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:merlin/utils/Constants.dart';

class HackathonServices {
  addHackertoRoom(String id) {
    FirebaseFirestore.instance.collection("hackathon").doc(id).update({
      'playersId': FieldValue.arrayUnion([Constants.prefs.getString('userId')]),
    });
  }

  getHackerIds(String id) {
    FirebaseFirestore.instance
        .collection("hackathon")
        .doc(id)
        .get()
        .then((querySnapshot) {
      return querySnapshot[0]['playersId'];
    });
  }
}
