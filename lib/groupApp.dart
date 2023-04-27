import 'package:flutter/material.dart';
import 'package:newtask/ProvidernNum.dart';

import 'ProviderAuth.dart';
import 'package:provider/provider.dart';

import 'package:toast/toast.dart';



class groupApp extends StatefulWidget {


  @override
  State<groupApp> createState() => _groupAppState();
}

class _groupAppState extends State<groupApp> {
bool STB;
  @override
  Widget build(BuildContext context) {
Provider.of<ProviderNum>(context,listen: false).fetchdata(true);
STB = Provider.of<ProviderNum>(context,listen: false).StateButton;
    return Consumer<ProviderAuth>(
        builder: (ctx, value, child){
value.getnum();
  return  Scaffold(
    appBar: AppBar(
      title:Text(" ${value.numberusers} members",style: TextStyle(fontSize: 20),),
  leading: 
    IconButton(icon: Icon(Icons.login_outlined),onPressed: ()=>value.longout() ,),),

      
    
body:
  Container(
    child: Align(
  alignment:STB?Alignment.topCenter : Alignment.center,
      child: ElevatedButton(
  child:Text(STB?"leave Group": "Join Group") ,
  onPressed:()async{ 


    if (STB==true )   
      { 
          Provider.of<product>(context,listen: false).updatefav(value.t, value.usId,STB).then((value1) {
        if(value1)
        {value.number_user_decrement();}
       
    Provider.of<ProviderNum>(context,listen: false).fetchdata(true);

      });}
else
{
        value.getnum();     
if( value.numberusers > 2)
 {ToastContext().init(context);
                                  
Toast.show("Can't add more than 3 users Please wait while someone checks out",
duration: 5,
gravity: Toast.top,
backgroundColor: Colors.black,
backgroundRadius: 4,
textStyle: TextStyle(color: Colors.white));
                                  
                                  }
else
{
   Provider.of<product>(context,listen: false).updatefav(value.t, value.usId,STB).then((value1) {
    if(value1)
        {value.number_user_inrement();}
  
    Provider.of<ProviderNum>(context,listen: false).fetchdata(true);
      
        });
        
        }
        } },),
    ),
    
    
    
      ),
   );
   }
);    

  }
}


