# Kernel exports

## RtlInitAnsiString

**Parameters**: OUT PANSI_STRING OutputString, IN LPCSTR String
**Returns**: OutputString as an ANSI equivalent of String
**Prototype**: void RtlInitAnsiString( PANSI_STRING, LPCSTR );
**Example**:

```cpp
ANSI_STRING DeviceName;
RtlInitAnsiString(&DeviceName, "\\Device\\Harddisk0\\Partition1");
```

## ObCreateSymbolicLink

**Parameters**: IN PANSI_STRING SymbolicLinkName, IN PANSI_STRING
DeviceName
**Returns**: 0 if success
**Prototype**: int ObCreateSymbolicLink( PANSI_STRING, PANSI_STRING
);
**Example**:

```cpp
int result = ObCreateSymbolicLink( "\\??\\hdd:", "\\Device\\Harddisk0\\Partition1" );
(wont actually work)
```

Both strings have to be ANSI, use RtlInitAnsiString to make them

## ObDeleteSymbolicLink

**Parameters**: IN PANSI_STRING SymbolicLinkName
**Returns**: 0 if success
**Prototype**: int ObDeleteSymbolicLink( PANSI_STRING );
**Example**:

```cpp
int result = ObDeleteSymbolicLink( "\\??\\hdd:" );
(wont actually work)
```

As above, use `RtlInitAnsiString` to make the string

[System Software](System_Software)
