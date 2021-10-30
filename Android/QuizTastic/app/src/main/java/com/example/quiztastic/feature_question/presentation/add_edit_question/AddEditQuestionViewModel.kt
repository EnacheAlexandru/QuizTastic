package com.example.quiztastic.feature_question.presentation.add_edit_question

import androidx.compose.runtime.State
import androidx.compose.runtime.mutableStateOf
import androidx.lifecycle.SavedStateHandle
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.quiztastic.feature_question.domain.model.InvalidQuestionException
import com.example.quiztastic.feature_question.domain.model.Question
import com.example.quiztastic.feature_question.domain.use_case.QuestionUseCases
import com.example.quiztastic.feature_question.presentation.add_edit_question.components.DropDownMenuState
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.asSharedFlow
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class AddEditQuestionViewModel @Inject constructor(
    private val questionUseCases: QuestionUseCases,
    savedStateHandle: SavedStateHandle
) : ViewModel() {

    private val _questionQuestion = mutableStateOf("")
    val questionQuestion: State<String> = _questionQuestion

    private val _questionCorrectAnswer = mutableStateOf("")
    val questionCorrectAnswer: State<String> = _questionCorrectAnswer

    private val _questionWrongAnswerOne = mutableStateOf("")
    val questionWrongAnswerOne: State<String> = _questionWrongAnswerOne

    private val _questionWrongAnswerTwo = mutableStateOf("")
    val questionWrongAnswerTwo: State<String> = _questionWrongAnswerTwo

    private val _questionWrongAnswerThree = mutableStateOf("")
    val questionWrongAnswerThree: State<String> = _questionWrongAnswerThree

    private val _questionCategory = mutableStateOf(DropDownMenuState(
        selectedItem = Question.categories[0]
    ))
    val questionCategory: State<DropDownMenuState> = _questionCategory

    private val _eventFlow = MutableSharedFlow<UiEvent>()
    val eventFlow = _eventFlow.asSharedFlow()

    sealed class UiEvent {
        data class ShowSnackBar(val message: String) : UiEvent()
        object SaveQuestion : UiEvent()
    }

    private var currentQuestionId: Long? = null

    init {
        savedStateHandle.get<Long>("questionId")?.let { questionId ->
            if (questionId != -1L) {
                viewModelScope.launch {
                    questionUseCases.getQuestionUseCase(questionId)?.also { question ->
                        currentQuestionId = question.id
                        _questionQuestion.value = question.question
                        _questionCorrectAnswer.value = question.correctAnswer
                        _questionWrongAnswerOne.value = question.wrongAnswerOne
                        _questionWrongAnswerTwo.value = question.wrongAnswerTwo
                        _questionWrongAnswerThree.value = question.wrongAnswerThree
                        _questionCategory.value = questionCategory.value.copy(
                            selectedItem = question.category
                        )
                    }
                }
            }
        }
    }

    fun onEvent(event: AddEditQuestionEvent) {
        when (event) {
            is AddEditQuestionEvent.EnteredQuestion -> {
                _questionQuestion.value = event.value
            }
            is AddEditQuestionEvent.EnteredCorrectAnswer -> {
                _questionCorrectAnswer.value = event.value
            }
            is AddEditQuestionEvent.EnteredWrongAnswerOne -> {
                _questionWrongAnswerOne.value = event.value
            }
            is AddEditQuestionEvent.EnteredWrongAnswerTwo -> {
                _questionWrongAnswerTwo.value = event.value
            }
            is AddEditQuestionEvent.EnteredWrongAnswerThree -> {
                _questionWrongAnswerThree.value = event.value
            }
            is AddEditQuestionEvent.ChangeCategory -> {
                _questionCategory.value = questionCategory.value.copy(
                    selectedItem = event.value,
                    isExpanded = false
                )
            }
            is AddEditQuestionEvent.ClickCategoryMenu -> {
                _questionCategory.value = questionCategory.value.copy(
                    isExpanded = true
                )
            }
            is AddEditQuestionEvent.DismissCategoryMenu -> {
                _questionCategory.value = questionCategory.value.copy(
                    isExpanded = false
                )
            }
            is AddEditQuestionEvent.SaveQuestion -> {
                viewModelScope.launch {
                    try {
                        questionUseCases.addQuestionUseCase(
                            Question(
                                id = currentQuestionId,
                                question = questionQuestion.value,
                                correctAnswer = questionCorrectAnswer.value,
                                wrongAnswerOne = questionWrongAnswerOne.value,
                                wrongAnswerTwo = questionWrongAnswerTwo.value,
                                wrongAnswerThree = questionWrongAnswerThree.value,
                                category = questionCategory.value.selectedItem
                            )
                        )
                        _eventFlow.emit(UiEvent.SaveQuestion)
                    } catch (e: InvalidQuestionException) {
                        _eventFlow.emit(
                            UiEvent.ShowSnackBar(message = e.message ?: "Error")
                        )
                    }
                }
            }
        }
    }
}