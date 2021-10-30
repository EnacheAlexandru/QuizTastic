package com.example.quiztastic.feature_question.data.data_source

import androidx.room.Database
import androidx.room.RoomDatabase
import com.example.quiztastic.feature_question.domain.model.Question

@Database(entities = [Question::class], version = 1)
abstract class QuestionDatabase : RoomDatabase() {
    abstract val questionDao: QuestionDao

    companion object {
        const val DATABASE_NAME = "quiztastic_db"
    }
}