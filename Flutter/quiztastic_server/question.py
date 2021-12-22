from typing import Optional
from pydantic import BaseModel


class Question(BaseModel):
    id: Optional[int]
    questionText: str
    correctAnswer: str
    wrongAnswerOne: str
    wrongAnswerTwo: str
    wrongAnswerThree: str
    category: str


class UpdateQuestion(BaseModel):
    id: int
    questionText: str
    correctAnswer: str
    wrongAnswerOne: str
    wrongAnswerTwo: str
    wrongAnswerThree: str
    category: str
