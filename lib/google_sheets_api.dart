import 'package:gsheets/gsheets.dart';
import 'constants.dart';

class GoogleSheetsApi {
  // create credentials
  static const _credentials = r'''
{
  // CREDENTIALS HERE
}

  ''';

  // set up & connect to the spreadsheet
  static const _spreadsheetId = 'SPREADSHEET ID HERE';
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
