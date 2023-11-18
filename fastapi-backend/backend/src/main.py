from pathlib import Path

from fastapi import FastAPI, HTTPException, status
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from starlette.responses import FileResponse

from src.database import (
    create_task,
    fetch_all_tasks,
    fetch_one_task,
    remove_task,
    update_task,
)
from src.model import Task

ROOT = Path(__file__).resolve().parent
TEMPLATES_DIR = ROOT / "templates"
INDEX_HTML = TEMPLATES_DIR / "index.html"

app = FastAPI()

origins = [
    "http://localhost:3000",
    "http://localhost:5173",
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


class HealthCheck(BaseModel):
    status: str = "OK"


@app.get("/")
async def read_root():
    if INDEX_HTML.is_file:
        return FileResponse(INDEX_HTML)
    else:
        raise Exception(f"Invalid path or file {INDEX_HTML}")


@app.get("/health", response_model=HealthCheck, status_code=status.HTTP_200_OK)
async def get_health():
    return HealthCheck(status="OK")


@app.get("/api/task")
async def get_task():
    response = await fetch_all_tasks()
    return response


@app.get("/api/task/{title}", response_model=Task)
async def get_task_by_title(title):
    response = await fetch_one_task(title)
    if response:
        return response
    raise HTTPException(404, f"There is no task with the title {title}")


@app.post("/api/task", response_model=Task)
async def post_task(task: Task):
    response = await create_task(task.dict())
    if response:
        return response
    raise HTTPException(400, "Something went wrong")


@app.put("/api/task/{title}", response_model=Task)
async def put_task(title: str, desc: str):
    response = await update_task(title, desc)
    if response:
        return response
    raise HTTPException(404, f"There is no task with the title {title}")


@app.delete("/api/task/{title}")
async def delete_task(title):
    response = await remove_task(title)
    if response:
        data = {"message": "Successfully deleted task!", "success": True}
        return data
    raise HTTPException(404, f"There is no task with the title {title}")
