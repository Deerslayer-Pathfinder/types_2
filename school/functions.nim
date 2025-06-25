import times
import re, strutils

import types

proc checkStr[T](data: T): bool =
  var pattern: Regex
  pattern = re"^([A-Za-z]{2,})$"
  data.match(pattern)

proc checkDigit[T](data: T): bool =
  data >= 1 and data <= 11

template getAttrValue(obj, attr): auto = obj.attr


template setAttrValue*(
    obj, attr, value, checkFunc) =
  if checkFunc(value):
    obj.attr = value

template initDirector*(varName; NameValue : string) =
  let varName = Director()
  varName.setAttrValue(name, NameValue, checkStr)
  
template initTeacher*(varName;
                  NameValue: string, ClassValue: int) =
  let varName = Teacher()
  varName.setAttrValue(name, NameValue, checkStr)
  varName.setAttrValue(class, ClassValue, checkDigit)
                                                     
template initStudent*(varName;
                  NameValue: string, ClassValue: int) =
  let varName = Student()
  varName.setAttrValue(name, NameValue, checkStr)
  varName.setAttrValue(class, ClassValue, checkDigit)  

proc `$`*(self: Director): string =
  "Директор : $1" % [
    self.getAttrValue(name)
  ]

proc `$`*(self: Teacher): string =
  "Учитель : $1 \n   Класс :  $2" % [
    self.getAttrValue(name),
    $self.getAttrValue(class)
  ]

proc `$`*(self: Student): string =
  "Учиник : $1 \n   Класс :  $2" % [
    self.getAttrValue(name),
    $self.getAttrValue(class)
  ]