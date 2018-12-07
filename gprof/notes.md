### Profiling with gprof on Linux

1. Need to enable "-pg" flag during compilation.
for cmake following needs to be added to the CMakeList file:

```
set (CMAKE_EXE_LINKER_FLAGS -pg)
set (CMAKE_C_FLAGS "pg")
```

2. Execute the code - it will produce gmon.out file which is later used for stats generation.

3. Run gprof - gmon.out file from 2. step needs to passed as a parameter
```
gprof test gmon.out > analysis.txt
```

To visualise the profiling results as a dot graph [gprof2dot](https://github.com/jrfonseca/gprof2dot):

"""
gprof test gmon.out | gprof2dot | dot -Tpng -o output.png
"""
