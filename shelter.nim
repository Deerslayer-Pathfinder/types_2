import shelter/[functions]

when isMainModule:
  initManager(Manager, "Sidorov", "Бухгалтер")
  echo Manager
  
  initStaff(staff, "Petrov", "11.06.2001", 1)
  echo staff
  
  initPet(Pet, "Dgek", 6)
  echo Pet
