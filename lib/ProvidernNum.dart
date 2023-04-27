import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class product with ChangeNotifier {
  bool isfav;

  bool get getisfav {
    return isfav;
  }



  void _setval(bool newval) {
    isfav = newval;
    notifyListeners();
  }



  Future<bool> updatefav(String t, String usId , bool STB) async {
isfav =STB;
  notifyListeners();

    final oldfav = isfav;
    isfav = !isfav;
    notifyListeners();



    final n0 = Uri.parse(
        "https://taskgroup-6cc7d-default-rtdb.firebaseio.com/userfav/$usId.json?auth=$t");

    try {
      final res = await http.put(n0, body: jsonEncode(isfav));


if(res.statusCode == 200){
    try {
      final n1 = Uri.parse(
          "https://taskgroup-6cc7d-default-rtdb.firebaseio.com/userfav/$usId.json?auth=$t");
      final resva1 = await http.get(n1);
      final resva = jsonDecode(resva1.body);
if(resva == isfav)
return true;

else 
return false;

    } catch (e) {
      return false;
   
    }
} 


else if (res.statusCode >= 400) 
{
      _setval(oldfav);
return false;
}

else return false;


    } catch (e) {
      _setval(oldfav);
      return false;
    }
  }
}

class ProviderNum with ChangeNotifier {
  String authtoken;
  String userId;
  bool StateButton =false;



  getdata(String token, String usID) {
    authtoken = token;
    userId = usID;
    notifyListeners();
  }

  

  Future<bool> fetchdata([bool filter]) async {

    try {
      final n1 = Uri.parse(
          "https://taskgroup-6cc7d-default-rtdb.firebaseio.com/userfav/$userId.json?auth=$authtoken");
      final resva1 = await http.get(n1);
      final resva = jsonDecode(resva1.body);


StateButton = resva ;
notifyListeners();
print(resva);
return resva;
    } catch (e) {
      print(e);
      throw e;
    }
  }




}
