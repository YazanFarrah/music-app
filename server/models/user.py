from models.base import Base
from pydantic_schema.user_create import Gender
from sqlalchemy import TEXT, VARCHAR, Column,  Enum as SQLAEnum, Date, LargeBinary


class User(Base):
    __tablename__ = 'users'
    id = Column(TEXT, primary_key=True)
    name = Column(VARCHAR(100))  # Specifying the max characters
    email = Column(VARCHAR(100))
    password = Column(LargeBinary)
    birthday = Column(Date)
    gender = Column(SQLAEnum(Gender))

    def to_dict(self):
        return {
            "id": self.id,
            "name": self.name,
            "email": self.email,
            "birthday": self.birthday.strftime('%d %B %Y'),  # Format the date as a string
            "gender": self.gender.value,
        }