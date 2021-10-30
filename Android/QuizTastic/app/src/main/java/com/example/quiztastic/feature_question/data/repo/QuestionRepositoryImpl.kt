package com.example.quiztastic.feature_question.data.repo

import com.example.quiztastic.feature_question.data.data_source.QuestionDao
import com.example.quiztastic.feature_question.domain.model.Question
import com.example.quiztastic.feature_question.domain.repo.QuestionRepository
import kotlinx.coroutines.flow.Flow

class QuestionRepositoryImpl(
    private val dao: QuestionDao
) : QuestionRepository {

    override fun getQuestions(): Flow<List<Question>> {
        return dao.getQuestions()
    }

    override suspend fun getQuestionById(id: Long): Question? {
        return dao.getQuestionById(id)
    }

    override suspend fun insertQuestion(question: Question) {
        dao.insertQuestion(question)
    }

    override suspend fun deleteQuestion(question: Question) {
        dao.deleteQuestion(question)
    }
}