import 'dart:html';

import 'package:pusher_channels_flutter/pusher-js/core/channels/channel.dart';
import 'package:pusher_channels_flutter/pusher-js/core/pusher.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class PusherService {
  static final PusherService instances=PusherService._internal();
  PusherService._internal();
  
  final PusherChannelsFlutter pusher=PusherChannelsFlutter.getInstance();
  
  void initPusher(context,String? token)async{
    try{
     var authToken=token;
     await pusher.init(apiKey: "d434bf4ee07c17bd7135", cluster: "eu");

    }catch(e,s){
      
    }
  }
}
