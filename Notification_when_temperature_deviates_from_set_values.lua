--- Domoticz: Notification when temperature deviates from set values | https://github.com/flemmingss/

--- Configuration
local temp_device = "Refrigerator temperature" --- Name of temperature device
local warning_sent_uservar = "refrigerator_warning_sent" --- name of UserVariable (string)
local upper_temp_limit = 10 --- Upper temp value
local lower_temp_limit = 0 --- lower temp value
local temp = tonumber(otherdevices_svalues[temp_device]) -- Sensor data to number

---Notification: If it is to hot
local msg_upper_subject = "Refrigerator"
local msg_upper_body = "Warning! The temperature is above " .. upper_temp_limit .. "ºC! (" .. temp .. "ºC)"
local msg_upper_pri = "1"

---Notification: If it is to cold
local msg_lower_subject = "Refrigerator"
local msg_lower_body = "Warning! The temperature is below " .. lower_temp_limit .. "ºC! (" .. temp .. "ºC)"
local msg_lower_pri = "1"

--------------------------------------------------------------------------------

commandArray = {}

if (upper_temp_limit < temp and uservariables[warning_sent_uservar] ~= "true") then
    commandArray['SendNotification']=''..msg_upper_subject..'#'..msg_upper_body..'#'..msg_upper_pri..''
    print("Notification sent - Subject: \"" .. msg_upper_subject .. "\" Body: \"" .. msg_upper_body .. "\" Priority: \"" .. msg_upper_pri .. "\"")
    commandArray['Variable:' .. warning_sent_uservar]='true'
  
elseif (lower_temp_limit > temp and uservariables[warning_sent_uservar] ~= "true") then
    commandArray['SendNotification']=''..msg_lower_subject..'#'..msg_lower_body..'#'..msg_lower_pri..''
    print("Notification sent - Subject: \"" .. msg_lower_subject .. "\" Body: \"" .. msg_lower_body .. "\" Priority: \"" .. msg_lower_pri .. "\"")
    commandArray['Variable:' .. warning_sent_uservar]='true'
  
elseif (upper_temp_limit > temp and lower_temp_limit < temp) then
    commandArray['Variable:' .. warning_sent_uservar]='false'
    
end

return commandArray