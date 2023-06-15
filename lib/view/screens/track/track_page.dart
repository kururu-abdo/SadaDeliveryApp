import 'dart:async';
import 'dart:math';

import 'package:eamar_delivery/controller/location_controller.dart';
import 'package:eamar_delivery/utill/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../../services/map_services.dart';

class TrackPage extends StatefulWidget {
  final LatLng? source;
  final LatLng? destination;
  final String? title;
  const TrackPage({ Key? key, this.source, this.destination, this.title }) : super(key: key);

  @override
  _TrackPageState createState() => _TrackPageState();
}

class _TrackPageState extends State<TrackPage> {



final Set<Polyline>_polyline={};
final Set<Polyline>  _secondPolyline={};

Completer<GoogleMapController>  _controller =  Completer();
CameraPosition? _cameraPosition;

List<LatLng>  polyLines=[];
Set<Marker> markers={};
LatLng? currentLocation;


List<LatLng> _list = [
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
   ImageConfiguration(),
    "assets/icon/pin_destination.png",
);

_currentMarker =   await  BitmapDescriptor.fromAssetImage(
   ImageConfiguration(),
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
   ImageConfiguration(),
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
   ImageConfiguration(
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


List<LatLng> _points =  convertToLatLng(decodedPolyline);


// for (var points in _points) {
  _polyline.add(
    Polyline(polylineId: 
    PolylineId('1') ,
    points: _points ,
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


List<LatLng> _points =  convertToLatLng(decodedPolyline);


// for (var points in _points) {
  _secondPolyline.add(
    Polyline(polylineId: 
    PolylineId('2') ,
    points: _points ,
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


  @override
  Widget build(BuildContext context) {
    // loadLocation();
    return Scaffold(
      body: SizedBox.expand(

        child: 
        currentLocation==null
        
        
        &&_cameraPosition==null?
        Center(child: Text('Loading...'),):
        Stack(
children: [


GoogleMap(initialCameraPosition: _cameraPosition!,
zoomControlsEnabled: true,
  minMaxZoomPreference: MinMaxZoomPreference(0, 16),
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
                      onCameraMove: (_position) {
             
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
  width: 40 ,height: 40,
    decoration: BoxDecoration(
  shape: BoxShape.circle,
  color: Colors.white,
  border: Border.all(
    width: .8 ,color: Colors.black
  ),
      boxShadow: [
  
        BoxShadow(
          offset: Offset(0, 3),
          blurRadius: 6 ,
          color: Color(0xFF0000000).withOpacity(.31)
        )
      ]
    ),
  
    child: Center(child: 
  Icon(Icons.close ,size: 28,)
    
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
    height: 200,width: 350 ,decoration: BoxDecoration(
  
      color: Colors.white , borderRadius: BorderRadius.circular(15)
    ),

    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '${widget.title}', 

        ),
        Spacer(), 

        Container(
          width: 250 ,height: 40,
decoration: BoxDecoration(
        color: Theme.of(context).primaryColor ,
         borderRadius: BorderRadius.circular(20)

),
child: Center(
  child: Text(
    'MARK AS DELIVERED', 
    style: TextStyle(
      color: Colors.white ,fontSize: 15
    ),
  ),
),

        ) ,

        SizedBox(height: 8,),
      ],
    ),
  ),

)


)
],

        ),
      ),
      
    );
  }
}