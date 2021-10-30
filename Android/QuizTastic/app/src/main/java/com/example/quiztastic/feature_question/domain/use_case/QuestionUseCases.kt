package com.example.quiztastic.feature_question.domain.use_case

data class QuestionUseCases(
    val getQuestionUseCase: GetQuestionUseCase,
    val deleteQuestionUseCase: DeleteQuestionUseCase,
    val addQuestionUseCase: AddQuestionUseCase,
    val getQuestionsUseCase: GetQuestionsUseCase
)