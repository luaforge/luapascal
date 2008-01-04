  (*
  ** state manipulation
  *)
  function lua_newstate(f: lua_Alloc; ud: Pointer): lua_State; cdecl; external fLuaLibFileName;
  procedure lua_close(L: lua_State); cdecl; external fLuaLibFileName;
  function lua_newthread(L: lua_State): lua_State; cdecl; external fLuaLibFileName;
  function lua_atpanic(L: lua_State; panicf: lua_CFunction): lua_CFunction; cdecl; external fLuaLibFileName;

  (*
  ** basic stack manipulation
  *)
  function lua_gettop(L: lua_State): Integer; cdecl; external fLuaLibFileName;
  procedure lua_settop(L: lua_State; idx: Integer); cdecl; external fLuaLibFileName;
  procedure lua_pushvalue(L: lua_State; idx: Integer); cdecl; external fLuaLibFileName;
  procedure lua_remove(L: lua_State; idx: Integer); cdecl; external fLuaLibFileName;
  procedure lua_insert(L: lua_State; idx: Integer); cdecl; external fLuaLibFileName;
  procedure lua_replace(L: lua_State; idx: Integer); cdecl; external fLuaLibFileName;
  function lua_checkstack(L: lua_State; extra: Integer): LongBool; cdecl; external fLuaLibFileName;
  procedure lua_xmove(from, dest: lua_State; n: Integer); cdecl; external fLuaLibFileName;

  (*
  ** access functions (stack -> C/Pascal)
  *)

  function lua_isnumber(L: lua_State; idx: Integer): LongBool; cdecl; external fLuaLibFileName;
  function lua_isstring(L: lua_State; idx: Integer): LongBool; cdecl; external fLuaLibFileName;
  function lua_iscfunction(L: lua_State; idx: Integer): LongBool; cdecl; external fLuaLibFileName;
  function lua_isuserdata(L: lua_State; idx: Integer): LongBool; cdecl; external fLuaLibFileName;
  function lua_type(L: lua_State; idx: Integer): Integer; cdecl; external fLuaLibFileName;
  function lua_typename(L: lua_State; tp: Integer): PChar; cdecl; external fLuaLibFileName;

  function lua_equal(L: lua_State; idx1, idx2: Integer): LongBool; cdecl; external fLuaLibFileName;
  function lua_rawequal(L: lua_State; idx1, idx2: Integer): LongBool; cdecl; external fLuaLibFileName;
  function lua_lessthan(L: lua_State; idx1, idx2: Integer): LongBool; cdecl; external fLuaLibFileName;

  function lua_tonumber(L: lua_State; idx: Integer): lua_Number; cdecl; external fLuaLibFileName;
  function lua_tointeger(L: lua_State; idx: Integer): lua_Integer; cdecl; external fLuaLibFileName;
  function lua_toboolean(L: lua_State; idx: Integer): LongBool; cdecl; external fLuaLibFileName;
  function lua_tolstring(L: lua_State; idx: Integer; var len: Cardinal): PChar; cdecl; external fLuaLibFileName;
  function lua_objlen(L: lua_State; idx: Integer): Cardinal; cdecl; external fLuaLibFileName;
  function lua_tocfunction(L: lua_State; idx: Integer): lua_CFunction; cdecl; external fLuaLibFileName;
  function lua_touserdata(L: lua_State; idx: Integer): Pointer; cdecl; external fLuaLibFileName;
  function lua_tothread(L: lua_State; idx: Integer): lua_State; cdecl; external fLuaLibFileName;
  function lua_topointer(L: lua_State; idx: Integer): Pointer; cdecl; external fLuaLibFileName;

  (*
  ** push functions (C/Pascal -> stack)
  *)
  procedure lua_pushnil(L: lua_State); cdecl; external fLuaLibFileName;
  procedure lua_pushnumber(L: lua_State; n: lua_Number); cdecl; external fLuaLibFileName;
  procedure lua_pushinteger(L: lua_State; n: lua_Integer); cdecl; external fLuaLibFileName;
  procedure lua_pushlstring(L: lua_State; s: PChar; len: Cardinal); cdecl; external fLuaLibFileName;
  procedure lua_pushstring(L: lua_State; s: PChar); cdecl; external fLuaLibFileName;
  function lua_pushvfstring(L: lua_State; fmt, argp: PChar): PChar; cdecl; external fLuaLibFileName;

  function lua_pushfstring(L: lua_State; fmt: PChar; args: array of const): PChar; cdecl; external fLuaLibFileName;
  procedure lua_pushcclosure(L: lua_State; fn: lua_CFunction; n: Integer); cdecl; external fLuaLibFileName;
  procedure lua_pushboolean(L: lua_State; b: LongBool); cdecl; external fLuaLibFileName;
  procedure lua_pushlightuserdata(L: lua_State; p: Pointer); cdecl; external fLuaLibFileName;
  function lua_pushthread(L: lua_State): Integer; cdecl; external fLuaLibFileName;

  (*
  ** get functions (Lua -> stack)
  *)
  procedure lua_gettable(L: lua_State; idx: Integer); cdecl; external fLuaLibFileName;
  procedure lua_getfield(L: lua_State; idx: Integer; k: PChar); cdecl; external fLuaLibFileName;
  procedure lua_rawget(L: lua_State; idx: Integer); cdecl; external fLuaLibFileName;
  procedure lua_rawgeti(L: lua_State; idx, n: Integer); cdecl; external fLuaLibFileName;
  procedure lua_createtable(L: lua_State; narr, nrec: Integer); cdecl; external fLuaLibFileName;
  function lua_newuserdata(L: lua_State; size: Cardinal): Pointer; cdecl; external fLuaLibFileName;
  function lua_getmetatable(L: lua_State; idx: Integer): LongBool; cdecl; external fLuaLibFileName;
  procedure lua_getfenv(L: lua_State; idx: Integer); cdecl; external fLuaLibFileName;

  (*
  ** set functions (stack -> Lua)
  *)
  procedure lua_settable(L: lua_State; idx: Integer); cdecl; external fLuaLibFileName;
  procedure lua_setfield(L: lua_State; idx: Integer; k: PChar ); cdecl; external fLuaLibFileName;
  procedure lua_rawset(L: lua_State; idx: Integer); cdecl; external fLuaLibFileName;
  procedure lua_rawseti(L: lua_State; idx, n: Integer); cdecl; external fLuaLibFileName;
  function lua_setmetatable(L: lua_State; idx: Integer): LongBool; cdecl; external fLuaLibFileName;
  function lua_setfenv(L: lua_State; idx: Integer): LongBool; cdecl; external fLuaLibFileName;

  (*
  ** `load' and `call' functions (load and run Lua code)
  *)
  procedure lua_call(L: lua_State; nargs, nresults: Integer); cdecl; external fLuaLibFileName;
  function lua_pcall(L: lua_State; nargs, nresults, errfunc: Integer): Integer; cdecl; external fLuaLibFileName;
  function lua_cpcall(L: lua_State; func: lua_CFunction; ud: Pointer): Integer; cdecl; external fLuaLibFileName;
  function lua_load(L: lua_State; reader: lua_Reader; data: Pointer; chunkname: PChar): Integer; cdecl; external fLuaLibFileName;
  function lua_dump(L: lua_State; writer: lua_Writer; data: Pointer): Integer; cdecl; external fLuaLibFileName;

  (*
  ** coroutine functions
  *)
  function lua_yield(L: lua_State; nresults: Integer): Integer; cdecl; external fLuaLibFileName;
  function lua_resume(L: lua_State; narg: Integer): Integer; cdecl; external fLuaLibFileName;
  function lua_status(L: lua_State): Integer; cdecl; external fLuaLibFileName;

  (*
  ** garbage-collection functions
  *)
  function lua_gc(L: lua_State; what, data: Integer): Integer; cdecl; external fLuaLibFileName;

  (*
  ** miscellaneous functions
  *)

  function lua_error(L: lua_State): Integer; cdecl; external fLuaLibFileName;
  function lua_next(L: lua_State; idx: Integer): Integer; cdecl; external fLuaLibFileName;
  procedure lua_concat(L: lua_State; n: Integer); cdecl; external fLuaLibFileName;

  function lua_getallocf(L: lua_State; ud: Pointer): lua_Alloc; cdecl; external fLuaLibFileName;
  procedure lua_setallocf(L: lua_State; f: lua_Alloc; ud: Pointer); cdecl; external fLuaLibFileName;

  (*
  ** {======================================================================
  ** Debug API
  ** =======================================================================
  *)

  function lua_getstack(L: lua_State; level: Integer; var ar: lua_Debug): Integer; cdecl; external fLuaLibFileName;
  function lua_getinfo(L: lua_State; what: PChar; var ar: lua_Debug): Integer; cdecl; external fLuaLibFileName;
  function lua_getlocal(L: lua_State; var ar: lua_Debug; n: Integer): PChar; cdecl; external fLuaLibFileName;
  function lua_setlocal(L: lua_State; var ar: lua_Debug; n: Integer): PChar; cdecl; external fLuaLibFileName;
  function lua_getupvalue(L: lua_State; funcindex, n: Integer): PChar; cdecl; external fLuaLibFileName;
  function lua_setupvalue(L: lua_State; funcindex, n: Integer): PChar; cdecl; external fLuaLibFileName;

  function lua_sethook(L: lua_State; func: lua_Hook; mask, count: Integer): Integer; cdecl; external fLuaLibFileName;
  function lua_gethook(L: lua_State): lua_Hook; cdecl; external fLuaLibFileName;
  function lua_gethookmask(L: lua_State): Integer; cdecl; external fLuaLibFileName;
  function lua_gethookcount(L: lua_State): Integer; cdecl; external fLuaLibFileName;

  (* lua libraries *)
  function luaopen_base(L: lua_State): Integer; cdecl; external fLuaLibFileName;
  function luaopen_debug(L: lua_State): Integer; cdecl; external fLuaLibFileName;
  function luaopen_io(L: lua_State): Integer; cdecl; external fLuaLibFileName;
  function luaopen_math(L: lua_State): Integer; cdecl; external fLuaLibFileName;
  function luaopen_os(L: lua_State): Integer; cdecl; external fLuaLibFileName;
  function luaopen_package(L: lua_State): Integer; cdecl; external fLuaLibFileName;
  function luaopen_string(L: lua_State): Integer; cdecl; external fLuaLibFileName;
  function luaopen_table(L: lua_State): Integer; cdecl; external fLuaLibFileName;
  (* open all previous libraries *)
  procedure luaL_openlibs(L: lua_State); cdecl; external fLuaLibFileName;

  procedure luaL_register(L: lua_State; libname: PChar; lr: PluaL_reg); cdecl; external fLuaLibFileName;
  function luaL_getmetafield(L: lua_State; obj: Integer; e: PChar): Integer; cdecl; external fLuaLibFileName;
  function luaL_callmeta(L: lua_State; obj: Integer; e: PChar): Integer; cdecl; external fLuaLibFileName;
  function luaL_typerror(L: lua_State; narg: Integer; tname: PChar): Integer; cdecl; external fLuaLibFileName;
  function luaL_argerror(L: lua_State; narg: Integer; extramsg: PChar): Integer; cdecl; external fLuaLibFileName;
  function luaL_checklstring(L: lua_State; narg: Integer; var len: Cardinal): PChar; cdecl; external fLuaLibFileName;
  function luaL_optlstring(L: lua_State; narg: Integer; d: PChar; var len: Cardinal): PChar; cdecl; external fLuaLibFileName;
  function luaL_checknumber(L: lua_State; narg: Integer): lua_Number; cdecl; external fLuaLibFileName;
  function luaL_optnumber(L: lua_State; narg: Integer; d: lua_Number): lua_Number; cdecl; external fLuaLibFileName;

  function luaL_checkinteger(L: lua_State; narg: Integer): lua_Integer; cdecl; external fLuaLibFileName;
  function luaL_optinteger(L: lua_State; narg: Integer; d: lua_Integer): lua_Integer; cdecl; external fLuaLibFileName;

  procedure luaL_checkstack(L: lua_State; sz: Integer; msg: PChar); cdecl; external fLuaLibFileName;
  procedure luaL_checktype(L: lua_State; narg, t: Integer); cdecl; external fLuaLibFileName;
  procedure luaL_checkany(L: lua_State; narg: Integer); cdecl; external fLuaLibFileName;

  function luaL_newmetatable(L: lua_State; tname: PChar): Integer; cdecl; external fLuaLibFileName;
  function luaL_checkudata(L: lua_State; narg: Integer; tname: PChar): Pointer; cdecl; external fLuaLibFileName;

  function luaL_checkoption(L: lua_State; narg: Integer; def: PChar; lst: array of PChar): Integer; cdecl; external fLuaLibFileName;

  procedure luaL_where(L: lua_State; lvl: Integer); cdecl; external fLuaLibFileName;
  function luaL_error(L: lua_State; fmt: PChar; args: array of const): Integer; cdecl; external fLuaLibFileName;

  function luaL_ref(L: lua_State; t: Integer): Integer; cdecl; external fLuaLibFileName;
  procedure luaL_unref(L: lua_State; t, ref: Integer); cdecl; external fLuaLibFileName;

{$ifdef LUA_COMPAT_GETN}
  function luaL_getn(L: lua_State; t: Integer): Integer; cdecl; external fLuaLibFileName;
  procedure luaL_setn(L: lua_State; t, n: Integer); cdecl; external fLuaLibFileName;
{$endif}

  function luaL_loadfile(L: lua_State; filename: PChar): Integer; cdecl; external fLuaLibFileName;
  function luaL_loadbuffer(L: lua_State; buff: PChar; sz: Cardinal; name: PChar): Integer; cdecl; external fLuaLibFileName;
  function luaL_loadstring(L: lua_State; s: PChar): Integer; cdecl; external fLuaLibFileName;

  function luaL_newstate(): lua_State; cdecl; external fLuaLibFileName;
  function luaL_gsub(L: lua_State; s, p, r: PChar): PChar; cdecl; external fLuaLibFileName;
  function luaL_findtable(L: lua_State; idx: Integer; fname: PChar; szhint: Integer): PChar; cdecl; external fLuaLibFileName;

  procedure luaL_buffinit(L: lua_State; var B: luaL_Buffer); cdecl; external fLuaLibFileName;
  function luaL_prepbuffer(var B: luaL_Buffer): PChar; cdecl; external fLuaLibFileName;
  procedure luaL_addlstring(var B: luaL_Buffer; s: PChar; l: Cardinal); cdecl; external fLuaLibFileName;
  procedure luaL_addstring(var B: luaL_Buffer; s: PChar); cdecl; external fLuaLibFileName;
  procedure luaL_addvalue(var B: luaL_Buffer); cdecl; external fLuaLibFileName;
  procedure luaL_pushresult(var B: luaL_Buffer); cdecl; external fLuaLibFileName;

