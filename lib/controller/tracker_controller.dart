import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eamar_delivery/data/api/api_checker.dart';
import 'package:eamar_delivery/data/model/body/track_body.dart';
import 'package:eamar_delivery/data/model/response/response_model.dart';
import 'package:eamar_delivery/data/repository/tracker_repo.dart';


class TrackerController extends GetxController implements GetxService {
  final TrackerRepo trackerRepo;

  TrackerController({@required this.trackerRepo});

  final List<TrackBody> _trackList = [];

  final int _selectedTrackIndex = 0;
  final bool _isBlockButton = false;
  final bool _canDismiss = true;

  List<TrackBody> get trackList => _trackList;

  int get selectedTrackIndex => _selectedTrackIndex;

  bool get isBlockButton => _isBlockButton;

  bool get canDismiss => _canDismiss;

  bool _startTrack = false;
  Timer timer;

  bool get startTrack => _startTrack;

  updateTrackStart(bool status) {
    _startTrack = status;
    if (status == false && timer != null) {
      timer.cancel();
    }
    update();
  }

  Future<ResponseModel> addTrack({TrackBody trackBody}) async {
    ResponseModel responseModel;
    timer = Timer.periodic(const Duration(seconds: 30), (timer) async {
      if (_startTrack) {
        Response apiResponse = await trackerRepo.addHistory(trackBody);
        if (apiResponse.statusCode == 200) {
          responseModel = ResponseModel(true, 'Successfully start track');
        } else {
         ApiChecker.checkApi(apiResponse);
        }
        update();
      } else {
        timer.cancel();
      }
    });

    return responseModel;
  }
}

class MyBackgroundService {
  static StreamSubscription timer;

  static void stop() {
    timer?.cancel();
  }
}
