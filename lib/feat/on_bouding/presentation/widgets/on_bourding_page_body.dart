import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intern_hup/core/constant/app_color.dart';
import 'package:intern_hup/core/constant/images_app.dart';
import 'package:gap/gap.dart';
import 'package:intern_hup/core/helper/app_router.dart';

class OnBourdingPageBody extends StatelessWidget {
  const OnBourdingPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [ 
          Image.asset(ImagesApp.OnBording,height: 300,width: 300,)  ,

          Gap(30) ,
          Text("Discover intership that mater " , style: TextStyle(
            color: Colors.black , 
            fontSize: 20 , 
            fontWeight: FontWeight.bold , 
          ), ), 

          Gap(10) , 

          Text("Explore opportunities with top companies" , style: TextStyle(
            color: Colors.black , 
            fontSize: 14 ,
            fontWeight: FontWeight.w400 , 
          ), ),  

          Gap(30) ,  

          CircleAvatar(
            radius: 20 , 
            backgroundColor: AppColors.primColor , 
            child: IconButton(
              onPressed: (){

                context.go(AppRouter.loginRoute) ;
              }
              , icon: Icon(Icons.arrow_forward , color: Colors.white , ) , 
          ) ,  
          ) ,



          
        ],
      ),
    );
  }
}