### installations
  * install kakaotalk without any components
  * don't install riched20, riched30
    - rich editor components conflict with lastest kakaotalk version 3.x (win 10 version)
  * some conponents are helpful
    - wmp9, wmp10 : sounds
    - gdiplus : clear emoticons

### configure wine
  * setup wine 
    - input problems on chatting rooms : duplicated keys are added
  * Add a registry key to change input method config
    - configure - wine - Registry Editor
    - 1. make a key
      - 'HKEY_CURRENT_USER\Software\Wine\X11 Driver'
    - 2. add a string
      - 'inputStyle'
    - 3. set data as 
      - 'root'
