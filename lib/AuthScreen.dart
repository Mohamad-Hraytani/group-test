import 'package:flutter/material.dart';


import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ProviderAuth.dart';


class AuthScreen extends StatefulWidget {
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var islood = true;
  final GlobalKey<FormState> ke = GlobalKey();
  final price = FocusNode();
  final confprice = FocusNode();
  var emailco = '';
  var passco = '';
  var conpassco = '';
  var islog = true;
  double b = -5.0;
  double n = 0.0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [Colors.purple.withOpacity(0.4), Colors.white],
            )),
            child: Center(
              child: AnimatedContainer(
                onEnd: () {
                  setState(() {
                    b = 0.0;
                    n = 0.0;
                  });
                },
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 1,
                        color: Colors.white,
                        offset: Offset(1, n == 0 ? 0 : 50))
                  ],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                ),
                duration: Duration(seconds: 1.5.toInt()),
                curve: Curves.linear,
                height: islog ? 275 : 250,
                width: 320,
                alignment: islog ? Alignment(n, n) : Alignment(-b, b),
                child: Container(
                  padding: EdgeInsets.only(top: 10),
                  width: 300,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 1,
                            color: Colors.purple.withOpacity(0.4),
                            offset: Offset(1, 5))
                      ],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  child: Form(
                      key: ke,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(),
                                decoration: InputDecoration(
                                  suffixText: "@gmail.com",
                                  prefixIcon: Icon(Icons.alternate_email_sharp),
                                  contentPadding: EdgeInsets.all(5),
                                  labelText: 'Enter Your Email ',
                                ),
                                validator: (value) {
                                  if (value.isEmpty )
                                    return 'Please Enter a correct value';
                                  else
                                    return null;
                                },
                                onSaved: (b) async {
                                  emailco = '${b.toString()}@gmail.com';
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setString('email', b);
                                },
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context).requestFocus(price);
                                }),
                            TextFormField(
                        
                                style: TextStyle(),
                                obscureText: true,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.security),
                                  contentPadding: EdgeInsets.all(5),
                                  labelText: 'Enter Your password',
                                ),
                                validator: (value) {
                                  if (value.isEmpty )
                                    return 'Please Enter a correct value';
                                  else
                                    return null;
                                },
                                onSaved: (b) {
                                  passco = b.toString();
                                },
                                focusNode: price,
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(confprice);
                                }),
                            islog
                                ? TextFormField(
                                    enabled: islog ? true : false,
                                    style: TextStyle(),
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.spellcheck_sharp),
                                      contentPadding: EdgeInsets.all(5),
                                      labelText: 'Enter Your same Password',
                                    ),
                                    validator: (value) {
                                      if (value != passco) {
                                        return 'your password is not corecct';
                                      }
                                      if (value.isEmpty )
                                        return 'Please Enter a correct value';
                                      else
                                        return null;
                                    },
                                    focusNode: confprice,
                                  )
                                : Container(),
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              decoration: BoxDecoration(
                                  color: Colors.purple.withOpacity(0.4),
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(30),
                                      topRight: Radius.circular(30))),
                              child: 
                                Consumer<ProviderAuth>(
        builder: (ctx, valueAuth, child){
                               return TextButton(
                                    onPressed: () {                       
                                      setState(() {
                                        islood = false;
                                      });
                                      ke.currentState.validate();
                                      ke.currentState.save();
                                      if (ke.currentState.validate()) {
                                       if (islog)
                                             Provider.of<ProviderAuth>(context,
                                                    listen: false)
                                                .signIn(emailco, passco, context)
                                                .then((value) => setState(() {
                                                      islood = true;
                                                    }));
                                            else
                                           {
                                             
                                 
                                            Provider.of<ProviderAuth>(context,
                                                    listen: false)
                                                .signUp(emailco, passco, context)
                                                .then((value) => setState(() {
                                 
                                             
                                                      islood = true;
                                                    }));
                                           
                                                     
                                           }
                                      }
                                     },
                                 
                                    child:
                                        islog ? Text('SingIn') : Text('Regester'),
                                                                 );})
                                 ),
                            
                      
                            islood
                                ? TextButton(
                                    onPressed: () {
                                      setState(() {
                                        islog = !islog;
                                        n = -5.0;
                                        b = -5.0;
                                      });
                                    },
                                    child: islog
                                        ? Text('Create account')
                                        : Text('SingIn'),
                                  )
                                : CircularProgressIndicator()
                          ],
                        ),
                      )),
                ),
              ),
            )));
  }
}
