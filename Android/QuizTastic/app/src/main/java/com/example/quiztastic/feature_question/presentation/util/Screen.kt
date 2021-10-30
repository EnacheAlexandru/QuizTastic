package com.example.quiztastic.feature_question.presentation.util

sealed class Screen(val route: String) {
    object MainScreen : Screen(
        route = "main_screen"
    )
    object QuestionsScreen : Screen(
        route = "questions_screen"
    )
    object AddEditQuestionScreen : Screen(
        route = "add_edit_question_screen"
    )
}

