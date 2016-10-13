/*
 * Author: Glowbal
 * Local callback for checking the blood pressure of a patient
 *
 * Arguments:
 * 0: The medic <OBJECT>
 * 1: The patient <OBJECT>
 * 2: Body part <STRING>
 *
 * Return Value:
 * None
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_caller", "_target", "_bodyPart"];

private _bloodPressure = _target call EFUNC(medical,getBloodPressure);

if (!alive _target) then {
    [0,0]
};

_bloodPressure params ["_bloodPressureLow", "_bloodPressureHigh"];

private _output = "";
private _logOutPut = "";

if (_caller call EFUNC(medical,isMedic)) then {
    _output = ELSTRING(medical,Check_Bloodpressure_Output_1);
    _logOutPut = format ["%1/%2", round _bloodPressureHigh, round _bloodPressureLow];
} else {
    if (_bloodPressureHigh > 20) then {
        _output = ELSTRING(medical,Check_Bloodpressure_Output_2);
        _logOutPut = ELSTRING(medical,Check_Bloodpressure_Low);

        if (_bloodPressureHigh > 100) then {
            _output = ELSTRING(medical,Check_Bloodpressure_Output_3);
            _logOutPut = ELSTRING(medical,Check_Bloodpressure_Normal);

            if (_bloodPressureHigh > 160) then {
                _output = ELSTRING(medical,Check_Bloodpressure_Output_4);
                _logOutPut = ELSTRING(medical,Check_Bloodpressure_High);
            };
        };
    } else {
        if (random 10 > 3) then {
            _output = ELSTRING(medical,Check_Bloodpressure_Output_5);
            _logOutPut = ELSTRING(medical,Check_Bloodpressure_NoBloodpressure);
        } else {
            _output = ELSTRING(medical,Check_Bloodpressure_Output_6);
            //Fail to find pressure, no logoutput
        };
    };
};

if (toLower _bodyPart in ["lefthand", "righthand"] && {[_unit, _bodyPart] call EFUNC(medical,hasTourniquetAppliedTo)}) then {
    _output = ELSTRING(medical,Check_Bloodpressure_Output_6);
    _logOutPut = "";
};

[QEGVAR(common,displayTextStructured), [[_output, _target call EFUNC(common,getName), round _bloodPressureHigh, round _bloodPressureLow], 1.75, _caller], _caller] call CBA_fnc_targetEvent;

if (_logOutPut != "") then {
    [_target, "activity", ELSTRING(medical,Check_Bloodpressure_Log), [_caller call EFUNC(common,getName), _logOutPut]] call FUNC(addToLog);
    [_target, "quick_view", ELSTRING(medical,Check_Bloodpressure_Log), [_caller call EFUNC(common,getName), _logOutPut]] call FUNC(addToLog);
};
