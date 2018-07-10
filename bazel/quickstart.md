# Quick Start



## Preparation



### Install

* required packages

```shell
sudo apt-get install pkg-config zip g++ zlib1g-dev unzip python
```

* download bazel

```shell
mkdir ~/bazel
cd ~/bazel
wget https://github.com/bazelbuild/bazel/releases/download/0.15.0/bazel-0.15.0-installer-linux-x86_64.sh
```

* run the installer

```shell
chmod +x bazel-0.15.0-installer-linux-x86_64.sh
./bazel-0.15.0-installer-linux-x86_64.sh --user
```

* set the environment (`~/.bashrc`)

```shell
export PATH="$PATH:$HOME/bin"
```



## Build



### C++

bazel mainly includes two parts, a `workspace` and `BUILD` files

* simple example

```shell
git clone https://github.com/bazelbuild/examples.git
cd ./example/cpp-tutorial/stage1
bazel build //main:hello-world

# execute the binary file
bazel-bin/main/hello-world

# show the build graph
bazel query --nohost_deps --noimplicit_deps 'deps(//main:hello-world)' --output graph
```

and the basic workspace structure as the below

```text
+ stage1
  + main
    - BUILD
    - hello-world.cc
  - workapce
+ stage2
+ stage3
```

the basic `BUILD`

```ini
cc_binary(
    name = "hello-world",
    srcs = ["hello-world.cc"],
)
```

* multiple targets

```shell
cd ./example/cpp-tutorial/stage2
bazel build //main:hello-world
bazel-bin/main/hello-world
bazel query --nohost_deps --noimplicit_deps 'deps(//main:hello-world)' --output graph
```

and the basic workspace structure as the below

```text
+ stage1
+ stage2
  + main
    - BUILD
    - hello-greet.cc
    - hello-greet.h
    - hello-world.cc
  - WORKSPACE
+ stage3
```

multiple targets `BUILD`

```ini
cc_library(
    name = "hello-greet",
    srcs = ["hello-greet.cc"],
    hdrs = ["hello-greet.h"],
)

cc_binary(
    name = "hello-world",
    srcs = ["hello-world.cc"],
    deps = [
        ":hello-greet",
    ],
)
```

* multiple targets `BUILD`

```shell
cd ./example/cpp-tutorial/stage3
bazel build //main:hello-world
bazel-bin/main/hello-world
bazel query --nohost_deps --noimplicit_deps 'deps(//main:hello-world)' --output graph
```

and the basic workspace structure as the below

```text
+ stage1
+ stage2
+ stage3
  + main
    - BUILD
    - hello-greet.cc
    - hello-greet.h
    - hello-world.cc
  + lib
    - BUILD
    - hello-time.cc
    - hello-time.h
  - WORKSPACE
```

the `BUILD` in the `main` package as the below

```ini
cc_library(
    name = "hello-greet",
    srcs = ["hello-greet.cc"],
    hdrs = ["hello-greet.h"],
)

cc_binary(
    name = "hello-world",
    srcs = ["hello-world.cc"],
    deps = [
        ":hello-greet",
        "//lib:hello-time",
    ],
)
```

the `BUILD` in the `lib` package as the below

```ini
cc_library(
    name = "hello-time",
    srcs = ["hello-time.cc"],
    hdrs = ["hello-time.h"],
    visibility = ["//main:__pkg__"],
)
```

















