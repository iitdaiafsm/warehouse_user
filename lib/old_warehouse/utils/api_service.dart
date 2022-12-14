import 'dart:convert';
import 'package:csv/csv.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:influxdb_client/api.dart';

class ApiService extends GetConnect{

  Future<Map<String,dynamic>> getData(Query query)async{
    var response = await post("http://wfp-smartwarehouse.in:8086/api/v2/query?org=IITD-WFP", query.toJson(),headers: {
      "Authorization":"Token IQDuRsScn2SO48P_rmH3UQr1bcOlhuMhdsBrCvgXrrTVG814HAHEkqgtvbDPm6TRc5Zb6K3zHvS4hPEgGKGd-g==",
      "Accept-Encoding":"gzip",
      // "Content-Type":"application/json"
    });
    var myValue = utf8.decoder
        .bind((response as http.StreamedResponse).stream)
        .transform(CsvToListConverter())
        .transform(FluxTransformer());
    myValue.forEach((record) {
      Get.log(
          'record:  ${DateTime.parse(record['_time'])}: ${record['host']} ${record['topic']} ${record['_value']}');

    });

    return {};
  }
}