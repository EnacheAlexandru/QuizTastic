package com.example.quiztastic.feature_question.presentation.add_edit_question.components

import android.widget.Toast
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.material.*
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.navigation.NavController
import com.example.quiztastic.feature_question.domain.model.Question
import com.example.quiztastic.feature_question.presentation.add_edit_question.AddEditQuestionEvent
import com.example.quiztastic.feature_question.presentation.add_edit_question.AddEditQuestionViewModel
import com.example.quiztastic.feature_question.presentation.util.Screen
import kotlinx.coroutines.flow.collectLatest
import kotlinx.coroutines.launch

@Composable
fun AddEditQuestionScreen(
    navController: NavController,
    viewModel: AddEditQuestionViewModel = hiltViewModel()
) {
    val questionState = viewModel.questionQuestion.value
    val correctAnswerState = viewModel.questionCorrectAnswer.value
    val wrongAnswerOneState = viewModel.questionWrongAnswerOne.value
    val wrongAnswerTwoState = viewModel.questionWrongAnswerTwo.value
    val wrongAnswerThreeState = viewModel.questionWrongAnswerThree.value
    val categoryState = viewModel.questionCategory.value

    val scaffoldState = rememberScaffoldState()

    LaunchedEffect(key1 = true) {
        viewModel.eventFlow.collectLatest { event ->
            when (event) {
                is AddEditQuestionViewModel.UiEvent.SaveQuestion -> {
                    navController.navigateUp()
                }
                is AddEditQuestionViewModel.UiEvent.ShowSnackBar -> {
                    scaffoldState.snackbarHostState.showSnackbar(event.message)
                }
            }
        }
    }

    Scaffold(
        scaffoldState = scaffoldState
    ) {
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(16.dp)
        ) {
            Text(
                text = "Question",
                style = MaterialTheme.typography.h5
            )
            TextField(
                value = questionState,
                onValueChange = {
                    viewModel.onEvent(AddEditQuestionEvent.EnteredQuestion(it))
                }
            )
            Text(
                text = "Correct Answer",
                style = MaterialTheme.typography.h5
            )
            TextField(
                value = correctAnswerState,
                onValueChange = {
                    viewModel.onEvent(AddEditQuestionEvent.EnteredCorrectAnswer(it))
                }
            )
            Text(
                text = "First wrong answer",
                style = MaterialTheme.typography.h5
            )
            TextField(
                value = wrongAnswerOneState,
                onValueChange = {
                    viewModel.onEvent(AddEditQuestionEvent.EnteredWrongAnswerOne(it))
                }
            )
            Text(
                text = "Second wrong answer",
                style = MaterialTheme.typography.h5
            )
            TextField(
                value = wrongAnswerTwoState,
                onValueChange = {
                    viewModel.onEvent(AddEditQuestionEvent.EnteredWrongAnswerTwo(it))
                }
            )
            Text(
                text = "Third wrong answer",
                style = MaterialTheme.typography.h5
            )
            TextField(
                value = wrongAnswerThreeState,
                onValueChange = {
                    viewModel.onEvent(AddEditQuestionEvent.EnteredWrongAnswerThree(it))
                }
            )

            Spacer(modifier = Modifier.height(20.dp))

            Column(
                horizontalAlignment = Alignment.CenterHorizontally,
                modifier = Modifier
                    .fillMaxWidth()
            ) {
                Text(
                    text = "Category",
                    style = MaterialTheme.typography.h5
                )
                DropDownMenuButton(
                    selectedItem = categoryState.selectedItem,
                    isExpanded = categoryState.isExpanded,
                    onClick = {
                        viewModel.onEvent(AddEditQuestionEvent.ClickCategoryMenu)
                    },
                    onDismiss = {
                        viewModel.onEvent(AddEditQuestionEvent.DismissCategoryMenu)
                    },
                    onValueChange = {
                        viewModel.onEvent(AddEditQuestionEvent.ChangeCategory(it))
                    }
                )

                Spacer(modifier = Modifier.height(20.dp))

                Button(
                    onClick = {
                        viewModel.onEvent(AddEditQuestionEvent.SaveQuestion)
                    },
                    colors = ButtonDefaults.buttonColors(
                        backgroundColor = Color.Green
                    )
                ) {
                    Text(
                        text = "Save",
                        style = MaterialTheme.typography.h4
                    )
                }
            }
        }
    }
}