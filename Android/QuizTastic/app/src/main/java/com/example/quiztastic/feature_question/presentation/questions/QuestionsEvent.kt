package com.example.quiztastic.feature_question.presentation.questions

sealed class QuestionsEvent {
    data class DeleteQuestionEvent(val id: Long): QuestionsEvent()
}
