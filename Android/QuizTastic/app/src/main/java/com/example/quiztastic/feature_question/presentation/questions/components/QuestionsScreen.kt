package com.example.quiztastic.feature_question.presentation.questions.components

import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Text
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.lifecycle.viewmodel.compose.viewModel
import androidx.navigation.NavController
import com.example.quiztastic.feature_question.presentation.questions.QuestionsEvent
import com.example.quiztastic.feature_question.presentation.questions.QuestionsState
import com.example.quiztastic.feature_question.presentation.questions.QuestionsViewModel
import com.example.quiztastic.feature_question.presentation.util.Screen

@Composable
fun QuestionsScreen(
    navController: NavController,
    viewModel: QuestionsViewModel = hiltViewModel()
) {
    val state: State<QuestionsState> = viewModel.state.collectAsState()

    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(15.dp)
    ) {
        Text(
            text = "All questions",
            style = MaterialTheme.typography.h4
        )
        Spacer(modifier = Modifier.height(20.dp))
        LazyColumn(modifier = Modifier.fillMaxSize()) {
            items(state.value.questions) { question ->
                QuestionItem(
                    question = question,
                    modifier = Modifier
                        .border(1.dp, Color.Blue)
                        .fillMaxWidth()
                        .padding(15.dp)
                        .clickable {
                            navController.navigate(
                                Screen.AddEditQuestionScreen.route +
                                        "?questionId=${question.id}&questionCategory=${question.category}"
                            )
                        },
                    onDeleteClick = {
                        viewModel.onEvent(QuestionsEvent.DeleteQuestionEvent(question))
                    }
                )
                Spacer(modifier = Modifier.height(16.dp))
            }
        }
    }
}