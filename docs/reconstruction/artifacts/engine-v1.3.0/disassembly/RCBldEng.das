[Code]
    File Name: <frozen RCBldEng>
    Object Name: <module>
    Arg Count: 0
    Pos Only Arg Count: 0
    KW Only Arg Count: 0
    Locals: 0
    Stack Size: 8
    Flags: 0x20000040 (CO_NOFREE | CO_PYARMOR_OBFUSCATED)
    [Names]
        '__assert_armored__'
        'os'
        'lib'
        'sys'
        'simulation'
        'warnings'
        'time'
        'strtobool'
        'baseCEN'
        'main'
        '__name__'
        'filterwarnings'
        'dict'
        'argv'
        'kwargs'
    [Var Names]
    [Free Vars]
    [Cell Vars]
    [Constants]
        '__pyarmor_assert_47061__'
        '<lambda>'
        '__pyarmor_enter_47062__'
        b'<COAddr>\x03\x00\x00\x14\x94\x00\x00\x00\x00\x00\x00\x00'
        0
        None
        [Code]
            File Name: <frozen RCBldEng>
            Object Name: strtobool
            Arg Count: 1
            Pos Only Arg Count: 0
            KW Only Arg Count: 0
            Locals: 2
            Stack Size: 8
            Flags: 0x20000043 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NOFREE | CO_PYARMOR_OBFUSCATED)
            [Names]
                'lower'
                'ValueError'
            [Var Names]
                'val'
                '__assert_armored__'
            [Free Vars]
            [Cell Vars]
            [Constants]
                None
                '__pyarmor_assert_47064__'
                'strtobool.<locals>.<lambda>'
                '__pyarmor_enter_47065__'
                b'<COAddr>\x01\x00\x00\x14N\x00\x00\x00\x00\x00\x00\x00'
                (
                    'y'
                    'yes'
                    't'
                    'true'
                    'on'
                    '1'
                )
                '__pyarmor_exit_47066__'
                True
                (
                    'n'
                    'no'
                    'f'
                    'false'
                    'off'
                    '0'
                )
                False
                'invalid truth value %r'
            [Disassembly]
                0       NOP                             
                2       NOP                             
                4       NOP                             
                6       NOP                             
                8       LOAD_CONST                      3: '__pyarmor_enter_47065__'
                10      NOP                             
                12      NOP                             
                14      LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14N\x00\x00\x00\x00\x00\x00\x00'
                16      CALL_FUNCTION                   1
                18      POP_TOP                         
                20      SETUP_FINALLY                   90 (to 112)
                22      LOAD_FAST                       0: val
                24      LOAD_METHOD                     0: lower
                26      CALL_METHOD                     0
                28      STORE_FAST                      0: val
                30      LOAD_FAST                       0: val
                32      LOAD_CONST                      5: ('y', 'yes', 't', 'true', 'on', '1')
                34      CONTAINS_OP                     0 (in)
                36      POP_JUMP_IF_FALSE               56
                38      POP_BLOCK                       
                40      NOP                             
                42      NOP                             
                44      NOP                             
                46      NOP                             
                48      NOP                             
                50      NOP                             
                52      LOAD_CONST                      7: True
                54      RETURN_VALUE                    
                56      LOAD_FAST                       0: val
                58      LOAD_CONST                      8: ('n', 'no', 'f', 'false', 'off', '0')
                60      CONTAINS_OP                     0 (in)
                62      POP_JUMP_IF_FALSE               82
                64      POP_BLOCK                       
                66      NOP                             
                68      NOP                             
                70      NOP                             
                72      NOP                             
                74      NOP                             
                76      NOP                             
                78      LOAD_CONST                      9: False
                80      RETURN_VALUE                    
                82      LOAD_GLOBAL                     1: ValueError
                84      LOAD_CONST                      10: 'invalid truth value %r'
                86      LOAD_FAST                       0: val
                88      BUILD_TUPLE                     1
                90      BINARY_MODULO                   
                92      CALL_FUNCTION                   1
                94      RAISE_VARARGS                   1
                96      POP_BLOCK                       
                98      LOAD_CONST                      6: '__pyarmor_exit_47066__'
                100     NOP                             
                102     NOP                             
                104     LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14N\x00\x00\x00\x00\x00\x00\x00'
                106     CALL_FUNCTION                   1
                108     POP_TOP                         
                110     JUMP_FORWARD                    14 (to 126)
                112     LOAD_CONST                      6: '__pyarmor_exit_47066__'
                114     NOP                             
                116     NOP                             
                118     LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14N\x00\x00\x00\x00\x00\x00\x00'
                120     CALL_FUNCTION                   1
                122     POP_TOP                         
                124     RERAISE                         
                126     LOAD_CONST                      0: None
                128     RETURN_VALUE                    
        'strtobool'
        [Code]
            File Name: <frozen RCBldEng>
            Object Name: baseCEN
            Arg Count: 3
            Pos Only Arg Count: 0
            KW Only Arg Count: 0
            Locals: 19
            Stack Size: 11
            Flags: 0x2000004B (CO_OPTIMIZED | CO_NEWLOCALS | CO_VARKEYWORDS | CO_NOFREE | CO_PYARMOR_OBFUSCATED)
            [Names]
                'time'
                'os'
                'path'
                'abspath'
                'join'
                'getcwd'
                'pardir'
                'lib'
                'Read_Inputs'
                'getInputDict'
                'strtobool'
                'get'
                'simulation'
                'Simulation'
                'exists'
                'makedirs'
                'run'
                'dumpResults'
                'print'
            [Var Names]
                'building'
                'first_day'
                'runcode'
                'kwargs'
                '__assert_armored__'
                '_var_var_0'
                '_var_var_1'
                '_var_var_2'
                '_var_var_3'
                '_var_var_4'
                '_var_var_5'
                '_var_var_6'
                '_var_var_7'
                '_var_var_8'
                '_var_var_9'
                '_var_var_10'
                '_var_var_11'
                '_var_var_12'
                '_var_var_13'
            [Free Vars]
            [Cell Vars]
            [Constants]
                None
                '__pyarmor_assert_47067__'
                'baseCEN.<locals>.<lambda>'
                '__pyarmor_enter_47068__'
                b'<COAddr>\x01\x00\x00\x14,\x01\x00\x00\x00\x00\x00\x00'
                '\\'
                'Projects\\'
                '_'
                '.sim'
                'if_pmv'
                'False'
                'if_print'
                'True'
                'solver'
                'crank-nicholson'
                'infl_style'
                'constant'
                'DHW_style'
                'real'
                'weather_mode'
                'default'
                1
                (
                    'first_day'
                    'solver'
                    'order'
                    'if_pmv'
                    'DHW_style'
                    'infl_style'
                    'if_print'
                )
                'Simulation completed in '
                '.2f'
                ' seconds'
                '__pyarmor_exit_47069__'
            [Disassembly]
                0       NOP                             
                2       NOP                             
                4       NOP                             
                6       NOP                             
                8       LOAD_CONST                      3: '__pyarmor_enter_47068__'
                10      NOP                             
                12      NOP                             
                14      LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14,\x01\x00\x00\x00\x00\x00\x00'
                16      CALL_FUNCTION                   1
                18      POP_TOP                         
                20      SETUP_FINALLY                   310 (to 334)
                24      LOAD_GLOBAL                     0: time
                26      LOAD_METHOD                     0: time
                28      CALL_METHOD                     0
                30      STORE_FAST                      5: _var_var_0
                32      LOAD_GLOBAL                     1: os
                34      LOAD_ATTR                       2: path
                36      LOAD_METHOD                     3: abspath
                38      LOAD_GLOBAL                     1: os
                40      LOAD_ATTR                       2: path
                42      LOAD_METHOD                     4: join
                44      LOAD_GLOBAL                     1: os
                46      LOAD_METHOD                     5: getcwd
                48      CALL_METHOD                     0
                50      LOAD_GLOBAL                     1: os
                52      LOAD_ATTR                       6: pardir
                54      CALL_METHOD                     2
                56      CALL_METHOD                     1
                58      LOAD_CONST                      5: '\\'
                60      BINARY_ADD                      
                62      STORE_FAST                      6: _var_var_1
                64      LOAD_FAST                       6: _var_var_1
                66      LOAD_CONST                      6: 'Projects\\'
                68      BINARY_ADD                      
                70      LOAD_FAST                       0: building
                72      BINARY_ADD                      
                74      LOAD_CONST                      5: '\\'
                76      BINARY_ADD                      
                78      STORE_FAST                      7: _var_var_2
                80      LOAD_FAST                       7: _var_var_2
                82      LOAD_FAST                       2: runcode
                84      BINARY_ADD                      
                86      LOAD_CONST                      5: '\\'
                88      BINARY_ADD                      
                90      STORE_FAST                      8: _var_var_3
                92      LOAD_GLOBAL                     7: lib
                94      LOAD_METHOD                     8: Read_Inputs
                96      LOAD_FAST                       8: _var_var_3
                98      LOAD_FAST                       0: building
                100     BINARY_ADD                      
                102     LOAD_CONST                      7: '_'
                104     BINARY_ADD                      
                106     LOAD_FAST                       2: runcode
                108     BINARY_ADD                      
                110     LOAD_CONST                      8: '.sim'
                112     BINARY_ADD                      
                114     CALL_METHOD                     1
                116     STORE_FAST                      9: _var_var_4
                118     LOAD_FAST                       9: _var_var_4
                120     LOAD_METHOD                     9: getInputDict
                122     CALL_METHOD                     0
                124     STORE_FAST                      10: _var_var_5
                126     LOAD_GLOBAL                     10: strtobool
                128     LOAD_FAST                       3: kwargs
                130     LOAD_METHOD                     11: get
                132     LOAD_CONST                      9: 'if_pmv'
                134     LOAD_CONST                      10: 'False'
                136     CALL_METHOD                     2
                138     CALL_FUNCTION                   1
                140     STORE_FAST                      11: _var_var_6
                142     LOAD_GLOBAL                     10: strtobool
                144     LOAD_FAST                       3: kwargs
                146     LOAD_METHOD                     11: get
                148     LOAD_CONST                      11: 'if_print'
                150     LOAD_CONST                      12: 'True'
                152     CALL_METHOD                     2
                154     CALL_FUNCTION                   1
                156     STORE_FAST                      12: _var_var_7
                158     LOAD_FAST                       3: kwargs
                160     LOAD_METHOD                     11: get
                162     LOAD_CONST                      13: 'solver'
                164     LOAD_CONST                      14: 'crank-nicholson'
                166     CALL_METHOD                     2
                168     STORE_FAST                      13: _var_var_8
                170     LOAD_FAST                       3: kwargs
                172     LOAD_METHOD                     11: get
                174     LOAD_CONST                      15: 'infl_style'
                176     LOAD_CONST                      16: 'constant'
                178     CALL_METHOD                     2
                180     STORE_FAST                      14: _var_var_9
                182     LOAD_FAST                       3: kwargs
                184     LOAD_METHOD                     11: get
                186     LOAD_CONST                      17: 'DHW_style'
                188     LOAD_CONST                      18: 'real'
                190     CALL_METHOD                     2
                192     STORE_FAST                      15: _var_var_10
                194     LOAD_FAST                       3: kwargs
                196     LOAD_METHOD                     11: get
                198     LOAD_CONST                      19: 'weather_mode'
                200     LOAD_CONST                      20: 'default'
                202     CALL_METHOD                     2
                204     STORE_FAST                      16: _var_var_11
                206     LOAD_GLOBAL                     12: simulation
                208     LOAD_ATTR                       13: Simulation
                210     LOAD_FAST                       10: _var_var_5
                212     LOAD_FAST                       16: _var_var_11
                214     LOAD_FAST                       1: first_day
                216     LOAD_FAST                       13: _var_var_8
                218     LOAD_CONST                      21: 1
                220     LOAD_FAST                       11: _var_var_6
                222     LOAD_FAST                       15: _var_var_10
                224     LOAD_FAST                       14: _var_var_9
                226     LOAD_FAST                       12: _var_var_7
                228     LOAD_CONST                      22: ('first_day', 'solver', 'order', 'if_pmv', 'DHW_style', 'infl_style', 'if_print')
                230     CALL_FUNCTION_KW                9
                232     STORE_FAST                      17: _var_var_12
                234     LOAD_GLOBAL                     1: os
                236     LOAD_ATTR                       2: path
                238     LOAD_METHOD                     14: exists
                240     LOAD_FAST                       8: _var_var_3
                242     CALL_METHOD                     1
                244     POP_JUMP_IF_TRUE                258
                248     LOAD_GLOBAL                     1: os
                250     LOAD_METHOD                     15: makedirs
                252     LOAD_FAST                       8: _var_var_3
                254     CALL_METHOD                     1
                256     POP_TOP                         
                258     LOAD_FAST                       17: _var_var_12
                260     LOAD_METHOD                     16: run
                262     CALL_METHOD                     0
                264     POP_TOP                         
                266     LOAD_FAST                       17: _var_var_12
                268     LOAD_METHOD                     17: dumpResults
                270     LOAD_FAST                       8: _var_var_3
                272     LOAD_FAST                       0: building
                274     BINARY_ADD                      
                276     LOAD_CONST                      7: '_'
                278     BINARY_ADD                      
                280     LOAD_FAST                       2: runcode
                282     BINARY_ADD                      
                284     CALL_METHOD                     1
                286     POP_TOP                         
                288     LOAD_GLOBAL                     0: time
                290     LOAD_METHOD                     0: time
                292     CALL_METHOD                     0
                294     STORE_FAST                      18: _var_var_13
                296     LOAD_GLOBAL                     18: print
                298     LOAD_CONST                      23: 'Simulation completed in '
                300     LOAD_FAST                       18: _var_var_13
                302     LOAD_FAST                       5: _var_var_0
                304     BINARY_SUBTRACT                 
                306     LOAD_CONST                      24: '.2f'
                308     FORMAT_VALUE                    4 (FVC_NONE | FVS_HAVE_SPEC)
                310     LOAD_CONST                      25: ' seconds'
                312     BUILD_STRING                    3
                314     CALL_FUNCTION                   1
                316     POP_TOP                         
                318     POP_BLOCK                       
                320     LOAD_CONST                      26: '__pyarmor_exit_47069__'
                322     NOP                             
                324     NOP                             
                326     LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14,\x01\x00\x00\x00\x00\x00\x00'
                328     CALL_FUNCTION                   1
                330     POP_TOP                         
                332     JUMP_FORWARD                    14 (to 348)
                334     LOAD_CONST                      26: '__pyarmor_exit_47069__'
                336     NOP                             
                338     NOP                             
                340     LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14,\x01\x00\x00\x00\x00\x00\x00'
                342     CALL_FUNCTION                   1
                344     POP_TOP                         
                346     RERAISE                         
                348     LOAD_CONST                      0: None
                350     RETURN_VALUE                    
        'baseCEN'
        [Code]
            File Name: <frozen RCBldEng>
            Object Name: main
            Arg Count: 1
            Pos Only Arg Count: 0
            KW Only Arg Count: 0
            Locals: 3
            Stack Size: 8
            Flags: 0x2000004B (CO_OPTIMIZED | CO_NEWLOCALS | CO_VARKEYWORDS | CO_NOFREE | CO_PYARMOR_OBFUSCATED)
            [Names]
                'baseCEN'
            [Var Names]
                'argv'
                'kwargs'
                '__assert_armored__'
            [Free Vars]
            [Cell Vars]
            [Constants]
                None
                '__pyarmor_assert_47070__'
                'main.<locals>.<lambda>'
                '__pyarmor_enter_47071__'
                b'<COAddr>\x01\x00\x00\x14$\x00\x00\x00\x00\x00\x00\x00'
                1
                2
                4
                '__pyarmor_exit_47072__'
            [Disassembly]
                0       NOP                             
                2       NOP                             
                4       NOP                             
                6       NOP                             
                8       LOAD_CONST                      3: '__pyarmor_enter_47071__'
                10      NOP                             
                12      NOP                             
                14      LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14$\x00\x00\x00\x00\x00\x00\x00'
                16      CALL_FUNCTION                   1
                18      POP_TOP                         
                20      SETUP_FINALLY                   48 (to 70)
                22      LOAD_GLOBAL                     0: baseCEN
                24      LOAD_FAST                       0: argv
                26      LOAD_CONST                      5: 1
                28      BINARY_SUBSCR                   
                30      LOAD_FAST                       0: argv
                32      LOAD_CONST                      6: 2
                34      BINARY_SUBSCR                   
                36      LOAD_FAST                       0: argv
                38      LOAD_CONST                      7: 4
                40      BINARY_SUBSCR                   
                42      BUILD_TUPLE                     3
                44      BUILD_MAP                       0
                46      LOAD_FAST                       1: kwargs
                48      DICT_MERGE                      1
                50      CALL_FUNCTION_EX                1
                52      POP_TOP                         
                54      POP_BLOCK                       
                56      LOAD_CONST                      8: '__pyarmor_exit_47072__'
                58      NOP                             
                60      NOP                             
                62      LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14$\x00\x00\x00\x00\x00\x00\x00'
                64      CALL_FUNCTION                   1
                66      POP_TOP                         
                68      JUMP_FORWARD                    14 (to 84)
                70      LOAD_CONST                      8: '__pyarmor_exit_47072__'
                72      NOP                             
                74      NOP                             
                76      LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14$\x00\x00\x00\x00\x00\x00\x00'
                78      CALL_FUNCTION                   1
                80      POP_TOP                         
                82      RERAISE                         
                84      LOAD_CONST                      0: None
                86      RETURN_VALUE                    
        'main'
        '__main__'
        'ignore'
        [Code]
            File Name: <frozen RCBldEng>
            Object Name: <genexpr>
            Arg Count: 1
            Pos Only Arg Count: 0
            KW Only Arg Count: 0
            Locals: 2
            Stack Size: 5
            Flags: 0x00000063 (CO_OPTIMIZED | CO_NEWLOCALS | CO_GENERATOR | CO_NOFREE)
            [Names]
                'split'
            [Var Names]
                '.0'
                '_var_var_14'
            [Free Vars]
            [Cell Vars]
            [Constants]
                '='
                1
                None
            [Disassembly]
                0       LOAD_FAST                       0: .0
                2       FOR_ITER                        26 (to 30)
                4       STORE_FAST                      1: _var_var_14
                6       LOAD_CONST                      0: '='
                8       LOAD_FAST                       1: _var_var_14
                10      CONTAINS_OP                     0 (in)
                12      POP_JUMP_IF_FALSE               2
                14      LOAD_FAST                       1: _var_var_14
                16      LOAD_METHOD                     0: split
                18      LOAD_CONST                      0: '='
                20      LOAD_CONST                      1: 1
                22      CALL_METHOD                     2
                24      YIELD_VALUE                     
                26      POP_TOP                         
                28      JUMP_ABSOLUTE                   2
                30      LOAD_CONST                      2: None
                32      RETURN_VALUE                    
        '<genexpr>'
        5
        '__pyarmor_exit_47063__'
    [Disassembly]
        0       NOP                             
        2       NOP                             
        4       NOP                             
        6       NOP                             
        8       LOAD_CONST                      2: '__pyarmor_enter_47062__'
        10      NOP                             
        12      NOP                             
        14      LOAD_CONST                      3: b'<COAddr>\x03\x00\x00\x14\x94\x00\x00\x00\x00\x00\x00\x00'
        16      CALL_FUNCTION                   1
        18      POP_TOP                         
        20      SETUP_FINALLY                   160 (to 182)
        22      LOAD_CONST                      4: 0
        24      LOAD_CONST                      5: None
        26      IMPORT_NAME                     1: os
        28      STORE_NAME                      1: os
        30      LOAD_CONST                      4: 0
        32      LOAD_CONST                      5: None
        34      IMPORT_NAME                     2: lib
        36      STORE_NAME                      2: lib
        38      LOAD_CONST                      4: 0
        40      LOAD_CONST                      5: None
        42      IMPORT_NAME                     3: sys
        44      STORE_NAME                      3: sys
        46      LOAD_CONST                      4: 0
        48      LOAD_CONST                      5: None
        50      IMPORT_NAME                     4: simulation
        52      STORE_NAME                      4: simulation
        54      LOAD_CONST                      4: 0
        56      LOAD_CONST                      5: None
        58      IMPORT_NAME                     5: warnings
        60      STORE_NAME                      5: warnings
        62      LOAD_CONST                      4: 0
        64      LOAD_CONST                      5: None
        66      IMPORT_NAME                     6: time
        68      STORE_NAME                      6: time
        70      LOAD_CONST                      6: <CODE> strtobool
        72      LOAD_CONST                      7: 'strtobool'
        74      MAKE_FUNCTION                   0
        76      STORE_NAME                      7: strtobool
        78      LOAD_CONST                      8: <CODE> baseCEN
        80      LOAD_CONST                      9: 'baseCEN'
        82      MAKE_FUNCTION                   0
        84      STORE_NAME                      8: baseCEN
        86      LOAD_CONST                      10: <CODE> main
        88      LOAD_CONST                      11: 'main'
        90      MAKE_FUNCTION                   0
        92      STORE_NAME                      9: main
        94      LOAD_NAME                       10: __name__
        96      LOAD_CONST                      12: '__main__'
        98      COMPARE_OP                      2 (==)
        100     POP_JUMP_IF_FALSE               166
        102     LOAD_NAME                       5: warnings
        104     LOAD_METHOD                     11: filterwarnings
        106     LOAD_CONST                      13: 'ignore'
        108     CALL_METHOD                     1
        110     POP_TOP                         
        112     LOAD_NAME                       12: dict
        114     LOAD_CONST                      14: <CODE> <genexpr>
        116     LOAD_CONST                      15: '<genexpr>'
        118     MAKE_FUNCTION                   0
        120     LOAD_NAME                       3: sys
        122     LOAD_ATTR                       13: argv
        124     LOAD_CONST                      16: 5
        126     LOAD_CONST                      5: None
        128     BUILD_SLICE                     2
        130     BINARY_SUBSCR                   
        132     GET_ITER                        
        134     CALL_FUNCTION                   1
        136     CALL_FUNCTION                   1
        138     STORE_NAME                      14: kwargs
        140     LOAD_NAME                       9: main
        142     LOAD_NAME                       3: sys
        144     LOAD_ATTR                       13: argv
        146     LOAD_CONST                      5: None
        148     LOAD_CONST                      16: 5
        150     BUILD_SLICE                     2
        152     BINARY_SUBSCR                   
        154     BUILD_TUPLE                     1
        156     BUILD_MAP                       0
        158     LOAD_NAME                       14: kwargs
        160     DICT_MERGE                      1
        162     CALL_FUNCTION_EX                1
        164     POP_TOP                         
        166     POP_BLOCK                       
        168     LOAD_CONST                      17: '__pyarmor_exit_47063__'
        170     NOP                             
        172     NOP                             
        174     LOAD_CONST                      3: b'<COAddr>\x03\x00\x00\x14\x94\x00\x00\x00\x00\x00\x00\x00'
        176     CALL_FUNCTION                   1
        178     POP_TOP                         
        180     JUMP_FORWARD                    14 (to 196)
        182     LOAD_CONST                      17: '__pyarmor_exit_47063__'
        184     NOP                             
        186     NOP                             
        188     LOAD_CONST                      3: b'<COAddr>\x03\x00\x00\x14\x94\x00\x00\x00\x00\x00\x00\x00'
        190     CALL_FUNCTION                   1
        192     POP_TOP                         
        194     RERAISE                         
        196     LOAD_CONST                      5: None
        198     RETURN_VALUE                    
