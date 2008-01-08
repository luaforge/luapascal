  (*
  ** state manipulation
  *)
  lua_newstate:  function(f: lua_Alloc; ud: Pointer): lua_State; cdecl;
  lua_close:     procedure(L: lua_State); cdecl;
  lua_newthread: function(L: lua_State): lua_State; cdecl;
  lua_atpanic:   function(L: lua_State; panicf: lua_CFunction): lua_CFunction; cdecl;

  (*
  ** basic stack manipulation
  *)
  lua_gettop:     function(L: lua_State): Integer; cdecl;
  lua_settop:     procedure(L: lua_State; idx: Integer); cdecl;
  lua_pushvalue:  procedure(L: lua_State; idx: Integer); cdecl;
  lua_remove:     procedure(L: lua_State; idx: Integer); cdecl;
  lua_insert:     procedure(L: lua_State; idx: Integer); cdecl;
  lua_replace:    procedure(L: lua_State; idx: Integer); cdecl;
  lua_checkstack: function(L: lua_State; extra: Integer): LongBool; cdecl;
  lua_xmove:      procedure(from, dest: lua_State; n: Integer); cdecl;

  (*
  ** access functions (stack -> C/Pascal)
  *)
  lua_isnumber:    function(L: lua_State; idx: Integer): LongBool; cdecl;
  lua_isstring:    function(L: lua_State; idx: Integer): LongBool; cdecl;
  lua_iscfunction: function(L: lua_State; idx: Integer): LongBool; cdecl;
  lua_isuserdata:  function(L: lua_State; idx: Integer): LongBool; cdecl;
  lua_type:        function(L: lua_State; idx: Integer): Integer; cdecl;
  lua_typename:    function(L: lua_State; tp: Integer): PChar; cdecl;

  lua_equal:       function(L: lua_State; idx1, idx2: Integer): LongBool; cdecl;
  lua_rawequal:    function(L: lua_State; idx1, idx2: Integer): LongBool; cdecl;
  lua_lessthan:    function(L: lua_State; idx1, idx2: Integer): LongBool; cdecl;

  lua_tonumber:    function(L: lua_State; idx: Integer): lua_Number; cdecl;
  lua_tointeger:   function(L: lua_State; idx: Integer): lua_Integer; cdecl;
  lua_toboolean:   function(L: lua_State; idx: Integer): LongBool; cdecl;
  lua_tolstring:   function(L: lua_State; idx: Integer; var len: Cardinal): PChar; cdecl;
  lua_objlen:      function(L: lua_State; idx: Integer): Cardinal; cdecl;
  lua_tocfunction: function(L: lua_State; idx: Integer): lua_CFunction; cdecl;
  lua_touserdata:  function(L: lua_State; idx: Integer): Pointer; cdecl;
  lua_tothread:    function(L: lua_State; idx: Integer): lua_State; cdecl;
  lua_topointer:   function(L: lua_State; idx: Integer): Pointer; cdecl;

  (*
  ** push functions (C/Pascal -> stack)
  *)
  lua_pushnil:      procedure(L: lua_State); cdecl;
  lua_pushnumber:   procedure(L: lua_State; n: lua_Number); cdecl;
  lua_pushinteger:  procedure(L: lua_State; n: lua_Integer); cdecl;
  lua_pushlstring:  procedure(L: lua_State; s: PChar; len: Cardinal); cdecl;
  lua_pushstring:   procedure(L: lua_State; s: PChar); cdecl;
  lua_pushvfstring: function(L: lua_State; fmt, argp: PChar): PChar; cdecl;

  lua_pushfstring:  function(L: lua_State; fmt: PChar; args: array of const): PChar; cdecl;
  lua_pushcclosure: procedure(L: lua_State; fn: lua_CFunction; n: Integer); cdecl;
  lua_pushboolean:  procedure(L: lua_State; b: LongBool); cdecl;
  lua_pushlightuserdata: procedure(L: lua_State; p: Pointer); cdecl;
  lua_pushthread:   function(L: lua_State): Integer; cdecl;

  (*
  ** get functions (Lua -> stack)
  *)
  lua_gettable:     procedure(L: lua_State; idx: Integer); cdecl;
  lua_getfield:     procedure(L: lua_State; idx: Integer; k: PChar); cdecl;
  lua_rawget:       procedure(L: lua_State; idx: Integer); cdecl;
  lua_rawgeti:      procedure(L: lua_State; idx, n: Integer); cdecl;
  lua_createtable:  procedure(L: lua_State; narr, nrec: Integer); cdecl;
  lua_newuserdata:  function(L: lua_State; size: Cardinal): Pointer; cdecl;
  lua_getmetatable: function(L: lua_State; idx: Integer): LongBool; cdecl;
  lua_getfenv:      procedure(L: lua_State; idx: Integer); cdecl;

  (*
  ** set functions (stack -> Lua)
  *)
  lua_settable:     procedure(L: lua_State; idx: Integer); cdecl;
  lua_setfield:     procedure(L: lua_State; idx: Integer; k: PChar ); cdecl;
  lua_rawset:       procedure(L: lua_State; idx: Integer); cdecl;
  lua_rawseti:      procedure(L: lua_State; idx, n: Integer); cdecl;
  lua_setmetatable: function(L: lua_State; idx: Integer): LongBool; cdecl;
  lua_setfenv:      function(L: lua_State; idx: Integer): LongBool; cdecl;

  (*
  ** `load' and `call' functions (load and run Lua code)
  *)
  lua_call:   procedure(L: lua_State; nargs, nresults: Integer); cdecl;
  lua_pcall:  function(L: lua_State; nargs, nresults, errfunc: Integer): Integer; cdecl;
  lua_cpcall: function(L: lua_State; func: lua_CFunction; ud: Pointer): Integer; cdecl;
  lua_load:   function(L: lua_State; reader: lua_Reader; data: Pointer; chunkname: PChar): Integer; cdecl;
  lua_dump:   function(L: lua_State; writer: lua_Writer; data: Pointer): Integer; cdecl;

  (*
  ** coroutine functions
  *)
  lua_yield:  function(L: lua_State; nresults: Integer): Integer; cdecl;
  lua_resume: function(L: lua_State; narg: Integer): Integer; cdecl;
  lua_status: function(L: lua_State): Integer; cdecl;

  (*
  ** garbage-collection functions
  *)
  lua_gc: function(L: lua_State; what, data: Integer): Integer; cdecl;

  (*
  ** miscellaneous functions
  *)
  lua_error:  function(L: lua_State): Integer; cdecl;
  lua_next:   function(L: lua_State; idx: Integer): Integer; cdecl;
  lua_concat: procedure(L: lua_State; n: Integer); cdecl;

  lua_getallocf: function(L: lua_State; ud: Pointer): lua_Alloc; cdecl;
  lua_setallocf: procedure(L: lua_State; f: lua_Alloc; ud: Pointer); cdecl;

  (*
  ** {======================================================================
  ** Debug API
  ** =======================================================================
  *)
  lua_getstack:   function(L: lua_State; level: Integer; var ar: lua_Debug): Integer; cdecl;
  lua_getinfo:    function(L: lua_State; what: PChar; var ar: lua_Debug): Integer; cdecl;
  lua_getlocal:   function(L: lua_State; var ar: lua_Debug; n: Integer): PChar; cdecl;
  lua_setlocal:   function(L: lua_State; var ar: lua_Debug; n: Integer): PChar; cdecl;
  lua_getupvalue: function(L: lua_State; funcindex, n: Integer): PChar; cdecl;
  lua_setupvalue: function(L: lua_State; funcindex, n: Integer): PChar; cdecl;

  lua_sethook:      function(L: lua_State; func: lua_Hook; mask, count: Integer): Integer; cdecl;
  lua_gethook:      function(L: lua_State): lua_Hook; cdecl;
  lua_gethookmask:  function(L: lua_State): Integer; cdecl;
  lua_gethookcount: function(L: lua_State): Integer; cdecl;

  (* lua libraries *)
  luaopen_base:    function(L: lua_State): Integer; cdecl;
  luaopen_debug:   function(L: lua_State): Integer; cdecl;
  luaopen_io:      function(L: lua_State): Integer; cdecl;
  luaopen_math:    function(L: lua_State): Integer; cdecl;
  luaopen_os:      function(L: lua_State): Integer; cdecl;
  luaopen_package: function(L: lua_State): Integer; cdecl;
  luaopen_string:  function(L: lua_State): Integer; cdecl;
  luaopen_table:   function(L: lua_State): Integer; cdecl;
  
  (* open all previous libraries *)
  luaL_openlibs:   procedure(L: lua_State); cdecl;

  luaL_register:     procedure(L: lua_State; libname: PChar; lr: PluaL_reg); cdecl;
  luaL_getmetafield: function(L: lua_State; obj: Integer; e: PChar): Integer; cdecl;
  luaL_callmeta:     function(L: lua_State; obj: Integer; e: PChar): Integer; cdecl;
  luaL_typerror:     function(L: lua_State; narg: Integer; tname: PChar): Integer; cdecl;
  luaL_argerror:     function(L: lua_State; narg: Integer; extramsg: PChar): Integer; cdecl;
  luaL_checklstring: function(L: lua_State; narg: Integer; var len: Cardinal): PChar; cdecl;
  luaL_optlstring:   function(L: lua_State; narg: Integer; d: PChar; var len: Cardinal): PChar; cdecl;
  luaL_checknumber:  function(L: lua_State; narg: Integer): lua_Number; cdecl;
  luaL_optnumber:    function(L: lua_State; narg: Integer; d: lua_Number): lua_Number; cdecl;

  luaL_checkinteger: function(L: lua_State; narg: Integer): lua_Integer; cdecl;
  luaL_optinteger:   function(L: lua_State; narg: Integer; d: lua_Integer): lua_Integer; cdecl;

  luaL_checkstack: procedure(L: lua_State; sz: Integer; msg: PChar); cdecl;
  luaL_checktype:  procedure(L: lua_State; narg, t: Integer); cdecl;
  luaL_checkany:   procedure(L: lua_State; narg: Integer); cdecl;

  luaL_newmetatable: function(L: lua_State; tname: PChar): Integer; cdecl;
  luaL_checkudata:   function(L: lua_State; narg: Integer; tname: PChar): Pointer; cdecl;

  luaL_checkoption: function(L: lua_State; narg: Integer; def: PChar; lst: array of PChar): Integer; cdecl;

  luaL_where: procedure(L: lua_State; lvl: Integer); cdecl;
  luaL_error: function(L: lua_State; fmt: PChar; args: array of const): Integer; cdecl;

  luaL_ref:   function(L: lua_State; t: Integer): Integer; cdecl;
  luaL_unref: procedure(L: lua_State; t, ref: Integer); cdecl;

{$ifdef LUA_COMPAT_GETN}
  luaL_getn: function(L: lua_State; t: Integer): Integer; cdecl;
  luaL_setn: procedure(L: lua_State; t, n: Integer); cdecl;
{$endif}

  luaL_loadfile:   function(L: lua_State; filename: PChar): Integer; cdecl;
  luaL_loadbuffer: function(L: lua_State; buff: PChar; sz: Cardinal; name: PChar): Integer; cdecl;
  luaL_loadstring: function(L: lua_State; s: PChar): Integer; cdecl;

  luaL_newstate:  function(): lua_State; cdecl;
  luaL_gsub:      function(L: lua_State; s, p, r: PChar): PChar; cdecl;
  luaL_findtable: function(L: lua_State; idx: Integer; fname: PChar; szhint: Integer): PChar; cdecl;

  luaL_buffinit:   procedure(L: lua_State; var B: luaL_Buffer); cdecl;
  luaL_prepbuffer: function(var B: luaL_Buffer): PChar; cdecl;
  luaL_addlstring: procedure(var B: luaL_Buffer; s: PChar; l: Cardinal); cdecl;
  luaL_addstring:  procedure(var B: luaL_Buffer; s: PChar); cdecl;
  luaL_addvalue:   procedure(var B: luaL_Buffer); cdecl;
  luaL_pushresult: procedure(var B: luaL_Buffer); cdecl;

