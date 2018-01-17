/*
 * Author: Commy2 and esteldunedain
 * Return true if the unit can unjam it's current weapon
 *
 * Arguments:
 * 0: Player <OBJECT>
 *
 * Return Value:
 * Bool
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_unit"];
TRACE_1("_unit",_unit);

private _jammedWeapons = _unit getVariable [QGVAR(jammedWeapons), []];
if !(currentWeapon _unit in _jammedWeapons) exitWith {
    false
};
if !([_unit] call CBA_fnc_canUseWeapon) exitWith {
    false
};
true
