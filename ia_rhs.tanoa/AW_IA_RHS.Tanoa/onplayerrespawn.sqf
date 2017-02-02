/*
@filename: onPlayerRespawn.sqf
Author:
	
	Quiksilver

Last modified:

	29/10/2014 ArmA 1.32 by Quiksilver
	
Description:

	Client scripts that should execute after respawn.
______________________________________________________*/

private ["_iamhelipilot"];

waitUntil {!isNull player};
waitUntil {player == player};

private _uid = getPlayerUID player;
					//AzE
private _allowed = ["76561197960586000"];

if ( !isTFU && !(_uid in _allowed) ) then {
	private _helipilots = ["rhsusf_army_ocp_helipilot", "rhsusf_airforce_jetpilot"];
	private _jetpilots = ["rhsusf_airforce_jetpilot", "rhsusf_army_ocp_helipilot"];
	private _snipers = ["rhsusf_army_ocp_sniper"];
	 
	private _isHPilot = (({typeOf player == _x} count _helipilots) > 0);
	private _isJPilot = (({typeOf player == _x} count _jetpilots) > 0);
	private _isSniper = (({typeOf player == _x} count _snipers) > 0);
	
	if ( _isHPilot || _isJPilot || _isSniper ) exitWith {
		[] spawn {
			systemChat "warning";
			99 cutText ["Pilot and sniper classes are restricted to members of TFU only. Apply for membership at http://taskforceunicorn.com.", "BLACK", 2, true];
			sleep 15;
			endMission "NOT_ALLOWED";
		};
	};
};
//=========================== Fatigue setting
if (PARAMS_Fatigue == 0) then {player enableFatigue FALSE;};

//=========================== Airdrop
_pilots = ["rhsusf_army_ocp_helipilot", "rhsusf_airforce_jetpilot"];
_iampilot = ({typeOf player == _x} count _pilots) > 0;
if (_iampilot && PARAMS_HeliDrop != 0) then {
	player addAction ["Drop supply crate",QS_fnc_airDrop,[],0,false,true,'','[] call QS_fnc_conditionAirDrop'];
};

//============================= UAV
_uavop = ["rhsusf_army_ocp_uav"];
_iamuavop = ({typeOf player == _x} count _uavop) > 0;

if (_iamuavop) then {
	player addAction ["Load new UAV software",QS_fnc_actionUAVSoftware,[],20,true,true,'','[] call QS_fnc_conditionUAVSoftware'];
};

//====================== Seating and Clear vehicle inventory stuff
saving_inventory = FALSE;
inventory_cleared = FALSE;
player setVariable ["seated",FALSE];
player addAction ["Clear vehicle inventory",QS_fnc_actionClearInventory,[],-97,FALSE,FALSE,'','[] call QS_fnc_conditionClearInventory'];

//====================== Right billboard Image Randomiser
if ( isNil "imageList" ) then { imageList = [1,2,3,4,5,6]; };
if ( (count imageList) == 0 ) then { imageList = [1,2,3,4,5,6]; };
_bill = imageList call BIS_fnc_selectRandom;
if (_bill == 1) then {Bill_2 setObjectTexture [0,"media\images\billboard1.paa"]};
if (_bill == 2) then {Bill_2 setObjectTexture [0,"media\images\billboard2.paa"]};
if (_bill == 3) then {Bill_2 setObjectTexture [0,"media\images\billboard3.paa"]};
if (_bill == 4) then {Bill_2 setObjectTexture [0,"media\images\billboard4.paa"]};
if (_bill == 5) then {Bill_2 setObjectTexture [0,"media\images\billboard5.paa"]};
if (_bill == 6) then {Bill_2 setObjectTexture [0,"media\images\billboard6.paa"]};
imageList = imageList - [_bill];
//Bill_2 setObjectTexture [0,"media\images\billboardNoel.paa"];

//======================= Remove any rf7800str radio and give a anprc152 instead
for "_i" from 1 to 999 do {
	scopeName "radioLoop";
	_cur = format["tf_rf7800str_%1",_i];
	if ( (call TFAR_fnc_activeSwRadio) == _cur ) then {
		player unlinkItem _cur;
		player linkItem "tf_anprc152";
		systemChat "RF-7800 replaced by an AN/RPC-152";
		breakOut "radioLoop";
	};
};

//======================= Configure ShortWave radio if player got one
sleep 3;
if ( call TFAR_fnc_haveSWRadio ) then {
	[(call TFAR_fnc_activeSwRadio), 1, "300"] call TFAR_fnc_SetChannelFrequency;
	[(call TFAR_fnc_activeSwRadio), 2, "310"] call TFAR_fnc_SetChannelFrequency;
	[(call TFAR_fnc_activeSwRadio), 3, "320"] call TFAR_fnc_SetChannelFrequency;
	[(call TFAR_fnc_activeSwRadio), 4, "330"] call TFAR_fnc_SetChannelFrequency;
	[(call TFAR_fnc_activeSwRadio), 5, "340"] call TFAR_fnc_SetChannelFrequency;
	[(call TFAR_fnc_activeSwRadio), 6, "350"] call TFAR_fnc_SetChannelFrequency;
	[(call TFAR_fnc_activeSwRadio), 7, "360"] call TFAR_fnc_SetChannelFrequency;
	[(call TFAR_fnc_activeSwRadio), 8, "370"] call TFAR_fnc_SetChannelFrequency;
	//systemChat "ShortWave Frequencies set";
};

//======================= Configure LongRange radio if player got one
if ( call TFAR_fnc_haveLRRadio ) then {
	[(call TFAR_fnc_activeLrRadio), 1, "50"] call TFAR_fnc_SetChannelFrequency;
	[(call TFAR_fnc_activeLrRadio), 2, "60"] call TFAR_fnc_SetChannelFrequency;
	[(call TFAR_fnc_activeLrRadio), 3, "70"] call TFAR_fnc_SetChannelFrequency;
	[(call TFAR_fnc_activeLrRadio), 4, "80"] call TFAR_fnc_SetChannelFrequency;
	[(call TFAR_fnc_activeLrRadio), 5, "90"] call TFAR_fnc_SetChannelFrequency;
	[(call TFAR_fnc_activeLrRadio), 6, "100"] call TFAR_fnc_SetChannelFrequency;
	[(call TFAR_fnc_activeLrRadio), 7, "110"] call TFAR_fnc_SetChannelFrequency;
	[(call TFAR_fnc_activeLrRadio), 8, "120"] call TFAR_fnc_SetChannelFrequency;
	[(call TFAR_fnc_activeLrRadio), 9, "130"] call TFAR_fnc_SetChannelFrequency;
	//systemChat "LongRange Frequencies set";
};

//======================= Auto Earplugs
_null = [] execVM "scripts\vas\earplugs.sqf";
