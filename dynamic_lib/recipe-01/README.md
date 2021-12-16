### 在Linux中创建动态库

通常来说，创建动态库的过程至少需要下面两个选项：
- -fPIC编译器选项。
- -shared连接器选项。

下面的简单示例演示了从两个源代码文件创建动态库的过程：
```shell
$ gcc -fPIC -c first.c second.c
$ gcc -shared first.o second.o -o libdynamiclib.so
```

### Linux构建过程中库文件定位规则

在Linux中使用-L和-l选项来指定构建过程中库文件的路径。以下列

#### 参考资料:
《高级C/C++编译技术》: 6.1章节
