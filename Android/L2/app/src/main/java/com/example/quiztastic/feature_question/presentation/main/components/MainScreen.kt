package com.example.quiztastic.feature_question.presentation.main.components

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material.Button
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.navigation.NavController
import com.example.quiztastic.feature_question.presentation.util.Screen

@Composable
fun MainScreen(
    navController: NavController
) {
    Column(
        verticalArrangement = Arrangement.SpaceEvenly,
        horizontalAlignment = Alignment.CenterHorizontally,
        modifier = Modifier
            .fillMaxSize()
    ) {
        Button(
            onClick = {
                navController.navigate(Screen.QuestionsScreen.route)
            }
        ) {
            Text(
                text = "All questions",
                style = MaterialTheme.typography.h3
            )
        }
        Button(
            onClick = {
                navController.navigate(Screen.AddEditQuestionScreen.route)
            }
        ) {
            Text(
                text = "Add question",
                style = MaterialTheme.typography.h3
            )
        }
    }
}