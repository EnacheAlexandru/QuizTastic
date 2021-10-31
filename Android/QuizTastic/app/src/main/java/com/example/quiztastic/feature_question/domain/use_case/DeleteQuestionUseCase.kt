package com.example.quiztastic.feature_question.domain.use_case

import com.example.quiztastic.feature_question.domain.repo.QuestionRepository

class DeleteQuestionUseCase(
    private val repo: QuestionRepository
) {
    suspend operator fun invoke(id: Long) {
        repo.deleteQuestion(id)
    }
}
