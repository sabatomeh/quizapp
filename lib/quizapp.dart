import 'package:flutter/material.dart';
import 'package:hgh/questions.dart';

class quiz extends StatefulWidget {
  @override
  State<quiz> createState() => _quizState();
}

class _quizState extends State<quiz> {
  List<question> listQ = getQ();
  int currentIndex = 0;
  int score = 0;
  answer? selectedAnswer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 5, 50, 80),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          const Text(
            'Quiz App',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
          ),
          const SizedBox(height: 32),
          _questions(),
          _answerList(),
          _nextButton(),
        ]),
      ),
    );
  }

  _questions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Question ${currentIndex + 1}/${listQ.length.toString()}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(32),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.orangeAccent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            listQ[currentIndex].que,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        )
      ],
    );
  }

  _answerList() {
    return Column(
      children: listQ[currentIndex]
          .answerList
          .map(
            (e) => _answerButton(e),
          )
          .toList(),
    );
  }

  Widget _answerButton(answer a) {
    bool isSelected = a == selectedAnswer;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      height: 48,
      child: ElevatedButton(
        child: Text(a.ans),
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          primary: isSelected ? Colors.orangeAccent : Colors.white,
          onPrimary: isSelected ? Colors.white : Colors.black,
        ),
        onPressed: () {
          if (selectedAnswer != null) {
            if (a.isCorrect) {
              score++;
            }
            setState(() {
              selectedAnswer = a;
            });
          } 
        },
      ),
    );
  }

  _nextButton() {
    bool isLastQuestion = false;
    if (currentIndex == listQ.length - 1) {
      isLastQuestion = true;
    }
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: 48,
      child: ElevatedButton(
        child: Text(isLastQuestion ? 'Submit' : 'Next'),
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          primary: Colors.blueAccent,
          onPrimary: Colors.white,
        ),
        onPressed: () {
          if (isLastQuestion) {
            showDialog(context: context, builder: (_) => _showScore());
          } else {
            setState(() {
              selectedAnswer = null;
              currentIndex++;
            });
          }
        },
      ),
    );
  }

  _showScore() {
    bool isPassed = false;
    if (score >= listQ.length * 0.5) {
      isPassed = true;
    }
    String title = isPassed ? 'Passed' : 'Failed';
    return AlertDialog(
      title: Text(
        title + '/ score is $score',
        style:
            TextStyle(color: isPassed ? Colors.greenAccent : Colors.redAccent),
      ),
      content: ElevatedButton(
        child: const Text('Restart'),
        onPressed: () {
          Navigator.pop(context);
          setState(() {
            currentIndex = 0;
            score = 0;
            selectedAnswer = null;
          });
        },
      ),
    );
  }
}
