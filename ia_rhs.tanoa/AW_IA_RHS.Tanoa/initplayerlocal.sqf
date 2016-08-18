enableSentences FALSE;															
enableSaving [FALSE,FALSE];
player enableFatigue FALSE;

//------------------------------------------------ Handle parameters
for [ {_i = 0}, {_i < count(paramsArray)}, {_i = _i + 1} ] do {
	call compile format
	[
		"PARAMS_%1 = %2",
		(configName ((missionConfigFile >> "Params") select _i)),
		(paramsArray select _i)
	];
};

//------------------- client executions
_null = [] execvm "scripts\vehicle\crew\crew.sqf"; 								// vehicle HUD
//_null = [] execVM 'scripts\group_manager.sqf';								// group manager
_null = [] execVM "scripts\restrictions.sqf"; 									// gear restrictions and safezone
_null = [] execVM "scripts\pilotCheck.sqf"; 									// pilots only
_null = [] execVM "scripts\crewCheck.sqf"; 										// tank crew only
_null = [] execVM "scripts\jump.sqf";											// jump action
_null = [] execVM "scripts\misc\diary.sqf";										// diary tabs	
_null = [] execVM "scripts\icons.sqf";											// blufor map tracker Quicksilver
_null = [] execVM "scripts\VAclient.sqf";										// Virtual Arsenal
_null = [] execVM "scripts\misc\Intro.sqf";										// AW intro screen
_null = [] execVM "scripts\voice_control\voiceControl.sqf";						// Voice Control
if (PARAMS_HeliRope != 0) then {call compile preprocessFileLineNumbers "scripts\vehicle\fastrope\zlt_fastrope.sqf";};

[] call QS_fnc_respawnHeli;
[] call QS_fnc_respawnJet;
[] call QS_fnc_respawnCrew;


//-------------------- PVEHs
"addToScore" addPublicVariableEventHandler
{
	((_this select 1) select 0) addScore ((_this select 1) select 1);
};

//tawvd_disablenone = false;

//--------------------- Arty Computer
enableEngineArtillery false;
if (player isKindOf "rhsusf_army_ocp_fso") then {
	enableEngineArtillery true;
};
if (player isKindOf "rhsusf_army_ocp_crewman") then {
	enableEngineArtillery true;
};

//--------------------- Squad Manager
["InitializePlayer", [player, true]] call BIS_fnc_dynamicGroups;

//--------------------- Fixed Billboard
Bill_1 setObjectTexture [0,"media\images\billboardTFAR.paa"];

//--------------------- Squad Url Hint
_infoArray = squadParams player;    
_infoSquad = _infoArray select 0;
_squad = _infoSquad select 1;
_infoName = _infoArray select 1;
_name = _infoName select 1; 
_email = _infoSquad select 2;

// replace line below with your Squad xml's email
if (_email == "rainman@taskforceunicorn.com") then {
	_GlobalHint = format["<t align='center' size='2.2' color='#FAAF3A'>%1<br/></t><t size='1.4' color='#33CCFF'>%2</t><br/>has joined the server, To become a TFU member, apply to taskforceunicorn.com</t><br/>",_squad,_name];
	[_GlobalHint] remoteExec ["AW_fnc_globalHint",0,false];
};






