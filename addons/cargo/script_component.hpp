#define COMPONENT cargo
#define COMPONENT_BEAUTIFIED Cargo
#include "\z\ace\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define CBA_DEBUG_SYNCHRONOUS
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_CARGO
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_ENABLED_CARGO
    #define DEBUG_SETTINGS DEBUG_ENABLED_CARGO
#endif

#include "\z\ace\addons\main\script_macros.hpp"

#define MAX_LOAD_DISTANCE 10
