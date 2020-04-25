import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{
  String location;//location for the name of the UI
  String time;//the time of curren time
  String flag;//asset location url
  String url;//location url for api end point
  bool isDayTime;//Checking is day or night

  WorldTime({this.location , this.flag, this.url});

  Future<void> getTime() async{


  try{
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
    Map data = jsonDecode(response.body);

    //Gettin date and offset val
    String datetime = data['datetime'];
    String offset = data['utc_offset'].substring(1,3);
  
    
    //increasing the time by plus offset
    DateTime now =  DateTime.parse(datetime);
    now = now.add(Duration(hours: int.parse(offset)));

    isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
    time = DateFormat.jm().format(now);
    
  }
  catch(e){
    print('error handling : $e');
    time = 'could not get the time';
  } 
    
  }
}

