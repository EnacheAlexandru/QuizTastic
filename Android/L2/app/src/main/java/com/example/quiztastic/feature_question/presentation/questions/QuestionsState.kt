package com.example.quiztastic.feature_question.presentation.questions

import com.example.quiztastic.feature_question.domain.model.Question

data class QuestionsState(
    val questions: List<Question> = emptyList()
)
