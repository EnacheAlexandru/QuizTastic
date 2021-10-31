package com.example.quiztastic.feature_question.domain.model

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity
data class Question(
    @PrimaryKey(autoGenerate = true) val id: Long?,
    @ColumnInfo(name = "question") val question: String,
    @ColumnInfo(name = "correct_answer") val correctAnswer: String,
    @ColumnInfo(name = "wrong_answer_one") val wrongAnswerOne: String,
    @ColumnInfo(name = "wrong_answer_two") val wrongAnswerTwo: String,
    @ColumnInfo(name = "wrong_answer_three") val wrongAnswerThree: String,
    @ColumnInfo(name = "category") val category: String
) {
    companion object {
        val categories = listOf("History", "Geography", "Math")
    }
}

class InvalidQuestionException(message: String): Exception(message)
