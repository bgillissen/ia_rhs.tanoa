/*
@filename: fn_vSetup02.sqf
Author:

	???
	
Last modified:

	22/10/2014 ArmA 1.32 by Quiksilver
	
Description:

	Apply code to vehicle
	vSetup02 deals with code that is already applied where it should be.
_______________________________________________*/

//============================================= CONFIG

private ["_u","_t"];

_u = _this select 0;
_t = typeOf _u;

if (isNull _u) exitWith {};

//============================================= ARRAYS

_blackVehicles = ["B_Heli_Light_01_armed_F"];									// black skin
_pinkVehicles = [];//["RHS_A10"];												// pink skin
_dropVeh = ["RHS_UH60M", "RHS_CH_47F_10", "rhsusf_CH53E_USMC_D", "RHS_C130J"];	// ammodrop capable
_uav = ["B_UAV_02_CAS_F","B_UAV_02_F","B_UGV_01_F","B_UGV_01_rcws_F"];			// UAVs

//============================================= SORT
//===== Add to Zeus

{_x addCuratorEditableObjects [[_u],false];} count allCurators;

//===== black camo

if (_t in _blackVehicles) then {
	for "_i" from 0 to 9 do {_u setObjectTextureGlobal [_i,"#(argb,8,8,3)color(0,0,0,0.6)"];};
};

//===== pink camo

if (_t in _pinkVehicles) then {
	_u setObjectTextureGlobal [0,"#(argb,8,8,3)color(1,0.75,0.84,0.3)"];
};

//===== Airdrop

if (_t in _dropVeh) then {
	_u setVariable ["airdrop_veh",TRUE,TRUE];
};

//===== UAV respawn fixer

if (_t in _uav) then {
	{deleteVehicle _x;} count (crew _u);
	[_u] spawn {
		_u = _this select 0;
		sleep 2;
		createVehicleCrew _u;
	};
};