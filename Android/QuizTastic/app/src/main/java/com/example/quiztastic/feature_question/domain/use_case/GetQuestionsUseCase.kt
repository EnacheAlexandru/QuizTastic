package com.example.quiztastic.feature_question.domain.use_case

import com.example.quiztastic.feature_question.domain.model.Question
import com.example.quiztastic.feature_question.domain.repo.QuestionRepository
import kotlinx.coroutines.flow.Flow

class GetQuestionsUseCase(
    private val repo: QuestionRepository
) {
    operator fun invoke(): Flow<List<Question>> {
        return repo.getQuestions()
    }
}