import motor.motor_asyncio
from decouple import config

from src.model import Task

# client = motor.motor_asyncio.AsyncIOMotorClient("mongodb://mongo:27017")
MONGODB_URI = config("MONGODB_URI")
client = motor.motor_asyncio.AsyncIOMotorClient(MONGODB_URI)

database = client.TaskList

collection = database.task


async def fetch_one_task(title):
    document = await collection.find_one({"title": title})
    return document


async def fetch_all_tasks():
    tasks = list()
    cursor = collection.find({})
    async for document in cursor:
        tasks.append(Task(**document))
    return tasks


async def create_task(task):
    document = task
    _ = await collection.insert_one(document)
    return document


async def update_task(title, description):
    await collection.update_one(
        {"title": title}, {"$set": {"description": description}}
    )
    document = await collection.find_one({"title": title})
    return document


async def remove_task(title):
    await collection.delete_one({"title": title})
    return True
