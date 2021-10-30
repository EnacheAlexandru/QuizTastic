package com.example.quiztastic.feature_question.presentation.add_edit_question.components

import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.padding
import androidx.compose.material.Button
import androidx.compose.material.DropdownMenu
import androidx.compose.material.DropdownMenuItem
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import com.example.quiztastic.feature_question.domain.model.Question

@Composable
fun DropDownMenuButton (
    selectedItem: String = "",
    isExpanded: Boolean = false,
    onClick: () -> Unit,
    onDismiss: () -> Unit,
    onValueChange: (String) -> Unit
) {
    Column(
        modifier = Modifier
            .padding(20.dp)
    ) {
        Button(
            onClick = onClick
        ) {
            Text(
                text = selectedItem
            )
        }
        DropdownMenu(
            expanded = isExpanded,
            onDismissRequest = onDismiss
        ) {
            Question.categories.forEach { category ->
                DropdownMenuItem(
                    onClick = {
                        onValueChange(category)
                    }
                ) {
                    Text(
                        text = category
                    )
                }
            }
        }
    }
}