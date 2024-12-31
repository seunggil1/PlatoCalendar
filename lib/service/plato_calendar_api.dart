import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:plato_calendar/model/model.dart';
import 'package:plato_calendar/util/logger.dart';

typedef PlatoMoodleSession = String;

class PlatoCalendarAPIException implements Exception {
  final String message;

  PlatoCalendarAPIException(this.message);
}

class PlatoCalendarAPI {
  static final logger = LoggerManager.getLogger('PlatoCalendarSync');

  static Future<List<String>> getPlatoCalendar(PlatoCredential credential) async {
    final moodleSession = await _login(credential);
    final calendar = await _getCalendar(moodleSession);

    return calendar;
  }

  static Future<PlatoMoodleSession> _login(PlatoCredential credential) async {
    late Response response;
    try {
      String body =
          'username=${credential.username}&password=${Uri.encodeQueryComponent(credential.password)}';
      response = await Dio().post('https://plato.pusan.ac.kr/login/index.php',
          options: Options(
              followRedirects: false,
              responseType: ResponseType.plain,
              contentType: 'application/x-www-form-urlencoded',
              headers: {
                'Accept':
                    'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7',
                'Accept-Encoding': 'gzip, deflate, br, zstd',
                'Accept-Language': 'ko-KR,ko;q=0.9',
                'Connection': 'keep-alive',
                'Host': 'plato.pusan.ac.kr',
                'Origin': 'https://plato.pusan.ac.kr',
                'Referer': 'https://plato.pusan.ac.kr/',
                'Upgrade-Insecure-Requests': '1',
                'User-Agent':
                    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3'
              }),
          data: body);

      logger.severe(
          'response.statusCode != 303 : status code=${response.statusCode}, body=${response.data}');
      throw PlatoCalendarAPIException(
          'response.statusCode != 303 : status code=${response.statusCode}, body=${response.data}');
    } on DioException catch (e, stackTrace) {
      if (e.response != null && e.response?.statusCode == 303) {
        response = e.response!;
      } else {
        logger.severe('Failed to login: $e', stackTrace);
        rethrow;
      }
    } catch (e, stackTrace) {
      logger.severe('Failed to login: $e', stackTrace);
      rethrow;
    }

    try {
      if (response.headers.map['location']![0] ==
          'https://plato.pusan.ac.kr/login.php?errorcode=3') {
        throw PlatoCalendarAPIException('ID,PW is incorrect');
      } else {
        PlatoMoodleSession moodleSession =
            response.headers.map['set-cookie']![1];
        moodleSession = moodleSession.substring(0, moodleSession.indexOf(';'));
        return moodleSession;
      }
    } catch (e, stackTrace) {
      logger.severe('Failed to login result parse: $e', stackTrace);
      rethrow;
    }
  }

  static Future<List<String>> _getCalendar(
      PlatoMoodleSession moodleSession) async {
    try {
      Response response = await Dio()
          .get('https://plato.pusan.ac.kr/calendar/export.php?course=1',
              options: Options(headers: {
                'Host': 'plato.pusan.ac.kr',
                'Connection': 'close',
                'Upgrade-Insecure-Requests': '1',
                'User-Agent':
                    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.150 Safari/537.36 Edg/88.0.705.63',
                'Accept':
                    'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9',
                'Accept-Encoding': 'gzip, deflate',
                'Accept-Language': 'ko,en;q=0.9,en-US;q=0.8',
                'Cookie': moodleSession
              }));

      String requestBody1, requestBody2;
      requestBody1 = RegExp('"sesskey":".*?"').stringMatch(response.data)!;
      requestBody1 = '{$requestBody1}';
      String sesskey = 'sesskey=${jsonDecode(requestBody1)["sesskey"]}';

      requestBody1 =
          '$sesskey&_qf__core_calendar_export_form=1&${Uri.encodeQueryComponent("events[exportevents]")}=all&${Uri.encodeQueryComponent("period[timeperiod]")}=monthnow&export=${Uri.encodeQueryComponent("내보내기")}';

      requestBody2 =
          '$sesskey&_qf__core_calendar_export_form=1&${Uri.encodeQueryComponent("events[exportevents]")}=all&${Uri.encodeQueryComponent("period[timeperiod]")}=recentupcoming&export=${Uri.encodeQueryComponent("내보내기")}';

      final calendarHeader = {
        'Host': 'plato.pusan.ac.kr',
        'Connection': 'close',
        'Upgrade-Insecure-Requests': '1',
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.150 Safari/537.36 Edg/88.0.705.63',
        'Origin': 'https://plato.pusan.ac.kr',
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept':
            'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9',
        'Referer': 'https://plato.pusan.ac.kr/calendar/export.php?course=1',
        'Accept-Encoding': 'gzip, deflate',
        'Accept-Language': 'ko,en;q=0.9,en-US;q=0.8',
        'Cookie': moodleSession
      };

      return await Future.wait([
        Dio().post('https://plato.pusan.ac.kr/calendar/export.php',
            options: Options(headers: calendarHeader), data: requestBody1),
        Dio().post('https://plato.pusan.ac.kr/calendar/export.php',
            options: Options(headers: calendarHeader), data: requestBody2)
      ]).then((value) async {
        return [value[0].data, value[1].data];
      });
    } catch (e, stackTrace) {
      logger.severe('Failed to get calendar: $e', stackTrace);
      rethrow;
    }
  }
}
