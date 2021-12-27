### 导入完整归档的情况

中介动态库（The intermediary dynamic library）自身并不使用任何动态库的功能。
链接器通过--whole-archive链接器选项来提供这个功能。

default目录下是没加--whole-archive链接器选项的工程，最终app链接mydynamiclib库时会报undefined reference的错误
```
main.c:(.text+0x1c): undefined reference to `first_function'
main.c:(.text+0x29): undefined reference to `second_function'
main.c:(.text+0x36): undefined reference to `third_function'
main.c:(.text+0x43): undefined reference to `fourth_function'
collect2: error: ld returned 1 exit status
```

#### 参考资料:
《高级C/C++编译技术》: 4.3章节
