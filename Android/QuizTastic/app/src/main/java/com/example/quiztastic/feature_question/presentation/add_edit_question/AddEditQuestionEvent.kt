package com.example.quiztastic.feature_question.presentation.add_edit_question

sealed class AddEditQuestionEvent {
    data class EnteredQuestion(val value: String): AddEditQuestionEvent()
    data class EnteredCorrectAnswer(val value: String): AddEditQuestionEvent()
    data class EnteredWrongAnswerOne(val value: String): AddEditQuestionEvent()
    data class EnteredWrongAnswerTwo(val value: String): AddEditQuestionEvent()
    data class EnteredWrongAnswerThree(val value: String): AddEditQuestionEvent()
    data class ChangeCategory(val value: String): AddEditQuestionEvent()
    object ClickCategoryMenu: AddEditQuestionEvent()
    object DismissCategoryMenu: AddEditQuestionEvent()
    object SaveQuestion: AddEditQuestionEvent()
}
