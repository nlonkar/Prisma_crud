from fastapi import FastAPI
from prisma import Prisma,register
import schemas


prisma = Prisma()
prisma.connect()
register(prisma)

app = FastAPI()


@app.get("/mqtt_client/")
def get_all_client():
    users = prisma.mqtt_client.find_many()
    return users

@app.get("/mqtt_client/{Id}")
def get_one_client(id: int):
    user = prisma.mqtt_client.find_unique(where={"id": id})
    return user

@app.put("/mqtt_client/{Id}")
def update_client(id: int, email: str, name: str):
    # user = prisma.user.find_unique(where={"id": id})
    updated = prisma.mqtt_client.update(where={"id": id}, data={"email": email, "name": name})
    return updated

@app.delete("/mqtt_client/{Id}")
def delete_client(id: int):
    prisma.mqtt_client.delete(where={"id": id})
    return "Deleted Successffuly"

@app.get("/mqtt_broker/")
def get_all_broker():
    all = prisma.mqtt_broker.find_many()
    return all

@app.get("/mqtt_broker/{id}")
def get_one_broker(id: int):
    one = prisma.mqtt_broker.find_unique(where={"id": id})
    return one


@app.post("/mqtt_broker/")
def create_broker(broker:schemas.mqt):
    new = prisma.mqtt_broker.create({"name": broker.name,"address": broker.address,"port":broker.port})
    return new


@app.put("/mqtt_broker/{id}")
def update_broker(id: int, name: str, address: str, port: int):
    update = prisma.mqtt_broker.update(where={"id": id}, data={"name": name, "address": address, "port": port})
    return update


@app.delete("/mqtt_broker/{id}")
def delete_broker(id: int):
    prisma.mqtt_broker.delete(where={"id": id})
    return "deleted successfully"
    #    print("error")
        #prisma.mqtt_broker.delete(clt)
    #else:
        #prisma.mqtt_broker.delete(clt)
        #return "deleted"

@app.get("/modbus_function/")
def Get_modbus_function():
    mod = prisma.modbus_function.find_many()
    return mod

@app.get("/modbus_function/{id}")
def get_one_modbus_function(id: int):
    cmp = prisma.modbus_function.find_unique(where={"id": id})
    return cmp

@app.post("/modbus_function/")
def create_modbus_function(modbus:schemas.modbus_function):
    ccmp = prisma.modbus_function.create({"name":modbus.name,"val":modbus.val})
    return ccmp
@app.put("/modbus_function/{id}")
def update_modbus_function(id :int,modbus:schemas.modbus_function):
    ucmp = prisma.modbus_function.update(where={"id": id },data={"name": modbus.name,"val":modbus.val})
    return ucmp

@app.delete("/modbus_function/{id}")
def delete_modbus_function(id : int):
    prisma.modbus_function.delete(where={"id": id})
    return "deleted"

@app.get("/modbus_device/")
def get_modbus_device():
    cmd = prisma.modbus_device.find_many()
    return cmd
@app.get("/modbus_device/{id}")
def get_one_modbus_device(id: int):
    comd = prisma.modbus_device.find_unique(where ={"id": id})
    return comd
@app.post("/modbus_device/")
def create_modbus_device(md:schemas.modbus_device):
    ccmd = prisma.modbus_device.create({"name":md.name})
    return ccmd
@app.put("/modbus_device/{id}")
def update_client_modbus_dataset(id: int,md:schemas.modbus_device):
    ucmd = prisma.modbus_device.update(where= {"id": id}, data={"name":md.name})
    return ucmd
@app.delete("/modbus_device/{id}")
def delete_client_modbus_dataset(id : int):
    prisma.modbus_device.delete(where={"id": id})
    return "deleted successfully"

@app.get("/modbus_device_dataset/")
def get_modbus_device_dataset():
    mdd=prisma.modbus_device_dataset.find_many()
    return mdd

@app.get("/modbus_device_dataset/{id}")
def get_one_modbus_device_dataset(id:int):
    omdd =prisma.modbus_device_dataset.find_unique(where={"id": id})
    return omdd

@app.post("/modbus_device_dataset/")
#def create_modbus_device_dataset(dataset:schemas.modbus_device_dataset):
    #cmdd = prism.
@app.get("/modbus_type/")
def get_modbus_type():
    mt = prisma.modbus_type.find_many()
    return mt

@app.get("/modbus_type/{id}")
def get_modbus_by_Id(id : int):
    mbi = prisma.modbus_type.find_unique(where={"id" : id})
    return mbi

@app.post("/modbus_type/")
def create_modbus_type(modtype:schemas.modbustype):
    cmt = prisma.modbus_type.create({"Name":modtype.Name,"ModifiedBy":modtype.ModifiedBy,"IsActive":modtype.IsActive})
    return cmt

@app.put("/modbus_type/{id}")
def update_modbus_type(id :int,Name:str,IsActive:bool):
    umt = prisma.modbus_type.update(where = {"id":id}, data ={"Name": Name,"IsActive":IsActive})
    return umt

@app.delete("/modbus_type/{id}")
def delete_modbus_type(id: int):
    prisma.modbus_type.delete(where={"id": id})
    return "Deleted Successffuly"