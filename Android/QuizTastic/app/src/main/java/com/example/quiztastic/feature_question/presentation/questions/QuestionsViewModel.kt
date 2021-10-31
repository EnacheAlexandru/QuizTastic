package com.example.quiztastic.feature_question.presentation.questions

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.quiztastic.feature_question.domain.use_case.QuestionUseCases
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class QuestionsViewModel @Inject constructor(
    private val questionUseCases: QuestionUseCases
) : ViewModel() {

//    private val _state = mutableStateOf(QuestionsState())
//    val state: State<QuestionsState> = _state

    private val _state = MutableStateFlow(QuestionsState())
    val state: StateFlow<QuestionsState> = _state

//    private val _state = mutableListOf(listOf())
//    val state: StateFlow<QuestionsState> = _state

//    private var getQuestionsJob: Job? = null

    init {
        getQuestions()
    }

    fun onEvent(event: QuestionsEvent) {
        when (event) {
            is QuestionsEvent.DeleteQuestionEvent -> {
                viewModelScope.launch {
                    questionUseCases.deleteQuestionUseCase(event.id)
                }
            }
        }
    }

    private fun getQuestions() {
//        getQuestionsJob?.cancel()
//        getQuestionsJob = questionUseCases.getQuestionsUseCase()
//            .onEach { questions ->
//                state.value = questions
//            }
//            .launchIn(viewModelScope)

        viewModelScope.launch {
            questionUseCases.getQuestionsUseCase().collect {
                _state.value = _state.value.copy(
                    questions = it
                )
            }
        }
    }
}