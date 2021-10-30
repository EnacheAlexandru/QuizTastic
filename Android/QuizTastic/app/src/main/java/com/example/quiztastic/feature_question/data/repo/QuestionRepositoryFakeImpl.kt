package com.example.quiztastic.feature_question.data.repo

import com.example.quiztastic.feature_question.domain.model.Question
import com.example.quiztastic.feature_question.domain.repo.QuestionRepository
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.flowOf
import java.util.*

class QuestionRepositoryFakeImpl(
    private var currentId: Long = 1,
    private var questions: MutableList<Question> = mutableListOf(
        Question(
            0L,
            "Capital of Uzbekistan?",
            "Dushanbe",
            "Bishkek",
            "Tashkent",
            "Ashgabat",
            "Geography"
        )
    )
) : QuestionRepository {

    override fun getQuestions(): Flow<List<Question>> {
        return flowOf(Collections.unmodifiableList(questions))
    }

    override suspend fun getQuestionById(id: Long): Question? {
        for (question in questions) {
            if (question.id == id) {
                return question
            }
        }
        return null
    }

    override suspend fun insertQuestion(question: Question) {
        if (question.id == null) {
            val questionWithId = Question(
                id = currentId,
                question = question.question,
                correctAnswer = question.correctAnswer,
                wrongAnswerOne = question.wrongAnswerOne,
                wrongAnswerTwo = question.wrongAnswerTwo,
                wrongAnswerThree = question.wrongAnswerThree,
                category = question.category
            )
            questions.add(questionWithId)
            currentId++
        } else {
            deleteQuestion(question)
            questions.add(question)
        }
    }

    override suspend fun deleteQuestion(question: Question) {
        questions.removeIf { it.id == question.id }
    }
}