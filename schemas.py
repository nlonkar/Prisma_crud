from pydantic import BaseModel

class mqt(BaseModel):
    name:str
    address:str
    port:int


class modbustype(BaseModel):
    Name:str
    ModifiedBy:str
    IsActive:bool

class modbus_function(BaseModel):
    name:str
    val:int

class modbus_device(BaseModel):
    name:str

class modbus_device_dataset(BaseModel):
    address:int
    name:str
    function_profile_id:int