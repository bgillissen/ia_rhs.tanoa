/*
@filename: fn_conditionAirDrop.sqf
Author: 

	Quiksilver
	
Last modified:

	28/07/2014 ArmA 1.24 by Quiksilver
	
Description:

	Conditional use of heli supply drop
_____________________________________________________________________________*/

private ["_veh","_cond"];

#define MIN_HEIGHT 40
_veh = vehicle player;
_cond = ( (AW_ammoDropAvail) && (_veh != player) && (_veh getVariable "airdrop_veh") && ((position _veh) select 2 >= MIN_HEIGHT) );

_cond;