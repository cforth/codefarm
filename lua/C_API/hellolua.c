#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"

int main(int argc, char* argv[])
{
	lua_State* L;
	L = luaL_newstate();
	luaL_openlibs(L);
	luaL_dostring(L, "print 'Hello World'");
	lua_close(L);
	return 0;
}

