type
  Post* = enum
    NONE, Директор, Секретарь, Бухгалтер

  Staff* = ref object of RootObj    
    name*: string
    birthDate*: int64
    uid* : int
  
  Manager* = ref object of RootObj
      name* : string 
      post* : Post

  Pet* = ref object of RootObj
      name* : string
      age* : int

  Shelter* = ref object of RootObj
    staff*: seq[Staff]
    manager*: seq[Manager]
    pet*: seq[Pet]
    