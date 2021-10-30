package com.example.quiztastic.feature_question.domain.use_case

import com.example.quiztastic.feature_question.domain.model.Question
import com.example.quiztastic.feature_question.domain.repo.QuestionRepository

class GetQuestionUseCase(
    private val repo: QuestionRepository
) {
    suspend operator fun invoke(id: Long): Question? {
        return repo.getQuestionById(id)
    }
}