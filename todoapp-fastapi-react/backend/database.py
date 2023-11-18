from model import Task
import motor.motor_asyncio  # MongoDB driver

client = motor.motor_asyncio.AsyncIOMotorClient("mongodb://mongo:27017")

# Erstelle Datenbank 'TaskList'
database = client.TaskList

# Erstelle Collection (Tabelle) 'task'
collection = database.task


# Funktion um bestimmten Task aus DB zu fetchen
async def fetch_one_task(title):
    document = await collection.find_one({"title": title})
    return document


# Funktion um alle Tasks aus DB zu fetchen
async def fetch_all_tasks():
    tasks = list()
    cursor = collection.find({})
    async for document in cursor:
        tasks.append(Task(**document))
    return tasks


# Funktion um neuen Task zu erstellen
async def create_task(task):
    document = task
    result = await collection.insert_one(document)
    return document


# Funktion um bestimmten Task zu ändern
async def update_task(title, description):
    await collection.update_one(
        {"title": title}, {"$set": {"description": description}}
    )
    document = await collection.find_one({"title": title})
    return document


# Funktion um bestimmten Task zu löschen
async def remove_task(title):
    await collection.delete_one({"title": title})
    return True
