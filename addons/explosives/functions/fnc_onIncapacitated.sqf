/*
 * Author: Garth 'L-H' de Wet
 * Detonates all attached deadman's switched triggered explosives.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * Handled by CBA
 *
 * Public: No
 */
#include "script_component.hpp"

//NOTE: Extended_Killed_EventHandlers runs only where _unit is local
params ["_unit"];
TRACE_1("params",_unit);

private ["_deadman"];

_deadman = [_unit, "DeadManSwitch"] call FUNC(getPlacedExplosives);
{
    [_unit, -1, _x, true] call FUNC(detonateExplosive);
} forEach _deadman;

//Handle deadman connected to explosive in inventory
private _connectedInventoryExplosive = _unit getVariable [QGVAR(deadmanInvExplosive), ""];
if (_connectedInventoryExplosive != "") then {
    if (!(_connectedInventoryExplosive in (magazines _unit))) exitWith {};

    //Remove mag and reset variable
    _unit removeMagazine _connectedInventoryExplosive;
    _unit setVariable [QGVAR(deadmanInvExplosive), "", true];

    private _ammo = getText (configFile >> "CfgMagazines" >> _connectedInventoryExplosive >> "ammo");
    TRACE_2("deadman inventory",_connectedInventoryExplosive,_ammo);
    private _magazineTrigger = configFile >> "CfgMagazines" >> _connectedInventoryExplosive >> "ACE_Triggers" >> "DeadmanSwitch";
    if (isText (_magazineTrigger >> "ammo")) then {
        _ammo = getText (_magazineTrigger >> "ammo");
    };

    private _explosive = createVehicle [_ammo, (getPos _unit), [], 0, "NONE"];
    _explosive setPosASL (getPosASL _unit);
    [_unit, -1, [_explosive, -1]] call FUNC(detonateExplosive); //Explode, ignoring range, with a random 0-1 second delay
};
