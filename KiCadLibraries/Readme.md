# KiCAD config files

## kicad_common.json

kicad_common.json  

    "environment": {
    "vars": {
        "EXTERNAL_LIBRARIES": "/home/jon/Documents/KiCad/ExternalLibraries/",  
        "MY_3DMODELS": "/home/jon/Documents/KiCad/KiCadLibraries/3dmodels",  
        "MY_FOOTPRINTS": "/home/jon/Documents/KiCad/KiCadLibraries/Footprints",  
        "MY_LIBRARIES": "/home/jon/Documents/KiCad/KiCadLibraries",  
        "MY_SYMBOLS": "/home/jon/Documents/KiCad/KiCadLibraries/Symbols"  
    }  
    },  

## fp-lib-table

fp-lib-table  

    (lib (name "My_Arduino")(type "KiCad")(uri "\${MY_FOOTPRINTS}/Arduino.pretty")(options "")(descr "")(disabled))  
    (lib (name "My_Arduino2")(type "KiCad")(uri "\${MY_FOOTPRINTS}/Arduino2.pretty")(options "")(descr "")(disabled))  
    (lib (name "My_ESP32")(type "KiCad")(uri "\${MY_FOOTPRINTS}/ESP32.pretty")(options "")(descr "")(disabled))  
    (lib (name "My_ESP8266")(type "KiCad")(uri "\${MY_FOOTPRINTS}/ESP8266.pretty")(options "")(descr "")(disabled))  
    (lib (name "My_Headers")(type "KiCad")(uri "\${MY_FOOTPRINTS}/Headers.pretty")(options "")(descr "")(disabled))  
    (lib (name "My_Heatsinks")(type "KiCad")(uri "\${MY_FOOTPRINTS}/Heatsinks.pretty")(options "")(descr "")(disabled))  
    (lib (name "My_Misc")(type "KiCad")(uri "\${MY_FOOTPRINTS}/Misc.pretty")(options "")(descr "")(disabled))  
    (lib (name "My_Parts")(type "KiCad")(uri "\${MY_FOOTPRINTS}/Parts.pretty")(options "")(descr "")(disabled))  
    (lib (name "My_RaspberryPi")(type "KiCad")(uri "\${MY_FOOTPRINTS}/RaspberryPi.pretty")(options "")(descr "")(disabled))  
    (lib (name "My_SparkFun-Electromechanical")(type "KiCad")(uri "\${MY_FOOTPRINTS}/SparkFun-Electromechanical.pretty")(options "")(descr ""))  
    (lib (name "My_Standoff")(type "KiCad")(uri "\${MY_FOOTPRINTS}/Standoff.pretty")(options "")(descr "")(disabled))  
    (lib (name "My_usini_sensors")(type "KiCad")(uri "\${MY_FOOTPRINTS}/usini_sensors.pretty")(options "")(descr ""))  
    (lib (name "PCM_kikit")(type "KiCad")(uri "\${KICAD8_3RD_PARTY}/footprints/com_github_yaqwsx_kikit-library/kikit.pretty")(options "")(descr "Added by Plugin and Content Manager"))  
    (lib (name "Alarm-Siren")(type "KiCad")(uri "\${EXTERNAL_LIBRARIES}/arduino-kicad-library/footprints")(options "")(descr "")(disabled))  
    (lib (name "My_Arduino-Library")(type "KiCad")(uri "\${MY_FOOTPRINTS}/arduino-library.pretty")(options "")(descr "")(disabled))  
    (lib (name "MyFootprints")(type "KiCad")(uri "\${MY_FOOTPRINTS}/MyFootprints.pretty")(options "")(descr ""))  

## sym-lib-table

sym-lib-table  

    (lib (name "My_arduino_alarm-siren")(type "KiCad")(uri "\${MY_SYMBOLS}/arduino_alarm-siren.kicad_sym")(options "")(descr ""))
    (lib (name "My_SparkFun-Electromechanical")(type "KiCad")(uri "${MY_SYMBOLS}/SparkFun-Electromechanical.kicad_sym")(options "")(descr ""))
    (lib (name "My_usini_sensors")(type "KiCad")(uri "${MY_SYMBOLS}/usini_sensors.kicad_sym")(options "")(descr ""))
    (lib (name "PCM_kikit")(type "KiCad")(uri "${KICAD8_3RD_PARTY}/symbols/com_github_yaqwsx_kikit-library/kikit.kicad_sym")(options "")(descr "Added by Plugin and Content Manager"))
    (lib (name "My_alarm-Siren")(type "KiCad")(uri "${EXTERNAL_LIBRARIES}/arduino-kicad-library/symbols/arduino-library.kicad_sym")(options "")(descr ""))
    (lib (name "My_arduino-Library")(type "KiCad")(uri "${MY_SYMBOLS}/arduino-library.kicad_sym")(options "")(descr ""))
    (lib (name "My_Symbols")(type "KiCad")(uri "${MY_SYMBOLS}/My_Symbols.kicad_sym")(options "")(descr ""))
