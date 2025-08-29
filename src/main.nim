import kina

let mode = "development"
let app_version = "0.0.1"

var daemon_server = "None"

const asciiArt = r"""
  _  ___              ____                            _       
 | |/ (_)_ __   __ _ / ___|___  _ __ ___  _ __  _   _| |_ ___ 
 | ' /| | '_ \ / _` | |   / _ \| '_ ` _ \| '_ \| | | | __/ _ \
 | . \| | | | | (_| | |__| (_) | | | | | | |_) | |_| | ||  __/
 |_|\_\_|_| |_|\__,_|\____\___/|_| |_| |_| .__/ \__,_|\__\___|
 |  ___|__  _   _ _ __   __| | __ _| |_(_)_|__  _ __          
 | |_ / _ \| | | | '_ \ / _` |/ _` | __| |/ _ \| '_ \         
 |  _| (_) | |_| | | | | (_| | (_| | |_| | (_) | | | |        
 |_|  \___/ \__,_|_| |_|\__,_|\__,_|\__|_|\___/|_| |_|        
                                                      
"""

echo asciiArt
echo "Starting the application. Please be patient."
echo "Initializing", " ", app_name
echo " "
echo "Copyright (C) KinaCompute Foundation"
