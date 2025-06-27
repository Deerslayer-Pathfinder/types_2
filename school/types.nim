type


  Director* = ref object of RootObj
    name* : string     
    
  Teacher* = ref object of RootObj
    name* : string
    class* : int
  
  Student* = ref object of RootObj
    name* : string
    class* : int 

  School* = ref object of RootObj
    director*: seq[Director]
    teacher*: seq[Teacher]
    student*: seq[Student]
      
  