package com.example.quiztastic.feature_question.presentation.questions.components

import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.height
import androidx.compose.material.AlertDialog
import androidx.compose.material.Button
import androidx.compose.material.ButtonDefaults
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import com.example.quiztastic.feature_question.domain.model.Question

@Composable
fun OnDeleteDialog(
    showDialog: Boolean,
    setShowDialog: (Boolean) -> Unit,
    onConfirm: () -> Unit
) {
    if (showDialog) {
        AlertDialog(
            onDismissRequest = {
                setShowDialog(false)
            },
            title = {
                Text("Are you sure you want to delete this question?")
                Spacer(modifier = Modifier.height(50.dp))
            },
            confirmButton = {
                Button(
                    onClick = {
                        setShowDialog(false)
                        onConfirm()
                    },
                    colors = ButtonDefaults.buttonColors(
                        backgroundColor = Color.Green
                    )
                ) {
                    Text("Yes")
                }
            },
            dismissButton = {
                Button(
                    onClick = {
                        setShowDialog(false)
                    },
                    colors = ButtonDefaults.buttonColors(
                        backgroundColor = Color.Red
                    )
                ) {
                    Text("No")
                }
            }
        )
    }

}
