import 'package:eamar_delivery/utill/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotFound404Error extends StatelessWidget {
  final String? errorMssage;
  final Function()? onRefresh;
  const NotFound404Error({Key? key, this.errorMssage, this.onRefresh}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
          Images.notFoundImage,
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height/4,
            // width: MediaQuery.of(context).size.width/4,
          ),
            
             Positioned(
              bottom: 170,
              left: 30,
              
              child: Text(
                errorMssage!,
                
                style: const TextStyle(
                  color: Colors.black,

                ),
                textAlign: TextAlign.start,
              ),
            ),
            Positioned(
              bottom: 100,
              left: 30,
              // : 250,
              child: 
              TextButton(
                onPressed: onRefresh,
                child:  Center(child: Text(
                       Get.locale!.languageCode=="ar"?

                        "تحديث":
                  
                  
                  'Refresh',  
                
                style: TextStyle(
                  color: Theme.of(context).primaryColor
                ),
                
                ),),
              )
              
              
              
             
            ),
          ],
        ),
      ),
    );
  }
}