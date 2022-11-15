#define FILTERSCRIPT

#include <a_samp>
#include <a_http>

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print("Anti VPN by Aleks4k(Propalica)");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

forward MyHttpResponse(playerid, response_code, data[]);
public OnPlayerConnect(playerid){
	new ip[16], string[256];
	GetPlayerIp(playerid, ip, sizeof ip);
 	format(string, sizeof string, "www.ip-api.com/json/%s?fields=proxy,hosting", ip);
  	HTTP(playerid, HTTP_GET, string, "", "MyHttpResponse");
	return 1;
}

public MyHttpResponse(playerid, response_code, data[])
{
    if(strfind(data, "true", true) != -1)
    {
   	    SendClientMessage(playerid, 0xFF0000FF, "Disable your VPN and rejoin!");
   	    SetTimerEx("DelayedKick", 100, false, "i", playerid);
	}
	return 1;
}

forward DelayedKick(playerid);
public DelayedKick(playerid)
{
    Kick(playerid);
    return 1;
}
