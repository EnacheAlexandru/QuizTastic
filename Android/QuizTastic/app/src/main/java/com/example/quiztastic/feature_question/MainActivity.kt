package com.example.quiztastic.feature_question

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Surface
import androidx.compose.material.Text
import androidx.navigation.NavType
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import androidx.navigation.navArgument
import com.example.quiztastic.feature_question.presentation.add_edit_question.components.AddEditQuestionScreen
import com.example.quiztastic.feature_question.presentation.main.components.MainScreen
import com.example.quiztastic.feature_question.presentation.questions.components.QuestionsScreen
import com.example.quiztastic.feature_question.presentation.util.Screen
import com.example.quiztastic.ui.theme.QuizTasticTheme
import dagger.hilt.android.AndroidEntryPoint

@AndroidEntryPoint
class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            QuizTasticTheme {
                Surface(
                    color = MaterialTheme.colors.background
                ) {
                    val navController = rememberNavController()
                    NavHost(
                        navController = navController,
                        startDestination = Screen.MainScreen.route
                    ) {
                        composable(route = Screen.MainScreen.route) {
                            MainScreen(navController = navController)
                        }
                        composable(route = Screen.QuestionsScreen.route) {
                            QuestionsScreen(navController = navController)
                        }
                        composable(
                            route = Screen.AddEditQuestionScreen.route +
                                    "?questionId={questionId}&questionCategory={questionCategory}",
                            arguments = listOf(
                                navArgument(
                                    name = "questionId"
                                ) {
                                    type = NavType.LongType
                                    defaultValue = -1L
                                },
                                navArgument(
                                    name = "questionCategory"
                                ) {
                                    type = NavType.StringType
                                    defaultValue = ""
                                }
                            )
                        ) {
                            AddEditQuestionScreen(navController = navController)
                        }
                    }
                }
            }
        }
    }
}
