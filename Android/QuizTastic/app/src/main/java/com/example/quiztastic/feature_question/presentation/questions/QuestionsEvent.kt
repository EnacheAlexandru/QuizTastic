package com.example.quiztastic.feature_question.presentation.questions

import com.example.quiztastic.feature_question.domain.model.Question

sealed class QuestionsEvent {
    data class DeleteQuestionEvent(val question: Question): QuestionsEvent()
}
