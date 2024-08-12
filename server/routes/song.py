import uuid
from fastapi import APIRouter, Depends, File, Form, UploadFile

from database import get_db
from sqlalchemy.orm import Session

from middleware.auth_middleware import auth_middleware
import cloudinary
import cloudinary.uploader

from models.song import Song


router = APIRouter()

cloudinary.config( 
    cloud_name = "dzu0odl3p", 
    api_key = "177745614983671", 
    api_secret = "NdFMp0201iDlYIxMuwFIzz5HBaU", 
    secure=True
)

@router.post('/upload', status_code=201)
def upload_song(song: UploadFile = File(...), 
                thumbnail: UploadFile = File(...), 
                artist_name: str = Form(...), 
                song_name: str = Form(...), 
                hex_code: str = Form(...),
                db: Session = Depends(get_db),
                auth_dict = Depends(auth_middleware)):
    song_id = str(uuid.uuid4())
    song_res = cloudinary.uploader.upload(song.file, resource_type='auto', folder=f'songs/{song_id}')
    thumbnail_res = cloudinary.uploader.upload(thumbnail.file, resource_type='image', folder=f'songs/{song_id}')
    
    new_song = Song(
        id=song_id,
        song_name=song_name,
        artist=artist_name,
        hex_code=hex_code,
        song_url=song_res['url'],
        thumbnail_url = thumbnail_res['url'],
    )

    db.add(new_song)
    db.commit()
    db.refresh(new_song)
    return new_song

@router.get('/list')
def songs_list(db: Session= Depends(get_db),
               auth_details = Depends(auth_middleware)):
    songs = db.query(Song).all()
    return songs