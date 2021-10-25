package com.example.quiztastic.feature_question.presentation.questions.components

import androidx.compose.foundation.layout.*
import androidx.compose.material.*
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Delete
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import com.example.quiztastic.feature_question.domain.model.Question

@Composable
fun QuestionItem(
    question: Question,
    modifier: Modifier = Modifier,
    onDeleteClick: () -> Unit
) {
    Card(
        modifier = modifier
    ) {
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(16.dp)
        ) {
            Text(
                text = question.question,
                style = MaterialTheme.typography.h5
            )
            Text(
                text = question.correctAnswer,
                style = MaterialTheme.typography.body1
            )
            Text(
                text = question.wrongAnswerOne,
                style = MaterialTheme.typography.body1
            )
            Text(
                text = question.wrongAnswerTwo,
                style = MaterialTheme.typography.body1
            )
            Text(
                text = question.wrongAnswerThree,
                style = MaterialTheme.typography.body1
            )
            Spacer(modifier = Modifier.height(5.dp))
            Text(
                text = "Category: " + question.category,
                style = MaterialTheme.typography.body1
            )
            IconButton(
                onClick = onDeleteClick,
                modifier = Modifier.align(Alignment.End)
            ) {
                Icon(
                    imageVector = Icons.Default.Delete,
                    contentDescription = "Delete question"
                )
            }
        }
    }
}