#define login custom_login
#define logout custom_logout

#include "openimsdk.h"

#if _WIN32
#include <windows.h>
#else
#include <pthread.h>
#endif

#if _WIN32
#define FFI_PLUGIN_EXPORT __declspec(dllexport)
#else
#define FFI_PLUGIN_EXPORT
#endif
