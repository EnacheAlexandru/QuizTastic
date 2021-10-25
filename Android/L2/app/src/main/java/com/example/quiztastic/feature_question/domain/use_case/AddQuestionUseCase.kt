package com.example.quiztastic.feature_question.domain.use_case

import com.example.quiztastic.feature_question.domain.model.InvalidQuestionException
import com.example.quiztastic.feature_question.domain.model.Question
import com.example.quiztastic.feature_question.domain.repo.QuestionRepository

class AddQuestionUseCase(
    private val repo: QuestionRepository
) {

    @Throws(InvalidQuestionException::class)
    suspend operator fun invoke(question: Question) {
        if (question.question.isBlank() ||
            question.correctAnswer.isBlank() ||
            question.wrongAnswerOne.isBlank() ||
            question.wrongAnswerTwo.isBlank() ||
            question.wrongAnswerThree.isBlank()
        ) {
            throw InvalidQuestionException("Please fill all the boxes.")
        }
        repo.insertQuestion(question)
    }
}