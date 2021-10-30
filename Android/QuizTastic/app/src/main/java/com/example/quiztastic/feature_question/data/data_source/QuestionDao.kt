package com.example.quiztastic.feature_question.data.data_source

import androidx.room.*
import com.example.quiztastic.feature_question.domain.model.Question
import kotlinx.coroutines.flow.Flow

@Dao
interface QuestionDao {

    @Query("SELECT * FROM Question")
    fun getQuestions(): Flow<List<Question>>

    @Query("SELECT * FROM Question WHERE id = :id")
    suspend fun getQuestionById(id: Long): Question?

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertQuestion(question: Question)

    @Delete
    suspend fun deleteQuestion(question: Question)
}