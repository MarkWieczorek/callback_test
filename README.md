This repo demonstrates how python can call a fortran routine, which itself calls a python routine. Everything works fine when only one fortran routine makes use of the python callback routine.

However, if there are two fortran functions that make use of the same routine, f2py can not compile the code, and complains that the callback function is being redefined.

Create the f2py bindings by
```
source compile
```

run the python script with
```
python script.py
```

The output should look like this:
```
In ROUTINE
capi_return is NULL
Call-back cb_pyfunc_in_routine__user__routines failed.
Traceback (most recent call last):
  File "script.py", line 4, in <module>
    callback_test.routine()
  File "script.py", line 2, in f
    def f(status): raise Exception(status)
Exception: 1
```
Next, remove the comments surrounding routine2 in signature.pyf, recompile. The error will look something like this:
```
/usr/local/lib/python3.5/site-packages/numpy/core/include/numpy/npy_1_7_deprecated_api.h:15:2: warning: "Using deprecated NumPy API, disable it by "          "#defining NPY_NO_DEPRECATED_API NPY_1_7_API_VERSION" [-W#warnings]
#warning "Using deprecated NumPy API, disable it by " \
 ^
/var/folders/9v/k2l3cpqs1wn56ktkr4l5zncr0000gn/T/tmpjopu3wm8/src.macosx-10.11-x86_64-3.5/callback_testmodule.c:327:13: error: redefinition of 'pyfunc_'
extern void F_FUNC(pyfunc,PYFUNC) (int *i_cb_capi) {
            ^
/var/folders/9v/k2l3cpqs1wn56ktkr4l5zncr0000gn/T/tmpjopu3wm8/src.macosx-10.11-x86_64-3.5/callback_testmodule.c:87:21: note: expanded from macro 'F_FUNC'
#define F_FUNC(f,F) f##_
                    ^
<scratch space>:122:1: note: expanded from here
pyfunc_
^
/var/folders/9v/k2l3cpqs1wn56ktkr4l5zncr0000gn/T/tmpjopu3wm8/src.macosx-10.11-x86_64-3.5/callback_testmodule.c:229:13: note: previous definition is here
extern void F_FUNC(pyfunc,PYFUNC) (int *i_cb_capi) {
            ^
/var/folders/9v/k2l3cpqs1wn56ktkr4l5zncr0000gn/T/tmpjopu3wm8/src.macosx-10.11-x86_64-3.5/callback_testmodule.c:87:21: note: expanded from macro 'F_FUNC'
#define F_FUNC(f,F) f##_
                    ^
<scratch space>:121:1: note: expanded from here
pyfunc_
^
1 warning and 1 error generated.
```
