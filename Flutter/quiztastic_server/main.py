from fastapi import FastAPI, HTTPException

from question import Question, UpdateQuestion
from question_repo import QuestionRepository

app = FastAPI()

repo = QuestionRepository()


@app.get('/questions')
def getQuestions() -> list[Question]:
    print(f'getQuestions() STARTED...')
    questions = repo.getQuestions()
    print(f'getQuestions() SUCCEEDED...')
    return questions


@app.get('/questions/{qid}')
def getQuestionById(qid: int) -> Question:
    print(f'getQuestionById() with id {qid} STARTED...')
    question = repo.getQuestionById(qid)
    if question is None:
        print(f'getQuestionById() with id {qid} FAILED...')
        raise HTTPException(status_code=404, detail='No question with given ID!')

    print(f'getQuestionById() with id {qid} SUCCEEDED...')
    return question


@app.post('/questions')
def addQuestion(question: Question) -> Question:
    print(f'addQuestion() STARTED...')
    question = repo.addQuestion(question)
    if question is None:
        print(f'addQuestion() FAILED...')
        raise HTTPException(status_code=400, detail='Invalid question!')

    print(f'addQuestion() SUCCEEDED...')
    return question


@app.put('/questions')
def updateQuestion(question: UpdateQuestion) -> Question:
    try:
        print(f'updateQuestion() STARTED...')
        question = repo.updateQuestion(question)
    except ValueError:
        print(f'updateQuestion() FAILED...')
        raise HTTPException(status_code=400, detail='Invalid question!')

    if question is None:
        print(f'updateQuestion() FAILED...')
        raise HTTPException(status_code=404, detail='No question with given ID!')

    print(f'updateQuestion() SUCCEEDED...')
    return question


@app.delete('/questions/{qid}')
def deleteQuestion(qid: int) -> bool:
    print(f'deleteQuestion() STARTED...')
    if repo.deleteQuestion(qid) is False:
        print(f'deleteQuestion() FAILED...')
        raise HTTPException(status_code=404, detail='No question with given ID!')

    print(f'deleteQuestion() SUCCEEDED...')
    return True
