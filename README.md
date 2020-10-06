# Task
This project was all about answering questions based on the query results. 
To the right of the table, I ran analysis on the table and answered the question posed by the question. 
Analyzed results and provided recommendations on how to use the data.

# The data
MIN: Mobile Identification Number: unique number assigned by the wireless service provider. (account #)
MDN: The phone number
IMEI: International Mobile Equipment Identity: unique number for identifying a device on a mobile network. (like your vehicles VIN)
There are 6 tables in the sample of Excelsior Mobile's DB.

Subscriber: Subscriber information including address, MDN and MIN.
Device: information about the devices used at Excelsior Mobile and has IMEI
DirNums: identifys the city and state of each MDN and connects it with an IMEI
MPlan: table of the plans used at Excelsior Mobile. Has data, throttle and cost
Bill: table of the current bills for each MIN, includes bill costs
LastMonthUsage: table of the last month of usage for each MIN, includes minutes, data in MB and texts
