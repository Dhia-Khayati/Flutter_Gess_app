class Question {
  late int _questionNumber;
  late String _questionName;
  late String _questionImage;
  late bool _qestionResultat;

  Question(int i, String n, String qm, bool r) {
    _questionNumber = i;
    _questionName = n;
    _questionImage = qm;
    _qestionResultat = r;
  }
  int getQuestionNumber() {
    return _questionNumber;
  }

  String getQuestionName() {
    return _questionName;
  }

  bool getQuestionResultat() {
    return _qestionResultat;
  }

  String getQuestionImage() {
    return _questionImage;
  }
}
