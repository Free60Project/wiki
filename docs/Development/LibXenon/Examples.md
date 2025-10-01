# LibXenon examples

## XMENU source code by **cpasjuste**

Download: [libxenon.org](http://file.libxenon.org/free60/libxenon/xmenu_src_20090914.tar.gz)

## Genesis Plus + SMS Plus source code by **ced2911**
Genesis Plus: <http://www.multiupload.com/6QYQL218GB>

SMS Plus: <http://www.multiupload.com/62T7RVYB5A>

## Controller Button test code by **ced2911**
Source Code (incl. Makefile): [Download](http://file.libxenon.org/free60/libxenon/LibXenon_HelloWorld.tar.gz)

```cpp
 #include <stdio.h>
 #include <stdlib.h>
 #include <input/input.h>
 #include <xenos/xenos.h>
 #include <console/console.h>

 void mainInit()
 {
    //init
    xenos_init();
    console_init();

    kmem_init();
    usb_init();
    usb_do_poll();
 }
 int main()
 {
    mainInit();
    printf("Test\n");

    struct controller_data_s oldc;
    while(1)
    {
        struct controller_data_s c;
        if (get_controller_data(&c, 0))
        {

            if((c.a)&&(!oldc.a))
            {
                printf("a pushed\n");
            }
            if((!c.a)&&(oldc.a))
            {
                printf("a released\n");
            }
            oldc=c;
        }
        usb_do_poll();
    }
    return 0;
 }
```

### Compiling LibXenon Code

All of these samples/programs include a Makefile, so its easy to compile
them with the [Toolchain](https://github.com/Free60Project/libxenon).

```sh
cd into_the_directory
make CROSS_COMPILE=xenon-
```

When you are writing your own programs you can just take the Makefile
from this HelloWorld application, put it in your sourcecode-folder and
move all the sourcecode-files of your project into a folder "source" so
the Makefile can find
them.

[Category: Homebrew Software](../../Homebrew/index.md)

