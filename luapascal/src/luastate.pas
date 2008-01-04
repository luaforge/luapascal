unit LuaState;

interface

uses Lua, uEntity;

type
  TLuaDataType = ( ldtNone, ldtNil, ldtBoolean, ldtLightUserData, ldtNumber, ldtString, ldtTable,
                   ldtFunction, ldtUserData, ldtThread, ldtInteger, ldtPChar, ldtCFunction, ldtPointer );

  TLuaTable = class
  end;

  TLuaThread = class
  end;

  TLuaUserData = class
  end;

  TLuaField = class
  private
    function GetAsBoolean: Boolean;
    function GetAsCFunction: Pointer;
    function GetAsInteger: Integer;
    function GetAsNumber: Double;
    function GetAsPChar: PChar;
    function GetAsPointer: Pointer;
    function GetAsString: String;
    function GetAsTable: TLuaTable;
    function GetAsThread: TLuaThread;
    function GetAsUserData: TLuaUserData;
    
    procedure SetAsBoolean(const Value: Boolean);
    procedure SetAsCFunction(const Value: Pointer);
    procedure SetAsInteger(const Value: Integer);
    procedure SetAsNumber(const Value: Double);
    procedure SetAsPChar(const Value: PChar);
    procedure SetAsPointer(const Value: Pointer);
    procedure SetAsString(const Value: String);
    procedure SetAsTable(const Value: TLuaTable);
    procedure SetAsThread(const Value: TLuaThread);
    procedure SetAsUserData(const Value: TLuaUserData);
  protected
  public
    function IsBoolean(): Boolean;
    function IsCFunction(): Boolean;
    function IsInteger(): Boolean;
    function IsNil(): Boolean;
    function IsNull(): Boolean;
    function IsNumber(): Boolean;
    function IsPChar(): Boolean;
    function IsPointer(): Boolean;
    function IsString(): Boolean;
    function IsTable(): Boolean;
    function IsThread(): Boolean;
    function IsUserData(): Boolean;

    function DataType(): TLuaDataType;
    function DataTypeName(): String;

    property AsBoolean: Boolean       read GetAsBoolean   write SetAsBoolean;
    property AsCFunction: Pointer     read GetAsCFunction write SetAsCFunction;
    property AsInteger: Integer       read GetAsInteger   write SetAsInteger;
    property AsNumber: Double         read GetAsNumber    write SetAsNumber;
    property AsPChar: PChar           read GetAsPChar     write SetAsPChar;
    property AsPointer: Pointer       read GetAsPointer   write SetAsPointer;
    property AsString: String         read GetAsString    write SetAsString;
    property AsTable: TLuaTable       read GetAsTable     write SetAsTable;
    property AsThread: TLuaThread     read GetAsThread    write SetAsThread;
    property AsUserData: TLuaUserData read GetAsUserData  write SetAsUserData;
  end;

  TLuaState = class
  private
   	LS: lua_State;
  protected
  public
    constructor Create();
    destructor Destroy(); override;

    function TableField( tableName: String; field: Integer ): TLuaField;
    function TableFieldByName( tableName, fieldName: String ): TLuaField;
    function CreateTable( tableName: String ): Boolean; overload;
    function CreateTable( tableName: String; narrays, nelements: Integer ): Boolean; overload;

    property  LuaState: lua_State read LS;
  end;

implementation

uses SysUtils;

{ TLuaField }

function TLuaField.DataType: TLuaDataType;
begin

end;

function TLuaField.DataTypeName: String;
begin

end;

function TLuaField.GetAsBoolean: Boolean;
begin

end;

function TLuaField.GetAsCFunction: Pointer;
begin

end;

function TLuaField.GetAsInteger: Integer;
begin

end;

function TLuaField.GetAsNumber: Double;
begin

end;

function TLuaField.GetAsPChar: PChar;
begin

end;

function TLuaField.GetAsPointer: Pointer;
begin

end;

function TLuaField.GetAsString: String;
begin

end;

function TLuaField.GetAsTable: TLuaTable;
begin

end;

function TLuaField.GetAsThread: TLuaThread;
begin

end;

function TLuaField.GetAsUserData: TLuaUserData;
begin

end;

function TLuaField.IsBoolean: Boolean;
begin
  Result := lua_isboolen( LS, -1 );
end;

function TLuaField.IsCFunction: Boolean;
begin
  Result := lua_isCFunction( LS, -1 );
end;

function TLuaField.IsInteger: Boolean;
begin
  Result := lua_isInteger( LS, -1 );
end;

function TLuaField.IsNil: Boolean;
begin
  Result := lua_isnoneornil( LS, -1 );
end;

function TLuaField.IsNull: Boolean;
begin
  if lua_isstring( LS, -1 ) then
  else
     ;
end;

function TLuaField.IsNumber: Boolean;
begin
  Result := lua_isnumber( LS, -1 );
end;

function TLuaField.IsPChar: Boolean;
begin
  Result := lua_isstring( LS, -1 );
end;

function TLuaField.IsPointer: Boolean;
begin
  Result := lua_ispointer( LS, -1 );
end;

function TLuaField.IsString: Boolean;
begin
  Result := lua_isstring( LS, -1 );
end;

function TLuaField.IsTable: Boolean;
begin
  Result := lua_istable( LS, -1 );
end;

function TLuaField.IsThread: Boolean;
begin
  Result := lua_isthread( LS, -1 );
end;

function TLuaField.IsUserData: Boolean;
begin
  Result := lua_isuserdata( LS, -1 );
end;

procedure TLuaField.SetAsBoolean(const Value: Boolean);
begin

end;

procedure TLuaField.SetAsCFunction(const Value: Pointer);
begin

end;

procedure TLuaField.SetAsInteger(const Value: Integer);
begin

end;

procedure TLuaField.SetAsNumber(const Value: Double);
begin

end;

procedure TLuaField.SetAsPChar(const Value: PChar);
begin

end;

procedure TLuaField.SetAsPointer(const Value: Pointer);
begin

end;

procedure TLuaField.SetAsString(const Value: String);
begin

end;

procedure TLuaField.SetAsTable(const Value: TLuaTable);
begin

end;

procedure TLuaField.SetAsThread(const Value: TLuaThread);
begin

end;

procedure TLuaField.SetAsUserData(const Value: TLuaUserData);
begin

end;

{ TLuaState }

constructor TLuaState.Create;
begin
  LS := lua_open();
end;

destructor TLuaState.Destroy;
begin
 	lua_close( LS );
end;

function TLuaState.CreateTable(tableName: String): Boolean;
begin

end;

function TLuaState.CreateTable(tableName: String; narrays, nelements: Integer): Boolean;
begin

end;

function TLuaState.TableField(tableName: String; field: Integer): TLuaField;
begin

end;

function TLuaState.TableFieldByName(tableName, fieldName: String): TLuaField;
begin

end;

end.

