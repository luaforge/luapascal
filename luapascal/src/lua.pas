(******************************************************************************
* Original copyright for the lua source and headers:
*  1994-2004 Tecgraf, PUC-Rio.
*  www.lua.org.
*
* Copyright for the Delphi adaptation:
*  2005 Rolf Meyerhoff
*  www.matrix44.de
*
* Copyright for the Lua 5.1 adaptation:
*  2007 Marco Antonio Abreu
*  www.marcoabreu.eti.br
*
*  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining
* a copy of this software and associated documentation files (the
* "Software"), to deal in the Software without restriction, including
* without limitation the rights to use, copy, modify, merge, publish,
* distribute, sublicense, and/or sell copies of the Software, and to
* permit persons to whom the Software is furnished to do so, subject to
* the following conditions:
*
* The above copyright notice and this permission notice shall be
* included in all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
* EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
* MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
* IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
* CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
* TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
* SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
******************************************************************************)
unit lua;

interface

const
  LUA_VERSION   = 'Lua 5.1';
  LUA_RELEASE   = 'Lua 5.1.2';
  LUA_COPYRIGHT = 'Copyright (C) 1994-2004 Tecgraf, PUC-Rio';
  LUA_AUTHORS   = 'R. Ierusalimschy, L. H. de Figueiredo & W. Celes';

  LUA_PASCAL_AUTHOR = 'Marco Antonio Abreu';
  LUA_PASCAL_COPYRIGHT = 'Copyright (C) 2008 Marco Antonio Abreu';

  (* mark for precompiled code (`<esc>Lua') *)
  LUA_SIGNATURE = #27'Lua';

  (* option for multiple returns in `lua_pcall' and `lua_call' *)
  LUA_MULTRET   = -1;

  (*
  ** pseudo-indices
  *)
  LUA_REGISTRYINDEX = -10000;
  LUA_ENVIRONINDEX  = -10001;
  LUA_GLOBALSINDEX  = -10002;

  (* thread status; 0 is OK *)
  LUA_TRD_YIELD = 1;
  LUA_ERRRUN    = 2;
  LUA_ERRSYNTAX = 3;
  LUA_ERRMEM    = 4;
  LUA_ERRERR    = 5;

  (* extra error code for `luaL_load' *)
  LUA_ERRFILE   = LUA_ERRERR + 1;

  (*
  ** basic types
  *)
  LUA_TNONE	         = -1;
  LUA_TNIL           = 0;
  LUA_TBOOLEAN       = 1;
  LUA_TLIGHTUSERDATA = 2;
  LUA_TNUMBER        = 3;
  LUA_TSTRING        = 4;
  LUA_TTABLE         = 5;
  LUA_TFUNCTION      = 6;
  LUA_TUSERDATA	     = 7;
  LUA_TTHREAD        = 8;

  (* minimum Lua stack available to a C function *)
  LUA_MINSTACK       = 20;

  (*
  ** garbage-collection function and options
  *)
  LUA_GCSTOP        = 0;
  LUA_GCRESTART     = 1;
  LUA_GCCOLLECT     = 2;
  LUA_GCCOUNT       = 3;
  LUA_GCCOUNTB      = 4;
  LUA_GCSTEP        = 5;
  LUA_GCSETPAUSE    = 6;
  LUA_GCSETSTEPMUL  = 7;

  (*
  ** {======================================================================
  ** Debug API
  ** =======================================================================
  *)

  (*
  ** Event codes
  *)
  LUA_HOOKCALL    = 0;
  LUA_HOOKRET     = 1;
  LUA_HOOKLINE    = 2;
  LUA_HOOKCOUNT	  = 3;
  LUA_HOOKTAILRET = 4;

  (*
  ** Event masks
  *)
  LUA_MASKCALL 	= (1 shl LUA_HOOKCALL);
  LUA_MASKRET  	= (1 shl LUA_HOOKRET);
  LUA_MASKLINE  = (1 shl LUA_HOOKLINE);
  LUA_MASKCOUNT	= (1 shl LUA_HOOKCOUNT);

  (*
  ** {======================================================================
  ** useful definitions for Lua kernel and libraries
  ** =======================================================================
  *)

  (*
  @@ LUA_NUMBER_SCAN is the format for reading numbers.
  @@ LUA_NUMBER_FMT is the format for writing numbers.
  @@ lua_number2str converts a number to a string.
  @@ LUAI_MAXNUMBER2STR is maximum size of previous conversion.
  @@ lua_str2number converts a string to a number.
  *)
  LUA_NUMBER_SCAN	=	'%lf';
  LUA_NUMBER_FMT	 =	'%.14g';
  LUAI_MAXNUMBER2STR =	32;  (* 16 digits, sign, point, and \0 *)

  (* pre-defined references *)
  LUA_NOREF  = -2;
  LUA_REFNIL = -1;

  LUA_IDSIZE = 60;

  (*
  ** package names
  *)
  LUA_COLIBNAME   = 'coroutine';
  LUA_TABLIBNAME  = 'table';
  LUA_IOLIBNAME   = 'io';
  LUA_OSLIBNAME   = 'os';
  LUA_STRLIBNAME  = 'string';
  LUA_MATHLIBNAME = 'math';
  LUA_DBLIBNAME   = 'debug';
  LUA_LOADLIBNAME = 'package';

  (*
  ** {======================================================
  ** Generic Buffer manipulation
  ** =======================================================
  *)

  BUFSIZ = 512; (* From stdio.h *)
  LUAL_BUFFERSIZE = BUFSIZ;

type
  lua_State = type Pointer;

  lua_CFunction = function(L: lua_State): Integer; cdecl;

  (*
  ** functions that read/write blocks when loading/dumping Lua chunks
  *)
  lua_Reader = function(L: lua_State; data: Pointer; var size: Cardinal): PChar; cdecl;
  lua_Writer = function(L: lua_State; p: Pointer; sz: Cardinal; ud: Pointer): Integer; cdecl;

  (*
  ** prototype for memory-allocation functions
  *)
  lua_Alloc = function(ud, ptr: Pointer; osize, nsize: Cardinal): Pointer; cdecl;

  (* type of numbers in Lua *)
  lua_Number  = type double;
  (* type for integer functions *)
  lua_Integer = type integer;

  lua_Debug = packed record
    event: Integer;
    name: PChar; (* (n) *)
    namewhat: PChar; (* (n) `global', `local', `field', `method' *)
    what: PChar; (* (S) `Lua', `C', `main', `tail' *)
    source: PChar; (* (S) *)
    currentline: Integer; (* (l) *)
    nups: Integer;  (* (u) number of upvalues *)
    linedefined: Integer; (* (S) *)
    lastlinedefine: Integer;	(* (S) *)
    short_src: array[0..LUA_IDSIZE - 1] of Char; (* (S) *)
    (* private part *)
    i_ci: Integer; (* active function *)
  end;

  (* Functions to be called by the debuger in specific events *)
  lua_Hook = procedure(L: lua_State; var ar: lua_Debug); cdecl;

  (* Lua Record *)
  PluaL_reg = ^luaL_reg;
  luaL_reg = packed record
    name: PChar;
    func: lua_CFunction;
  end;

  (*
  ** {======================================================
  ** Generic Buffer manipulation
  ** =======================================================
  *)
  luaL_Buffer = packed record
    p: PChar; (* current position in buffer *)
    lvl: Integer;  (* number of strings in the stack (level) *)
    L: lua_State;
    buffer: array[0..LUAL_BUFFERSIZE - 1] of Char;
  end;

{$ifdef MSWINDOWS}
var
  {$include fdecl_win32.inc}
{$endif}
{$ifdef LINUX}
const
  fLuaLibFileName = 'liblua.so.5.1';

  {$include fdecl_linux.inc}
{$endif}

  (*
  ** ===============================================================
  ** some useful macros
  ** ===============================================================
  *)

{$ifndef LUA_COMPAT_GETN}
  function  luaL_getn(L: lua_State; t: Integer): Integer;
  procedure luaL_setn(L: lua_State; t, n: Integer); 
{$endif}

  (* pseudo-indices *)
  function lua_upvalueindex(i: Integer): Integer;

  (* to help testing the libraries *)
  procedure lua_assert(c: Boolean);

  function lua_number2str(s: Lua_Number; n: Integer): String;
  function lua_str2number(s: String; p: integer): Lua_Number;

  (* argument and parameters checks *)
  function luaL_argcheck(L: lua_State; cond: Boolean; narg: Integer; extramsg: PChar): Integer;
  function luaL_checkstring(L: lua_State; narg: Integer): PChar;
  function luaL_optstring(L: lua_State; narg: Integer; d: PChar): PChar;
  function luaL_checkint(L: lua_State; narg: Integer): Integer;
  function luaL_optint(L: lua_State; narg, d: Integer): Integer;
  function luaL_checklong(L: lua_State; narg: Integer): LongInt;
  function luaL_optlong(L: lua_State; narg: Integer; d: LongInt): LongInt;

  function luaL_typename(L: lua_State; idx: Integer): PChar;
  function luaL_dofile(L: lua_State; filename: PChar): Integer;
  function luaL_dostring(L: lua_State; str: PChar): Integer;

  procedure luaL_getmetatable(L: lua_State; tname: PChar);

  (* Generic Buffer manipulation *)
  procedure luaL_addchar(var B: luaL_Buffer; c: Char);
  procedure luaL_putchar(var B: luaL_Buffer; c: Char);
  procedure luaL_addsize(var B: luaL_Buffer; n: Cardinal);

  function luaL_check_lstr(L: lua_State; numArg: Integer; var ls: Cardinal): PChar;
  function luaL_opt_lstr(L: lua_State; numArg: Integer; def: PChar; var ls: Cardinal): PChar;
  function luaL_check_number(L: lua_State; numArg: Integer): lua_Number;
  function luaL_opt_number(L: lua_State; nArg: Integer; def: lua_Number): lua_Number;
  function luaL_arg_check(L: lua_State; cond: Boolean; numarg: Integer; extramsg: PChar): Integer;
  function luaL_check_string(L: lua_State; n: Integer): PChar;
  function luaL_opt_string(L: lua_State; n: Integer; d: PChar): PChar;
  function luaL_check_int(L: lua_State; n: Integer): Integer;
  function luaL_check_long(L: lua_State; n: LongInt): LongInt;
  function luaL_opt_int(L: lua_State; n, d: Integer): Integer;
  function luaL_opt_long(L: lua_State; n: Integer; d: LongInt): LongInt;

  procedure lua_pop(L: lua_State; n: Integer);
  procedure lua_newtable(L: lua_State);
  procedure lua_register(L: lua_state; name: PChar; f: lua_CFunction);
  procedure lua_pushcfunction(L: lua_State; f: lua_CFunction);
  function  lua_strlen(L: lua_State; i: Integer): Cardinal;

  function lua_isfunction(L: lua_State; idx: Integer): Boolean;
  function lua_istable(L: lua_State; idx: Integer): Boolean;
  function lua_islightuserdata(L: lua_State; idx: Integer): Boolean;
  function lua_isnil(L: lua_State; idx: Integer): Boolean;
  function lua_isboolean(L: lua_State; idx: Integer): Boolean;
  function lua_isthread(L: lua_State; idx: Integer): Boolean;
  function lua_isnone(L: lua_State; idx: Integer): Boolean;
  function lua_isnoneornil(L: lua_State; idx: Integer): Boolean;

  procedure lua_pushliteral(L: lua_State; s: PChar);
  procedure lua_setglobal(L: lua_State; name: PChar);
  procedure lua_getglobal(L: lua_State; name: PChar);
  function  lua_tostring(L: lua_State; idx: Integer): PChar;

  (*
  ** compatibility macros and functions
  *)
  function  lua_open(): lua_State;
  procedure lua_getregistry(L: lua_State);
  function  lua_getgccount(L: lua_State): Integer;

  (* compatibility with ref system *)
  function  lua_ref(L: lua_State; lock: Boolean): Integer;
  procedure lua_unref(L: lua_State; ref: Integer);
  procedure lua_getref(L: lua_State; ref: Integer);

  (*
  ** Dynamic library manipulation
  *)
  function  GetProcAddr( fHandle: THandle; const methodName: String; bErrorIfNotExists: Boolean = True ): Pointer;
  procedure SetLuaLibFileName( newLuaLibFileName: String );
  function  GetLuaLibFileName(): String;
  function  LoadLuaLib( newLuaLibFileName: String = '' ): Integer;
  procedure FreeLuaLib();

implementation

uses
  SysUtils, Math,
{$ifdef MSWINDOWS}
  Windows
{$endif}
;

{$ifdef MSWINDOWS}
var
  fLibHandle: Integer = 0;
  fLuaLibFileName: String = 'Lua5.1.dll';
{$endif}

(*
** Dynamic library manipulation
*)

function GetProcAddr( fHandle: THandle; const methodName: String; bErrorIfNotExists: Boolean = True ): Pointer;
begin
  Result := GetProcAddress( fHandle, PChar( methodName ) );

  if bErrorIfNotExists and ( Result = nil ) then
     Raise Exception.Create( 'Cannot load method ' + QuotedStr( methodName ) + ' from dynamic library.' );
end;

procedure SetLuaLibFileName( newLuaLibFileName: String );
begin
  fLuaLibFileName := newLuaLibFileName;
end;

function GetLuaLibFileName(): String;
begin
  Result := fLuaLibFileName;
end;

function LoadLuaLib(newLuaLibFileName: String): Integer;
begin
{$ifdef MSWINDOWS}
  FreeLuaLib();

  if newLuaLibFileName <> '' then
     SetLuaLibFileName( newLuaLibFileName );
      
  if not FileExists( GetLuaLibFileName() ) then begin
     Result := -1;
     exit;
  end;

  fLibHandle := LoadLibrary( PChar( GetLuaLibFileName() ) );

  if fLibHandle = 0 then begin
     Result := -2;
     exit;
  end;

  lua_newstate       := GetProcAddr( fLibHandle, 'lua_newstate' );
  lua_close          := GetProcAddr( fLibHandle, 'lua_close' );
  lua_newthread      := GetProcAddr( fLibHandle, 'lua_newthread' );
  lua_atpanic        := GetProcAddr( fLibHandle, 'lua_atpanic' );
  lua_gettop         := GetProcAddr( fLibHandle, 'lua_gettop' );
  lua_settop         := GetProcAddr( fLibHandle, 'lua_settop' );
  lua_pushvalue      := GetProcAddr( fLibHandle, 'lua_pushvalue' );
  lua_remove         := GetProcAddr( fLibHandle, 'lua_remove' );
  lua_insert         := GetProcAddr( fLibHandle, 'lua_insert' );
  lua_replace        := GetProcAddr( fLibHandle, 'lua_replace' );
  lua_checkstack     := GetProcAddr( fLibHandle, 'lua_checkstack' );
  lua_xmove          := GetProcAddr( fLibHandle, 'lua_xmove' );
  lua_isnumber       := GetProcAddr( fLibHandle, 'lua_isnumber' );
  lua_isstring       := GetProcAddr( fLibHandle, 'lua_isstring' );
  lua_iscfunction    := GetProcAddr( fLibHandle, 'lua_iscfunction' );
  lua_isuserdata     := GetProcAddr( fLibHandle, 'lua_isuserdata' );
  lua_type           := GetProcAddr( fLibHandle, 'lua_type' );
  lua_typename       := GetProcAddr( fLibHandle, 'lua_typename' );
  lua_equal          := GetProcAddr( fLibHandle, 'lua_equal' );
  lua_rawequal       := GetProcAddr( fLibHandle, 'lua_rawequal' );
  lua_lessthan       := GetProcAddr( fLibHandle, 'lua_lessthan' );
  lua_tonumber       := GetProcAddr( fLibHandle, 'lua_tonumber' );
  lua_tointeger      := GetProcAddr( fLibHandle, 'lua_tointeger' );
  lua_toboolean      := GetProcAddr( fLibHandle, 'lua_toboolean' );
  lua_tolstring      := GetProcAddr( fLibHandle, 'lua_tolstring' );
  lua_objlen         := GetProcAddr( fLibHandle, 'lua_objlen' );
  lua_tocfunction    := GetProcAddr( fLibHandle, 'lua_tocfunction' );
  lua_touserdata     := GetProcAddr( fLibHandle, 'lua_touserdata' );
  lua_tothread       := GetProcAddr( fLibHandle, 'lua_tothread' );
  lua_topointer      := GetProcAddr( fLibHandle, 'lua_topointer' );
  lua_pushnil        := GetProcAddr( fLibHandle, 'lua_pushnil' );
  lua_pushnumber     := GetProcAddr( fLibHandle, 'lua_pushnumber' );
  lua_pushinteger    := GetProcAddr( fLibHandle, 'lua_pushinteger' );
  lua_pushlstring    := GetProcAddr( fLibHandle, 'lua_pushlstring' );
  lua_pushstring     := GetProcAddr( fLibHandle, 'lua_pushstring' );
  lua_pushvfstring   := GetProcAddr( fLibHandle, 'lua_pushvfstring' );
  lua_pushfstring    := GetProcAddr( fLibHandle, 'lua_pushfstring' );
  lua_pushcclosure   := GetProcAddr( fLibHandle, 'lua_pushcclosure' );
  lua_pushboolean    := GetProcAddr( fLibHandle, 'lua_pushboolean' );
  lua_pushlightuserdata := GetProcAddr( fLibHandle, 'lua_pushlightuserdata' );
  lua_pushthread     := GetProcAddr( fLibHandle, 'lua_pushthread' );
  lua_gettable       := GetProcAddr( fLibHandle, 'lua_gettable' );
  lua_getfield       := GetProcAddr( fLibHandle, 'lua_getfield' );
  lua_rawget         := GetProcAddr( fLibHandle, 'lua_rawget' );
  lua_rawgeti        := GetProcAddr( fLibHandle, 'lua_rawgeti' );
  lua_createtable    := GetProcAddr( fLibHandle, 'lua_createtable' );
  lua_newuserdata    := GetProcAddr( fLibHandle, 'lua_newuserdata' );
  lua_getmetatable   := GetProcAddr( fLibHandle, 'lua_getmetatable' );
  lua_getfenv        := GetProcAddr( fLibHandle, 'lua_getfenv' );
  lua_settable       := GetProcAddr( fLibHandle, 'lua_settable' );
  lua_setfield       := GetProcAddr( fLibHandle, 'lua_setfield' );
  lua_rawset         := GetProcAddr( fLibHandle, 'lua_rawset' );
  lua_rawseti        := GetProcAddr( fLibHandle, 'lua_rawseti' );
  lua_setmetatable   := GetProcAddr( fLibHandle, 'lua_setmetatable' );
  lua_setfenv        := GetProcAddr( fLibHandle, 'lua_setfenv' );
  lua_call           := GetProcAddr( fLibHandle, 'lua_call' );
  lua_pcall          := GetProcAddr( fLibHandle, 'lua_pcall' );
  lua_cpcall         := GetProcAddr( fLibHandle, 'lua_cpcall' );
  lua_load           := GetProcAddr( fLibHandle, 'lua_load' );
  lua_dump           := GetProcAddr( fLibHandle, 'lua_dump' );
  lua_yield          := GetProcAddr( fLibHandle, 'lua_yield' );
  lua_resume         := GetProcAddr( fLibHandle, 'lua_resume' );
  lua_status         := GetProcAddr( fLibHandle, 'lua_status' );
  lua_gc             := GetProcAddr( fLibHandle, 'lua_gc' );
  lua_error          := GetProcAddr( fLibHandle, 'lua_error' );
  lua_next           := GetProcAddr( fLibHandle, 'lua_next' );
  lua_concat         := GetProcAddr( fLibHandle, 'lua_concat' );
  lua_getallocf      := GetProcAddr( fLibHandle, 'lua_getallocf' );
  lua_setallocf      := GetProcAddr( fLibHandle, 'lua_setallocf' );
  lua_getstack       := GetProcAddr( fLibHandle, 'lua_getstack' );
  lua_getinfo        := GetProcAddr( fLibHandle, 'lua_getinfo' );
  lua_getlocal       := GetProcAddr( fLibHandle, 'lua_getlocal' );
  lua_setlocal       := GetProcAddr( fLibHandle, 'lua_setlocal' );
  lua_getupvalue     := GetProcAddr( fLibHandle, 'lua_getupvalue' );
  lua_setupvalue     := GetProcAddr( fLibHandle, 'lua_setupvalue' );
  lua_sethook        := GetProcAddr( fLibHandle, 'lua_sethook' );
  lua_gethook        := GetProcAddr( fLibHandle, 'lua_gethook' );
  lua_gethookmask    := GetProcAddr( fLibHandle, 'lua_gethookmask' );
  lua_gethookcount   := GetProcAddr( fLibHandle, 'lua_gethookcount' );
  luaopen_base       := GetProcAddr( fLibHandle, 'luaopen_base' );
  luaopen_table      := GetProcAddr( fLibHandle, 'luaopen_table' );
  luaopen_io         := GetProcAddr( fLibHandle, 'luaopen_io' );
  luaopen_os         := GetProcAddr( fLibHandle, 'luaopen_os' );
  luaopen_string     := GetProcAddr( fLibHandle, 'luaopen_string' );
  luaopen_math       := GetProcAddr( fLibHandle, 'luaopen_math' );
  luaopen_debug      := GetProcAddr( fLibHandle, 'luaopen_debug' );
  luaopen_package    := GetProcAddr( fLibHandle, 'luaopen_package' );
  luaL_openlibs      := GetProcAddr( fLibHandle, 'luaL_openlibs' );
  luaL_register      := GetProcAddr( fLibHandle, 'luaL_register' );
  luaL_getmetafield  := GetProcAddr( fLibHandle, 'luaL_getmetafield' );
  luaL_callmeta      := GetProcAddr( fLibHandle, 'luaL_callmeta' );
  luaL_typerror      := GetProcAddr( fLibHandle, 'luaL_typerror' );
  luaL_argerror      := GetProcAddr( fLibHandle, 'luaL_argerror' );
  luaL_checklstring  := GetProcAddr( fLibHandle, 'luaL_checklstring' );
  luaL_optlstring    := GetProcAddr( fLibHandle, 'luaL_optlstring' );
  luaL_checknumber   := GetProcAddr( fLibHandle, 'luaL_checknumber' );
  luaL_optnumber     := GetProcAddr( fLibHandle, 'luaL_optnumber' );
  luaL_checkinteger  := GetProcAddr( fLibHandle, 'luaL_checkinteger' );
  luaL_optinteger    := GetProcAddr( fLibHandle, 'luaL_optinteger' );
  luaL_checkstack    := GetProcAddr( fLibHandle, 'luaL_checkstack' );
  luaL_checktype     := GetProcAddr( fLibHandle, 'luaL_checktype' );
  luaL_checkany      := GetProcAddr( fLibHandle, 'luaL_checkany' );
  luaL_newmetatable  := GetProcAddr( fLibHandle, 'luaL_newmetatable' );
  luaL_checkudata    := GetProcAddr( fLibHandle, 'luaL_checkudata' );
  luaL_where         := GetProcAddr( fLibHandle, 'luaL_where' );
  luaL_error         := GetProcAddr( fLibHandle, 'luaL_error' );
  luaL_checkoption   := GetProcAddr( fLibHandle, 'luaL_checkoption' );
  luaL_ref           := GetProcAddr( fLibHandle, 'luaL_ref' );
  luaL_unref         := GetProcAddr( fLibHandle, 'luaL_unref' );
{$ifdef LUA_COMPAT_GETN}
  luaL_getn          := GetProcAddr( fLibHandle, 'luaL_getn' );
  luaL_setn          := GetProcAddr( fLibHandle, 'luaL_setn' );
{$endif}
  luaL_loadfile      := GetProcAddr( fLibHandle, 'luaL_loadfile' );
  luaL_loadbuffer    := GetProcAddr( fLibHandle, 'luaL_loadbuffer' );
  luaL_loadstring    := GetProcAddr( fLibHandle, 'luaL_loadstring' );
  luaL_newstate      := GetProcAddr( fLibHandle, 'luaL_newstate' );
  luaL_gsub          := GetProcAddr( fLibHandle, 'luaL_gsub' );
  luaL_findtable     := GetProcAddr( fLibHandle, 'luaL_findtable' );
  luaL_buffinit      := GetProcAddr( fLibHandle, 'luaL_buffinit' );
  luaL_prepbuffer    := GetProcAddr( fLibHandle, 'luaL_prepbuffer' );
  luaL_addlstring    := GetProcAddr( fLibHandle, 'luaL_addlstring' );
  luaL_addstring     := GetProcAddr( fLibHandle, 'luaL_addstring' );
  luaL_addvalue      := GetProcAddr( fLibHandle, 'luaL_addvalue' );
  luaL_pushresult    := GetProcAddr( fLibHandle, 'luaL_pushresult' );

  Result := fLibHandle;
{$endif}
end;

procedure FreeLuaLib();
begin
{$ifdef MSWINDOWS}
  lua_newstate       := nil;
  lua_close          := nil;
  lua_newthread      := nil;
  lua_atpanic        := nil;
  lua_gettop         := nil;
  lua_settop         := nil;
  lua_pushvalue      := nil;
  lua_remove         := nil;
  lua_insert         := nil;
  lua_replace        := nil;
  lua_checkstack     := nil;
  lua_xmove          := nil;
  lua_isnumber       := nil;
  lua_isstring       := nil;
  lua_iscfunction    := nil;
  lua_isuserdata     := nil;
  lua_type           := nil;
  lua_typename       := nil;
  lua_equal          := nil;
  lua_rawequal       := nil;
  lua_lessthan       := nil;
  lua_tonumber       := nil;
  lua_tointeger      := nil;
  lua_toboolean      := nil;
  lua_tolstring      := nil;
  lua_objlen         := nil;
  lua_tocfunction    := nil;
  lua_touserdata     := nil;
  lua_tothread       := nil;
  lua_topointer      := nil;
  lua_pushnil        := nil;
  lua_pushnumber     := nil;
  lua_pushinteger    := nil;
  lua_pushlstring    := nil;
  lua_pushstring     := nil;
  lua_pushvfstring   := nil;
  lua_pushfstring    := nil;
  lua_pushcclosure   := nil;
  lua_pushboolean    := nil;
  lua_pushlightuserdata := nil;
  lua_pushthread     := nil;
  lua_gettable       := nil;
  lua_getfield       := nil;
  lua_rawget         := nil;
  lua_rawgeti        := nil;
  lua_createtable    := nil;
  lua_newuserdata    := nil;
  lua_getmetatable   := nil;
  lua_getfenv        := nil;
  lua_settable       := nil;
  lua_setfield       := nil;
  lua_rawset         := nil;
  lua_rawseti        := nil;
  lua_setmetatable   := nil;
  lua_setfenv        := nil;
  lua_call           := nil;
  lua_pcall          := nil;
  lua_cpcall         := nil;
  lua_load           := nil;
  lua_dump           := nil;
  lua_yield          := nil;
  lua_resume         := nil;
  lua_status         := nil;
  lua_gc             := nil;
  lua_error          := nil;
  lua_next           := nil;
  lua_concat         := nil;
  lua_getallocf      := nil;
  lua_setallocf      := nil;
  lua_getstack       := nil;
  lua_getinfo        := nil;
  lua_getlocal       := nil;
  lua_setlocal       := nil;
  lua_getupvalue     := nil;
  lua_setupvalue     := nil;
  lua_sethook        := nil;
  lua_gethook        := nil;
  lua_gethookmask    := nil;
  lua_gethookcount   := nil;
  luaopen_base       := nil;
  luaopen_table      := nil;
  luaopen_io         := nil;
  luaopen_os         := nil;
  luaopen_string     := nil;
  luaopen_math       := nil;
  luaopen_debug      := nil;
  luaopen_package    := nil;
  luaL_openlibs      := nil;
  luaL_register      := nil;
  luaL_getmetafield  := nil;
  luaL_callmeta      := nil;
  luaL_typerror      := nil;
  luaL_argerror      := nil;
  luaL_checklstring  := nil;
  luaL_optlstring    := nil;
  luaL_checknumber   := nil;
  luaL_optnumber     := nil;
  luaL_checkinteger  := nil;
  luaL_optinteger    := nil;
  luaL_checkstack    := nil;
  luaL_checktype     := nil;
  luaL_checkany      := nil;
  luaL_newmetatable  := nil;
  luaL_checkudata    := nil;
  luaL_where         := nil;
  luaL_error         := nil;
  luaL_checkoption   := nil;
  luaL_ref           := nil;
  luaL_unref         := nil;
{$ifdef LUA_COMPAT_GETN}
  luaL_getn          := nil;
  luaL_setn          := nil;
{$endif}
  luaL_loadfile      := nil;
  luaL_loadbuffer    := nil;
  luaL_loadstring    := nil;
  luaL_newstate      := nil;
  luaL_gsub          := nil;
  luaL_findtable     := nil;
  luaL_buffinit      := nil;
  luaL_prepbuffer    := nil;
  luaL_addlstring    := nil;
  luaL_addstring     := nil;
  luaL_addvalue      := nil;
  luaL_pushresult    := nil;

  if fLibHandle <> 0 then begin
     FreeLibrary( fLibHandle );
     fLibHandle := 0;
  end;
{$endif}
end;

{$ifndef LUA_COMPAT_GETN}
function luaL_getn(L: lua_State; t: Integer): Integer;
begin
  Result := lua_objlen(L, t);
end;

procedure luaL_setn(L: lua_State; t, n: Integer);
begin
end;
{$endif}

function lua_upvalueindex(i: Integer): Integer;
begin
  Result := LUA_GLOBALSINDEX - i;
end;

procedure lua_pop(L: lua_State; n: Integer);
begin
  lua_settop(L, -(n) - 1);
end;

procedure lua_newtable(L: lua_State);
begin
  lua_createtable(L, 0, 0);
end;

function lua_strlen(L: lua_State; i: Integer): Cardinal;
begin
  result := lua_objlen(L, i);
end;

procedure lua_register(L: lua_state; name: PChar; f: lua_CFunction);
begin
  lua_pushcfunction(L, f);
  lua_setglobal(L, name);
end;

procedure lua_pushcfunction(L: lua_State; f: lua_CFunction);
begin
  lua_pushcclosure(L, f, 0);
end;

function lua_isfunction(L: lua_State; idx: Integer): Boolean;
begin
  Result := lua_type(L, idx) = LUA_TFUNCTION;
end;

function lua_istable(L: lua_State; idx: Integer): Boolean;
begin
  Result := lua_type(L, idx) = LUA_TTABLE;
end;

function lua_islightuserdata(L: lua_State; idx: Integer): Boolean;
begin
  Result := lua_type(L, idx) = LUA_TLIGHTUSERDATA;
end;

function lua_isnil(L: lua_State; idx: Integer): Boolean;
begin
  Result := lua_type(L, idx) = LUA_TNIL;
end;

function lua_isboolean(L: lua_State; idx: Integer): Boolean;
begin
  Result := lua_type(L, idx) = LUA_TBOOLEAN;
end;

function lua_isthread(L: lua_State; idx: Integer): Boolean;
begin
  Result := lua_type(L, idx) = LUA_TTHREAD;
end;

function lua_isnone(L: lua_State; idx: Integer): Boolean;
begin
  Result := lua_type(L, idx) = LUA_TNONE;
end;

function lua_isnoneornil(L: lua_State; idx: Integer): Boolean;
begin
  Result := lua_type(L, idx) <= 0;
end;

procedure lua_pushliteral(L: lua_State; s: PChar);
begin
  lua_pushlstring(L, s, StrLen(s));
end;

procedure lua_setglobal(L: lua_State; name: PChar);
begin
  lua_setfield(L, LUA_GLOBALSINDEX, name);
end;

procedure lua_getglobal(L: lua_State; name: PChar);
begin
  lua_getfield(L, LUA_GLOBALSINDEX, name);
end;

function lua_tostring(L: lua_State; idx: Integer): PChar;
var
  len: Cardinal;
begin
  Result := lua_tolstring(L, idx, len);
end;

function lua_getgccount(L: lua_State): Integer;
begin
  Result := lua_gc(L, LUA_GCCOUNT, 0);
end;

function lua_open(): lua_State;
begin
  Result := luaL_newstate();
end;

procedure lua_getregistry(L: lua_State);
begin
  lua_pushvalue(L, LUA_REGISTRYINDEX);
end;

function lua_ref(L: lua_State; lock: Boolean): Integer;
begin
  if lock then
     Result := luaL_ref(L, LUA_REGISTRYINDEX)
  else begin
     lua_pushstring(L, 'unlocked references are obsolete');
     Result := lua_error(L);
  end;
end;

procedure lua_unref(L: lua_State; ref: Integer);
begin
  luaL_unref(L, LUA_REGISTRYINDEX, ref);
end;

procedure lua_getref(L: lua_State; ref: Integer);
begin
  lua_rawgeti(L, LUA_REGISTRYINDEX, ref);
end;

procedure lua_assert(c: Boolean);
begin
end;

function lua_number2str(s: Lua_Number; n: Integer): String;
begin
  Result := FormatFloat( LUA_NUMBER_FMT, RoundTo( s, n ) );
end;

function lua_str2number(s: String; p: integer): Lua_Number;
begin
  Result := RoundTo( StrToFloat( s ), p );
end;

function luaL_argcheck(L: lua_State; cond: Boolean; narg: Integer; extramsg: PChar): Integer;
begin
  if cond then
     Result := 0
  else
     Result := luaL_argerror(L, narg, extramsg);
end;

function luaL_checkstring(L: lua_State; narg: Integer): PChar;
var
  ls: Cardinal;
begin
  Result := luaL_checklstring(L, narg, ls);
end;

function luaL_optstring(L: lua_State; narg: Integer; d: PChar): PChar;
var
  ls: Cardinal;
begin
  Result := luaL_optlstring(L, narg, d, ls);
end;

function luaL_checkint(L: lua_State; narg: Integer): Integer;
begin
  Result := Trunc(luaL_checkinteger(L, narg));
end;

function luaL_optint(L: lua_State; narg, d: Integer): Integer;
begin
  Result := Trunc(luaL_optinteger(L, narg, d));
end;

function luaL_checklong(L: lua_State; narg: Integer): LongInt;
begin
  Result := Trunc(luaL_checkinteger(L, narg));
end;

function luaL_optlong(L: lua_State; narg: Integer; d: LongInt): LongInt;
begin
  Result := Trunc(luaL_optinteger(L, narg, d));
end;

function luaL_typename(L: lua_State; idx: Integer): PChar;
begin
  Result := lua_typename(L, lua_type(L, idx));
end;

function luaL_dofile(L: lua_State; filename: PChar): Integer;
begin
  Result := luaL_loadfile(L, filename);

  If Result = 0 Then
     Result := lua_pcall(L, 0, LUA_MULTRET, 0);
end;

function luaL_dostring(L: lua_State; str: PChar): Integer;
begin
  Result := luaL_loadstring(L, str);
  
  If Result = 0 Then
     Result := lua_pcall(L, 0, LUA_MULTRET, 0);
end;

procedure luaL_getmetatable(L: lua_State; tname: PChar);
begin
   lua_getfield(L, LUA_REGISTRYINDEX, tname);
end;

procedure luaL_addchar(var B: luaL_Buffer; c: Char);
begin
  if Integer(B.p) < Integer(B.buffer + LUAL_BUFFERSIZE) then
     luaL_prepbuffer(B);

  B.p^ := c;
  Inc(B.p);
{  // original C code
#define luaL_addchar(B,c) \
  ((void)((B)->p < ((B)->buffer+LUAL_BUFFERSIZE) || luaL_prepbuffer(B)), \
   (*(B)->p++ = (char)(c)))
}
end;

procedure luaL_putchar(var B: luaL_Buffer; c: Char);
begin
  luaL_addchar(B, c);
end;

procedure luaL_addsize(var B: luaL_Buffer; n: Cardinal);
begin
  Inc(B.p, n);
end;

function luaL_check_lstr(L: lua_State; numArg: Integer; var ls: Cardinal): PChar;
begin
  Result := luaL_checklstring(L, numArg, ls);
end;

function luaL_opt_lstr(L: lua_State; numArg: Integer; def: PChar; var ls: Cardinal): PChar;
begin
  Result := luaL_optlstring(L, numArg, def, ls);
end;

function luaL_check_number(L: lua_State; numArg: Integer): lua_Number;
begin
  Result := luaL_checknumber(L, numArg);
end;

function luaL_opt_number(L: lua_State; nArg: Integer; def: lua_Number): lua_Number;
begin
  Result := luaL_optnumber(L, nArg, def);
end;

function luaL_arg_check(L: lua_State; cond: Boolean; numarg: Integer; extramsg: PChar): Integer;
begin
  Result := luaL_argcheck(L, cond, numarg, extramsg);
end;

function luaL_check_string(L: lua_State; n: Integer): PChar;
begin
  Result := luaL_checkstring(L, n);
end;

function luaL_opt_string(L: lua_State; n: Integer; d: PChar): PChar;
begin
  Result := luaL_optstring(L, n, d);
end;

function luaL_check_int(L: lua_State; n: Integer): Integer;
begin
  Result := luaL_checkint(L, n);
end;

function luaL_check_long(L: lua_State; n: LongInt): LongInt;
begin
  Result := luaL_checklong(L, n);
end;

function luaL_opt_int(L: lua_State; n, d: Integer): Integer;
begin
  Result := luaL_optint(L, n, d);
end;

function luaL_opt_long(L: lua_State; n: Integer; d: LongInt): LongInt;
begin
  Result := luaL_optlong(L, n, d);
end;

end.

