# Freeze Python



## Tool: cx_Freeze

Install the package.

```sh
python -m pip install cx_Freeze --upgrade
```

The following is the simple python script (`simple.py`) ready for freezing.

```python
print("Hello World!")
```

Now we create a script `setup.py` used for packaging the simple script.

```python
from cx_Freeze import setup, Executable

setup(name = "SIMPLE",
      version = "0.1",
      description = "",
      executables = [Executable("simple.py")])
```

We put the above two scripts together on the same folder. You can build the script by the following command.

```sh
python setup.py build
```

Or type the command to generate a `dist` resource.

```sh
cxfreeze simple.py
```

After you freeze the script, you can execute the script. For example,

```sh
# if you freeze the script by `build`
./build/exe.linux-x86_64-3.5/simple

# if you directly freeze the script by `cxfreeze`
./dist/simple
```

