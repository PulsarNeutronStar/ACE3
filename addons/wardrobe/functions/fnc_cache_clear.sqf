#include "../script_component.hpp"

/*
 * Author: OverlordZorn
 * Function to clear an entry from the  cache-database.
 *
 * Arguments:
 * 0: Key <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["myKey"] call ace_wardrobe_fnc_cache_clear
 *
 * Public: Yes
 */

params [ ["_key", "", [""]] ];

private _map = missionNamespace getVariable [QGVAR(cache), "404"];
_map deleteAt _key;