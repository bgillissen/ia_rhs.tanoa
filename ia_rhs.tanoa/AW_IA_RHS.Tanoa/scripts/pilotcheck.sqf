_helipilots = ["rhsusf_army_ocp_helipilot", "rhsusf_airforce_jetpilot"];
_jetpilots = ["rhsusf_airforce_jetpilot", "rhsusf_army_ocp_helipilot"];

_heli_nocopilot = ["RHS_UH60M", 
				   "RHS_UH60M_MEV2",
				   "RHS_CH_47F_10", 
				   "rhsusf_CH53E_USMC_D", 
				   "RHS_MELB_AH6M_M"];

waitUntil {player == player};

_iamhelipilot = ({typeOf player == _x} count _helipilots) > 0;
_iamjetpilot = ({typeOf player == _x} count _jetpilots) > 0;

while { true } do {

	if(vehicle player != player) then {
		_veh = vehicle player;
		//------------------------------ only helipilot
		if((_veh isKindOf "Helicopter") && !(_veh isKindOf "ParachuteBase")) then {
			if(({typeOf _veh == _x} count _heli_nocopilot) > 0) then {
				_forbidden = [_veh turretUnit [0]];
				if(player in _forbidden) then {
					if (!_iamhelipilot) then {
						systemChat "Co-pilot seat is disabled on this helicopter";
						player action ["getOut",_veh];
					};
				};
			};
			if(!_iamhelipilot) then {
				_forbidden = [driver _veh];
				if (player in _forbidden) then {
					systemChat "You must be a pilot to fly this helicopter";
					player action ["getOut", _veh];
				};
			};
		};
		//------------------------------ only jetpilot
		if((_veh isKindOf "Plane") && !(_veh isKindOf "ParachuteBase")) then {
			if(!_iamjetpilot) then {
				_forbidden = [driver _veh];
				if (player in _forbidden) then {
					systemChat "You must be a pilot to fly this aircraft";
					player action ["getOut", _veh];
				};
				_forbidden = [_veh turretUnit [0]];
				if(player in _forbidden) then {
					systemChat "Co-pilot seat is disabled on this aircraft";
					player action ["getOut",_veh];
				};
			};
		};
		sleep 4;
	};	
};

