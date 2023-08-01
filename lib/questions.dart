class question {
  final String que;
  final List<answer> answerList;

  question(this.que, this.answerList);
}

class answer {
  final String ans;
  final bool isCorrect;

  answer(this.ans, this.isCorrect);
}

List<question> getQ() {
  List<question> l = [];

  l.add(question(
    'What is the capital of Palestine?',
    [
      answer('Jerusalem', true),
      answer('Baghdad', false),
      answer('Cairo', false),
      answer('Beirut', false)
    ],
  ));

  l.add(question(
    'In what year did the Nakba war take place?',
    [
      answer('2002', false),
      answer('1990', false),
      answer('1948', true),
      answer('1988', false)
    ],
  ));

  l.add(question(
    'What are the borders of Palestine from the East?',
    [
      answer('Syria', false),
      answer('Jordan', true),
      answer('Lebanon', false),
      answer('Egypt', false)
    ],
  ));

  l.add(question(
    'Palestine is located in the continent of Asia',
    [answer('True', true), answer('False', false)],
  ));
  return l;
}
