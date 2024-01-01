import 'dart:async';
import 'dart:math';

import 'package:eamar_delivery/controller/auth_controller.dart';
import 'package:eamar_delivery/controller/location_controller.dart';
import 'package:eamar_delivery/controller/order_controller.dart';
import 'package:eamar_delivery/controller/tracker_controller.dart';
import 'package:eamar_delivery/utill/color_resources.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';

import '../../../services/map_services.dart';

class TrackPage extends StatefulWidget {
  final int? orderId;
  final LatLng? source;
  final LatLng? destination;
  final String? title;
  const TrackPage({ Key? key, this.source, this.destination, this.title, this.orderId }) : super(key: key);

  @override
  _TrackPageState createState() => _TrackPageState();
}

class _TrackPageState extends State<TrackPage> {



final Set<Polyline>_polyline={};
final Set<Polyline>  _secondPolyline={};

final Completer<GoogleMapController>  _controller =  Completer();
CameraPosition? _cameraPosition;

List<LatLng>  polyLines=[];
Set<Marker> markers={};
LatLng? currentLocation;


final List<LatLng> _list = [
 // Point D
];


_getCurrentLocation()async{
try {
    print('-----CURRENT LOCATION ${widget.destination!.latitude}   ${widget.destination!.longitude}');

    // setState(() {
    // });
  Location location =Location();








location.getLocation().then((value) {
  print('-----CURRENT LOCATION2 ${widget.destination!.latitude}   ${widget.destination!.longitude}');

currentLocation =LatLng(
  value.latitude!
  , value.longitude!);
if (mounted) {
  setState(() {
  
});

}

_cameraPosition = CameraPosition(target: 
   currentLocation! , 

    
    );
    if (mounted) {
      setState(() {
        
      });
    }
_drawOrignalPolyLine();
});


GoogleMapController googleMapController =await  _controller
.future;


location.onLocationChanged.listen((value) {
  currentLocation =LatLng(
  value.latitude!
  , value.longitude!);
if (mounted) {
  setState(() {
  
});
}
_drawSecondPolyLine();
googleMapController.animateCamera(
  CameraUpdate.newCameraPosition(
    CameraPosition(target: 
    currentLocation!, zoom: 14.4
    )
  )
);


});

} catch (e) {
print('CURRENT LOCATION # $e');
  
}
}
loadLocation()async{

   await Get.find<LocationController>().getUserLocation();



currentLocation=
LatLng(   double.parse(Get.find<LocationController>().currentLocation.latitude .toString()),

double.parse(Get.find<LocationController>().currentLocation.longitude .toString()));
_cameraPosition
= CameraPosition(target: 

currentLocation!
);
if (mounted) {
  setState(() {
  
});
}

print('Location3 ${currentLocation!.latitude}');
_drawSecondPolyLine();
}

LatLngBounds computeBounds(List<LatLng> list) {
  assert(list.isNotEmpty);
  var firstLatLng = list.first;
  var s = firstLatLng.latitude,
      n = firstLatLng.latitude,
      w = firstLatLng.longitude,
      e = firstLatLng.longitude;
  for (var i = 1; i < list.length; i++) {
    var latlng = list[i];
    s = min(s, latlng.latitude);
    n = max(n, latlng.latitude);
    w = min(w, latlng.longitude);
    e = max(e, latlng.longitude);
  }
  return LatLngBounds(southwest: LatLng(s, w), northeast: LatLng(n, e));
}




_animateCamera()async{
          GoogleMapController  googleMapController = await _controller.future;
  
  print('_LIST LENGTH  ${_list.length}');
  
  var bounds = computeBounds(_list);




 googleMapController.animateCamera(CameraUpdate.newLatLngBounds(
bounds
  , 50));

 
}
 BitmapDescriptor? _pinDestinationMarker ;

 BitmapDescriptor? _pinSourceMarker ;
 BitmapDescriptor? _currentMarker ;


 _setMarkerIcons()async{
try {
  
// var result =await Future.wait([
//    BitmapDescriptor.fromAssetImage(
//    ImageConfiguration(),
//     "assets/icon/pin_destination.png",
// ), BitmapDescriptor.fromAssetImage(
//    ImageConfiguration(),
//     "assets/icon/pin_source.png",
// ), BitmapDescriptor.fromAssetImage(
//    ImageConfiguration(),
//     "assets/icon/pin_current.png",
// )
// ]);
 
_pinDestinationMarker =  await  BitmapDescriptor.fromAssetImage(
   const ImageConfiguration(),
    "assets/icon/pin_destination.png",
);

_currentMarker =   await  BitmapDescriptor.fromAssetImage(
   const ImageConfiguration(),
    "assets/icon/pin_current.png",
);
if (mounted) {
  print('----- ${(_pinDestinationMarker==null)}');
  setState(() {
  
});
}
} catch (e) {

  print('EXCEPTION ---- $e');
  
}
}

_setCurrentIcon()async{



  var icon =   await  BitmapDescriptor.fromAssetImage(
   const ImageConfiguration(),
    "assets/icon/pin_current.png",
);
_currentMarker= icon;
if (mounted) {
  setState(() {
    
  });
}
}

_setSourceIcon()async{


BitmapDescriptor  marker
= await 

BitmapDescriptor.fromAssetImage(
   const ImageConfiguration(
    size: Size(20, 20),
   ),
    "assets/icon/pin_source.png",
);
_pinSourceMarker
= marker;
setState(() {
  
});
}



@override
  void initState() {
    // TODO: implement initState
    super.initState();
    
      // loadLocation();
    Future.microtask(()async {
    await   _setMarkerIcons();
   await   _setSourceIcon();
  await    _setCurrentIcon();

// loadLocation();
await loadLocation();

await _getCurrentLocation();

     

      _drawMarkers();

_animateCamera();

  _drawOrignalPolyLine();

    });



  }
void _drawMarkers(){
_list.clear();
markers.clear();

print((_pinSourceMarker==null).toString());

  try {
    markers.add(
      Marker(markerId: 
      MarkerId(widget.source!.hashCode.toString()),
      icon: _pinSourceMarker!,
      position: widget.source!
      )
    );

      markers.add(
      Marker(markerId: 
      MarkerId(widget.destination!.hashCode.toString()),
      icon: _pinDestinationMarker!,
      position: widget.destination!
      )
    );

 markers.add(
      Marker(markerId: 
      MarkerId(currentLocation!.hashCode.toString()),
      icon: _currentMarker!,
      position: currentLocation!
      )
    );


_list
.add
(
  widget.destination!
);
_list
.add
(
  currentLocation!
);


    setState(() {
      
    });
                          // _animateCamera();

  } catch (e) {
    print('DRAW MARKERS :   $e');
  }
}



void _drawOrignalPolyLine()async{
  _polyline.clear();
  try {
      var result = await getRoutePoints(
        widget.source! ,widget.destination!
      );

      var decodedPolyline=    decodePoly(result!);


List<LatLng> points =  convertToLatLng(decodedPolyline);


// for (var points in _points) {
  _polyline.add(
    Polyline(polylineId: 
    const PolylineId('1') ,
    points: points ,
    width: 3, 
    color: ColorResources.colorGray

    )
  );
// }

if (mounted) {
  setState(() {
  
});
}

  } catch (e) {
    
  }
}



void _drawSecondPolyLine()async{
  _secondPolyline.clear();
  try {
      var result = await getRoutePoints(
        currentLocation! ,widget.destination!
      );

      var decodedPolyline=    decodePoly(result!);


List<LatLng> points =  convertToLatLng(decodedPolyline);


// for (var points in _points) {
  _secondPolyline.add(
    Polyline(polylineId: 
    const PolylineId('2') ,
    points: points ,
    width: 5, 
    color: ColorResources.polyLineColor

    )
  );
// }
setState(() {
  
});


  } catch (e) {
    
  }
}
bool isTablet(BuildContext context){
  return MediaQuery.of(context).size.width>=450;
}

  @override
  Widget build(BuildContext context) {
    // loadLocation();
    return Scaffold(
      body:
       GetBuilder<AuthController>(builder: (profileController)
        {
          return SizedBox.expand(

            child: 
            currentLocation==null
            
            
            &&_cameraPosition==null?
            const Center(child: Text('Loading...'),):
            Stack(
children: [


GoogleMap(initialCameraPosition: _cameraPosition!,
zoomControlsEnabled: true,
  minMaxZoomPreference: const MinMaxZoomPreference(0, 16),
                          mapType: MapType.normal,

                        polylines: _polyline,
                          markers: markers,
                          // compassEnabled: false,
                          indoorViewEnabled: true,
                          // mapToolbarEnabled: false,
                          onCameraIdle: () {
                            // if (widget.address != null && !widget.fromCheckout) {
                            //   locationProvider.updatePosition(
                            //       _cameraPosition, true, null, context, true);
                            //   _updateAddress = true;
                            // } else {
                            //   if (_updateAddress) {
                            //     locationProvider.updatePosition(
                            //         _cameraPosition, true, null, context, true);
                            //   } else {
                            //     _updateAddress = true;
                            //   }
                            // }
                          },
                          onCameraMove: (position) {
                 
                          },
                          onMapCreated: (GoogleMapController controller) {
                                            _controller.complete(controller);
_drawOrignalPolyLine();


                          },

)

, 





Positioned(
  top: 100,
  left: 30,
  
  child: GestureDetector(
    onTap: (){
    // Navigator.pop(context);
    Get.back();
    },
    child: Container(
  width: isTablet(context)?60:40 ,height: isTablet(context)?60:40,
    decoration: BoxDecoration(
  shape: BoxShape.circle,
  color: Colors.white,
  border: Border.all(
    width: .8 ,color: Colors.black
  ),
          boxShadow: [
  
            BoxShadow(
              offset: const Offset(0, 3),
              blurRadius: 6 ,
              color: const Color(0xff0000000).withOpacity(.31)
            )
          ]
    ),
  
    child:  Center(child: 
  Icon(Icons.close ,size: isTablet(context)?40: 28,)
    
    ),
  ),
  ))




,


Positioned(
  
  bottom: 30,
  left: 30,right: 30,
  child: 
Center(
  child:   Container(
    height:isTablet(context)? 350: 200,width:
isTablet(context)? MediaQuery.of(context).size.width:    
     350 ,decoration: BoxDecoration(
  
          color: Colors.white , borderRadius: BorderRadius.circular(15)
    ),

    child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
  '${'distance'.tr}: ' , 

  style:TextStyle(
    fontSize: isTablet(context)? 20:15
  )
),
                Text(

'${calculateDistance(
currentLocation!.latitude, 
currentLocation!.longitude , 

widget.destination!.latitude , 

widget.destination!.longitude
)}'
, 

  style:TextStyle(
    fontSize: isTablet(context)? 20:15
  )
                  // '${widget.title}', 

                ),
              
              
              const SizedBox(width: 5,),
                       Text(
  'k.m', 

  style:TextStyle(
  fontSize: isTablet(context)? 20:15
  )
),
              ],
            ),

            SizedBox(
              height:
              isTablet(context)?
              350*.60:
              
               200*.60,
              child: Row(

              mainAxisAlignment: MainAxisAlignment.start,

              children: [

  Container(
            height: double.infinity,
            padding: EdgeInsets.zero,
            width:isTablet(context)? 250: 200,
child:

   SingleChildScrollView(
     child: Column(
           children: [
//pickup

   
             Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              // mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // margin: EdgeInsets.only(top: 16),
                                  height:
                                  isTablet(context)? 40:
                                  
                                   20,
                                  width:                                  isTablet(context)? 40:
 20,
                                  decoration: const BoxDecoration(
                                      // shape: BoxShape.circle,
                                      // border:
                                      //     Border.all(width: 1.5, color: Colors.greenAccent)
                                          
                                          
                       image: DecorationImage(image: AssetImage('assets/icon/pickup.png')

,
fit: BoxFit.cover
)                   
                                          
                                          
                                          ),
                                ),
   
    SizedBox(width:                                   isTablet(context)? 15:
9) ,
   
                                Dash(
                                    direction: Axis.vertical,
                                    length:                                   isTablet(context)? 20:
15,
                                    dashLength:                                   isTablet(context)? 10
:5,
                                    dashColor: Colors.grey),
                              ],
                            ),
   
   
   const SizedBox(width: 6,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                              SizedBox(
                                width:                                   isTablet(context)? 150:
100,
                                child: Text(
                                  'pickup'.tr
                                  
                                  
                                  
                                  ),
                              )
                              ],
                            ),

//   




                            // Container(
                            //   height: 25,
                            //   width: 25,
                            //   decoration: BoxDecoration(
                            //       shape: BoxShape.rectangle,
                            //       border: Border.all(width: 2, color: Colors.red)),
                            //   child: Container(
                            //     height: 20,
                            //   ),
                            // ),
                          ],
                        ),
//my adddress




  Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // margin: EdgeInsets.only(top: 16),
                                  height: 10,
                                  width: 10,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border:
                                          Border.all(width: 1.5, color: const Color(0xFFDFDFDF))),
                                ),
   
  //  const SizedBox(width: 9) ,
   
    SizedBox(width:                                   isTablet(context)? 15:
9) ,
                                Dash(
                                    direction: Axis.vertical,
                                    length:                             
 20,
                                    dashLength:                                  isTablet(context)? 
16: 8,
                                    dashColor: Colors.grey),
                              ],
                            ),
   
   
   const SizedBox(width: 6,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                              SizedBox(
                                width:   isTablet(context)?150: 100,
                                child: Text('my_address'.tr ,
                                overflow: TextOverflow.ellipsis,
                                style:  TextStyle(
                                  fontWeight: FontWeight.bold , 

                                  fontSize:    isTablet(context)?20:15
                                ),
                                ),
                              )
                              ],
                            ),
                            // Container(
                            //   height: 25,
                            //   width: 25,
                            //   decoration: BoxDecoration(
                            //       shape: BoxShape.rectangle,
                            //       border: Border.all(width: 2, color: Colors.red)),
                            //   child: Container(
                            //     height: 20,
                            //   ),
                            // ),
                          ],
                        ),
            

//drop off


    Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              // mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // margin: EdgeInsets.only(top: 16),
                                  height: 20,
                                  width: 20,
                                  decoration: 
                                  const BoxDecoration(
                                      // shape: BoxShape.circle,
                                      // border:
                                      //     Border.all(width: 1.5, color: Colors.greenAccent)
                                          
                                          

image: DecorationImage(image: AssetImage('assets/icon/dropoff.png')

,
fit: BoxFit.cover
)




                                          ),
                                )
                                
                                ,
   
    SizedBox(width:    isTablet(context)?15:9) ,
   
                                Dash(
                                    direction: Axis.vertical,
                                    length:    isTablet(context)?30: 20,
                                    dashLength: 5,
                                    dashColor: Colors.grey),
                              ],
                            ),
   
   
   const SizedBox(width: 6,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                              SizedBox(
                                width:   isTablet(context)?150: 100,
                                child: Text(
                                
                                  
                                  'dropoff'.tr, 
                                  style: TextStyle(
                                    fontSize:    isTablet(context)?20:18
                                  ),
                                  ),
                              )
                              ],
                            ),
                           
                          ],
                        ),
           
          //deliver address 
    Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[


  //                       Column(
  //                         mainAxisSize: MainAxisSize.min,
  //                         mainAxisAlignment: MainAxisAlignment.start,
  //                         crossAxisAlignment: CrossAxisAlignment.center,
  //                         children: [
  //                           Container(
  //                             // margin: EdgeInsets.only(top: 16),
  //                             height: 10,
  //                             width: 10,
  //                             decoration: BoxDecoration(
  //                                 shape: BoxShape.circle,
  //                                 border:
  //                                     Border.all(width: 1.5, color: Color(0xFFDFDFDF))),
  //                           ),
   
  // //  SizedBox(width: 9) ,
   
  // //                          Dash(
  // //                               direction: Axis.vertical,
  // //                               length: 30,
  // //                               dashLength: 8,
  // //                               dashColor: Colors.grey),
  //                         ],
  //                       ),
          Container(
                                  // margin: EdgeInsets.only(top: 16),
                                  height:   isTablet(context)?20: 10,
                                  width:   isTablet(context)?20: 10,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border:
                                          Border.all(width: 1.5, color: const Color(0xFFDFDFDF))),
                                ),
   
   const SizedBox(width: 6,),
                            SizedBox(
                              width:   isTablet(context)?150: 100,
                              child: Text('${ widget.title}' ,
                                    overflow: TextOverflow.ellipsis,
                              style:  TextStyle(
                                fontWeight: FontWeight.bold ,fontSize:    isTablet(context)?20:15
                              ),
                              ),
                            ),
                            
                          ],
                        ),
            
  



           ] 
           )
           )


  )

              ],
            )),
            const Spacer(), 

            GestureDetector(

              onTap: 
               Get.find<OrderController>().isLoading?
               null:
              
              
              ()async{
 FirebaseAnalytics.instance.logEvent(
    name: "shipping_done",
    parameters: {
          'order_id':widget.orderId,
          'destination_lat':widget.destination!.latitude,
          'destination_lng':widget.destination!.longitude,

            "delivery_man_id":profileController.profileModel.id,
            'delivery_man_name': '${profileController.profileModel.fName!} ${profileController.profileModel.lName!}'
             ,
            "date": DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
    },
);
   

             await   Get.find<OrderController>().updateOrderStatus(orderId: widget.orderId, status: 'delivered',context: context);
                await                  Get.find<TrackerController>().updateTrackStart(false);
             
            Get.back();
             
              },
              child: Container(
                margin:    isTablet(context)?const EdgeInsets.symmetric(
                  horizontal: 8
                ):null,
                width:    isTablet(context)?double.infinity:250 ,height: isTablet(context)?60: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor ,
               borderRadius: BorderRadius.circular(10)
            
            ),
            child: Center(
              child: 
              
               Get.find<OrderController>()
               .isLoading?
               const CircularProgressIndicator(
                color: Colors.white,
               ):
              
              Text(
                'mark_as_delivered'.tr, 
                style:  TextStyle(
                  color: Colors.white ,fontSize: isTablet(context)?25: 15
                ),
              ),
            ),
            
              ),
            ) ,

            const SizedBox(height: 10,),
          ],
    ),
  ),

)


)
],

            ),
          );
        }
      ),
      
    );
  }
}