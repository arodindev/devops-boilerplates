from pydantic import BaseModel


# Simples Model um Tabelle (oder Dokument) der MongoDB zu beschreiben
class Task(BaseModel):
    title: str
    description: str
