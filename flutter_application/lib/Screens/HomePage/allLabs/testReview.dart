//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/cupertino.dart';

import 'dart:io';

import 'booking/bookingScreen.dart';

class testReport extends StatefulWidget {
  

  @override
  testReportState createState() => testReportState();

}

class testReportState extends State<testReport> {
   int _value=0;
  //final _visit ={"Home visit","Lab visit"};
   //var male = "1";
 // String gender = "male";
 // String groupValue='value';
 // String _selectedVisit = 'Lab';
  TextEditingController _date = TextEditingController(); 
  //TimeOfDay time;
  //TimeOfDay picked;
   
  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:Text('Review Test',
     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25 ,
      fontFamily: 'Raleway')
          ),
          centerTitle: true,
     backgroundColor : AppColors.mainColor, 
  ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(padding: EdgeInsets.only(bottom:7)),
          Row(
            
            children: [
           
               Container(
                  padding: EdgeInsets.only(top: 5,left: 13),
                  height: 50,
                  width: 385,
                  decoration: BoxDecoration(
                  color:Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                     boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 137, 123, 163).withOpacity(0.1),
                    blurRadius: 5.0,
                    offset: Offset(3, 3),
                    spreadRadius: 1,

                  ),
                ],
              ),

             
        
             child : Row(
              children: <Widget>[
              Text('Test Name :',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16 , fontFamily: 'Raleway',color: Colors.black)),
              

            SizedBox(width: 6 ),
            Expanded(child: 
            Text ('kjndksjcnkadjcnkdlvkdfopvk',style: TextStyle(fontSize: 16 , fontFamily: 'Raleway',color: Colors.black)
             ) )
             
                  ]      )
               ),
            ]
            
              ),
            
            
         
      Padding(padding: EdgeInsets.only(bottom:7)),
          Row(
            children: [
                 Container(
                  padding: EdgeInsets.only(top: 5,left: 13),
                  height: 50,
                  width: 385,
                  decoration: BoxDecoration(
                  color:Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
       boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 137, 123, 163).withOpacity(0.1),
                    blurRadius: 5.0,
                    offset: Offset(3, 3),
                    spreadRadius: 1,

                  ),
                ],
              ),
              child : Row(
              children: <Widget>[
              Text('Dr Name :',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16 , fontFamily: 'Raleway',color: Colors.black)),
              

            SizedBox(width: 6 ),
            Expanded(child: 
            Text ('kjndksjjhcxvbzdjhfvzdkfv',style: TextStyle(fontSize: 16 , fontFamily: 'Raleway',color: Colors.black)
             ) )
             
                  ]      )

              
              ),
            ],
          ),


          Padding(padding: EdgeInsets.only(bottom:7)),
          Row(
            children: [
                 Container(
                  padding: EdgeInsets.only(top: 5,left: 13),
                  height: 130,
                  width: 385,
                  decoration: BoxDecoration(
                  color:Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                   boxShadow: [
                     BoxShadow(
                    color: Color.fromARGB(255, 137, 123, 163).withOpacity(0.1),
                    blurRadius: 5.0,
                    offset: Offset(3, 3),
                    spreadRadius: 1,

                  ),
                   ]
              ),
                  child : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
              Text('About the test :',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16 , fontFamily: 'Raleway',color: Colors.black)),
              

            SizedBox(width: 6 ),
            Expanded(child: 
            Text ('kjndksjcnkadjcnkdlvkdfhhhhghvgfcfcddrfchhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhopvk', maxLines: 10,style: TextStyle(fontSize: 16 , fontFamily: 'Raleway',color: Colors.black)
             ) 
            )
                  ]      )

              
              ),
            ],
          ),
         
           Padding(padding: EdgeInsets.only(bottom:7)),
          
           Padding(padding: EdgeInsets.only(bottom:7)),
          Row(
            children: [
                 Container(
                  padding: EdgeInsets.only(top: 5,left: 13),
                  height: 30,
                  width: 385,
                  decoration: BoxDecoration(
                  color:Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                   boxShadow: [
                     BoxShadow(
                    color: Color.fromARGB(255, 137, 123, 163).withOpacity(0.1),
                    blurRadius: 5.0,
                    offset: Offset(3, 3),
                    spreadRadius: 1,

                  ),
                   ]
              ),
                 child : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
              Text('Total Amount Payable :',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16 , fontFamily: 'Raleway',color: Colors.black)),
              

            SizedBox(width: 6 ),
          
            Text ('30' +'₪', maxLines: 10,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16 ,color: Colors.black)
             ) 
            
                  ]      )
              
              ),
            ],
          ),
           Padding(padding: EdgeInsets.only(bottom:240)),
          Row(
            children: [
               Container(
              
            margin: EdgeInsets.only(left: 30,right: 30),
             //padding:EdgeInsets.only(top:8),
              width: 310,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.circular(25),
               boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 196, 162, 255).withOpacity(0.1),
                    blurRadius: 5.0,
                    offset: Offset(3, 3),
                    spreadRadius: 1,

                  ),
                ],
              ),
                padding: const EdgeInsets.all(14),
                          alignment: Alignment.center,
    child :  InkWell(
             child: Text('Place Order',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22 , fontFamily: 'Raleway',color: Colors.white), 
           textAlign: TextAlign.center,),
           
             onTap:() {
         Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MovieBookingScreen()));
        // print('ffff');
        } ,
           
           ),
           
           )
            ],
          ),
             
        
         
      
        ]
      ),
      
      );
    
  }
}
class AppColors {

  static final Color mainColor = Color.fromARGB(255, 133, 73, 188);
  static final Color backgroundColor = Color.fromARGB(255, 255, 255, 255);
}