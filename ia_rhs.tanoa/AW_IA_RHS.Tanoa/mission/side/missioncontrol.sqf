/*
Author: 

	Quiksilver

Last modified: 

	1/05/2014

Description:

	Mission control

To do:

	Rescue/capture/HVT missions
______________________________________________*/

private ["_mission","_missionList","_currentMission","_nextMission","_delay","_loopTimeout"];

//_delay = 300 + (random 600);
_delay = 60;
_loopTimeout = 10 + (random 10);

_missionList = [	
	"destroyUrban",
	"HQcoast",
	"HQfia",
	"HQind",
	"HQresearch",
	"priorityAA",	
	"priorityARTY",
	"priorityROCKET",
	"secureChopper",
	"secureRadar",
	"secureIntelUnit",
	"secureIntelVehicle"
	
];

SM_SWITCH = true; publicVariable "SM_SWITCH";
	
while { true } do {

	if (SM_SWITCH) then {
	
		hqSideChat = "Side objective assigned, stand-by for orders.";
		[hqSideChat] remoteExec ["AW_fnc_globalSideChat",0,false];
		
	
		sleep 3;
	
		_mission = _missionList call BIS_fnc_selectRandom;
		_currentMission = execVM format ["mission\side\missions\%1.sqf", _mission];
	
		waitUntil {
			sleep 3;
			scriptDone _currentMission
		};
	
		sleep _delay;
		
		SM_SWITCH = true; publicVariable "SM_SWITCH";
	};
	sleep _loopTimeout;
};


	
