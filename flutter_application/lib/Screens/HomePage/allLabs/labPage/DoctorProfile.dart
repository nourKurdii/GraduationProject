import 'dart:math';

import 'package:flutter/material.dart';

class DoctorProfile extends StatefulWidget {



  @override
  DoctorProfileState createState() => DoctorProfileState();
}

class DoctorProfileState extends State<DoctorProfile> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: AppBar(   
     backgroundColor : AppColors.mainColor, 
  ),
          body: Column(
 children: <Widget>[
   Padding(padding: EdgeInsets.only(top: 45)),
  Row(
children: <Widget>[

  
   Container(
margin: EdgeInsets.only(left: 90,right: 80),
                       width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,),
                              
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.1),
                                offset: Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/images/doctor.png")
                              
                          ),
  ),
                
  
                 //Padding(padding: EdgeInsets.only(top: )),
             //   Row(
               // children :[
                     child: Container( 
                  padding: EdgeInsets.only(left: 130,top: 135),
                      child :
                        Icon(Icons.chat,
                      color:AppColors.mainColor,size: 42,)
                     )
                //]
                 //   )
                 ),
  
  ]
                ),
 

            
                 Padding(padding: EdgeInsets.only(top: 40)),
                 Container(
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
              child:   Row(
                  children:<Widget> [
                    Row(
                     children: <Widget>[
                     SizedBox(width: 20,),

                       Text('Dr Name :',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18 , fontFamily: 'Raleway',color: Colors.black)),
                     ], 
                    ),
              
                    Row(
                     children: <Widget>[
                       SizedBox(width: 20,),
                       Text('the name',style: TextStyle( fontSize: 18 , fontFamily: 'Raleway',color: Colors.black)),
                     ], 
                    )

                  ],
                )),
                 SizedBox(height: 5),
                Container(
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
              child:   Row(
                  children:<Widget> [
                 
                   
                     SizedBox(width: 20,),

                       Text('E-Mail :',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18 , fontFamily: 'Raleway',color: Colors.black)),
                      
                     SizedBox(width: 20,),


                  
                      Expanded(
                      child: Text('Dana.abushaqdam106@gmail.com',style: TextStyle( fontSize: 18 , fontFamily: 'Raleway',color: Colors.black)),
                    )], 
                    )

                  
                ),

                SizedBox(height: 5),
                Container(
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
              child:   Row(
                  children:<Widget> [
                 
                   
                     SizedBox(width: 20,),

                       Text('Phone Number :',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18 , fontFamily: 'Raleway',color: Colors.black)),
                      
                     SizedBox(width: 20,),


                  
                      Expanded(
                      child: Text('08963258',style: TextStyle( fontSize: 18 , color: Colors.black)),
                    )], 
                    )

                  
                ),
                SizedBox(height: 5),
                Container(
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
              child:   Row(
                  children:<Widget> [
                 
                   
                     SizedBox(width: 20,),

                       Text('Lab work in :',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18 , fontFamily: 'Raleway',color: Colors.black)),
                      
                     SizedBox(width: 20,),


                  
                      Expanded(
                      child: Text('Lab NAME',style: TextStyle( fontSize: 18 , fontFamily: 'Raleway',color: Colors.black)),
                    )], 
                    )

                  
                )
                ]
                ),
                
              
                  

          
              
        
           
           
    
        
      
        
          
          
         

  
 bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(label: "",icon: Icon(Icons.arrow_back,color: Colors.grey,)),
        BottomNavigationBarItem(label: "",icon: Icon(Icons.home_max)),

       // BottomNavigationBarItem(label: "",icon: Icon(Icons.arrow_forward,color: Colors.grey,))

      ]
      ),
    );
  }
}

class AppColors {

  static final Color mainColor = Color(0XFF6F36A5);
  }