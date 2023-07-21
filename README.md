Project Overview
Kiron API is design to utilize KironTest database.
The datanase has user table to store usersname and password with hashpassword. 

KironAPI expose number of endpoints to create users , login enpoint to allow user to login then when succesful JWT token is returned to the client.

An BankHoliday endpoint is being expose to call exertenal API to retrieve UK bankHolidays and stored them in KironTest holiday tables.
also an Region creation endpoint is being exposed to get the regions in external API(https://www.gov.uk/bank-holidays.json) stored in Regions table.
Expose CoinStat endpoint which make call to retrieve the latest Coin Stats.

KironAPI run in visual studio 2020 6.0 .Net Core.

git clone the project
