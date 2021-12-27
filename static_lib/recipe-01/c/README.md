### 构建静态库和可执行程序

1. 基于gcc命令行方式构建程序
```
$ cd ${CURRENT_DIR}/lib
$ ./build_static_lib.sh
$ cd ${CURRENT_DIR}/app
$ ./build_app.sh
```
或者
```
$ ./build.sh
```

2. 基于make脚本方式构建程序
```
$ cd ${CURRENT_DIR}/lib
$ make
$ cd ${CURRENT_DIR}/app
$ make
```
或者
```
$ make
```

