from fastapi import HTTPException
from pydantic import BaseModel, validator
from datetime import datetime

from enums.gender_enum import Gender




class UserCreate(BaseModel):
    name: str
    email: str
    password: str
    birthday: str  # String format: 'day month year'
    gender: Gender
    
    @validator('birthday')
    def validate_birthday(cls, v):
        try:
            # Parse date from 'day month year' format
            return datetime.strptime(v, '%d %B %Y').date()
        except ValueError:
            raise HTTPException(status_code=400, detail="Invalid date format. Use 'day month year'.")