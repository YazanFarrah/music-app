from fastapi import HTTPException, Header
import jwt

password_key = "password_key"


def auth_middleware(x_auth_token= Header()):
    try:
        if not x_auth_token:
            raise HTTPException(401, "Not authorized")
        verified_token = jwt.decode(x_auth_token, password_key, ["HS256"])
        if not verified_token:
            raise HTTPException(401, "Authorization failed")
        
        uid = verified_token.get("id")  # calling get and not ['id'] because get returns None if not there, it throws exception
        return {"uid":uid, "token": x_auth_token}
    except jwt.PyJWTError:
        raise HTTPException(401, "Invalid token")