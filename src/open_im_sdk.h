#ifdef __APPLE__
#define login hide_login
#define logout hide_logout
#endif

#include "openimsdk.h"
#include <stdint.h>

#if _WIN32
#include <windows.h>
#else
#include <pthread.h>
#include <unistd.h>
#endif
