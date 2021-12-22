from typing import Optional

from question import Question, UpdateQuestion


class QuestionRepository:
    def __init__(self):
        self.__questions: list[Question] = [
            Question(
                id=1,
                questionText='What is the capital of Kenya?',
                correctAnswer='Nairobi',
                wrongAnswerOne='Lusaka',
                wrongAnswerTwo='Harare',
                wrongAnswerThree='Kampala',
                category='Geography'),
            Question(
                id=2,
                questionText='Which is often considered the biggest turning point of World War II?',
                correctAnswer='The Battle of Stalingrad',
                wrongAnswerOne='The Battle of Britain',
                wrongAnswerTwo='The Battle of Normandy',
                wrongAnswerThree='The Attack on Pearl Harbor',
                category='History'),
            Question(
                id=3,
                questionText='Which is the most populated city in the world?',
                correctAnswer='Tokyo',
                wrongAnswerOne='New Delhi',
                wrongAnswerTwo='Beijing',
                wrongAnswerThree='Shanghai',
                category='Geography')
        ]
        self.__next_free_id: int = len(self.__questions) + 1

    def getQuestions(self) -> list[Question]:
        return self.__questions

    def getQuestionById(self, qid: int) -> Optional[Question]:
        for question in self.__questions:
            if question.id == qid:
                return question

        return None

    def addQuestion(self, question: Question) -> Optional[Question]:
        if not 0 < len(question.questionText) < 101 \
                or not 0 < len(question.correctAnswer) < 101 \
                or not 0 < len(question.wrongAnswerOne) < 101 \
                or not 0 < len(question.wrongAnswerTwo) < 101 \
                or not 0 < len(question.wrongAnswerThree) < 101 \
                or not 0 < len(question.category) < 31:
            return None

        question.id = self.__next_free_id
        self.__next_free_id += 1
        self.__questions.append(question)
        return question

    def updateQuestion(self, question_to_update: UpdateQuestion) -> Optional[Question]:
        if not 0 < len(question_to_update.questionText) < 101 \
                or not 0 < len(question_to_update.correctAnswer) < 101 \
                or not 0 < len(question_to_update.wrongAnswerOne) < 101 \
                or not 0 < len(question_to_update.wrongAnswerTwo) < 101 \
                or not 0 < len(question_to_update.wrongAnswerThree) < 101 \
                or not 0 < len(question_to_update.category) < 31:
            raise ValueError

        question = self.getQuestionById(question_to_update.id)
        if question is None:
            return None

        question.questionText = question_to_update.questionText
        question.correctAnswer = question_to_update.correctAnswer
        question.wrongAnswerOne = question_to_update.wrongAnswerOne
        question.wrongAnswerTwo = question_to_update.wrongAnswerTwo
        question.wrongAnswerThree = question_to_update.wrongAnswerThree
        question.category = question_to_update.category

        return question

    def deleteQuestion(self, qid: int) -> bool:
        question = self.getQuestionById(qid)
        if question is None:
            return False

        self.__questions.remove(question)
        return True
