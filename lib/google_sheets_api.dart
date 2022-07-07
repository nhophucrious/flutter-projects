import 'package:gsheets/gsheets.dart';
import 'constants.dart';

class GoogleSheetsApi {
  // create credentials
  static const _credentials = r'''
{
  "type": "service_account",
  "project_id": "gsheets-355406",
  "private_key_id": "16142de8637449ce8896a152799b5ce63899b605",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCofgSUxOtP+Sv3\nXYzRFwyUYyMzk/hWbt4SoxgHVmZkCGPghfDbt4s0tzLxh8xAwsBSXCI4+KtnDBKU\nfzSULZHtTI3rzo+Hv7F9e9vHsr4vrkjPc7amI6z6mxyMkxUcMOyJOIlieWdP/jco\n00KIT376RPbGMr/hzEwMpFCn3rk2hCMLFPkmC8fOeiGI5x6mSMtHQG7YtipwtL0b\nZPm7YXpjhGZ11yVxqF9k9PX21jE0MuGAjmwzfevXuRkYPe8D2lsxm8oIb4s6jBj0\nHbE13QSqUAjGIfoev9ZOvx92bHpwU3e4a1bajAkekYF+KjHT83YOOwGigB1TRkiQ\n3FAS1rb5AgMBAAECggEAVBrPW5luInXs+eWjGG3qdBmGZUUb5b0isefiYytAIffE\nLzt8rphQbuhxj/nqvXrZOGNQG+MY3++5SJG0o7CZknuvrgDmSWspBEuyudyhrbhQ\nFOmcRxMw0clid1Ml6vQK5jYn8dVK+jWZwBGwOM2BwxhwnB+SA3qQjZDpx9nX1vtP\n/h4QYxfsxTyELJVkAtSf/xl4IiB4ORxDG4+xuKU9FEdyycCUDu2kBwhe8EeAacGW\nsgRPuao4ARqp/yxulneB7Rqb9m0Z3l4/eM6iCk3Yj5YwWI0b7iuaI6upDSJtYEob\neh5nagDthQ4abIrBW/OPiKaL4vs/fZc47kQQxGYxzwKBgQDVVqdP5VWZQXosRVFU\nVs0wM13OBCtNtKZeqDsSyha6p4zWzP22ze75mSlo9ZGZ9OeXF2ZFQ9Xxi06fahSo\n1WPgsscOaiboIv/I6WPIrvyRim6u9t1hTszOiAnUca/qfWkpYXZeCyIYZX3GMrPd\nJ8XI9IHHol7dB8Z4hMAftUaN7wKBgQDKL5H6tRQa0EYHRw4jXPUSJCGdLswVzjIf\nPJoRIpPQZQZ84XPMvseE5bDHqfGHfxJxTYFdb+iyhDTkqgmpMtMlKkao/khiZRAV\nd60WX4Xr2WrZfSa5ISaKFqW68s34Vu3sWMf8lzVTRhKE0fo/CY2X+E3WM5TjlllB\nlnocShXxlwKBgQDILx+gYNoJjN9PW1wNf8XaTNjg0BiyOalDeSi1YNwjGcWWaZRJ\nTMPJgmbRDl0p0hzeMh7NL/I5TTbhb3EjW9j0p80RQZpwiSbrJ9VyIoDtMLDbjNn+\nzSpxQkW3C1a++h8LrWCcrmW37sQujrUn+IInJwgAg+PwE7OwsyB0oG0sEQKBgHQg\nwo3nN7b27WH8s+gn2jMjQZNQb7QOjMdYPX2eCJxnikRsEeEFqv9wFgt4VtvmZqdh\nRu5t+o+eU+sKpyXhpVjxYUhrVRP+zDAoXug80WTXqgFlWrp2ifZCb8pi7162P03C\n6IryJpS/6J8VI9DVIdipq7teQSQ/FOERFu3st5HdAoGBAL7/BitGjg3jPRSYnhoe\ni2ryl3CucDLO0xGPYu6KaDvGKk4FygpdJwjtJu/BEo+5NUsJ3YbXiOcqMyk/qcD6\n5o1mQuuABebVosvYeNQUREkewvhoYs3ZgL+yIv9sIMoYO+OR4mkq4te8EXanD4KB\nQDZJyJcXNzKDet+eu60Lf36Q\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheets@gsheets-355406.iam.gserviceaccount.com",
  "client_id": "111307009267153222519",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40gsheets-355406.iam.gserviceaccount.com"
}

  ''';

  // set up & connect to the spreadsheet
  static const _spreadsheetId = '1KwGicFPvCKtXrfEkQJDMt56Hakmp970B2VTnwTwO6pU';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _teamMemberSheet, _wordListSheet;
  static int wordNumber = 15;
  static int membersPerTeam = 3;
  // some variables to keep track of..
  static List<String> teamOneFromFirst = [];
  static List<String> teamTwoFromFirst = [];
  static List<String> teamOneFromSecond = [];
  static List<String> teamTwoFromSecond = [];
  static List<String> teamOneFromThird = [];
  static List<String> teamTwoFromThird = [];
  static List<String> currentWordsOne = [];
  static List<String> currentWordsTwo = [];
  static List<String> currentWordsThree = [];

  // initialise the spreadsheet!
  Future init() async {
    final ss = await _gsheets.spreadsheet(_spreadsheetId);
    _teamMemberSheet = ss.worksheetByTitle('TeamList');
    _wordListSheet = ss.worksheetByTitle('WordList');
    loadTeamOneFromFirst();
    loadTeamTwoFromFirst();
    loadTeamOneFromSecond();
    loadTeamTwoFromSecond();
    loadTeamOneFromThird();
    loadTeamTwoFromThird();
    loadWordsOne();
    loadWordsTwo();
    loadWordsThree();
  }

  // load words from the Google spreadsheet
  // load first session
  static Future loadTeamOneFromFirst() async {
    for (int i = 2; i < membersPerTeam + 2; i++) {
      final String newMember =
          await _teamMemberSheet!.values.value(column: 2, row: i + 1);
      if (teamOneFromFirst.length < membersPerTeam) {
        teamOneFromFirst.add(newMember);
      }
    }
  }

  static Future loadTeamTwoFromFirst() async {
    for (int i = 2; i < membersPerTeam + 2; i++) {
      final String newMember =
          await _teamMemberSheet!.values.value(column: 3, row: i + 1);
      if (teamTwoFromFirst.length < membersPerTeam) {
        teamTwoFromFirst.add(newMember);
      }
    }
  }

  // load second session
  static Future loadTeamOneFromSecond() async {
    for (int i = 2; i < membersPerTeam + 2; i++) {
      final String newMember =
          await _teamMemberSheet!.values.value(column: 4, row: i + 1);
      if (teamOneFromSecond.length < membersPerTeam) {
        teamOneFromSecond.add(newMember);
      }
    }
  }

  static Future loadTeamTwoFromSecond() async {
    for (int i = 2; i < membersPerTeam + 2; i++) {
      final String newMember =
          await _teamMemberSheet!.values.value(column: 5, row: i + 1);
      if (teamTwoFromSecond.length < membersPerTeam) {
        teamTwoFromSecond.add(newMember);
      }
    }
  }

  // load third session
  static Future loadTeamOneFromThird() async {
    for (int i = 2; i < membersPerTeam + 2; i++) {
      final String newMember =
          await _teamMemberSheet!.values.value(column: 6, row: i + 1);
      if (teamOneFromThird.length < membersPerTeam) {
        teamOneFromThird.add(newMember);
      }
    }
  }

  static Future loadTeamTwoFromThird() async {
    for (int i = 2; i < membersPerTeam + 2; i++) {
      final String newMember =
          await _teamMemberSheet!.values.value(column: 7, row: i + 1);
      if (teamTwoFromThird.length < membersPerTeam) {
        teamTwoFromThird.add(newMember);
      }
    }
  }

  // load words
  static Future loadWordsOne() async {
    for (int i = 1; i < wordNumber + 1; i++) {
      final String newWord =
          await _wordListSheet!.values.value(column: 1, row: i + 1);
      if (currentWordsOne.length < wordNumber) {
        currentWordsOne.add(newWord);
      }
      // fetch from column 1, row 1 to 15
    }
  }

  static Future loadWordsTwo() async {
    for (int i = 1; i < wordNumber + 1; i++) {
      final String newWord =
          await _wordListSheet!.values.value(column: 2, row: i + 1);
      if (currentWordsOne.length < wordNumber) {
        currentWordsTwo.add(newWord);
      }
      // fetch from column 2, row 1 to 15
    }
  }

  static Future loadWordsThree() async {
    for (int i = 1; i < wordNumber + 1; i++) {
      final String newWord =
          await _wordListSheet!.values.value(column: 3, row: i + 1);
      if (currentWordsThree.length < wordNumber) {
        currentWordsThree.add(newWord);
      }
      // fetch from column 3, row 1 to 15
    }
  }
}
