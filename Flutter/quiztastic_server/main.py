from fastapi import FastAPI, HTTPException
from starlette.websockets import WebSocket, WebSocketDisconnect

from question import Question, UpdateQuestion
from question_repo import QuestionRepository

app = FastAPI()

repo = QuestionRepository()


class ConnectionManager:
    def __init__(self):
        self.active_connections: list[WebSocket] = []

    async def connect(self, websocket: WebSocket):
        await websocket.accept()
        self.active_connections.append(websocket)

    def disconnect(self, websocket: WebSocket):
        self.active_connections.remove(websocket)

    async def broadcast(self, payload):
        for connection in self.active_connections:
            try:
                await connection.send_json(payload)
            except WebSocketDisconnect:
                manager.disconnect(connection)


manager = ConnectionManager()


@app.websocket("/ws")
async def websocket_endpoint(websocket: WebSocket):
    await manager.connect(websocket)
    try:
        while True:
            await websocket.receive_json()
    except WebSocketDisconnect:
        manager.disconnect(websocket)


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
async def addQuestion(question: Question) -> Question:
    print(f'addQuestion() STARTED...')
    question = repo.addQuestion(question)
    if question is None:
        print(f'addQuestion() FAILED...')
        raise HTTPException(status_code=400, detail='Invalid question!')

    await manager.broadcast({'type': 'add-question', 'payload': question.json()})
    print(f'addQuestion() SUCCEEDED...')
    return question


@app.put('/questions')
async def updateQuestion(question: UpdateQuestion) -> Question:
    try:
        print(f'updateQuestion() STARTED...')
        question = repo.updateQuestion(question)
    except ValueError:
        print(f'updateQuestion() FAILED...')
        raise HTTPException(status_code=400, detail='Invalid question!')

    if question is None:
        print(f'updateQuestion() FAILED...')
        raise HTTPException(status_code=404, detail='No question with given ID!')

    await manager.broadcast({'type': 'update-question', 'payload': question.json()})
    print(f'updateQuestion() SUCCEEDED...')
    return question


@app.delete('/questions/{qid}')
async def deleteQuestion(qid: int) -> bool:
    print(f'deleteQuestion() STARTED...')
    if repo.deleteQuestion(qid) is False:
        print(f'deleteQuestion() FAILED...')
        raise HTTPException(status_code=404, detail='No question with given ID!')

    await manager.broadcast({'type': 'delete-question', 'payload': qid})
    print(f'deleteQuestion() SUCCEEDED...')
    return True
