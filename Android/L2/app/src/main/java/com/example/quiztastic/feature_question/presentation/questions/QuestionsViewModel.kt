package com.example.quiztastic.feature_question.presentation.questions

import androidx.compose.runtime.State
import androidx.compose.runtime.mutableStateOf
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.quiztastic.feature_question.domain.model.Question
import com.example.quiztastic.feature_question.domain.use_case.QuestionUseCases
import com.example.quiztastic.feature_question.presentation.add_edit_question.AddEditQuestionViewModel
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.Job
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.asSharedFlow
import kotlinx.coroutines.flow.launchIn
import kotlinx.coroutines.flow.onEach
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class QuestionsViewModel @Inject constructor(
    private val questionUseCases: QuestionUseCases
) : ViewModel() {

    private val _state = mutableStateOf(QuestionsState())
    val state: State<QuestionsState> = _state

    private var getQuestionsJob: Job? = null

    init {
        getQuestions()
    }

    fun onEvent(event: QuestionsEvent) {
        when (event) {
            is QuestionsEvent.DeleteQuestionEvent -> {
                viewModelScope.launch {
                    questionUseCases.deleteQuestionUseCase(event.question)
                }
            }
        }
    }

    private fun getQuestions() {
        getQuestionsJob?.cancel()
        getQuestionsJob = questionUseCases.getQuestionsUseCase()
            .onEach { questions ->
                _state.value = state.value.copy(
                    questions = questions
                )
            }
            .launchIn(viewModelScope)
    }

}