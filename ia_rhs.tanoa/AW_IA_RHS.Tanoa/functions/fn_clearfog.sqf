/*
@filename: fn_clearfog.sqf
Author: 

	Ben
	
Last modified:

	25/10/2016

Description: 

	Reset Fog to Zero

___________________________________________________________________________*/

0 setFog 0;
forceWeatherChange;
systemChat "Fog Cleared";