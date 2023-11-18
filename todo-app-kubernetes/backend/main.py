from fastapi import FastAPI, HTTPException

from model import Task

from database import (
    fetch_one_task,
    fetch_all_tasks,
    create_task,
    update_task,
    remove_task,
)

from fastapi.middleware.cors import CORSMiddleware


from prometheus_fastapi_instrumentator import Instrumentator


app = FastAPI()

Instrumentator().instrument(app).expose(app)

# Erlaube folgende origins
origins = [
    "http://localhost:3000",
    "http://localhost:5173",
]

# Erstelle CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


# Main endpoint
@app.get("/")
async def read_root():
    return {"Task": "App"}


# Endpoint um alle Tasks aus DB zu fetchen
@app.get("/api/task")
async def get_task():
    response = await fetch_all_tasks()
    return response


# Endpoint um bestimmten Task aus DB zu fetchen
@app.get("/api/task/{title}", response_model=Task)
async def get_task_by_title(title):
    response = await fetch_one_task(title)
    if response:
        return response
    raise HTTPException(404, f"There is no task with the title {title}")


# Endpoint um neuen Task anzulegen
@app.post("/api/task", response_model=Task)
async def post_task(task: Task):
    response = await create_task(task.dict())
    if response:
        return response
    raise HTTPException(400, "Something went wrong")


# Endpoint um bestehenden Task zu ändern
@app.put("/api/task/{title}", response_model=Task)
async def put_task(title: str, desc: str):
    response = await update_task(title, desc)
    if response:
        return response
    raise HTTPException(404, f"There is no task with the title {title}")


# Endpoint um bestimmten Task zu löschen
@app.delete("/api/task/{title}")
async def delete_task(title):
    response = await remove_task(title)
    if response:
        data = {"message": "Successfully deleted task!", "success": True}
        return data
    raise HTTPException(404, f"There is no task with the title {title}")
