OFCRA_UNITES_CIBLES = "HUMAINS+IA";			// parmi {HUMAINS+IA|HUMAINS}
OFCRA_LISTE_INFANTERIE_EXCEPTIONS = [];		// tableau de noms d'unit�s entre-guillemets � ne pas �quiper, ex: ["nom1", "nom2"]
OFCRA_TENUES_BLUEFOR = "MARPAT_DESERT";		// parmi {UCP|OCP|SOC|MARPAT_WOOD|MARPAT_DESERT}
OFCRA_TENUES_REDFOR = "M88";				// parmi {VDV|VDV-M|MSV_DIGITAL|MSV_FLORA|SPETZ|M88}

////////// NE PAS TOUCHER EN DESSOUS

_handle = execVM  "ofcra\gears_infantry\library.sqf";
waitUntil {isNull _handle};
_handle = execVM  "ofcra\gears_infantry\redfor_weapons.sqf";
waitUntil {isNull _handle};
_handle = execVM  "ofcra\gears_infantry\redfor_clothes.sqf";
waitUntil {isNull _handle};
_handle = execVM "ofcra\gears_infantry\bluefor_weapons.sqf";
waitUntil {isNull _handle};
_handle = execVM "ofcra\gears_infantry\bluefor_clothes.sqf";
waitUntil {isNull _handle};

diag_log "[OFCRA] INFO: setting infantry gears ...";
systemChat "Setting gears for infantry";


_targeted_units = nil;
switch(OFCRA_UNITES_CIBLES) do {
	case "HUMAINS+IA":	{ _targeted_units = allUnits; };
	case "HUMAINS":		{ _targeted_units = playableUnits; };
	default	{
		_log = "param _UNITES_CIBLES incorrect: '" + _UNITES_CIBLES + "'";
		[_log, "ERROR"] call ofcra_fnc_log;
		_targeted_units = [];
	};
};

{
	uiSleep 0.1;
	[_x] call ofcra_fnc_set_unit_gears;
	_x addEventHandler ["respawn", { [_this select 0] call ofcra_fnc_set_unit_gears}];
} forEach _targeted_units;

diag_log "[OFCRA] INFO: infantry gears done.";
