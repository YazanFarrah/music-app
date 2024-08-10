from fastapi import FastAPI
from models.base import Base
from routes import auth, song
from database import engine

app = FastAPI()

app.include_router(auth.router, prefix='/auth')
app.include_router(song.router, prefix='/song')

# To create the table in the database
Base.metadata.create_all(engine)
