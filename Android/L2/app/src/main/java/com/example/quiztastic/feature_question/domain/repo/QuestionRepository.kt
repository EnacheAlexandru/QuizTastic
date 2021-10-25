package com.example.quiztastic.feature_question.domain.repo

import com.example.quiztastic.feature_question.domain.model.Question
import kotlinx.coroutines.flow.Flow

interface QuestionRepository {

    fun getQuestions(): Flow<List<Question>>

    suspend fun getQuestionById(id: Long): Question?

    suspend fun insertQuestion(question: Question)

    suspend fun deleteQuestion(question: Question)
}