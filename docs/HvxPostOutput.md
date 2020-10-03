# HvxPostOutput

``` cpp
 static QWORD _declspec(naked) HvxPostOutput(BYTE code)
 {
    __asm
    {
        li  r0, 0xD
        sc
        blr
    }
 }
```

HvxPostOutput(0xFF); 

Returns 0
