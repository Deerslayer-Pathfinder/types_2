import times
import re, strutils
import types
proc toUnix(date: string): int64 =
  try:
    return date.parse("dd'.'MM'.'YYYY").toTime.toUnix
  except TimeParseError:
    stderr.write(getCurrentExceptionMsg() & "\n")
    return result

proc toStr(date: int64): string =
  fromUnix(date).format("dd'.'MM'.'YYYY")

proc checkStr[T](data: T): bool =
  var pattern: Regex
  pattern = re"^([A-Za-z]{2,})$"
  data.match(pattern)

proc checkDigit[T](data: T): bool =
    data > 0

template getAttrValue(obj, attr): auto = obj.attr

template setDate*(obj, attr; date: string) =
  obj.attr = date.toUnix

template setAttrValue*(
    obj, attr, value, checkFunc) =
  if checkFunc(value):
    obj.attr = value

proc setManagerPost*(self: Manager, post: string) =
  try:
    self.post = parseEnum[Post](post)
  except ValueError:
    stderr.write("Нет такой должности $1\n" % post)
    self.post = NONE


template initStaff*(varName;
                   nameValue,
                   birthDateValue: string,
                   uidValue : int) =
  let varName = Staff()
  varName.setAttrValue(name, nameValue, checkStr)  
  varName.setDate(birthDate, birthDateValue)
  varName.setAttrValue(uid, uidValue, checkDigit)

template initManager*(varName;
                   nameValue, postValue : string) =
  let varName = Manager()
  varName.setAttrValue(name, nameValue, checkStr)
  varName.setManagerPost(postValue)
  
template initPet*(varName;
                  nameValue: string, 
                  ageValue: int) =
  let varName = Pet()
  varName.setAttrValue(name, nameValue, checkStr)
  varName.setAttrValue(age, ageValue, checkDigit)  

proc `$`*(self: Staff): string =
  "Персонал : $1 \n   День рождения : $2 \n   UID: $3" % [
    self.getAttrValue(name),    
    self.getAttrValue(birthDate).toStr,
    $self.getAttrValue(uid)
  ]

proc `$`*(self: Manager): string =
  "Управление : $1 \n   Должность: $2" % [
    self.getAttrValue(name),
    $self.getAttrValue(post)
  ]

proc `$`*(self: Pet): string =
  "Питомец : Кличка '$1' \n   Возраст:  $2" % [
    self.getAttrValue(name),    
    $self.getAttrValue(age)
  ]

