/*
@filename: initServer.sqf
Author:
	
	Quiksilver

Last modified:

	23/10/2014 ArmA 1.32 by Quiksilver
	
Description:

	Server scripts such as missions, modules, third party and clean-up.
	
______________________________________________________*/

//------------------------------------------------ Handle parameters

for [ {_i = 0}, {_i < count(paramsArray)}, {_i = _i + 1} ] do {
	call compile format
	[
		"PARAMS_%1 = %2",
		(configName ((missionConfigFile >> "Params") select _i)),
		(paramsArray select _i)
	];
};

//-------------------------------------------------- Server scripts

if (PARAMS_AO == 1) then { _null = [] execVM "mission\main\missionControl.sqf"; };						// Main AO
if (PARAMS_SideObjectives == 1) then { _null = [] execVM "mission\side\missionControl.sqf";};			// Side objectives		

_null = [] execVM "scripts\misc\cleanup.sqf";															// cleanup
_null = [] execVM "scripts\misc\islandConfig.sqf";														// prep the island for mission

enableEnvironment FALSE;
BACO_ammoSuppAvail = true; publicVariable "BACO_ammoSuppAvail";

//-------------------------------------------------- Random start time

_skips = [1,2,3,4,5,6,7,8,9,10,11,12];
_skipTo = _skips call BIS_fnc_selectRandom;
skipTime _skipTo;

//-------------------------------------------------- Independent enemy to BLUFOR and friendly to OPFOR

independent setFriend [east, 1];
east setFriend [independent, 1];

independent setFriend [west, 0];
west setFriend [independent, 0];