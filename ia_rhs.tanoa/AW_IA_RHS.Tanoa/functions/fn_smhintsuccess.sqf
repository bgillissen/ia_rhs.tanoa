private ["_smRewards", "_smMarkerList", "_veh","_vehName","_vehVarname","_completeText","_reward","_mortar"];

_smRewards =
[
	["an UH-1Y Unarmed", "RHS_UH1Y_UNARMED_d"],
	["an UH-1Y FFAR", "RHS_UH1Y_FFAR_d"],
	["an AH1Z Ground Support", "RHS_AH1Z_GS"],
	["an AH64D Ground Support", "RHS_AH64D_GS"],
	["a RG33 M2", "rhsusf_rg33_m2_usmc_wd"],
	["an Offraod (Repair)", "C_Offroad_01_repair_F"],
	["a Mobile Mortar Truck", "B_G_Offroad_01_repair_F"],
	["a M113 M2", "rhsusf_m113d_usarmy"],
	["a M109 Artillery Tank", "rhsusf_m109d_usarmy"],
	["a BM-21 Artillery Truck", "rhsgref_cdf_b_reg_BM21"],
	["a T-90", "rhs_t90_tv"]
];

_smMarkerList = ["smReward1","smReward2","smReward3","smReward4","smReward5","smReward6","smReward7","smReward8","smReward9","smReward10","smReward11","smReward12","smReward13","smReward14","smReward15","smReward16","smReward17","smReward18","smReward19","smReward20","smReward21","smReward22","smReward23","smReward24","smReward25","smReward26","smReward27"];

_veh = _smRewards call BIS_fnc_selectRandom;
_vehName = _veh select 0;
_vehVarname = _veh select 1;

_completeText = format[
"<t align='center'><t size='2.2'>Side Mission</t><br/><t size='1.5' color='#08b000'>COMPLETE</t><br/>____________________<br/>Fantastic job, lads! The OPFOR stationed on the island won't last long if you keep that up!<br/><br/>We've given you %1 to help with the fight. You'll find it at base.<br/><br/>Focus on the main objective for now; we'll relay this success to the intel team and see if there's anything else you can do for us. We'll get back to you in 1 minute.</t>",_vehName];

systemChat format["If the Side Mission bugs, please report this to ben : %1", _vehVarname];

_reward = createVehicle [_vehVarname, getMarkerPos "smReward1", _smMarkerList, 0, "NONE"];
waitUntil {!isNull _reward};

_reward setDir 284;

[_completeText] remoteExec ["AW_fnc_globalHint",0,false];
["CompletedSideMission", sideMarkerText] remoteExec ["AW_fnc_globalNotification",0,false];
_rewardtext = format["Your team received %1!", _vehName];
["Reward",_rewardtext] remoteExec ["AW_fnc_globalNotification",0,false];

if (_reward isKindOf "B_G_Offroad_01_repair_F") exitWith {
	_mortar = createVehicle ["B_Mortar_01_F", getMarkerPos "smReward1",smMarkerList,0,"NONE"];
	_mortar attachTo [_reward,[0,-2.5,.3]];
};

{
	_x addCuratorEditableObjects [[_reward], false];
} foreach allCurators;