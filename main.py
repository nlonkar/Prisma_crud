from fastapi import FastAPI
from  prisma import Prisma,register

prisma = Prisma()
prisma.connect()
app = FastAPI()


@app.get("/")
def get_all():
    users = prisma.user.find_many()
    return users

@app.get("/{Id}")
def get_one(id: int):
    user = prisma.user.find_unique(where={"id": id})
    return user

@app.post("/")
def Create(email: str,name:str):
    user =prisma.user.create({"email":email, "name":name})
    return user

@app.put("/")
def update(id: int,email: str,name:str):
    #user = prisma.user.find_unique(where={"id": id})
    updated =prisma.user.update(where={"id": id},data={"email":email, "name":name})
    return updated

@app.delete("/")
def delete(id: int):
    prisma.user.delete(where={"id": id})
    return "Deleted Successffuly"