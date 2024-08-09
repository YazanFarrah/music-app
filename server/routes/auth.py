import uuid
import bcrypt
from fastapi import Depends, HTTPException, Header
from fastapi import APIRouter
import jwt

from database import get_db
from middleware.auth_middleware import auth_middleware

from models.user import User
from pydantic_schema.user_create import UserCreate
from sqlalchemy.orm import Session

from pydantic_schema.user_login import UserLogin

router = APIRouter()

password_key = "password_key"


@router.post('/signup', status_code=201)
def signup_user(user: UserCreate, db: Session = Depends(get_db)):
    # Check if user already exists
    user_db = db.query(User).filter(User.email == user.email).first()
    
    if user_db:
        raise HTTPException(400, "User already exists")


    # Convert UserCreate to User model
    hashed_pw = bcrypt.hashpw(user.password.encode(), bcrypt.gensalt())
    db_user = User(
        id=str(uuid.uuid4()),
        name=user.name,
        email=user.email,
        password=hashed_pw,
        birthday=user.birthday,
        gender=user.gender
    )
    
    # Add user to the database
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return db_user.to_dict()  # Use the to_dict method

@router.post('/login')
def login_user(user: UserLogin, db: Session = Depends(get_db)):
    user_db = db.query(User).filter(User.email == user.email).first()
    
    if not user_db:
        raise HTTPException(400, "User doesn't exist")
    
    is_match = bcrypt.checkpw(user.password.encode(), user_db.password)
    if not is_match:
        raise HTTPException(400, "Incorrect Password")
    token = jwt.encode({"id": user_db.id}, password_key)
    
    return {"token": token, "user": user_db }
        
        
@router.get('/')
def current_user_data(db: Session=Depends(get_db), 
                      user_dict = Depends(auth_middleware)):
    user = db.query(User).filter(User.id == user_dict['uid']).first()

    if not user:
        raise HTTPException(404, 'User not found!')
    
    return user


    
