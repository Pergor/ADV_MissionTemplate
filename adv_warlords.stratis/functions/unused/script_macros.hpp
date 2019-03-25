#include "\x\cba\addons\main\script_macros_common.hpp"
#include "\x\cba\addons\xeh\script_xeh.hpp"

#undef GLUE
#define GLUE(var1,var2) var1##var2
#undef UP
#define UP(var1) toUpper (var1)
#undef DN
#define DN(var1) toLower (var1)

#define COMP(var1,var2) UP(var1) isEqualTo UP(var2)

#define GETVAR_SYS(var1,var2) getVariable [ARR_2(QUOTE(var1),var2)]
#define SETVAR_SYS(var1,var2) setVariable [ARR_2(QUOTE(var1),var2)]
#define SETPVAR_SYS(var1,var2) setVariable [ARR_3(QUOTE(var1),var2,true)]

#undef GETVAR
#define GETVAR(var1,var2,var3) var1 GETVAR_SYS(var2,var3)
#define GETMVAR(var1,var2) missionNamespace GETVAR_SYS(var1,var2)
#define GETUVAR(var1,var2) uiNamespace GETVAR_SYS(var1,var2)
#define GETPRVAR(var1,var2) profileNamespace GETVAR_SYS(var1,var2)
#define GETPAVAR(var1,var2) parsingNamespace GETVAR_SYS(var1,var2)

#undef SETVAR
#define SETVAR(var1,var2,var3) var1 SETVAR_SYS(var2,var3)
#define SETPVAR(var1,var2,var3) var1 SETPVAR_SYS(var2,var3)
#define SETMVAR(var1,var2) missionNamespace SETVAR_SYS(var1,var2)
#define SETMPVAR(var1,var2) missionNamespace SETPVAR_SYS(var1,var2)
#define SETUVAR(var1,var2) uiNamespace SETVAR_SYS(var1,var2)
#define SETPRVAR(var1,var2) profileNamespace SETVAR_SYS(var1,var2)
#define SETPAVAR(var1,var2) parsingNamespace SETVAR_SYS(var1,var2)

#undef FUNC
#define FUNC(var1) GLUE(adv_fnc_,var1)
#define FUNCO(var1) GLUE(adv_opf_fnc_,var1)
#define FUNCI(var1) GLUE(adv_ind_fnc_,var1)
#define QFUNC(var1)  UP(QUOTE(FUNC(var1)))
#define QFUNCO(var1)  UP(QUOTE(FUNCO(var1)))
#define QFUNCI(var1)  UP(QUOTE(FUNCI(var1)))

#undef GVAR
#define GVAR(var1) adv_var_(var1)
#define QGVAR(var1) QUOTE(UP(GVAR(var1)))