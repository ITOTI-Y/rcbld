[Code]
    File Name: <frozen simulation>
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
        'collections'
        'copy'
        'comfort'
        'weather'
        'time'
        'numpy'
        'np'
        'lib'
        'pandas'
        'pd'
        'path'
        'abspath'
        'join'
        'getcwd'
        'pardir'
        'parent_folder'
        'print_progress_bar'
        'Simulation'
    [Var Names]
    [Free Vars]
    [Cell Vars]
    [Constants]
        '__pyarmor_assert_47073__'
        '<lambda>'
        '__pyarmor_enter_47074__'
        b'<COAddr>\x01\x00\x00\x14\x84\x00\x00\x00\x00\x00\x00\x00'
        0
        None
        '\\'
        'Progress:'
        'Complete'
        50
        [Code]
            File Name: <frozen simulation>
            Object Name: print_progress_bar
            Arg Count: 5
            Pos Only Arg Count: 0
            KW Only Arg Count: 0
            Locals: 13
            Stack Size: 10
            Flags: 0x20000043 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NOFREE | CO_PYARMOR_OBFUSCATED)
            [Names]
                'float'
                'int'
                'time'
                'print_progress_bar'
                'start_time'
                'print'
            [Var Names]
                'iteration'
                'total'
                'prefix'
                'suffix'
                'length'
                '__assert_armored__'
                '_var_var_0'
                '_var_var_1'
                '_var_var_2'
                '_var_var_3'
                '_var_var_4'
                '_var_var_5'
                '_var_var_6'
            [Free Vars]
            [Cell Vars]
            [Constants]
                '\n    Call in a loop to create terminal progress bar\n    '
                '__pyarmor_assert_47076__'
                'print_progress_bar.<locals>.<lambda>'
                '__pyarmor_enter_47077__'
                b'<COAddr>\x03\x00\x00\x14\xae\x00\x00\x00\x00\x00\x00\x00'
                100
                '█'
                '-'
                0
                ' | Time remaining: '
                '.1f'
                's'
                ''
                '\r'
                ' |'
                '| '
                '% '
                (
                    'end'
                )
                '__pyarmor_exit_47078__'
                None
            [Disassembly]
                0       NOP                             
                2       NOP                             
                4       NOP                             
                6       NOP                             
                8       LOAD_CONST                      3: '__pyarmor_enter_47077__'
                10      NOP                             
                12      NOP                             
                14      LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x14\xae\x00\x00\x00\x00\x00\x00\x00'
                16      CALL_FUNCTION                   1
                18      POP_TOP                         
                20      SETUP_FINALLY                   186 (to 208)
                22      LOAD_CONST                      5: 100
                24      LOAD_FAST                       0: iteration
                26      LOAD_GLOBAL                     0: float
                28      LOAD_FAST                       1: total
                30      CALL_FUNCTION                   1
                32      BINARY_TRUE_DIVIDE              
                34      BINARY_MULTIPLY                 
                36      STORE_FAST                      6: _var_var_0
                38      LOAD_GLOBAL                     1: int
                40      LOAD_FAST                       4: length
                42      LOAD_FAST                       0: iteration
                44      BINARY_MULTIPLY                 
                46      LOAD_FAST                       1: total
                48      BINARY_FLOOR_DIVIDE             
                50      CALL_FUNCTION                   1
                52      STORE_FAST                      7: _var_var_1
                54      LOAD_CONST                      6: '█'
                56      LOAD_FAST                       7: _var_var_1
                58      BINARY_MULTIPLY                 
                60      LOAD_CONST                      7: '-'
                62      LOAD_FAST                       4: length
                64      LOAD_FAST                       7: _var_var_1
                66      BINARY_SUBTRACT                 
                68      BINARY_MULTIPLY                 
                70      BINARY_ADD                      
                72      STORE_FAST                      8: _var_var_2
                74      LOAD_GLOBAL                     2: time
                76      LOAD_METHOD                     2: time
                78      CALL_METHOD                     0
                80      LOAD_GLOBAL                     3: print_progress_bar
                82      LOAD_ATTR                       4: start_time
                84      BINARY_SUBTRACT                 
                86      STORE_FAST                      9: _var_var_3
                88      LOAD_FAST                       0: iteration
                90      LOAD_CONST                      8: 0
                92      COMPARE_OP                      4 (>)
                94      POP_JUMP_IF_FALSE               132
                96      LOAD_FAST                       9: _var_var_3
                98      LOAD_FAST                       1: total
                100     BINARY_MULTIPLY                 
                102     LOAD_FAST                       0: iteration
                104     BINARY_TRUE_DIVIDE              
                106     STORE_FAST                      10: _var_var_4
                108     LOAD_FAST                       10: _var_var_4
                110     LOAD_FAST                       9: _var_var_3
                112     BINARY_SUBTRACT                 
                114     STORE_FAST                      11: _var_var_5
                116     LOAD_CONST                      9: ' | Time remaining: '
                118     LOAD_FAST                       11: _var_var_5
                120     LOAD_CONST                      10: '.1f'
                122     FORMAT_VALUE                    4 (FVC_NONE | FVS_HAVE_SPEC)
                124     LOAD_CONST                      11: 's'
                126     BUILD_STRING                    3
                128     STORE_FAST                      12: _var_var_6
                130     JUMP_FORWARD                    4 (to 136)
                132     LOAD_CONST                      12: ''
                134     STORE_FAST                      12: _var_var_6
                136     LOAD_GLOBAL                     5: print
                138     LOAD_CONST                      13: '\r'
                140     LOAD_FAST                       2: prefix
                142     FORMAT_VALUE                    0 (FVC_NONE)
                144     LOAD_CONST                      14: ' |'
                146     LOAD_FAST                       8: _var_var_2
                148     FORMAT_VALUE                    0 (FVC_NONE)
                150     LOAD_CONST                      15: '| '
                152     LOAD_FAST                       6: _var_var_0
                154     LOAD_CONST                      10: '.1f'
                156     FORMAT_VALUE                    4 (FVC_NONE | FVS_HAVE_SPEC)
                158     LOAD_CONST                      16: '% '
                160     LOAD_FAST                       3: suffix
                162     FORMAT_VALUE                    0 (FVC_NONE)
                164     LOAD_FAST                       12: _var_var_6
                166     FORMAT_VALUE                    0 (FVC_NONE)
                168     BUILD_STRING                    9
                170     LOAD_CONST                      12: ''
                172     LOAD_CONST                      17: ('end',)
                174     CALL_FUNCTION_KW                2
                176     POP_TOP                         
                178     LOAD_FAST                       0: iteration
                180     LOAD_FAST                       1: total
                182     COMPARE_OP                      2 (==)
                184     POP_JUMP_IF_FALSE               192
                186     LOAD_GLOBAL                     5: print
                188     CALL_FUNCTION                   0
                190     POP_TOP                         
                192     POP_BLOCK                       
                194     LOAD_CONST                      18: '__pyarmor_exit_47078__'
                196     NOP                             
                198     NOP                             
                200     LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x14\xae\x00\x00\x00\x00\x00\x00\x00'
                202     CALL_FUNCTION                   1
                204     POP_TOP                         
                206     JUMP_FORWARD                    14 (to 222)
                208     LOAD_CONST                      18: '__pyarmor_exit_47078__'
                210     NOP                             
                212     NOP                             
                214     LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x14\xae\x00\x00\x00\x00\x00\x00\x00'
                216     CALL_FUNCTION                   1
                218     POP_TOP                         
                220     RERAISE                         
                222     LOAD_CONST                      19: None
                224     RETURN_VALUE                    
        'print_progress_bar'
        [Code]
            File Name: <frozen simulation>
            Object Name: Simulation
            Arg Count: 0
            Pos Only Arg Count: 0
            KW Only Arg Count: 0
            Locals: 0
            Stack Size: 8
            Flags: 0x20000040 (CO_NOFREE | CO_PYARMOR_OBFUSCATED)
            [Names]
                '__name__'
                '__module__'
                '__qualname__'
                '__assert_armored__'
                '__init__'
                'getInputClass'
                'solarGain'
                'otherHeatGain'
                'beforeIterate'
                'initiate'
                'iterate'
                'hourlyAggregate'
                'energy'
                'renewables'
                'aggregate'
                'comfAnalysis'
                'postProcess'
                'dumpResults'
                'run'
            [Var Names]
            [Free Vars]
            [Cell Vars]
            [Constants]
                'Simulation'
                '__pyarmor_assert_47079__'
                'Simulation.<lambda>'
                '__pyarmor_enter_47080__'
                b'<COAddr>\x01\x00\x00\x1c|\x00\x00\x00\x00\x00\x00\x00'
                [Code]
                    File Name: <frozen simulation>
                    Object Name: __init__
                    Arg Count: 3
                    Pos Only Arg Count: 0
                    KW Only Arg Count: 0
                    Locals: 7
                    Stack Size: 8
                    Flags: 0x2000004B (CO_OPTIMIZED | CO_NEWLOCALS | CO_VARKEYWORDS | CO_NOFREE | CO_PYARMOR_OBFUSCATED)
                    [Names]
                        'list'
                        'items'
                        'setattr'
                        'replace'
                        'input_dict'
                        'weather'
                        'Weather'
                        'W'
                        'getWeaDict'
                        'wea_dict'
                        'getInputClass'
                    [Var Names]
                        'self'
                        'input_dict'
                        'wea_file'
                        'kwargs'
                        '__assert_armored__'
                        '_var_var_7'
                        '_var_var_8'
                    [Free Vars]
                    [Cell Vars]
                    [Constants]
                        None
                        '__pyarmor_assert_47082__'
                        'Simulation.__init__.<locals>.<lambda>'
                        '__pyarmor_enter_47083__'
                        b'<COAddr>\x01\x00\x00\x14|\x00\x00\x00\x00\x00\x00\x00'
                        ' '
                        '_'
                        'default'
                        'Basics'
                        'Weather File'
                        '__pyarmor_exit_47084__'
                    [Disassembly]
                        0       NOP                             
                        2       NOP                             
                        4       NOP                             
                        6       NOP                             
                        8       LOAD_CONST                      3: '__pyarmor_enter_47083__'
                        10      NOP                             
                        12      NOP                             
                        14      LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14|\x00\x00\x00\x00\x00\x00\x00'
                        16      CALL_FUNCTION                   1
                        18      POP_TOP                         
                        20      SETUP_FINALLY                   136 (to 158)
                        22      LOAD_FAST                       3: kwargs
                        24      LOAD_CONST                      0: None
                        26      IS_OP                           1 (is not)
                        28      POP_JUMP_IF_FALSE               72
                        30      LOAD_GLOBAL                     0: list
                        32      LOAD_FAST                       3: kwargs
                        34      LOAD_METHOD                     1: items
                        36      CALL_METHOD                     0
                        38      CALL_FUNCTION                   1
                        40      GET_ITER                        
                        42      FOR_ITER                        28 (to 72)
                        44      UNPACK_SEQUENCE                 2
                        46      STORE_FAST                      5: _var_var_7
                        48      STORE_FAST                      6: _var_var_8
                        50      LOAD_GLOBAL                     2: setattr
                        52      LOAD_FAST                       0: self
                        54      LOAD_FAST                       5: _var_var_7
                        56      LOAD_METHOD                     3: replace
                        58      LOAD_CONST                      5: ' '
                        60      LOAD_CONST                      6: '_'
                        62      CALL_METHOD                     2
                        64      LOAD_FAST                       6: _var_var_8
                        66      CALL_FUNCTION                   3
                        68      POP_TOP                         
                        70      JUMP_ABSOLUTE                   42
                        72      LOAD_FAST                       1: input_dict
                        74      LOAD_FAST                       0: self
                        76      STORE_ATTR                      4: input_dict
                        78      LOAD_FAST                       2: wea_file
                        80      LOAD_CONST                      7: 'default'
                        82      COMPARE_OP                      2 (==)
                        84      POP_JUMP_IF_FALSE               110
                        86      LOAD_GLOBAL                     5: weather
                        88      LOAD_METHOD                     6: Weather
                        90      LOAD_FAST                       0: self
                        92      LOAD_ATTR                       4: input_dict
                        94      LOAD_CONST                      8: 'Basics'
                        96      BINARY_SUBSCR                   
                        98      LOAD_CONST                      9: 'Weather File'
                        100     BINARY_SUBSCR                   
                        102     CALL_METHOD                     1
                        104     LOAD_FAST                       0: self
                        106     STORE_ATTR                      7: W
                        108     JUMP_FORWARD                    12 (to 122)
                        110     LOAD_GLOBAL                     5: weather
                        112     LOAD_METHOD                     6: Weather
                        114     LOAD_FAST                       2: wea_file
                        116     CALL_METHOD                     1
                        118     LOAD_FAST                       0: self
                        120     STORE_ATTR                      7: W
                        122     LOAD_FAST                       0: self
                        124     LOAD_ATTR                       7: W
                        126     LOAD_METHOD                     8: getWeaDict
                        128     CALL_METHOD                     0
                        130     LOAD_FAST                       0: self
                        132     STORE_ATTR                      9: wea_dict
                        134     LOAD_FAST                       0: self
                        136     LOAD_METHOD                     10: getInputClass
                        138     CALL_METHOD                     0
                        140     POP_TOP                         
                        142     POP_BLOCK                       
                        144     LOAD_CONST                      10: '__pyarmor_exit_47084__'
                        146     NOP                             
                        148     NOP                             
                        150     LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14|\x00\x00\x00\x00\x00\x00\x00'
                        152     CALL_FUNCTION                   1
                        154     POP_TOP                         
                        156     JUMP_FORWARD                    14 (to 172)
                        158     LOAD_CONST                      10: '__pyarmor_exit_47084__'
                        160     NOP                             
                        162     NOP                             
                        164     LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14|\x00\x00\x00\x00\x00\x00\x00'
                        166     CALL_FUNCTION                   1
                        168     POP_TOP                         
                        170     RERAISE                         
                        172     LOAD_CONST                      0: None
                        174     RETURN_VALUE                    
                'Simulation.__init__'
                [Code]
                    File Name: <frozen simulation>
                    Object Name: getInputClass
                    Arg Count: 1
                    Pos Only Arg Count: 0
                    KW Only Arg Count: 0
                    Locals: 4
                    Stack Size: 21
                    Flags: 0x20000043 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NOFREE | CO_PYARMOR_OBFUSCATED)
                    [Names]
                        'hasattr'
                        'if_print'
                        'print'
                        'lib'
                        'Pre_Calculation'
                        'wea_dict'
                        'input_dict'
                        'first_day'
                        'order'
                        'solver'
                        'if_pmv'
                        'getDict'
                        'pre_dict'
                        'SubSystem'
                        'PV'
                        'General'
                        'DHW'
                        'Pumps'
                        'BEM'
                        'Wind_Turbines'
                        'At'
                        'Am'
                        'T_er'
                        'Te'
                        'ws'
                        'rh'
                        'np'
                        'where'
                        'rse'
                        'building_type'
                        'P_shading_threshold'
                        'Cm'
                        'Ct'
                    [Var Names]
                        'self'
                        '__assert_armored__'
                        '_var_var_9'
                        '_var_var_10'
                    [Free Vars]
                    [Cell Vars]
                    [Constants]
                        None
                        '__pyarmor_assert_47085__'
                        'Simulation.getInputClass.<locals>.<lambda>'
                        '__pyarmor_enter_47086__'
                        b'<COAddr>\x01\x00\x00\x14\xe4\x01\x00\x00\x00\x00\x00\x00'
                        'if_print'
                        True
                        'Reading model parameters from the input file...'
                        'first_day'
                        'sun'
                        'order'
                        1
                        'crank-nicholson'
                        'if_pmv'
                        'PV'
                        'General'
                        'DHW'
                        'Pumps'
                        'BEM'
                        'Wind_Turbines'
                        'T_er'
                        'DBT'
                        'wind'
                        'RH'
                        1.5
                        0.08
                        2.5
                        0.06
                        3.5
                        0.05
                        6
                        0.04
                        8.5
                        0.03
                        0.02
                        26
                        23
                        2
                        3600
                        0.35
                        '__pyarmor_exit_47087__'
                    [Disassembly]
                        0       NOP                             
                        2       NOP                             
                        4       NOP                             
                        6       NOP                             
                        8       LOAD_CONST                      3: '__pyarmor_enter_47086__'
                        10      NOP                             
                        12      NOP                             
                        14      LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14\xe4\x01\x00\x00\x00\x00\x00\x00'
                        16      CALL_FUNCTION                   1
                        18      POP_TOP                         
                        20      SETUP_FINALLY                   494 (to 518)
                        24      LOAD_GLOBAL                     0: hasattr
                        26      LOAD_FAST                       0: self
                        28      LOAD_CONST                      5: 'if_print'
                        30      CALL_FUNCTION                   2
                        32      POP_JUMP_IF_FALSE               52
                        34      LOAD_FAST                       0: self
                        36      LOAD_ATTR                       1: if_print
                        38      LOAD_CONST                      6: True
                        40      COMPARE_OP                      2 (==)
                        42      POP_JUMP_IF_FALSE               52
                        44      LOAD_GLOBAL                     2: print
                        46      LOAD_CONST                      7: 'Reading model parameters from the input file...'
                        48      CALL_FUNCTION                   1
                        50      POP_TOP                         
                        52      LOAD_GLOBAL                     0: hasattr
                        54      LOAD_FAST                       0: self
                        56      LOAD_CONST                      8: 'first_day'
                        58      CALL_FUNCTION                   2
                        60      POP_JUMP_IF_FALSE               84
                        62      LOAD_GLOBAL                     3: lib
                        64      LOAD_METHOD                     4: Pre_Calculation
                        66      LOAD_FAST                       0: self
                        68      LOAD_ATTR                       5: wea_dict
                        70      LOAD_FAST                       0: self
                        72      LOAD_ATTR                       6: input_dict
                        74      LOAD_FAST                       0: self
                        76      LOAD_ATTR                       7: first_day
                        78      CALL_METHOD                     3
                        80      STORE_FAST                      2: _var_var_9
                        82      JUMP_FORWARD                    18 (to 102)
                        84      LOAD_GLOBAL                     3: lib
                        86      LOAD_METHOD                     4: Pre_Calculation
                        88      LOAD_FAST                       0: self
                        90      LOAD_ATTR                       5: wea_dict
                        92      LOAD_FAST                       0: self
                        94      LOAD_ATTR                       6: input_dict
                        96      LOAD_CONST                      9: 'sun'
                        98      CALL_METHOD                     3
                        100     STORE_FAST                      2: _var_var_9
                        102     LOAD_GLOBAL                     0: hasattr
                        104     LOAD_FAST                       0: self
                        106     LOAD_CONST                      10: 'order'
                        108     CALL_FUNCTION                   2
                        110     POP_JUMP_IF_TRUE                124
                        112     LOAD_CONST                      11: 1
                        114     LOAD_FAST                       0: self
                        116     STORE_ATTR                      8: order
                        118     LOAD_CONST                      12: 'crank-nicholson'
                        120     LOAD_FAST                       0: self
                        122     STORE_ATTR                      9: solver
                        124     LOAD_GLOBAL                     0: hasattr
                        126     LOAD_FAST                       0: self
                        128     LOAD_CONST                      13: 'if_pmv'
                        130     CALL_FUNCTION                   2
                        132     POP_JUMP_IF_TRUE                140
                        134     LOAD_CONST                      6: True
                        136     LOAD_FAST                       0: self
                        138     STORE_ATTR                      10: if_pmv
                        140     LOAD_FAST                       2: _var_var_9
                        142     LOAD_METHOD                     11: getDict
                        144     CALL_METHOD                     0
                        146     STORE_FAST                      3: _var_var_10
                        148     LOAD_FAST                       3: _var_var_10
                        150     LOAD_FAST                       0: self
                        152     STORE_ATTR                      12: pre_dict
                        154     LOAD_GLOBAL                     3: lib
                        156     LOAD_METHOD                     13: SubSystem
                        158     LOAD_FAST                       3: _var_var_10
                        160     LOAD_CONST                      14: 'PV'
                        162     BINARY_SUBSCR                   
                        164     CALL_METHOD                     1
                        166     LOAD_FAST                       0: self
                        168     STORE_ATTR                      14: PV
                        170     LOAD_GLOBAL                     3: lib
                        172     LOAD_METHOD                     13: SubSystem
                        174     LOAD_FAST                       3: _var_var_10
                        176     LOAD_CONST                      15: 'General'
                        178     BINARY_SUBSCR                   
                        180     CALL_METHOD                     1
                        182     LOAD_FAST                       0: self
                        184     STORE_ATTR                      15: General
                        186     LOAD_GLOBAL                     3: lib
                        188     LOAD_METHOD                     13: SubSystem
                        190     LOAD_FAST                       3: _var_var_10
                        192     LOAD_CONST                      16: 'DHW'
                        194     BINARY_SUBSCR                   
                        196     CALL_METHOD                     1
                        198     LOAD_FAST                       0: self
                        200     STORE_ATTR                      16: DHW
                        202     LOAD_GLOBAL                     3: lib
                        204     LOAD_METHOD                     13: SubSystem
                        206     LOAD_FAST                       3: _var_var_10
                        208     LOAD_CONST                      17: 'Pumps'
                        210     BINARY_SUBSCR                   
                        212     CALL_METHOD                     1
                        214     LOAD_FAST                       0: self
                        216     STORE_ATTR                      17: Pumps
                        218     LOAD_GLOBAL                     3: lib
                        220     LOAD_METHOD                     13: SubSystem
                        222     LOAD_FAST                       3: _var_var_10
                        224     LOAD_CONST                      18: 'BEM'
                        226     BINARY_SUBSCR                   
                        228     CALL_METHOD                     1
                        230     LOAD_FAST                       0: self
                        232     STORE_ATTR                      18: BEM
                        234     LOAD_GLOBAL                     3: lib
                        236     LOAD_METHOD                     13: SubSystem
                        238     LOAD_FAST                       3: _var_var_10
                        240     LOAD_CONST                      19: 'Wind_Turbines'
                        242     BINARY_SUBSCR                   
                        244     CALL_METHOD                     1
                        246     LOAD_FAST                       0: self
                        248     STORE_ATTR                      19: Wind_Turbines
                        250     LOAD_FAST                       0: self
                        252     LOAD_ATTR                       15: General
                        254     LOAD_ATTR                       20: At
                        256     LOAD_FAST                       0: self
                        258     STORE_ATTR                      20: At
                        260     LOAD_FAST                       0: self
                        262     LOAD_ATTR                       15: General
                        264     LOAD_ATTR                       21: Am
                        266     LOAD_FAST                       0: self
                        268     STORE_ATTR                      21: Am
                        270     LOAD_FAST                       0: self
                        272     LOAD_ATTR                       5: wea_dict
                        274     LOAD_CONST                      20: 'T_er'
                        276     BINARY_SUBSCR                   
                        278     LOAD_FAST                       0: self
                        280     STORE_ATTR                      22: T_er
                        282     LOAD_FAST                       0: self
                        284     LOAD_ATTR                       5: wea_dict
                        286     LOAD_CONST                      21: 'DBT'
                        288     BINARY_SUBSCR                   
                        290     LOAD_FAST                       0: self
                        292     STORE_ATTR                      23: Te
                        294     LOAD_FAST                       0: self
                        296     LOAD_ATTR                       5: wea_dict
                        298     LOAD_CONST                      22: 'wind'
                        300     BINARY_SUBSCR                   
                        302     LOAD_FAST                       0: self
                        304     STORE_ATTR                      24: ws
                        306     LOAD_FAST                       0: self
                        308     LOAD_ATTR                       5: wea_dict
                        310     LOAD_CONST                      23: 'RH'
                        312     BINARY_SUBSCR                   
                        314     LOAD_FAST                       0: self
                        316     STORE_ATTR                      25: rh
                        318     LOAD_GLOBAL                     26: np
                        320     LOAD_METHOD                     27: where
                        322     LOAD_FAST                       0: self
                        324     LOAD_ATTR                       24: ws
                        326     LOAD_CONST                      24: 1.5
                        328     COMPARE_OP                      1 (<=)
                        330     LOAD_CONST                      25: 0.08
                        332     LOAD_GLOBAL                     26: np
                        334     LOAD_METHOD                     27: where
                        336     LOAD_FAST                       0: self
                        338     LOAD_ATTR                       24: ws
                        340     LOAD_CONST                      26: 2.5
                        342     COMPARE_OP                      1 (<=)
                        344     LOAD_CONST                      27: 0.06
                        346     LOAD_GLOBAL                     26: np
                        348     LOAD_METHOD                     27: where
                        350     LOAD_FAST                       0: self
                        352     LOAD_ATTR                       24: ws
                        354     LOAD_CONST                      28: 3.5
                        356     COMPARE_OP                      1 (<=)
                        358     LOAD_CONST                      29: 0.05
                        360     LOAD_GLOBAL                     26: np
                        362     LOAD_METHOD                     27: where
                        364     LOAD_FAST                       0: self
                        366     LOAD_ATTR                       24: ws
                        368     LOAD_CONST                      30: 6
                        370     COMPARE_OP                      1 (<=)
                        372     LOAD_CONST                      31: 0.04
                        374     LOAD_GLOBAL                     26: np
                        376     LOAD_METHOD                     27: where
                        378     LOAD_FAST                       0: self
                        380     LOAD_ATTR                       24: ws
                        382     LOAD_CONST                      32: 8.5
                        384     COMPARE_OP                      1 (<=)
                        386     LOAD_CONST                      33: 0.03
                        388     LOAD_CONST                      34: 0.02
                        390     CALL_METHOD                     3
                        392     CALL_METHOD                     3
                        394     CALL_METHOD                     3
                        396     CALL_METHOD                     3
                        398     CALL_METHOD                     3
                        400     LOAD_FAST                       0: self
                        402     STORE_ATTR                      28: rse
                        404     LOAD_FAST                       0: self
                        406     LOAD_ATTR                       15: General
                        408     LOAD_ATTR                       29: building_type
                        410     LOAD_CONST                      11: 1
                        412     COMPARE_OP                      2 (==)
                        414     POP_JUMP_IF_FALSE               422
                        418     LOAD_CONST                      35: 26
                        420     JUMP_FORWARD                    2 (to 424)
                        422     LOAD_CONST                      36: 23
                        424     LOAD_FAST                       0: self
                        426     STORE_ATTR                      30: P_shading_threshold
                        428     LOAD_FAST                       0: self
                        430     LOAD_ATTR                       8: order
                        432     LOAD_CONST                      37: 2
                        434     COMPARE_OP                      2 (==)
                        436     POP_JUMP_IF_FALSE               474
                        440     LOAD_FAST                       0: self
                        442     LOAD_ATTR                       15: General
                        444     LOAD_ATTR                       31: Cm
                        446     LOAD_CONST                      38: 3600
                        448     BINARY_TRUE_DIVIDE              
                        450     LOAD_FAST                       0: self
                        452     STORE_ATTR                      31: Cm
                        454     LOAD_CONST                      39: 0.35
                        456     LOAD_FAST                       0: self
                        458     LOAD_ATTR                       15: General
                        460     LOAD_ATTR                       31: Cm
                        462     BINARY_MULTIPLY                 
                        464     LOAD_CONST                      38: 3600
                        466     BINARY_TRUE_DIVIDE              
                        468     LOAD_FAST                       0: self
                        470     STORE_ATTR                      32: Ct
                        472     JUMP_FORWARD                    26 (to 500)
                        474     LOAD_FAST                       0: self
                        476     LOAD_ATTR                       8: order
                        478     LOAD_CONST                      11: 1
                        480     COMPARE_OP                      2 (==)
                        482     POP_JUMP_IF_FALSE               500
                        486     LOAD_FAST                       0: self
                        488     LOAD_ATTR                       15: General
                        490     LOAD_ATTR                       31: Cm
                        492     LOAD_CONST                      38: 3600
                        494     BINARY_TRUE_DIVIDE              
                        496     LOAD_FAST                       0: self
                        498     STORE_ATTR                      31: Cm
                        500     LOAD_FAST                       3: _var_var_10
                        502     POP_BLOCK                       
                        504     LOAD_CONST                      40: '__pyarmor_exit_47087__'
                        506     NOP                             
                        508     NOP                             
                        510     LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14\xe4\x01\x00\x00\x00\x00\x00\x00'
                        512     CALL_FUNCTION                   1
                        514     POP_TOP                         
                        516     RETURN_VALUE                    
                        518     LOAD_CONST                      40: '__pyarmor_exit_47087__'
                        520     NOP                             
                        522     NOP                             
                        524     LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14\xe4\x01\x00\x00\x00\x00\x00\x00'
                        526     CALL_FUNCTION                   1
                        528     POP_TOP                         
                        530     RERAISE                         
                        532     LOAD_CONST                      0: None
                        534     RETURN_VALUE                    
                'Simulation.getInputClass'
                [Code]
                    File Name: <frozen simulation>
                    Object Name: solarGain
                    Arg Count: 1
                    Pos Only Arg Count: 0
                    KW Only Arg Count: 0
                    Locals: 10
                    Stack Size: 12
                    Flags: 0x20000003 (CO_OPTIMIZED | CO_NEWLOCALS | CO_PYARMOR_OBFUSCATED)
                    [Names]
                        'hasattr'
                        'if_print'
                        'print'
                        'next'
                        'iter'
                        'pre_dict'
                        'items'
                        'W'
                        'getCalDict'
                        'SCal_dict'
                        'list'
                        'qi_env_dict_w'
                        'qi_env_dict_op'
                        'Envelopes'
                        '__dict__'
                        'np'
                        'array'
                        'values'
                        'shape'
                        'rse'
                        'Te'
                        'T_er'
                        'transpose'
                        'count_nonzero'
                        'sum'
                        'Af'
                        'q_sol_op'
                        'q_sol_w_rfl'
                        'where'
                        'P_shading_threshold'
                        'q_sol_w'
                        'q_sol'
                        'Solar'
                        'AreaFrac'
                    [Var Names]
                        'self'
                        '__assert_armored__'
                        '_var_var_12'
                        '_var_var_13'
                        '_var_var_14'
                        '_var_var_15'
                        '_var_var_16'
                        '_var_var_17'
                        '_var_var_18'
                        '_var_var_19'
                    [Free Vars]
                    [Cell Vars]
                        '_var_var_11'
                    [Constants]
                        None
                        '__pyarmor_assert_47088__'
                        'Simulation.solarGain.<locals>.<lambda>'
                        '__pyarmor_enter_47089__'
                        b'<COAddr>\x01\x00\x00\x14R\t\x00\x00\x00\x00\x00\x00'
                        'if_print'
                        True
                        'Calculating solar heat gain by default simplified solar radiation calculation method...'
                        'Zones'
                        'Solar'
                        False
                        'no extra solar'
                        1
                        12
                        'gain'
                        'reflection'
                        'shading_SRF'
                        'G'
                        0
                        'R'
                        'overhang'
                        2
                        'fin'
                        3
                        'horizon'
                        4
                        'surf'
                        'GSR'
                        -5
                        -1
                        5
                        6
                        -4
                        [Code]
                            File Name: <frozen simulation>
                            Object Name: <listcomp>
                            Arg Count: 1
                            Pos Only Arg Count: 0
                            KW Only Arg Count: 0
                            Locals: 3
                            Stack Size: 8
                            Flags: 0x00000013 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NESTED)
                            [Names]
                                'np'
                                'array'
                                'list'
                                'Envelopes'
                                '__dict__'
                                'values'
                                'shape'
                                'sum'
                            [Var Names]
                                '.0'
                                '_var_var_13'
                                '_var_var_20'
                            [Free Vars]
                                'zone'
                            [Cell Vars]
                            [Constants]
                                1
                                5
                                0
                                (
                                    'axis'
                                )
                            [Disassembly]
                                0       BUILD_LIST                      0
                                2       LOAD_FAST                       0: .0
                                4       FOR_ITER                        72 (to 78)
                                6       UNPACK_SEQUENCE                 2
                                8       STORE_FAST                      1: _var_var_13
                                10      STORE_FAST                      2: _var_var_20
                                12      LOAD_GLOBAL                     0: np
                                14      LOAD_METHOD                     1: array
                                16      LOAD_GLOBAL                     2: list
                                18      LOAD_DEREF                      0: zone
                                20      LOAD_ATTR                       3: Envelopes
                                22      LOAD_ATTR                       4: __dict__
                                24      LOAD_FAST                       1: _var_var_13
                                26      BINARY_SUBSCR                   
                                28      LOAD_METHOD                     5: values
                                30      CALL_METHOD                     0
                                32      CALL_FUNCTION                   1
                                34      CALL_METHOD                     1
                                36      LOAD_ATTR                       6: shape
                                38      LOAD_CONST                      0: 1
                                40      BINARY_SUBSCR                   
                                42      LOAD_CONST                      1: 5
                                44      COMPARE_OP                      2 (==)
                                46      POP_JUMP_IF_FALSE               4
                                48      LOAD_GLOBAL                     0: np
                                50      LOAD_ATTR                       7: sum
                                52      LOAD_GLOBAL                     0: np
                                54      LOAD_METHOD                     1: array
                                56      LOAD_GLOBAL                     2: list
                                58      LOAD_FAST                       2: _var_var_20
                                60      LOAD_METHOD                     5: values
                                62      CALL_METHOD                     0
                                64      CALL_FUNCTION                   1
                                66      CALL_METHOD                     1
                                68      LOAD_CONST                      2: 0
                                70      LOAD_CONST                      3: ('axis',)
                                72      CALL_FUNCTION_KW                2
                                74      LIST_APPEND                     2
                                76      JUMP_ABSOLUTE                   4
                                78      RETURN_VALUE                    
                        'Simulation.solarGain.<locals>.<listcomp>'
                        (
                            'axis'
                        )
                        [Code]
                            File Name: <frozen simulation>
                            Object Name: <listcomp>
                            Arg Count: 1
                            Pos Only Arg Count: 0
                            KW Only Arg Count: 0
                            Locals: 3
                            Stack Size: 8
                            Flags: 0x00000013 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NESTED)
                            [Names]
                                'np'
                                'array'
                                'list'
                                'Envelopes'
                                '__dict__'
                                'values'
                                'shape'
                                'sum'
                            [Var Names]
                                '.0'
                                '_var_var_13'
                                '_var_var_20'
                            [Free Vars]
                                'zone'
                            [Cell Vars]
                            [Constants]
                                1
                                12
                                'reflection'
                                0
                                (
                                    'axis'
                                )
                            [Disassembly]
                                0       BUILD_LIST                      0
                                2       LOAD_FAST                       0: .0
                                4       FOR_ITER                        76 (to 82)
                                6       UNPACK_SEQUENCE                 2
                                8       STORE_FAST                      1: _var_var_13
                                10      STORE_FAST                      2: _var_var_20
                                12      LOAD_GLOBAL                     0: np
                                14      LOAD_METHOD                     1: array
                                16      LOAD_GLOBAL                     2: list
                                18      LOAD_DEREF                      0: zone
                                20      LOAD_ATTR                       3: Envelopes
                                22      LOAD_ATTR                       4: __dict__
                                24      LOAD_FAST                       1: _var_var_13
                                26      BINARY_SUBSCR                   
                                28      LOAD_METHOD                     5: values
                                30      CALL_METHOD                     0
                                32      CALL_FUNCTION                   1
                                34      CALL_METHOD                     1
                                36      LOAD_ATTR                       6: shape
                                38      LOAD_CONST                      0: 1
                                40      BINARY_SUBSCR                   
                                42      LOAD_CONST                      1: 12
                                44      COMPARE_OP                      2 (==)
                                46      POP_JUMP_IF_FALSE               4
                                48      LOAD_GLOBAL                     0: np
                                50      LOAD_ATTR                       7: sum
                                52      LOAD_GLOBAL                     0: np
                                54      LOAD_METHOD                     1: array
                                56      LOAD_GLOBAL                     2: list
                                58      LOAD_FAST                       2: _var_var_20
                                60      LOAD_CONST                      2: 'reflection'
                                62      BINARY_SUBSCR                   
                                64      LOAD_METHOD                     5: values
                                66      CALL_METHOD                     0
                                68      CALL_FUNCTION                   1
                                70      CALL_METHOD                     1
                                72      LOAD_CONST                      3: 0
                                74      LOAD_CONST                      4: ('axis',)
                                76      CALL_FUNCTION_KW                2
                                78      LIST_APPEND                     2
                                80      JUMP_ABSOLUTE                   4
                                82      RETURN_VALUE                    
                        [Code]
                            File Name: <frozen simulation>
                            Object Name: <listcomp>
                            Arg Count: 1
                            Pos Only Arg Count: 0
                            KW Only Arg Count: 0
                            Locals: 3
                            Stack Size: 7
                            Flags: 0x00000053 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NESTED | CO_NOFREE)
                            [Names]
                                'np'
                                'matmul'
                            [Var Names]
                                '.0'
                                '_var_var_13'
                                '_var_var_21'
                            [Free Vars]
                            [Cell Vars]
                            [Constants]
                                'gain'
                                'shading_SRF'
                            [Disassembly]
                                0       BUILD_LIST                      0
                                2       LOAD_FAST                       0: .0
                                4       FOR_ITER                        28 (to 34)
                                6       UNPACK_SEQUENCE                 2
                                8       STORE_FAST                      1: _var_var_13
                                10      STORE_FAST                      2: _var_var_21
                                12      LOAD_GLOBAL                     0: np
                                14      LOAD_METHOD                     1: matmul
                                16      LOAD_FAST                       2: _var_var_21
                                18      LOAD_CONST                      0: 'gain'
                                20      BINARY_SUBSCR                   
                                22      LOAD_FAST                       2: _var_var_21
                                24      LOAD_CONST                      1: 'shading_SRF'
                                26      BINARY_SUBSCR                   
                                28      CALL_METHOD                     2
                                30      LIST_APPEND                     2
                                32      JUMP_ABSOLUTE                   4
                                34      RETURN_VALUE                    
                        [Code]
                            File Name: <frozen simulation>
                            Object Name: <listcomp>
                            Arg Count: 1
                            Pos Only Arg Count: 0
                            KW Only Arg Count: 0
                            Locals: 3
                            Stack Size: 6
                            Flags: 0x00000053 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NESTED | CO_NOFREE)
                            [Names]
                                'np'
                                'sum'
                            [Var Names]
                                '.0'
                                '_var_var_13'
                                '_var_var_21'
                            [Free Vars]
                            [Cell Vars]
                            [Constants]
                                'gain'
                                1
                                (
                                    'axis'
                                )
                            [Disassembly]
                                0       BUILD_LIST                      0
                                2       LOAD_FAST                       0: .0
                                4       FOR_ITER                        26 (to 32)
                                6       UNPACK_SEQUENCE                 2
                                8       STORE_FAST                      1: _var_var_13
                                10      STORE_FAST                      2: _var_var_21
                                12      LOAD_GLOBAL                     0: np
                                14      LOAD_ATTR                       1: sum
                                16      LOAD_FAST                       2: _var_var_21
                                18      LOAD_CONST                      0: 'gain'
                                20      BINARY_SUBSCR                   
                                22      LOAD_CONST                      1: 1
                                24      LOAD_CONST                      2: ('axis',)
                                26      CALL_FUNCTION_KW                2
                                28      LIST_APPEND                     2
                                30      JUMP_ABSOLUTE                   4
                                32      RETURN_VALUE                    
                        'has extra solar'
                        [Code]
                            File Name: <frozen simulation>
                            Object Name: <listcomp>
                            Arg Count: 1
                            Pos Only Arg Count: 0
                            KW Only Arg Count: 0
                            Locals: 3
                            Stack Size: 8
                            Flags: 0x00000013 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NESTED)
                            [Names]
                                'np'
                                'array'
                                'list'
                                'Envelopes'
                                '__dict__'
                                'values'
                                'shape'
                                'sum'
                            [Var Names]
                                '.0'
                                '_var_var_13'
                                '_var_var_20'
                            [Free Vars]
                                'zone'
                            [Cell Vars]
                            [Constants]
                                1
                                5
                                0
                                (
                                    'axis'
                                )
                            [Disassembly]
                                0       BUILD_LIST                      0
                                2       LOAD_FAST                       0: .0
                                4       FOR_ITER                        72 (to 78)
                                6       UNPACK_SEQUENCE                 2
                                8       STORE_FAST                      1: _var_var_13
                                10      STORE_FAST                      2: _var_var_20
                                12      LOAD_GLOBAL                     0: np
                                14      LOAD_METHOD                     1: array
                                16      LOAD_GLOBAL                     2: list
                                18      LOAD_DEREF                      0: zone
                                20      LOAD_ATTR                       3: Envelopes
                                22      LOAD_ATTR                       4: __dict__
                                24      LOAD_FAST                       1: _var_var_13
                                26      BINARY_SUBSCR                   
                                28      LOAD_METHOD                     5: values
                                30      CALL_METHOD                     0
                                32      CALL_FUNCTION                   1
                                34      CALL_METHOD                     1
                                36      LOAD_ATTR                       6: shape
                                38      LOAD_CONST                      0: 1
                                40      BINARY_SUBSCR                   
                                42      LOAD_CONST                      1: 5
                                44      COMPARE_OP                      2 (==)
                                46      POP_JUMP_IF_FALSE               4
                                48      LOAD_GLOBAL                     0: np
                                50      LOAD_ATTR                       7: sum
                                52      LOAD_GLOBAL                     0: np
                                54      LOAD_METHOD                     1: array
                                56      LOAD_GLOBAL                     2: list
                                58      LOAD_FAST                       2: _var_var_20
                                60      LOAD_METHOD                     5: values
                                62      CALL_METHOD                     0
                                64      CALL_FUNCTION                   1
                                66      CALL_METHOD                     1
                                68      LOAD_CONST                      2: 0
                                70      LOAD_CONST                      3: ('axis',)
                                72      CALL_FUNCTION_KW                2
                                74      LIST_APPEND                     2
                                76      JUMP_ABSOLUTE                   4
                                78      RETURN_VALUE                    
                        [Code]
                            File Name: <frozen simulation>
                            Object Name: <listcomp>
                            Arg Count: 1
                            Pos Only Arg Count: 0
                            KW Only Arg Count: 0
                            Locals: 3
                            Stack Size: 8
                            Flags: 0x00000013 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NESTED)
                            [Names]
                                'np'
                                'array'
                                'list'
                                'Envelopes'
                                '__dict__'
                                'values'
                                'shape'
                                'sum'
                            [Var Names]
                                '.0'
                                '_var_var_13'
                                '_var_var_20'
                            [Free Vars]
                                'zone'
                            [Cell Vars]
                            [Constants]
                                1
                                12
                                'reflection'
                                0
                                (
                                    'axis'
                                )
                            [Disassembly]
                                0       BUILD_LIST                      0
                                2       LOAD_FAST                       0: .0
                                4       FOR_ITER                        76 (to 82)
                                6       UNPACK_SEQUENCE                 2
                                8       STORE_FAST                      1: _var_var_13
                                10      STORE_FAST                      2: _var_var_20
                                12      LOAD_GLOBAL                     0: np
                                14      LOAD_METHOD                     1: array
                                16      LOAD_GLOBAL                     2: list
                                18      LOAD_DEREF                      0: zone
                                20      LOAD_ATTR                       3: Envelopes
                                22      LOAD_ATTR                       4: __dict__
                                24      LOAD_FAST                       1: _var_var_13
                                26      BINARY_SUBSCR                   
                                28      LOAD_METHOD                     5: values
                                30      CALL_METHOD                     0
                                32      CALL_FUNCTION                   1
                                34      CALL_METHOD                     1
                                36      LOAD_ATTR                       6: shape
                                38      LOAD_CONST                      0: 1
                                40      BINARY_SUBSCR                   
                                42      LOAD_CONST                      1: 12
                                44      COMPARE_OP                      2 (==)
                                46      POP_JUMP_IF_FALSE               4
                                48      LOAD_GLOBAL                     0: np
                                50      LOAD_ATTR                       7: sum
                                52      LOAD_GLOBAL                     0: np
                                54      LOAD_METHOD                     1: array
                                56      LOAD_GLOBAL                     2: list
                                58      LOAD_FAST                       2: _var_var_20
                                60      LOAD_CONST                      2: 'reflection'
                                62      BINARY_SUBSCR                   
                                64      LOAD_METHOD                     5: values
                                66      CALL_METHOD                     0
                                68      CALL_FUNCTION                   1
                                70      CALL_METHOD                     1
                                72      LOAD_CONST                      3: 0
                                74      LOAD_CONST                      4: ('axis',)
                                76      CALL_FUNCTION_KW                2
                                78      LIST_APPEND                     2
                                80      JUMP_ABSOLUTE                   4
                                82      RETURN_VALUE                    
                        [Code]
                            File Name: <frozen simulation>
                            Object Name: <listcomp>
                            Arg Count: 1
                            Pos Only Arg Count: 0
                            KW Only Arg Count: 0
                            Locals: 3
                            Stack Size: 7
                            Flags: 0x00000053 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NESTED | CO_NOFREE)
                            [Names]
                                'np'
                                'matmul'
                            [Var Names]
                                '.0'
                                '_var_var_13'
                                '_var_var_21'
                            [Free Vars]
                            [Cell Vars]
                            [Constants]
                                'gain'
                                'shading_SRF'
                            [Disassembly]
                                0       BUILD_LIST                      0
                                2       LOAD_FAST                       0: .0
                                4       FOR_ITER                        28 (to 34)
                                6       UNPACK_SEQUENCE                 2
                                8       STORE_FAST                      1: _var_var_13
                                10      STORE_FAST                      2: _var_var_21
                                12      LOAD_GLOBAL                     0: np
                                14      LOAD_METHOD                     1: matmul
                                16      LOAD_FAST                       2: _var_var_21
                                18      LOAD_CONST                      0: 'gain'
                                20      BINARY_SUBSCR                   
                                22      LOAD_FAST                       2: _var_var_21
                                24      LOAD_CONST                      1: 'shading_SRF'
                                26      BINARY_SUBSCR                   
                                28      CALL_METHOD                     2
                                30      LIST_APPEND                     2
                                32      JUMP_ABSOLUTE                   4
                                34      RETURN_VALUE                    
                        [Code]
                            File Name: <frozen simulation>
                            Object Name: <listcomp>
                            Arg Count: 1
                            Pos Only Arg Count: 0
                            KW Only Arg Count: 0
                            Locals: 3
                            Stack Size: 6
                            Flags: 0x00000053 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NESTED | CO_NOFREE)
                            [Names]
                                'np'
                                'sum'
                            [Var Names]
                                '.0'
                                '_var_var_13'
                                '_var_var_21'
                            [Free Vars]
                            [Cell Vars]
                            [Constants]
                                'gain'
                                1
                                (
                                    'axis'
                                )
                            [Disassembly]
                                0       BUILD_LIST                      0
                                2       LOAD_FAST                       0: .0
                                4       FOR_ITER                        26 (to 32)
                                6       UNPACK_SEQUENCE                 2
                                8       STORE_FAST                      1: _var_var_13
                                10      STORE_FAST                      2: _var_var_21
                                12      LOAD_GLOBAL                     0: np
                                14      LOAD_ATTR                       1: sum
                                16      LOAD_FAST                       2: _var_var_21
                                18      LOAD_CONST                      0: 'gain'
                                20      BINARY_SUBSCR                   
                                22      LOAD_CONST                      1: 1
                                24      LOAD_CONST                      2: ('axis',)
                                26      CALL_FUNCTION_KW                2
                                28      LIST_APPEND                     2
                                30      JUMP_ABSOLUTE                   4
                                32      RETURN_VALUE                    
                        '__pyarmor_exit_47090__'
                    [Disassembly]
                        0       NOP                             
                        2       NOP                             
                        4       NOP                             
                        6       NOP                             
                        8       LOAD_CONST                      3: '__pyarmor_enter_47089__'
                        10      NOP                             
                        12      NOP                             
                        14      LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14R\t\x00\x00\x00\x00\x00\x00'
                        16      CALL_FUNCTION                   1
                        18      POP_TOP                         
                        20      SETUP_FINALLY                   2396 (to 2420)
                        24      LOAD_GLOBAL                     0: hasattr
                        26      LOAD_FAST                       0: self
                        28      LOAD_CONST                      5: 'if_print'
                        30      CALL_FUNCTION                   2
                        32      POP_JUMP_IF_FALSE               52
                        34      LOAD_FAST                       0: self
                        36      LOAD_ATTR                       1: if_print
                        38      LOAD_CONST                      6: True
                        40      COMPARE_OP                      2 (==)
                        42      POP_JUMP_IF_FALSE               52
                        44      LOAD_GLOBAL                     2: print
                        46      LOAD_CONST                      7: 'Calculating solar heat gain by default simplified solar radiation calculation method...'
                        48      CALL_FUNCTION                   1
                        50      POP_TOP                         
                        52      LOAD_GLOBAL                     3: next
                        54      LOAD_GLOBAL                     4: iter
                        56      LOAD_FAST                       0: self
                        58      LOAD_ATTR                       5: pre_dict
                        60      LOAD_CONST                      8: 'Zones'
                        62      BINARY_SUBSCR                   
                        64      LOAD_METHOD                     6: items
                        66      CALL_METHOD                     0
                        68      CALL_FUNCTION                   1
                        70      CALL_FUNCTION                   1
                        72      UNPACK_SEQUENCE                 2
                        74      STORE_FAST                      2: _var_var_12
                        76      STORE_DEREF                     0: _var_var_11
                        78      LOAD_GLOBAL                     0: hasattr
                        80      LOAD_FAST                       0: self
                        82      LOAD_ATTR                       5: pre_dict
                        84      LOAD_CONST                      8: 'Zones'
                        86      BINARY_SUBSCR                   
                        88      LOAD_FAST                       2: _var_var_12
                        90      BINARY_SUBSCR                   
                        92      LOAD_CONST                      9: 'Solar'
                        94      CALL_FUNCTION                   2
                        96      LOAD_CONST                      10: False
                        98      COMPARE_OP                      2 (==)
                        100     POP_JUMP_IF_FALSE               1198
                        104     LOAD_GLOBAL                     2: print
                        106     LOAD_CONST                      11: 'no extra solar'
                        108     CALL_FUNCTION                   1
                        110     POP_TOP                         
                        112     LOAD_FAST                       0: self
                        114     LOAD_ATTR                       7: W
                        116     LOAD_METHOD                     8: getCalDict
                        118     CALL_METHOD                     0
                        120     LOAD_FAST                       0: self
                        122     STORE_ATTR                      9: SCal_dict
                        124     LOAD_GLOBAL                     10: list
                        126     LOAD_FAST                       0: self
                        128     LOAD_ATTR                       5: pre_dict
                        130     LOAD_CONST                      8: 'Zones'
                        132     BINARY_SUBSCR                   
                        134     LOAD_METHOD                     6: items
                        136     CALL_METHOD                     0
                        138     CALL_FUNCTION                   1
                        140     GET_ITER                        
                        142     FOR_ITER                        1048 (to 1194)
                        146     UNPACK_SEQUENCE                 2
                        148     STORE_FAST                      2: _var_var_12
                        150     STORE_DEREF                     0: _var_var_11
                        152     BUILD_MAP                       0
                        154     LOAD_DEREF                      0: _var_var_11
                        156     STORE_ATTR                      11: qi_env_dict_w
                        158     BUILD_MAP                       0
                        160     LOAD_DEREF                      0: _var_var_11
                        162     STORE_ATTR                      12: qi_env_dict_op
                        164     LOAD_GLOBAL                     10: list
                        166     LOAD_DEREF                      0: _var_var_11
                        168     LOAD_ATTR                       13: Envelopes
                        170     LOAD_ATTR                       14: __dict__
                        172     LOAD_METHOD                     6: items
                        174     CALL_METHOD                     0
                        176     CALL_FUNCTION                   1
                        178     GET_ITER                        
                        180     FOR_ITER                        770 (to 954)
                        184     UNPACK_SEQUENCE                 2
                        186     STORE_FAST                      3: _var_var_13
                        188     STORE_FAST                      4: _var_var_14
                        190     LOAD_GLOBAL                     15: np
                        192     LOAD_METHOD                     16: array
                        194     LOAD_GLOBAL                     10: list
                        196     LOAD_FAST                       4: _var_var_14
                        198     LOAD_METHOD                     17: values
                        200     CALL_METHOD                     0
                        202     CALL_FUNCTION                   1
                        204     CALL_METHOD                     1
                        206     LOAD_ATTR                       18: shape
                        208     LOAD_CONST                      12: 1
                        210     BINARY_SUBSCR                   
                        212     LOAD_CONST                      13: 12
                        214     COMPARE_OP                      2 (==)
                        216     POP_JUMP_IF_FALSE               730
                        220     BUILD_MAP                       0
                        222     LOAD_DEREF                      0: _var_var_11
                        224     LOAD_ATTR                       11: qi_env_dict_w
                        226     LOAD_FAST                       3: _var_var_13
                        228     STORE_SUBSCR                    
                        230     BUILD_MAP                       0
                        232     LOAD_DEREF                      0: _var_var_11
                        234     LOAD_ATTR                       11: qi_env_dict_w
                        236     LOAD_FAST                       3: _var_var_13
                        238     BINARY_SUBSCR                   
                        240     LOAD_CONST                      14: 'gain'
                        242     STORE_SUBSCR                    
                        244     BUILD_MAP                       0
                        246     LOAD_DEREF                      0: _var_var_11
                        248     LOAD_ATTR                       11: qi_env_dict_w
                        250     LOAD_FAST                       3: _var_var_13
                        252     BINARY_SUBSCR                   
                        254     LOAD_CONST                      15: 'reflection'
                        256     STORE_SUBSCR                    
                        258     BUILD_MAP                       0
                        260     LOAD_DEREF                      0: _var_var_11
                        262     LOAD_ATTR                       11: qi_env_dict_w
                        264     LOAD_FAST                       3: _var_var_13
                        266     BINARY_SUBSCR                   
                        268     LOAD_CONST                      16: 'shading_SRF'
                        270     STORE_SUBSCR                    
                        272     LOAD_GLOBAL                     10: list
                        274     LOAD_FAST                       4: _var_var_14
                        276     LOAD_METHOD                     6: items
                        278     CALL_METHOD                     0
                        280     CALL_FUNCTION                   1
                        282     GET_ITER                        
                        284     FOR_ITER                        328 (to 616)
                        288     UNPACK_SEQUENCE                 2
                        290     STORE_FAST                      5: _var_var_15
                        292     STORE_FAST                      6: _var_var_16
                        294     LOAD_FAST                       5: _var_var_15
                        296     LOAD_CONST                      17: 'G'
                        298     COMPARE_OP                      3 (!=)
                        300     POP_JUMP_IF_FALSE               284
                        304     LOAD_FAST                       6: _var_var_16
                        306     LOAD_CONST                      12: 1
                        308     BINARY_SUBSCR                   
                        310     LOAD_CONST                      18: 0
                        312     COMPARE_OP                      2 (==)
                        314     POP_JUMP_IF_TRUE                328
                        318     LOAD_FAST                       5: _var_var_15
                        320     LOAD_CONST                      19: 'R'
                        322     COMPARE_OP                      2 (==)
                        324     POP_JUMP_IF_FALSE               332
                        328     LOAD_CONST                      12: 1
                        330     JUMP_FORWARD                    20 (to 352)
                        332     LOAD_FAST                       0: self
                        334     LOAD_ATTR                       9: SCal_dict
                        336     LOAD_CONST                      20: 'overhang'
                        338     BINARY_SUBSCR                   
                        340     LOAD_FAST                       6: _var_var_16
                        342     LOAD_CONST                      12: 1
                        344     BINARY_SUBSCR                   
                        346     BINARY_SUBSCR                   
                        348     LOAD_FAST                       5: _var_var_15
                        350     BINARY_SUBSCR                   
                        352     STORE_FAST                      7: _var_var_17
                        354     LOAD_FAST                       6: _var_var_16
                        356     LOAD_CONST                      21: 2
                        358     BINARY_SUBSCR                   
                        360     LOAD_CONST                      18: 0
                        362     COMPARE_OP                      2 (==)
                        364     POP_JUMP_IF_TRUE                378
                        368     LOAD_FAST                       5: _var_var_15
                        370     LOAD_CONST                      19: 'R'
                        372     COMPARE_OP                      2 (==)
                        374     POP_JUMP_IF_FALSE               382
                        378     LOAD_CONST                      12: 1
                        380     JUMP_FORWARD                    20 (to 402)
                        382     LOAD_FAST                       0: self
                        384     LOAD_ATTR                       9: SCal_dict
                        386     LOAD_CONST                      22: 'fin'
                        388     BINARY_SUBSCR                   
                        390     LOAD_FAST                       6: _var_var_16
                        392     LOAD_CONST                      21: 2
                        394     BINARY_SUBSCR                   
                        396     BINARY_SUBSCR                   
                        398     LOAD_FAST                       5: _var_var_15
                        400     BINARY_SUBSCR                   
                        402     STORE_FAST                      8: _var_var_18
                        404     LOAD_FAST                       6: _var_var_16
                        406     LOAD_CONST                      23: 3
                        408     BINARY_SUBSCR                   
                        410     LOAD_CONST                      18: 0
                        412     COMPARE_OP                      2 (==)
                        414     POP_JUMP_IF_TRUE                428
                        418     LOAD_FAST                       5: _var_var_15
                        420     LOAD_CONST                      19: 'R'
                        422     COMPARE_OP                      2 (==)
                        424     POP_JUMP_IF_FALSE               432
                        428     LOAD_CONST                      12: 1
                        430     JUMP_FORWARD                    20 (to 452)
                        432     LOAD_FAST                       0: self
                        434     LOAD_ATTR                       9: SCal_dict
                        436     LOAD_CONST                      24: 'horizon'
                        438     BINARY_SUBSCR                   
                        440     LOAD_FAST                       6: _var_var_16
                        442     LOAD_CONST                      23: 3
                        444     BINARY_SUBSCR                   
                        446     BINARY_SUBSCR                   
                        448     LOAD_FAST                       5: _var_var_15
                        450     BINARY_SUBSCR                   
                        452     STORE_FAST                      9: _var_var_19
                        454     LOAD_FAST                       6: _var_var_16
                        456     LOAD_CONST                      25: 4
                        458     BINARY_SUBSCR                   
                        460     LOAD_DEREF                      0: _var_var_11
                        462     LOAD_ATTR                       11: qi_env_dict_w
                        464     LOAD_FAST                       3: _var_var_13
                        466     BINARY_SUBSCR                   
                        468     LOAD_CONST                      16: 'shading_SRF'
                        470     BINARY_SUBSCR                   
                        472     LOAD_FAST                       5: _var_var_15
                        474     STORE_SUBSCR                    
                        476     LOAD_FAST                       7: _var_var_17
                        478     LOAD_FAST                       8: _var_var_18
                        480     BINARY_MULTIPLY                 
                        482     LOAD_FAST                       9: _var_var_19
                        484     BINARY_MULTIPLY                 
                        486     LOAD_FAST                       0: self
                        488     LOAD_ATTR                       9: SCal_dict
                        490     LOAD_CONST                      26: 'surf'
                        492     BINARY_SUBSCR                   
                        494     LOAD_FAST                       5: _var_var_15
                        496     BINARY_SUBSCR                   
                        498     LOAD_CONST                      27: 'GSR'
                        500     BINARY_SUBSCR                   
                        502     BINARY_MULTIPLY                 
                        504     LOAD_FAST                       6: _var_var_16
                        506     LOAD_CONST                      18: 0
                        508     BINARY_SUBSCR                   
                        510     BINARY_MULTIPLY                 
                        512     LOAD_CONST                      12: 1
                        514     LOAD_FAST                       6: _var_var_16
                        516     LOAD_CONST                      28: -5
                        518     BINARY_SUBSCR                   
                        520     BINARY_SUBTRACT                 
                        522     BINARY_MULTIPLY                 
                        524     LOAD_FAST                       6: _var_var_16
                        526     LOAD_CONST                      29: -1
                        528     BINARY_SUBSCR                   
                        530     BINARY_MULTIPLY                 
                        532     LOAD_DEREF                      0: _var_var_11
                        534     LOAD_ATTR                       11: qi_env_dict_w
                        536     LOAD_FAST                       3: _var_var_13
                        538     BINARY_SUBSCR                   
                        540     LOAD_CONST                      14: 'gain'
                        542     BINARY_SUBSCR                   
                        544     LOAD_FAST                       5: _var_var_15
                        546     STORE_SUBSCR                    
                        548     LOAD_FAST                       6: _var_var_16
                        550     LOAD_CONST                      30: 5
                        552     BINARY_SUBSCR                   
                        554     LOAD_FAST                       0: self
                        556     LOAD_ATTR                       19: rse
                        558     BINARY_MULTIPLY                 
                        560     LOAD_FAST                       6: _var_var_16
                        562     LOAD_CONST                      31: 6
                        564     BINARY_SUBSCR                   
                        566     BINARY_MULTIPLY                 
                        568     LOAD_FAST                       6: _var_var_16
                        570     LOAD_CONST                      18: 0
                        572     BINARY_SUBSCR                   
                        574     BINARY_MULTIPLY                 
                        576     LOAD_FAST                       6: _var_var_16
                        578     LOAD_CONST                      32: -4
                        580     BINARY_SUBSCR                   
                        582     BINARY_MULTIPLY                 
                        584     LOAD_FAST                       0: self
                        586     LOAD_ATTR                       20: Te
                        588     LOAD_FAST                       0: self
                        590     LOAD_ATTR                       21: T_er
                        592     BINARY_SUBTRACT                 
                        594     BINARY_MULTIPLY                 
                        596     LOAD_DEREF                      0: _var_var_11
                        598     LOAD_ATTR                       11: qi_env_dict_w
                        600     LOAD_FAST                       3: _var_var_13
                        602     BINARY_SUBSCR                   
                        604     LOAD_CONST                      15: 'reflection'
                        606     BINARY_SUBSCR                   
                        608     LOAD_FAST                       5: _var_var_15
                        610     STORE_SUBSCR                    
                        612     JUMP_ABSOLUTE                   284
                        616     LOAD_GLOBAL                     15: np
                        618     LOAD_METHOD                     16: array
                        620     LOAD_GLOBAL                     10: list
                        622     LOAD_DEREF                      0: _var_var_11
                        624     LOAD_ATTR                       11: qi_env_dict_w
                        626     LOAD_FAST                       3: _var_var_13
                        628     BINARY_SUBSCR                   
                        630     LOAD_CONST                      16: 'shading_SRF'
                        632     BINARY_SUBSCR                   
                        634     LOAD_METHOD                     17: values
                        636     CALL_METHOD                     0
                        638     CALL_FUNCTION                   1
                        640     CALL_METHOD                     1
                        642     LOAD_DEREF                      0: _var_var_11
                        644     LOAD_ATTR                       11: qi_env_dict_w
                        646     LOAD_FAST                       3: _var_var_13
                        648     BINARY_SUBSCR                   
                        650     LOAD_CONST                      16: 'shading_SRF'
                        652     STORE_SUBSCR                    
                        654     LOAD_GLOBAL                     15: np
                        656     LOAD_METHOD                     16: array
                        658     LOAD_GLOBAL                     10: list
                        660     LOAD_DEREF                      0: _var_var_11
                        662     LOAD_ATTR                       11: qi_env_dict_w
                        664     LOAD_FAST                       3: _var_var_13
                        666     BINARY_SUBSCR                   
                        668     LOAD_CONST                      14: 'gain'
                        670     BINARY_SUBSCR                   
                        672     LOAD_METHOD                     17: values
                        674     CALL_METHOD                     0
                        676     CALL_FUNCTION                   1
                        678     CALL_METHOD                     1
                        680     LOAD_METHOD                     22: transpose
                        682     CALL_METHOD                     0
                        684     LOAD_DEREF                      0: _var_var_11
                        686     LOAD_ATTR                       11: qi_env_dict_w
                        688     LOAD_FAST                       3: _var_var_13
                        690     BINARY_SUBSCR                   
                        692     LOAD_CONST                      14: 'gain'
                        694     STORE_SUBSCR                    
                        696     LOAD_GLOBAL                     15: np
                        698     LOAD_METHOD                     23: count_nonzero
                        700     LOAD_DEREF                      0: _var_var_11
                        702     LOAD_ATTR                       11: qi_env_dict_w
                        704     LOAD_FAST                       3: _var_var_13
                        706     BINARY_SUBSCR                   
                        708     LOAD_CONST                      14: 'gain'
                        710     BINARY_SUBSCR                   
                        712     CALL_METHOD                     1
                        714     LOAD_CONST                      18: 0
                        716     COMPARE_OP                      2 (==)
                        718     POP_JUMP_IF_FALSE               730
                        722     LOAD_DEREF                      0: _var_var_11
                        724     LOAD_ATTR                       11: qi_env_dict_w
                        726     LOAD_FAST                       3: _var_var_13
                        728     DELETE_SUBSCR                   
                        730     LOAD_GLOBAL                     15: np
                        732     LOAD_METHOD                     16: array
                        734     LOAD_GLOBAL                     10: list
                        736     LOAD_FAST                       4: _var_var_14
                        738     LOAD_METHOD                     17: values
                        740     CALL_METHOD                     0
                        742     CALL_FUNCTION                   1
                        744     CALL_METHOD                     1
                        746     LOAD_ATTR                       18: shape
                        748     LOAD_CONST                      12: 1
                        750     BINARY_SUBSCR                   
                        752     LOAD_CONST                      30: 5
                        754     COMPARE_OP                      2 (==)
                        756     POP_JUMP_IF_FALSE               180
                        758     BUILD_MAP                       0
                        760     LOAD_DEREF                      0: _var_var_11
                        762     LOAD_ATTR                       12: qi_env_dict_op
                        764     LOAD_FAST                       3: _var_var_13
                        766     STORE_SUBSCR                    
                        768     LOAD_GLOBAL                     10: list
                        770     LOAD_FAST                       4: _var_var_14
                        772     LOAD_METHOD                     6: items
                        774     CALL_METHOD                     0
                        776     CALL_FUNCTION                   1
                        778     GET_ITER                        
                        780     FOR_ITER                        128 (to 910)
                        782     UNPACK_SEQUENCE                 2
                        784     STORE_FAST                      5: _var_var_15
                        786     STORE_FAST                      6: _var_var_16
                        788     LOAD_FAST                       5: _var_var_15
                        790     LOAD_CONST                      17: 'G'
                        792     COMPARE_OP                      3 (!=)
                        794     POP_JUMP_IF_FALSE               780
                        798     LOAD_FAST                       0: self
                        800     LOAD_ATTR                       9: SCal_dict
                        802     LOAD_CONST                      26: 'surf'
                        804     BINARY_SUBSCR                   
                        806     LOAD_FAST                       5: _var_var_15
                        808     BINARY_SUBSCR                   
                        810     LOAD_CONST                      27: 'GSR'
                        812     BINARY_SUBSCR                   
                        814     LOAD_FAST                       6: _var_var_16
                        816     LOAD_CONST                      18: 0
                        818     BINARY_SUBSCR                   
                        820     BINARY_MULTIPLY                 
                        822     LOAD_FAST                       6: _var_var_16
                        824     LOAD_CONST                      21: 2
                        826     BINARY_SUBSCR                   
                        828     BINARY_MULTIPLY                 
                        830     LOAD_FAST                       6: _var_var_16
                        832     LOAD_CONST                      23: 3
                        834     BINARY_SUBSCR                   
                        836     BINARY_MULTIPLY                 
                        838     LOAD_FAST                       0: self
                        840     LOAD_ATTR                       19: rse
                        842     BINARY_MULTIPLY                 
                        844     LOAD_FAST                       6: _var_var_16
                        846     LOAD_CONST                      12: 1
                        848     BINARY_SUBSCR                   
                        850     LOAD_FAST                       0: self
                        852     LOAD_ATTR                       19: rse
                        854     BINARY_MULTIPLY                 
                        856     LOAD_FAST                       6: _var_var_16
                        858     LOAD_CONST                      21: 2
                        860     BINARY_SUBSCR                   
                        862     BINARY_MULTIPLY                 
                        864     LOAD_FAST                       6: _var_var_16
                        866     LOAD_CONST                      18: 0
                        868     BINARY_SUBSCR                   
                        870     BINARY_MULTIPLY                 
                        872     LOAD_FAST                       6: _var_var_16
                        874     LOAD_CONST                      29: -1
                        876     BINARY_SUBSCR                   
                        878     BINARY_MULTIPLY                 
                        880     LOAD_FAST                       0: self
                        882     LOAD_ATTR                       20: Te
                        884     LOAD_FAST                       0: self
                        886     LOAD_ATTR                       21: T_er
                        888     BINARY_SUBTRACT                 
                        890     BINARY_MULTIPLY                 
                        892     BINARY_SUBTRACT                 
                        894     LOAD_DEREF                      0: _var_var_11
                        896     LOAD_ATTR                       12: qi_env_dict_op
                        898     LOAD_FAST                       3: _var_var_13
                        900     BINARY_SUBSCR                   
                        902     LOAD_FAST                       5: _var_var_15
                        904     STORE_SUBSCR                    
                        906     JUMP_ABSOLUTE                   780
                        910     LOAD_GLOBAL                     15: np
                        912     LOAD_METHOD                     23: count_nonzero
                        914     LOAD_GLOBAL                     15: np
                        916     LOAD_METHOD                     16: array
                        918     LOAD_GLOBAL                     10: list
                        920     LOAD_DEREF                      0: _var_var_11
                        922     LOAD_ATTR                       12: qi_env_dict_op
                        924     LOAD_FAST                       3: _var_var_13
                        926     BINARY_SUBSCR                   
                        928     LOAD_METHOD                     17: values
                        930     CALL_METHOD                     0
                        932     CALL_FUNCTION                   1
                        934     CALL_METHOD                     1
                        936     CALL_METHOD                     1
                        938     LOAD_CONST                      18: 0
                        940     COMPARE_OP                      2 (==)
                        942     POP_JUMP_IF_FALSE               180
                        944     LOAD_DEREF                      0: _var_var_11
                        946     LOAD_ATTR                       12: qi_env_dict_op
                        948     LOAD_FAST                       3: _var_var_13
                        950     DELETE_SUBSCR                   
                        952     JUMP_ABSOLUTE                   180
                        954     LOAD_GLOBAL                     15: np
                        956     LOAD_ATTR                       24: sum
                        958     LOAD_GLOBAL                     15: np
                        960     LOAD_METHOD                     16: array
                        962     LOAD_CLOSURE                    0: _var_var_11
                        964     BUILD_TUPLE                     1
                        966     LOAD_CONST                      33: <CODE> <listcomp>
                        968     LOAD_CONST                      34: 'Simulation.solarGain.<locals>.<listcomp>'
                        970     MAKE_FUNCTION                   8
                        972     LOAD_GLOBAL                     10: list
                        974     LOAD_DEREF                      0: _var_var_11
                        976     LOAD_ATTR                       12: qi_env_dict_op
                        978     LOAD_METHOD                     6: items
                        980     CALL_METHOD                     0
                        982     CALL_FUNCTION                   1
                        984     GET_ITER                        
                        986     CALL_FUNCTION                   1
                        988     CALL_METHOD                     1
                        990     LOAD_CONST                      18: 0
                        992     LOAD_CONST                      35: ('axis',)
                        994     CALL_FUNCTION_KW                2
                        996     LOAD_DEREF                      0: _var_var_11
                        998     LOAD_ATTR                       25: Af
                        1000    BINARY_TRUE_DIVIDE              
                        1002    LOAD_DEREF                      0: _var_var_11
                        1004    STORE_ATTR                      26: q_sol_op
                        1006    LOAD_GLOBAL                     15: np
                        1008    LOAD_ATTR                       24: sum
                        1010    LOAD_GLOBAL                     15: np
                        1012    LOAD_METHOD                     16: array
                        1014    LOAD_CLOSURE                    0: _var_var_11
                        1016    BUILD_TUPLE                     1
                        1018    LOAD_CONST                      36: <CODE> <listcomp>
                        1020    LOAD_CONST                      34: 'Simulation.solarGain.<locals>.<listcomp>'
                        1022    MAKE_FUNCTION                   8
                        1024    LOAD_GLOBAL                     10: list
                        1026    LOAD_DEREF                      0: _var_var_11
                        1028    LOAD_ATTR                       11: qi_env_dict_w
                        1030    LOAD_METHOD                     6: items
                        1032    CALL_METHOD                     0
                        1034    CALL_FUNCTION                   1
                        1036    GET_ITER                        
                        1038    CALL_FUNCTION                   1
                        1040    CALL_METHOD                     1
                        1042    LOAD_CONST                      18: 0
                        1044    LOAD_CONST                      35: ('axis',)
                        1046    CALL_FUNCTION_KW                2
                        1048    LOAD_DEREF                      0: _var_var_11
                        1050    LOAD_ATTR                       25: Af
                        1052    BINARY_TRUE_DIVIDE              
                        1054    LOAD_DEREF                      0: _var_var_11
                        1056    STORE_ATTR                      27: q_sol_w_rfl
                        1058    LOAD_GLOBAL                     15: np
                        1060    LOAD_METHOD                     28: where
                        1062    LOAD_FAST                       0: self
                        1064    LOAD_ATTR                       20: Te
                        1066    LOAD_FAST                       0: self
                        1068    LOAD_ATTR                       29: P_shading_threshold
                        1070    COMPARE_OP                      4 (>)
                        1072    LOAD_GLOBAL                     15: np
                        1074    LOAD_ATTR                       24: sum
                        1076    LOAD_GLOBAL                     15: np
                        1078    LOAD_METHOD                     16: array
                        1080    LOAD_CONST                      37: <CODE> <listcomp>
                        1082    LOAD_CONST                      34: 'Simulation.solarGain.<locals>.<listcomp>'
                        1084    MAKE_FUNCTION                   0
                        1086    LOAD_GLOBAL                     10: list
                        1088    LOAD_DEREF                      0: _var_var_11
                        1090    LOAD_ATTR                       11: qi_env_dict_w
                        1092    LOAD_METHOD                     6: items
                        1094    CALL_METHOD                     0
                        1096    CALL_FUNCTION                   1
                        1098    GET_ITER                        
                        1100    CALL_FUNCTION                   1
                        1102    CALL_METHOD                     1
                        1104    LOAD_CONST                      18: 0
                        1106    LOAD_CONST                      35: ('axis',)
                        1108    CALL_FUNCTION_KW                2
                        1110    LOAD_DEREF                      0: _var_var_11
                        1112    LOAD_ATTR                       25: Af
                        1114    BINARY_TRUE_DIVIDE              
                        1116    LOAD_DEREF                      0: _var_var_11
                        1118    LOAD_ATTR                       27: q_sol_w_rfl
                        1120    BINARY_SUBTRACT                 
                        1122    LOAD_GLOBAL                     15: np
                        1124    LOAD_ATTR                       24: sum
                        1126    LOAD_GLOBAL                     15: np
                        1128    LOAD_METHOD                     16: array
                        1130    LOAD_CONST                      38: <CODE> <listcomp>
                        1132    LOAD_CONST                      34: 'Simulation.solarGain.<locals>.<listcomp>'
                        1134    MAKE_FUNCTION                   0
                        1136    LOAD_GLOBAL                     10: list
                        1138    LOAD_DEREF                      0: _var_var_11
                        1140    LOAD_ATTR                       11: qi_env_dict_w
                        1142    LOAD_METHOD                     6: items
                        1144    CALL_METHOD                     0
                        1146    CALL_FUNCTION                   1
                        1148    GET_ITER                        
                        1150    CALL_FUNCTION                   1
                        1152    CALL_METHOD                     1
                        1154    LOAD_CONST                      18: 0
                        1156    LOAD_CONST                      35: ('axis',)
                        1158    CALL_FUNCTION_KW                2
                        1160    LOAD_DEREF                      0: _var_var_11
                        1162    LOAD_ATTR                       25: Af
                        1164    BINARY_TRUE_DIVIDE              
                        1166    LOAD_DEREF                      0: _var_var_11
                        1168    LOAD_ATTR                       27: q_sol_w_rfl
                        1170    BINARY_SUBTRACT                 
                        1172    CALL_METHOD                     3
                        1174    LOAD_DEREF                      0: _var_var_11
                        1176    STORE_ATTR                      30: q_sol_w
                        1178    LOAD_DEREF                      0: _var_var_11
                        1180    LOAD_ATTR                       30: q_sol_w
                        1182    LOAD_DEREF                      0: _var_var_11
                        1184    LOAD_ATTR                       26: q_sol_op
                        1186    BINARY_ADD                      
                        1188    LOAD_DEREF                      0: _var_var_11
                        1190    STORE_ATTR                      31: q_sol
                        1192    JUMP_ABSOLUTE                   142
                        1194    JUMP_FORWARD                    1206 (to 2404)
                        1198    LOAD_GLOBAL                     2: print
                        1200    LOAD_CONST                      39: 'has extra solar'
                        1202    CALL_FUNCTION                   1
                        1204    POP_TOP                         
                        1206    LOAD_FAST                       0: self
                        1208    LOAD_ATTR                       7: W
                        1210    LOAD_METHOD                     8: getCalDict
                        1212    CALL_METHOD                     0
                        1214    LOAD_FAST                       0: self
                        1216    STORE_ATTR                      9: SCal_dict
                        1218    LOAD_GLOBAL                     10: list
                        1220    LOAD_FAST                       0: self
                        1222    LOAD_ATTR                       5: pre_dict
                        1224    LOAD_CONST                      8: 'Zones'
                        1226    BINARY_SUBSCR                   
                        1228    LOAD_METHOD                     6: items
                        1230    CALL_METHOD                     0
                        1232    CALL_FUNCTION                   1
                        1234    GET_ITER                        
                        1236    FOR_ITER                        1056 (to 2296)
                        1240    UNPACK_SEQUENCE                 2
                        1242    STORE_FAST                      2: _var_var_12
                        1244    STORE_DEREF                     0: _var_var_11
                        1246    BUILD_MAP                       0
                        1248    LOAD_DEREF                      0: _var_var_11
                        1250    STORE_ATTR                      11: qi_env_dict_w
                        1252    BUILD_MAP                       0
                        1254    LOAD_DEREF                      0: _var_var_11
                        1256    STORE_ATTR                      12: qi_env_dict_op
                        1258    LOAD_GLOBAL                     10: list
                        1260    LOAD_DEREF                      0: _var_var_11
                        1262    LOAD_ATTR                       13: Envelopes
                        1264    LOAD_ATTR                       14: __dict__
                        1266    LOAD_METHOD                     6: items
                        1268    CALL_METHOD                     0
                        1270    CALL_FUNCTION                   1
                        1272    GET_ITER                        
                        1274    FOR_ITER                        776 (to 2054)
                        1278    UNPACK_SEQUENCE                 2
                        1280    STORE_FAST                      3: _var_var_13
                        1282    STORE_FAST                      4: _var_var_14
                        1284    LOAD_GLOBAL                     15: np
                        1286    LOAD_METHOD                     16: array
                        1288    LOAD_GLOBAL                     10: list
                        1290    LOAD_FAST                       4: _var_var_14
                        1292    LOAD_METHOD                     17: values
                        1294    CALL_METHOD                     0
                        1296    CALL_FUNCTION                   1
                        1298    CALL_METHOD                     1
                        1300    LOAD_ATTR                       18: shape
                        1302    LOAD_CONST                      12: 1
                        1304    BINARY_SUBSCR                   
                        1306    LOAD_CONST                      13: 12
                        1308    COMPARE_OP                      2 (==)
                        1310    POP_JUMP_IF_FALSE               1824
                        1314    BUILD_MAP                       0
                        1316    LOAD_DEREF                      0: _var_var_11
                        1318    LOAD_ATTR                       11: qi_env_dict_w
                        1320    LOAD_FAST                       3: _var_var_13
                        1322    STORE_SUBSCR                    
                        1324    BUILD_MAP                       0
                        1326    LOAD_DEREF                      0: _var_var_11
                        1328    LOAD_ATTR                       11: qi_env_dict_w
                        1330    LOAD_FAST                       3: _var_var_13
                        1332    BINARY_SUBSCR                   
                        1334    LOAD_CONST                      14: 'gain'
                        1336    STORE_SUBSCR                    
                        1338    BUILD_MAP                       0
                        1340    LOAD_DEREF                      0: _var_var_11
                        1342    LOAD_ATTR                       11: qi_env_dict_w
                        1344    LOAD_FAST                       3: _var_var_13
                        1346    BINARY_SUBSCR                   
                        1348    LOAD_CONST                      15: 'reflection'
                        1350    STORE_SUBSCR                    
                        1352    BUILD_MAP                       0
                        1354    LOAD_DEREF                      0: _var_var_11
                        1356    LOAD_ATTR                       11: qi_env_dict_w
                        1358    LOAD_FAST                       3: _var_var_13
                        1360    BINARY_SUBSCR                   
                        1362    LOAD_CONST                      16: 'shading_SRF'
                        1364    STORE_SUBSCR                    
                        1366    LOAD_GLOBAL                     10: list
                        1368    LOAD_FAST                       4: _var_var_14
                        1370    LOAD_METHOD                     6: items
                        1372    CALL_METHOD                     0
                        1374    CALL_FUNCTION                   1
                        1376    GET_ITER                        
                        1378    FOR_ITER                        328 (to 1710)
                        1382    UNPACK_SEQUENCE                 2
                        1384    STORE_FAST                      5: _var_var_15
                        1386    STORE_FAST                      6: _var_var_16
                        1388    LOAD_FAST                       5: _var_var_15
                        1390    LOAD_CONST                      17: 'G'
                        1392    COMPARE_OP                      3 (!=)
                        1394    POP_JUMP_IF_FALSE               1378
                        1398    LOAD_FAST                       6: _var_var_16
                        1400    LOAD_CONST                      12: 1
                        1402    BINARY_SUBSCR                   
                        1404    LOAD_CONST                      18: 0
                        1406    COMPARE_OP                      2 (==)
                        1408    POP_JUMP_IF_TRUE                1422
                        1412    LOAD_FAST                       5: _var_var_15
                        1414    LOAD_CONST                      19: 'R'
                        1416    COMPARE_OP                      2 (==)
                        1418    POP_JUMP_IF_FALSE               1426
                        1422    LOAD_CONST                      12: 1
                        1424    JUMP_FORWARD                    20 (to 1446)
                        1426    LOAD_FAST                       0: self
                        1428    LOAD_ATTR                       9: SCal_dict
                        1430    LOAD_CONST                      20: 'overhang'
                        1432    BINARY_SUBSCR                   
                        1434    LOAD_FAST                       6: _var_var_16
                        1436    LOAD_CONST                      12: 1
                        1438    BINARY_SUBSCR                   
                        1440    BINARY_SUBSCR                   
                        1442    LOAD_FAST                       5: _var_var_15
                        1444    BINARY_SUBSCR                   
                        1446    STORE_FAST                      7: _var_var_17
                        1448    LOAD_FAST                       6: _var_var_16
                        1450    LOAD_CONST                      21: 2
                        1452    BINARY_SUBSCR                   
                        1454    LOAD_CONST                      18: 0
                        1456    COMPARE_OP                      2 (==)
                        1458    POP_JUMP_IF_TRUE                1472
                        1462    LOAD_FAST                       5: _var_var_15
                        1464    LOAD_CONST                      19: 'R'
                        1466    COMPARE_OP                      2 (==)
                        1468    POP_JUMP_IF_FALSE               1476
                        1472    LOAD_CONST                      12: 1
                        1474    JUMP_FORWARD                    20 (to 1496)
                        1476    LOAD_FAST                       0: self
                        1478    LOAD_ATTR                       9: SCal_dict
                        1480    LOAD_CONST                      22: 'fin'
                        1482    BINARY_SUBSCR                   
                        1484    LOAD_FAST                       6: _var_var_16
                        1486    LOAD_CONST                      21: 2
                        1488    BINARY_SUBSCR                   
                        1490    BINARY_SUBSCR                   
                        1492    LOAD_FAST                       5: _var_var_15
                        1494    BINARY_SUBSCR                   
                        1496    STORE_FAST                      8: _var_var_18
                        1498    LOAD_FAST                       6: _var_var_16
                        1500    LOAD_CONST                      23: 3
                        1502    BINARY_SUBSCR                   
                        1504    LOAD_CONST                      18: 0
                        1506    COMPARE_OP                      2 (==)
                        1508    POP_JUMP_IF_TRUE                1522
                        1512    LOAD_FAST                       5: _var_var_15
                        1514    LOAD_CONST                      19: 'R'
                        1516    COMPARE_OP                      2 (==)
                        1518    POP_JUMP_IF_FALSE               1526
                        1522    LOAD_CONST                      12: 1
                        1524    JUMP_FORWARD                    20 (to 1546)
                        1526    LOAD_FAST                       0: self
                        1528    LOAD_ATTR                       9: SCal_dict
                        1530    LOAD_CONST                      24: 'horizon'
                        1532    BINARY_SUBSCR                   
                        1534    LOAD_FAST                       6: _var_var_16
                        1536    LOAD_CONST                      23: 3
                        1538    BINARY_SUBSCR                   
                        1540    BINARY_SUBSCR                   
                        1542    LOAD_FAST                       5: _var_var_15
                        1544    BINARY_SUBSCR                   
                        1546    STORE_FAST                      9: _var_var_19
                        1548    LOAD_FAST                       6: _var_var_16
                        1550    LOAD_CONST                      25: 4
                        1552    BINARY_SUBSCR                   
                        1554    LOAD_DEREF                      0: _var_var_11
                        1556    LOAD_ATTR                       11: qi_env_dict_w
                        1558    LOAD_FAST                       3: _var_var_13
                        1560    BINARY_SUBSCR                   
                        1562    LOAD_CONST                      16: 'shading_SRF'
                        1564    BINARY_SUBSCR                   
                        1566    LOAD_FAST                       5: _var_var_15
                        1568    STORE_SUBSCR                    
                        1570    LOAD_FAST                       7: _var_var_17
                        1572    LOAD_FAST                       8: _var_var_18
                        1574    BINARY_MULTIPLY                 
                        1576    LOAD_FAST                       9: _var_var_19
                        1578    BINARY_MULTIPLY                 
                        1580    LOAD_FAST                       0: self
                        1582    LOAD_ATTR                       9: SCal_dict
                        1584    LOAD_CONST                      26: 'surf'
                        1586    BINARY_SUBSCR                   
                        1588    LOAD_FAST                       5: _var_var_15
                        1590    BINARY_SUBSCR                   
                        1592    LOAD_CONST                      27: 'GSR'
                        1594    BINARY_SUBSCR                   
                        1596    BINARY_MULTIPLY                 
                        1598    LOAD_FAST                       6: _var_var_16
                        1600    LOAD_CONST                      18: 0
                        1602    BINARY_SUBSCR                   
                        1604    BINARY_MULTIPLY                 
                        1606    LOAD_CONST                      12: 1
                        1608    LOAD_FAST                       6: _var_var_16
                        1610    LOAD_CONST                      28: -5
                        1612    BINARY_SUBSCR                   
                        1614    BINARY_SUBTRACT                 
                        1616    BINARY_MULTIPLY                 
                        1618    LOAD_FAST                       6: _var_var_16
                        1620    LOAD_CONST                      29: -1
                        1622    BINARY_SUBSCR                   
                        1624    BINARY_MULTIPLY                 
                        1626    LOAD_DEREF                      0: _var_var_11
                        1628    LOAD_ATTR                       11: qi_env_dict_w
                        1630    LOAD_FAST                       3: _var_var_13
                        1632    BINARY_SUBSCR                   
                        1634    LOAD_CONST                      14: 'gain'
                        1636    BINARY_SUBSCR                   
                        1638    LOAD_FAST                       5: _var_var_15
                        1640    STORE_SUBSCR                    
                        1642    LOAD_FAST                       6: _var_var_16
                        1644    LOAD_CONST                      30: 5
                        1646    BINARY_SUBSCR                   
                        1648    LOAD_FAST                       0: self
                        1650    LOAD_ATTR                       19: rse
                        1652    BINARY_MULTIPLY                 
                        1654    LOAD_FAST                       6: _var_var_16
                        1656    LOAD_CONST                      31: 6
                        1658    BINARY_SUBSCR                   
                        1660    BINARY_MULTIPLY                 
                        1662    LOAD_FAST                       6: _var_var_16
                        1664    LOAD_CONST                      18: 0
                        1666    BINARY_SUBSCR                   
                        1668    BINARY_MULTIPLY                 
                        1670    LOAD_FAST                       6: _var_var_16
                        1672    LOAD_CONST                      32: -4
                        1674    BINARY_SUBSCR                   
                        1676    BINARY_MULTIPLY                 
                        1678    LOAD_FAST                       0: self
                        1680    LOAD_ATTR                       20: Te
                        1682    LOAD_FAST                       0: self
                        1684    LOAD_ATTR                       21: T_er
                        1686    BINARY_SUBTRACT                 
                        1688    BINARY_MULTIPLY                 
                        1690    LOAD_DEREF                      0: _var_var_11
                        1692    LOAD_ATTR                       11: qi_env_dict_w
                        1694    LOAD_FAST                       3: _var_var_13
                        1696    BINARY_SUBSCR                   
                        1698    LOAD_CONST                      15: 'reflection'
                        1700    BINARY_SUBSCR                   
                        1702    LOAD_FAST                       5: _var_var_15
                        1704    STORE_SUBSCR                    
                        1706    JUMP_ABSOLUTE                   1378
                        1710    LOAD_GLOBAL                     15: np
                        1712    LOAD_METHOD                     16: array
                        1714    LOAD_GLOBAL                     10: list
                        1716    LOAD_DEREF                      0: _var_var_11
                        1718    LOAD_ATTR                       11: qi_env_dict_w
                        1720    LOAD_FAST                       3: _var_var_13
                        1722    BINARY_SUBSCR                   
                        1724    LOAD_CONST                      16: 'shading_SRF'
                        1726    BINARY_SUBSCR                   
                        1728    LOAD_METHOD                     17: values
                        1730    CALL_METHOD                     0
                        1732    CALL_FUNCTION                   1
                        1734    CALL_METHOD                     1
                        1736    LOAD_DEREF                      0: _var_var_11
                        1738    LOAD_ATTR                       11: qi_env_dict_w
                        1740    LOAD_FAST                       3: _var_var_13
                        1742    BINARY_SUBSCR                   
                        1744    LOAD_CONST                      16: 'shading_SRF'
                        1746    STORE_SUBSCR                    
                        1748    LOAD_GLOBAL                     15: np
                        1750    LOAD_METHOD                     16: array
                        1752    LOAD_GLOBAL                     10: list
                        1754    LOAD_DEREF                      0: _var_var_11
                        1756    LOAD_ATTR                       11: qi_env_dict_w
                        1758    LOAD_FAST                       3: _var_var_13
                        1760    BINARY_SUBSCR                   
                        1762    LOAD_CONST                      14: 'gain'
                        1764    BINARY_SUBSCR                   
                        1766    LOAD_METHOD                     17: values
                        1768    CALL_METHOD                     0
                        1770    CALL_FUNCTION                   1
                        1772    CALL_METHOD                     1
                        1774    LOAD_METHOD                     22: transpose
                        1776    CALL_METHOD                     0
                        1778    LOAD_DEREF                      0: _var_var_11
                        1780    LOAD_ATTR                       11: qi_env_dict_w
                        1782    LOAD_FAST                       3: _var_var_13
                        1784    BINARY_SUBSCR                   
                        1786    LOAD_CONST                      14: 'gain'
                        1788    STORE_SUBSCR                    
                        1790    LOAD_GLOBAL                     15: np
                        1792    LOAD_METHOD                     23: count_nonzero
                        1794    LOAD_DEREF                      0: _var_var_11
                        1796    LOAD_ATTR                       11: qi_env_dict_w
                        1798    LOAD_FAST                       3: _var_var_13
                        1800    BINARY_SUBSCR                   
                        1802    LOAD_CONST                      14: 'gain'
                        1804    BINARY_SUBSCR                   
                        1806    CALL_METHOD                     1
                        1808    LOAD_CONST                      18: 0
                        1810    COMPARE_OP                      2 (==)
                        1812    POP_JUMP_IF_FALSE               1824
                        1816    LOAD_DEREF                      0: _var_var_11
                        1818    LOAD_ATTR                       11: qi_env_dict_w
                        1820    LOAD_FAST                       3: _var_var_13
                        1822    DELETE_SUBSCR                   
                        1824    LOAD_GLOBAL                     15: np
                        1826    LOAD_METHOD                     16: array
                        1828    LOAD_GLOBAL                     10: list
                        1830    LOAD_FAST                       4: _var_var_14
                        1832    LOAD_METHOD                     17: values
                        1834    CALL_METHOD                     0
                        1836    CALL_FUNCTION                   1
                        1838    CALL_METHOD                     1
                        1840    LOAD_ATTR                       18: shape
                        1842    LOAD_CONST                      12: 1
                        1844    BINARY_SUBSCR                   
                        1846    LOAD_CONST                      30: 5
                        1848    COMPARE_OP                      2 (==)
                        1850    POP_JUMP_IF_FALSE               1274
                        1854    BUILD_MAP                       0
                        1856    LOAD_DEREF                      0: _var_var_11
                        1858    LOAD_ATTR                       12: qi_env_dict_op
                        1860    LOAD_FAST                       3: _var_var_13
                        1862    STORE_SUBSCR                    
                        1864    LOAD_GLOBAL                     10: list
                        1866    LOAD_FAST                       4: _var_var_14
                        1868    LOAD_METHOD                     6: items
                        1870    CALL_METHOD                     0
                        1872    CALL_FUNCTION                   1
                        1874    GET_ITER                        
                        1876    FOR_ITER                        128 (to 2006)
                        1878    UNPACK_SEQUENCE                 2
                        1880    STORE_FAST                      5: _var_var_15
                        1882    STORE_FAST                      6: _var_var_16
                        1884    LOAD_FAST                       5: _var_var_15
                        1886    LOAD_CONST                      17: 'G'
                        1888    COMPARE_OP                      3 (!=)
                        1890    POP_JUMP_IF_FALSE               1876
                        1894    LOAD_FAST                       0: self
                        1896    LOAD_ATTR                       9: SCal_dict
                        1898    LOAD_CONST                      26: 'surf'
                        1900    BINARY_SUBSCR                   
                        1902    LOAD_FAST                       5: _var_var_15
                        1904    BINARY_SUBSCR                   
                        1906    LOAD_CONST                      27: 'GSR'
                        1908    BINARY_SUBSCR                   
                        1910    LOAD_FAST                       6: _var_var_16
                        1912    LOAD_CONST                      18: 0
                        1914    BINARY_SUBSCR                   
                        1916    BINARY_MULTIPLY                 
                        1918    LOAD_FAST                       6: _var_var_16
                        1920    LOAD_CONST                      21: 2
                        1922    BINARY_SUBSCR                   
                        1924    BINARY_MULTIPLY                 
                        1926    LOAD_FAST                       6: _var_var_16
                        1928    LOAD_CONST                      23: 3
                        1930    BINARY_SUBSCR                   
                        1932    BINARY_MULTIPLY                 
                        1934    LOAD_FAST                       0: self
                        1936    LOAD_ATTR                       19: rse
                        1938    BINARY_MULTIPLY                 
                        1940    LOAD_FAST                       6: _var_var_16
                        1942    LOAD_CONST                      12: 1
                        1944    BINARY_SUBSCR                   
                        1946    LOAD_FAST                       0: self
                        1948    LOAD_ATTR                       19: rse
                        1950    BINARY_MULTIPLY                 
                        1952    LOAD_FAST                       6: _var_var_16
                        1954    LOAD_CONST                      21: 2
                        1956    BINARY_SUBSCR                   
                        1958    BINARY_MULTIPLY                 
                        1960    LOAD_FAST                       6: _var_var_16
                        1962    LOAD_CONST                      18: 0
                        1964    BINARY_SUBSCR                   
                        1966    BINARY_MULTIPLY                 
                        1968    LOAD_FAST                       6: _var_var_16
                        1970    LOAD_CONST                      29: -1
                        1972    BINARY_SUBSCR                   
                        1974    BINARY_MULTIPLY                 
                        1976    LOAD_FAST                       0: self
                        1978    LOAD_ATTR                       20: Te
                        1980    LOAD_FAST                       0: self
                        1982    LOAD_ATTR                       21: T_er
                        1984    BINARY_SUBTRACT                 
                        1986    BINARY_MULTIPLY                 
                        1988    BINARY_SUBTRACT                 
                        1990    LOAD_DEREF                      0: _var_var_11
                        1992    LOAD_ATTR                       12: qi_env_dict_op
                        1994    LOAD_FAST                       3: _var_var_13
                        1996    BINARY_SUBSCR                   
                        1998    LOAD_FAST                       5: _var_var_15
                        2000    STORE_SUBSCR                    
                        2002    JUMP_ABSOLUTE                   1876
                        2006    LOAD_GLOBAL                     15: np
                        2008    LOAD_METHOD                     23: count_nonzero
                        2010    LOAD_GLOBAL                     15: np
                        2012    LOAD_METHOD                     16: array
                        2014    LOAD_GLOBAL                     10: list
                        2016    LOAD_DEREF                      0: _var_var_11
                        2018    LOAD_ATTR                       12: qi_env_dict_op
                        2020    LOAD_FAST                       3: _var_var_13
                        2022    BINARY_SUBSCR                   
                        2024    LOAD_METHOD                     17: values
                        2026    CALL_METHOD                     0
                        2028    CALL_FUNCTION                   1
                        2030    CALL_METHOD                     1
                        2032    CALL_METHOD                     1
                        2034    LOAD_CONST                      18: 0
                        2036    COMPARE_OP                      2 (==)
                        2038    POP_JUMP_IF_FALSE               1274
                        2042    LOAD_DEREF                      0: _var_var_11
                        2044    LOAD_ATTR                       12: qi_env_dict_op
                        2046    LOAD_FAST                       3: _var_var_13
                        2048    DELETE_SUBSCR                   
                        2050    JUMP_ABSOLUTE                   1274
                        2054    LOAD_GLOBAL                     15: np
                        2056    LOAD_ATTR                       24: sum
                        2058    LOAD_GLOBAL                     15: np
                        2060    LOAD_METHOD                     16: array
                        2062    LOAD_CLOSURE                    0: _var_var_11
                        2064    BUILD_TUPLE                     1
                        2066    LOAD_CONST                      40: <CODE> <listcomp>
                        2068    LOAD_CONST                      34: 'Simulation.solarGain.<locals>.<listcomp>'
                        2070    MAKE_FUNCTION                   8
                        2072    LOAD_GLOBAL                     10: list
                        2074    LOAD_DEREF                      0: _var_var_11
                        2076    LOAD_ATTR                       12: qi_env_dict_op
                        2078    LOAD_METHOD                     6: items
                        2080    CALL_METHOD                     0
                        2082    CALL_FUNCTION                   1
                        2084    GET_ITER                        
                        2086    CALL_FUNCTION                   1
                        2088    CALL_METHOD                     1
                        2090    LOAD_CONST                      18: 0
                        2092    LOAD_CONST                      35: ('axis',)
                        2094    CALL_FUNCTION_KW                2
                        2096    LOAD_DEREF                      0: _var_var_11
                        2098    LOAD_ATTR                       25: Af
                        2100    BINARY_TRUE_DIVIDE              
                        2102    LOAD_DEREF                      0: _var_var_11
                        2104    STORE_ATTR                      26: q_sol_op
                        2106    LOAD_GLOBAL                     15: np
                        2108    LOAD_ATTR                       24: sum
                        2110    LOAD_GLOBAL                     15: np
                        2112    LOAD_METHOD                     16: array
                        2114    LOAD_CLOSURE                    0: _var_var_11
                        2116    BUILD_TUPLE                     1
                        2118    LOAD_CONST                      41: <CODE> <listcomp>
                        2120    LOAD_CONST                      34: 'Simulation.solarGain.<locals>.<listcomp>'
                        2122    MAKE_FUNCTION                   8
                        2124    LOAD_GLOBAL                     10: list
                        2126    LOAD_DEREF                      0: _var_var_11
                        2128    LOAD_ATTR                       11: qi_env_dict_w
                        2130    LOAD_METHOD                     6: items
                        2132    CALL_METHOD                     0
                        2134    CALL_FUNCTION                   1
                        2136    GET_ITER                        
                        2138    CALL_FUNCTION                   1
                        2140    CALL_METHOD                     1
                        2142    LOAD_CONST                      18: 0
                        2144    LOAD_CONST                      35: ('axis',)
                        2146    CALL_FUNCTION_KW                2
                        2148    LOAD_DEREF                      0: _var_var_11
                        2150    LOAD_ATTR                       25: Af
                        2152    BINARY_TRUE_DIVIDE              
                        2154    LOAD_DEREF                      0: _var_var_11
                        2156    STORE_ATTR                      27: q_sol_w_rfl
                        2158    LOAD_GLOBAL                     15: np
                        2160    LOAD_METHOD                     28: where
                        2162    LOAD_FAST                       0: self
                        2164    LOAD_ATTR                       20: Te
                        2166    LOAD_FAST                       0: self
                        2168    LOAD_ATTR                       29: P_shading_threshold
                        2170    COMPARE_OP                      4 (>)
                        2172    LOAD_GLOBAL                     15: np
                        2174    LOAD_ATTR                       24: sum
                        2176    LOAD_GLOBAL                     15: np
                        2178    LOAD_METHOD                     16: array
                        2180    LOAD_CONST                      42: <CODE> <listcomp>
                        2182    LOAD_CONST                      34: 'Simulation.solarGain.<locals>.<listcomp>'
                        2184    MAKE_FUNCTION                   0
                        2186    LOAD_GLOBAL                     10: list
                        2188    LOAD_DEREF                      0: _var_var_11
                        2190    LOAD_ATTR                       11: qi_env_dict_w
                        2192    LOAD_METHOD                     6: items
                        2194    CALL_METHOD                     0
                        2196    CALL_FUNCTION                   1
                        2198    GET_ITER                        
                        2200    CALL_FUNCTION                   1
                        2202    CALL_METHOD                     1
                        2204    LOAD_CONST                      18: 0
                        2206    LOAD_CONST                      35: ('axis',)
                        2208    CALL_FUNCTION_KW                2
                        2210    LOAD_DEREF                      0: _var_var_11
                        2212    LOAD_ATTR                       25: Af
                        2214    BINARY_TRUE_DIVIDE              
                        2216    LOAD_DEREF                      0: _var_var_11
                        2218    LOAD_ATTR                       27: q_sol_w_rfl
                        2220    BINARY_SUBTRACT                 
                        2222    LOAD_GLOBAL                     15: np
                        2224    LOAD_ATTR                       24: sum
                        2226    LOAD_GLOBAL                     15: np
                        2228    LOAD_METHOD                     16: array
                        2230    LOAD_CONST                      43: <CODE> <listcomp>
                        2232    LOAD_CONST                      34: 'Simulation.solarGain.<locals>.<listcomp>'
                        2234    MAKE_FUNCTION                   0
                        2236    LOAD_GLOBAL                     10: list
                        2238    LOAD_DEREF                      0: _var_var_11
                        2240    LOAD_ATTR                       11: qi_env_dict_w
                        2242    LOAD_METHOD                     6: items
                        2244    CALL_METHOD                     0
                        2246    CALL_FUNCTION                   1
                        2248    GET_ITER                        
                        2250    CALL_FUNCTION                   1
                        2252    CALL_METHOD                     1
                        2254    LOAD_CONST                      18: 0
                        2256    LOAD_CONST                      35: ('axis',)
                        2258    CALL_FUNCTION_KW                2
                        2260    LOAD_DEREF                      0: _var_var_11
                        2262    LOAD_ATTR                       25: Af
                        2264    BINARY_TRUE_DIVIDE              
                        2266    LOAD_DEREF                      0: _var_var_11
                        2268    LOAD_ATTR                       27: q_sol_w_rfl
                        2270    BINARY_SUBTRACT                 
                        2272    CALL_METHOD                     3
                        2274    LOAD_DEREF                      0: _var_var_11
                        2276    STORE_ATTR                      30: q_sol_w
                        2278    LOAD_DEREF                      0: _var_var_11
                        2280    LOAD_ATTR                       30: q_sol_w
                        2282    LOAD_DEREF                      0: _var_var_11
                        2284    LOAD_ATTR                       26: q_sol_op
                        2286    BINARY_ADD                      
                        2288    LOAD_DEREF                      0: _var_var_11
                        2290    STORE_ATTR                      31: q_sol
                        2292    JUMP_ABSOLUTE                   1236
                        2296    LOAD_GLOBAL                     10: list
                        2298    LOAD_FAST                       0: self
                        2300    LOAD_ATTR                       5: pre_dict
                        2302    LOAD_CONST                      8: 'Zones'
                        2304    BINARY_SUBSCR                   
                        2306    LOAD_METHOD                     6: items
                        2308    CALL_METHOD                     0
                        2310    CALL_FUNCTION                   1
                        2312    GET_ITER                        
                        2314    FOR_ITER                        88 (to 2404)
                        2316    UNPACK_SEQUENCE                 2
                        2318    STORE_FAST                      2: _var_var_12
                        2320    STORE_DEREF                     0: _var_var_11
                        2322    LOAD_GLOBAL                     0: hasattr
                        2324    LOAD_FAST                       0: self
                        2326    LOAD_ATTR                       5: pre_dict
                        2328    LOAD_CONST                      8: 'Zones'
                        2330    BINARY_SUBSCR                   
                        2332    LOAD_FAST                       2: _var_var_12
                        2334    BINARY_SUBSCR                   
                        2336    LOAD_CONST                      9: 'Solar'
                        2338    CALL_FUNCTION                   2
                        2340    POP_JUMP_IF_FALSE               2314
                        2344    LOAD_FAST                       0: self
                        2346    LOAD_ATTR                       5: pre_dict
                        2348    LOAD_CONST                      8: 'Zones'
                        2350    BINARY_SUBSCR                   
                        2352    LOAD_FAST                       2: _var_var_12
                        2354    BINARY_SUBSCR                   
                        2356    LOAD_ATTR                       32: Solar
                        2358    LOAD_DEREF                      0: _var_var_11
                        2360    STORE_ATTR                      31: q_sol
                        2362    LOAD_DEREF                      0: _var_var_11
                        2364    LOAD_ATTR                       31: q_sol
                        2366    LOAD_FAST                       0: self
                        2368    LOAD_ATTR                       5: pre_dict
                        2370    LOAD_CONST                      8: 'Zones'
                        2372    BINARY_SUBSCR                   
                        2374    LOAD_FAST                       2: _var_var_12
                        2376    BINARY_SUBSCR                   
                        2378    LOAD_ATTR                       33: AreaFrac
                        2380    BINARY_MULTIPLY                 
                        2382    LOAD_DEREF                      0: _var_var_11
                        2384    STORE_ATTR                      30: q_sol_w
                        2386    LOAD_DEREF                      0: _var_var_11
                        2388    LOAD_ATTR                       31: q_sol
                        2390    LOAD_DEREF                      0: _var_var_11
                        2392    LOAD_ATTR                       30: q_sol_w
                        2394    BINARY_SUBTRACT                 
                        2396    LOAD_DEREF                      0: _var_var_11
                        2398    STORE_ATTR                      26: q_sol_op
                        2400    JUMP_ABSOLUTE                   2314
                        2404    POP_BLOCK                       
                        2406    LOAD_CONST                      44: '__pyarmor_exit_47090__'
                        2408    NOP                             
                        2410    NOP                             
                        2412    LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14R\t\x00\x00\x00\x00\x00\x00'
                        2414    CALL_FUNCTION                   1
                        2416    POP_TOP                         
                        2418    JUMP_FORWARD                    14 (to 2434)
                        2420    LOAD_CONST                      44: '__pyarmor_exit_47090__'
                        2422    NOP                             
                        2424    NOP                             
                        2426    LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14R\t\x00\x00\x00\x00\x00\x00'
                        2428    CALL_FUNCTION                   1
                        2430    POP_TOP                         
                        2432    RERAISE                         
                        2434    LOAD_CONST                      0: None
                        2436    RETURN_VALUE                    
                'Simulation.solarGain'
                [Code]
                    File Name: <frozen simulation>
                    Object Name: otherHeatGain
                    Arg Count: 1
                    Pos Only Arg Count: 0
                    KW Only Arg Count: 0
                    Locals: 8
                    Stack Size: 8
                    Flags: 0x20000003 (CO_OPTIMIZED | CO_NEWLOCALS | CO_PYARMOR_OBFUSCATED)
                    [Names]
                        'list'
                        'pre_dict'
                        'items'
                        'At'
                        'Htr_is'
                        'sum'
                        'Envelopes'
                        '__dict__'
                        'Htr_w'
                        'Htr_op'
                        'Am'
                        'Htr_ms'
                        'Af'
                        'Htr_em'
                        'prs'
                        'prm'
                        'ground_U'
                        'occupancy_frac'
                        'occupant_load'
                        'qi_occ'
                        'equipment_frac'
                        'appliance_load'
                        'qi_app'
                        'light_frac'
                        'lighting_load'
                        'Lightings'
                        'P_pc'
                        'qi_li'
                        'q_int'
                        'Ventilation'
                        'supply'
                        'MV_sched'
                        'qv_supp_fctrl'
                        'qv_exh'
                        'qv_diff'
                        'HR_eff'
                        'qv_supp'
                        'q_ia'
                        'HVAC'
                        'T_Swater_H'
                        'T_Rwater_H'
                        'deltaT_water_H'
                        'T_Swater_C'
                        'T_Rwater_C'
                        'deltaT_water_C'
                        'q_sol'
                        'q_m'
                        'q_st'
                        'General'
                        'building_area'
                        'Htr_gr'
                        'adj_wall_zone'
                        'adj_ceiling_zone'
                        'Htr_iw'
                        'Htr_if'
                        'adj_floor_zone'
                        'U_if'
                        'copy'
                        'deepcopy'
                        'wea_dict'
                        'astype'
                        'np'
                        'float64'
                        'range'
                        'len'
                        'ground_temperature'
                        'int'
                        'array'
                        'T_gr'
                    [Var Names]
                        'self'
                        '__assert_armored__'
                        '_var_var_22'
                        '_var_var_12'
                        '_var_var_23'
                        '_var_var_24'
                        '_var_var_25'
                        '_var_var_26'
                    [Free Vars]
                    [Cell Vars]
                        '_var_var_11'
                    [Constants]
                        None
                        '__pyarmor_assert_47091__'
                        'Simulation.otherHeatGain.<locals>.<lambda>'
                        '__pyarmor_enter_47092__'
                        b'<COAddr>\x01\x00\x00\x14t\x03\x00\x00\x00\x00\x00\x00'
                        0
                        'Zones'
                        3.2
                        [Code]
                            File Name: <frozen simulation>
                            Object Name: <listcomp>
                            Arg Count: 1
                            Pos Only Arg Count: 0
                            KW Only Arg Count: 0
                            Locals: 3
                            Stack Size: 10
                            Flags: 0x00000053 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NESTED | CO_NOFREE)
                            [Names]
                                'len'
                                'np'
                                'transpose'
                                'array'
                                'list'
                                'values'
                                'sum'
                            [Var Names]
                                '.0'
                                '_var_var_27'
                                '_var_var_28'
                            [Free Vars]
                            [Cell Vars]
                            [Constants]
                                12
                                None
                                0
                                6
                            [Disassembly]
                                0       BUILD_LIST                      0
                                2       LOAD_FAST                       0: .0
                                4       FOR_ITER                        106 (to 112)
                                6       UNPACK_SEQUENCE                 2
                                8       STORE_FAST                      1: _var_var_27
                                10      STORE_FAST                      2: _var_var_28
                                12      LOAD_GLOBAL                     0: len
                                14      LOAD_GLOBAL                     1: np
                                16      LOAD_METHOD                     2: transpose
                                18      LOAD_GLOBAL                     1: np
                                20      LOAD_METHOD                     3: array
                                22      LOAD_GLOBAL                     4: list
                                24      LOAD_FAST                       2: _var_var_28
                                26      LOAD_METHOD                     5: values
                                28      CALL_METHOD                     0
                                30      CALL_FUNCTION                   1
                                32      CALL_METHOD                     1
                                34      CALL_METHOD                     1
                                36      CALL_FUNCTION                   1
                                38      LOAD_CONST                      0: 12
                                40      COMPARE_OP                      2 (==)
                                42      POP_JUMP_IF_FALSE               4
                                44      LOAD_GLOBAL                     1: np
                                46      LOAD_METHOD                     6: sum
                                48      LOAD_GLOBAL                     1: np
                                50      LOAD_METHOD                     3: array
                                52      LOAD_GLOBAL                     4: list
                                54      LOAD_FAST                       2: _var_var_28
                                56      LOAD_METHOD                     5: values
                                58      CALL_METHOD                     0
                                60      CALL_FUNCTION                   1
                                62      CALL_METHOD                     1
                                64      LOAD_CONST                      1: None
                                66      LOAD_CONST                      1: None
                                68      BUILD_SLICE                     2
                                70      LOAD_CONST                      2: 0
                                72      BUILD_TUPLE                     2
                                74      BINARY_SUBSCR                   
                                76      LOAD_GLOBAL                     1: np
                                78      LOAD_METHOD                     3: array
                                80      LOAD_GLOBAL                     4: list
                                82      LOAD_FAST                       2: _var_var_28
                                84      LOAD_METHOD                     5: values
                                86      CALL_METHOD                     0
                                88      CALL_FUNCTION                   1
                                90      CALL_METHOD                     1
                                92      LOAD_CONST                      1: None
                                94      LOAD_CONST                      1: None
                                96      BUILD_SLICE                     2
                                98      LOAD_CONST                      3: 6
                                100     BUILD_TUPLE                     2
                                102     BINARY_SUBSCR                   
                                104     BINARY_MULTIPLY                 
                                106     CALL_METHOD                     1
                                108     LIST_APPEND                     2
                                110     JUMP_ABSOLUTE                   4
                                112     RETURN_VALUE                    
                        'Simulation.otherHeatGain.<locals>.<listcomp>'
                        [Code]
                            File Name: <frozen simulation>
                            Object Name: <listcomp>
                            Arg Count: 1
                            Pos Only Arg Count: 0
                            KW Only Arg Count: 0
                            Locals: 3
                            Stack Size: 10
                            Flags: 0x00000053 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NESTED | CO_NOFREE)
                            [Names]
                                'len'
                                'np'
                                'transpose'
                                'array'
                                'list'
                                'values'
                                'sum'
                            [Var Names]
                                '.0'
                                '_var_var_27'
                                '_var_var_28'
                            [Free Vars]
                            [Cell Vars]
                            [Constants]
                                5
                                None
                                0
                                2
                            [Disassembly]
                                0       BUILD_LIST                      0
                                2       LOAD_FAST                       0: .0
                                4       FOR_ITER                        106 (to 112)
                                6       UNPACK_SEQUENCE                 2
                                8       STORE_FAST                      1: _var_var_27
                                10      STORE_FAST                      2: _var_var_28
                                12      LOAD_GLOBAL                     0: len
                                14      LOAD_GLOBAL                     1: np
                                16      LOAD_METHOD                     2: transpose
                                18      LOAD_GLOBAL                     1: np
                                20      LOAD_METHOD                     3: array
                                22      LOAD_GLOBAL                     4: list
                                24      LOAD_FAST                       2: _var_var_28
                                26      LOAD_METHOD                     5: values
                                28      CALL_METHOD                     0
                                30      CALL_FUNCTION                   1
                                32      CALL_METHOD                     1
                                34      CALL_METHOD                     1
                                36      CALL_FUNCTION                   1
                                38      LOAD_CONST                      0: 5
                                40      COMPARE_OP                      2 (==)
                                42      POP_JUMP_IF_FALSE               4
                                44      LOAD_GLOBAL                     1: np
                                46      LOAD_METHOD                     6: sum
                                48      LOAD_GLOBAL                     1: np
                                50      LOAD_METHOD                     3: array
                                52      LOAD_GLOBAL                     4: list
                                54      LOAD_FAST                       2: _var_var_28
                                56      LOAD_METHOD                     5: values
                                58      CALL_METHOD                     0
                                60      CALL_FUNCTION                   1
                                62      CALL_METHOD                     1
                                64      LOAD_CONST                      1: None
                                66      LOAD_CONST                      1: None
                                68      BUILD_SLICE                     2
                                70      LOAD_CONST                      2: 0
                                72      BUILD_TUPLE                     2
                                74      BINARY_SUBSCR                   
                                76      LOAD_GLOBAL                     1: np
                                78      LOAD_METHOD                     3: array
                                80      LOAD_GLOBAL                     4: list
                                82      LOAD_FAST                       2: _var_var_28
                                84      LOAD_METHOD                     5: values
                                86      CALL_METHOD                     0
                                88      CALL_FUNCTION                   1
                                90      CALL_METHOD                     1
                                92      LOAD_CONST                      1: None
                                94      LOAD_CONST                      1: None
                                96      BUILD_SLICE                     2
                                98      LOAD_CONST                      3: 2
                                100     BUILD_TUPLE                     2
                                102     BINARY_SUBSCR                   
                                104     BINARY_MULTIPLY                 
                                106     CALL_METHOD                     1
                                108     LIST_APPEND                     2
                                110     JUMP_ABSOLUTE                   4
                                112     RETURN_VALUE                    
                        9
                        1
                        9.1
                        [Code]
                            File Name: <frozen simulation>
                            Object Name: <listcomp>
                            Arg Count: 1
                            Pos Only Arg Count: 0
                            KW Only Arg Count: 0
                            Locals: 3
                            Stack Size: 10
                            Flags: 0x00000053 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NESTED | CO_NOFREE)
                            [Names]
                                'len'
                                'np'
                                'transpose'
                                'array'
                                'list'
                                'values'
                                'sum'
                            [Var Names]
                                '.0'
                                '_var_var_27'
                                '_var_var_28'
                            [Free Vars]
                            [Cell Vars]
                            [Constants]
                                2
                                None
                                1
                                0
                            [Disassembly]
                                0       BUILD_LIST                      0
                                2       LOAD_FAST                       0: .0
                                4       FOR_ITER                        108 (to 114)
                                6       UNPACK_SEQUENCE                 2
                                8       STORE_FAST                      1: _var_var_27
                                10      STORE_FAST                      2: _var_var_28
                                12      LOAD_GLOBAL                     0: len
                                14      LOAD_GLOBAL                     1: np
                                16      LOAD_METHOD                     2: transpose
                                18      LOAD_GLOBAL                     1: np
                                20      LOAD_METHOD                     3: array
                                22      LOAD_GLOBAL                     4: list
                                24      LOAD_FAST                       2: _var_var_28
                                26      LOAD_METHOD                     5: values
                                28      CALL_METHOD                     0
                                30      CALL_FUNCTION                   1
                                32      CALL_METHOD                     1
                                34      CALL_METHOD                     1
                                36      CALL_FUNCTION                   1
                                38      LOAD_CONST                      0: 2
                                40      COMPARE_OP                      2 (==)
                                42      POP_JUMP_IF_FALSE               4
                                44      LOAD_GLOBAL                     6: sum
                                46      LOAD_GLOBAL                     1: np
                                48      LOAD_METHOD                     3: array
                                50      LOAD_GLOBAL                     4: list
                                52      LOAD_FAST                       2: _var_var_28
                                54      LOAD_METHOD                     5: values
                                56      CALL_METHOD                     0
                                58      CALL_FUNCTION                   1
                                60      CALL_METHOD                     1
                                62      LOAD_CONST                      1: None
                                64      LOAD_CONST                      1: None
                                66      BUILD_SLICE                     2
                                68      LOAD_CONST                      2: 1
                                70      BUILD_TUPLE                     2
                                72      BINARY_SUBSCR                   
                                74      CALL_FUNCTION                   1
                                76      LOAD_GLOBAL                     6: sum
                                78      LOAD_GLOBAL                     1: np
                                80      LOAD_METHOD                     3: array
                                82      LOAD_GLOBAL                     4: list
                                84      LOAD_FAST                       2: _var_var_28
                                86      LOAD_METHOD                     5: values
                                88      CALL_METHOD                     0
                                90      CALL_FUNCTION                   1
                                92      CALL_METHOD                     1
                                94      LOAD_CONST                      1: None
                                96      LOAD_CONST                      1: None
                                98      BUILD_SLICE                     2
                                100     LOAD_CONST                      3: 0
                                102     BUILD_TUPLE                     2
                                104     BINARY_SUBSCR                   
                                106     CALL_FUNCTION                   1
                                108     BINARY_MULTIPLY                 
                                110     LIST_APPEND                     2
                                112     JUMP_ABSOLUTE                   4
                                114     RETURN_VALUE                    
                        [Code]
                            File Name: <frozen simulation>
                            Object Name: <listcomp>
                            Arg Count: 1
                            Pos Only Arg Count: 0
                            KW Only Arg Count: 0
                            Locals: 3
                            Stack Size: 10
                            Flags: 0x00000053 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NESTED | CO_NOFREE)
                            [Names]
                                'len'
                                'np'
                                'transpose'
                                'array'
                                'list'
                                'values'
                                'sum'
                            [Var Names]
                                '.0'
                                '_var_var_27'
                                '_var_var_28'
                            [Free Vars]
                            [Cell Vars]
                            [Constants]
                                2
                                None
                                1
                                0
                            [Disassembly]
                                0       BUILD_LIST                      0
                                2       LOAD_FAST                       0: .0
                                4       FOR_ITER                        108 (to 114)
                                6       UNPACK_SEQUENCE                 2
                                8       STORE_FAST                      1: _var_var_27
                                10      STORE_FAST                      2: _var_var_28
                                12      LOAD_GLOBAL                     0: len
                                14      LOAD_GLOBAL                     1: np
                                16      LOAD_METHOD                     2: transpose
                                18      LOAD_GLOBAL                     1: np
                                20      LOAD_METHOD                     3: array
                                22      LOAD_GLOBAL                     4: list
                                24      LOAD_FAST                       2: _var_var_28
                                26      LOAD_METHOD                     5: values
                                28      CALL_METHOD                     0
                                30      CALL_FUNCTION                   1
                                32      CALL_METHOD                     1
                                34      CALL_METHOD                     1
                                36      CALL_FUNCTION                   1
                                38      LOAD_CONST                      0: 2
                                40      COMPARE_OP                      2 (==)
                                42      POP_JUMP_IF_FALSE               4
                                44      LOAD_GLOBAL                     6: sum
                                46      LOAD_GLOBAL                     1: np
                                48      LOAD_METHOD                     3: array
                                50      LOAD_GLOBAL                     4: list
                                52      LOAD_FAST                       2: _var_var_28
                                54      LOAD_METHOD                     5: values
                                56      CALL_METHOD                     0
                                58      CALL_FUNCTION                   1
                                60      CALL_METHOD                     1
                                62      LOAD_CONST                      1: None
                                64      LOAD_CONST                      1: None
                                66      BUILD_SLICE                     2
                                68      LOAD_CONST                      2: 1
                                70      BUILD_TUPLE                     2
                                72      BINARY_SUBSCR                   
                                74      CALL_FUNCTION                   1
                                76      LOAD_GLOBAL                     6: sum
                                78      LOAD_GLOBAL                     1: np
                                80      LOAD_METHOD                     3: array
                                82      LOAD_GLOBAL                     4: list
                                84      LOAD_FAST                       2: _var_var_28
                                86      LOAD_METHOD                     5: values
                                88      CALL_METHOD                     0
                                90      CALL_FUNCTION                   1
                                92      CALL_METHOD                     1
                                94      LOAD_CONST                      1: None
                                96      LOAD_CONST                      1: None
                                98      BUILD_SLICE                     2
                                100     LOAD_CONST                      3: 0
                                102     BUILD_TUPLE                     2
                                104     BINARY_SUBSCR                   
                                106     CALL_FUNCTION                   1
                                108     BINARY_MULTIPLY                 
                                110     LIST_APPEND                     2
                                112     JUMP_ABSOLUTE                   4
                                114     RETURN_VALUE                    
                        0.5
                        11
                        5
                        [Code]
                            File Name: <frozen simulation>
                            Object Name: <listcomp>
                            Arg Count: 1
                            Pos Only Arg Count: 0
                            KW Only Arg Count: 0
                            Locals: 3
                            Stack Size: 4
                            Flags: 0x00000013 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NESTED)
                            [Names]
                                'U_iw'
                            [Var Names]
                                '.0'
                                '_var_var_23'
                                '_var_var_24'
                            [Free Vars]
                                'zone'
                            [Cell Vars]
                            [Constants]
                            [Disassembly]
                                0       BUILD_LIST                      0
                                2       LOAD_FAST                       0: .0
                                4       FOR_ITER                        18 (to 24)
                                6       UNPACK_SEQUENCE                 2
                                8       STORE_FAST                      1: _var_var_23
                                10      STORE_FAST                      2: _var_var_24
                                12      LOAD_DEREF                      0: zone
                                14      LOAD_ATTR                       0: U_iw
                                16      LOAD_FAST                       2: _var_var_24
                                18      BINARY_MULTIPLY                 
                                20      LIST_APPEND                     2
                                22      JUMP_ABSOLUTE                   4
                                24      RETURN_VALUE                    
                        [Code]
                            File Name: <frozen simulation>
                            Object Name: <listcomp>
                            Arg Count: 1
                            Pos Only Arg Count: 0
                            KW Only Arg Count: 0
                            Locals: 3
                            Stack Size: 4
                            Flags: 0x00000013 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NESTED)
                            [Names]
                                'U_if'
                            [Var Names]
                                '.0'
                                '_var_var_23'
                                '_var_var_24'
                            [Free Vars]
                                'zone'
                            [Cell Vars]
                            [Constants]
                            [Disassembly]
                                0       BUILD_LIST                      0
                                2       LOAD_FAST                       0: .0
                                4       FOR_ITER                        18 (to 24)
                                6       UNPACK_SEQUENCE                 2
                                8       STORE_FAST                      1: _var_var_23
                                10      STORE_FAST                      2: _var_var_24
                                12      LOAD_DEREF                      0: zone
                                14      LOAD_ATTR                       0: U_if
                                16      LOAD_FAST                       2: _var_var_24
                                18      BINARY_MULTIPLY                 
                                20      LIST_APPEND                     2
                                22      JUMP_ABSOLUTE                   4
                                24      RETURN_VALUE                    
                        'ground'
                        'month'
                        '__pyarmor_exit_47093__'
                    [Disassembly]
                        0       NOP                             
                        2       NOP                             
                        4       NOP                             
                        6       NOP                             
                        8       LOAD_CONST                      3: '__pyarmor_enter_47092__'
                        10      NOP                             
                        12      NOP                             
                        14      LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14t\x03\x00\x00\x00\x00\x00\x00'
                        16      CALL_FUNCTION                   1
                        18      POP_TOP                         
                        20      SETUP_FINALLY                   894 (to 918)
                        24      LOAD_CONST                      5: 0
                        26      STORE_FAST                      2: _var_var_22
                        28      LOAD_GLOBAL                     0: list
                        30      LOAD_FAST                       0: self
                        32      LOAD_ATTR                       1: pre_dict
                        34      LOAD_CONST                      6: 'Zones'
                        36      BINARY_SUBSCR                   
                        38      LOAD_METHOD                     2: items
                        40      CALL_METHOD                     0
                        42      CALL_FUNCTION                   1
                        44      GET_ITER                        
                        46      FOR_ITER                        544 (to 594)
                        50      UNPACK_SEQUENCE                 2
                        52      STORE_FAST                      3: _var_var_12
                        54      STORE_DEREF                     0: _var_var_11
                        56      LOAD_CONST                      7: 3.2
                        58      LOAD_FAST                       0: self
                        60      LOAD_ATTR                       3: At
                        62      BINARY_MULTIPLY                 
                        64      LOAD_DEREF                      0: _var_var_11
                        66      STORE_ATTR                      4: Htr_is
                        68      LOAD_GLOBAL                     5: sum
                        70      LOAD_CONST                      8: <CODE> <listcomp>
                        72      LOAD_CONST                      9: 'Simulation.otherHeatGain.<locals>.<listcomp>'
                        74      MAKE_FUNCTION                   0
                        76      LOAD_GLOBAL                     0: list
                        78      LOAD_DEREF                      0: _var_var_11
                        80      LOAD_ATTR                       6: Envelopes
                        82      LOAD_ATTR                       7: __dict__
                        84      LOAD_METHOD                     2: items
                        86      CALL_METHOD                     0
                        88      CALL_FUNCTION                   1
                        90      GET_ITER                        
                        92      CALL_FUNCTION                   1
                        94      CALL_FUNCTION                   1
                        96      LOAD_DEREF                      0: _var_var_11
                        98      STORE_ATTR                      8: Htr_w
                        100     LOAD_GLOBAL                     5: sum
                        102     LOAD_CONST                      10: <CODE> <listcomp>
                        104     LOAD_CONST                      9: 'Simulation.otherHeatGain.<locals>.<listcomp>'
                        106     MAKE_FUNCTION                   0
                        108     LOAD_GLOBAL                     0: list
                        110     LOAD_DEREF                      0: _var_var_11
                        112     LOAD_ATTR                       6: Envelopes
                        114     LOAD_ATTR                       7: __dict__
                        116     LOAD_METHOD                     2: items
                        118     CALL_METHOD                     0
                        120     CALL_FUNCTION                   1
                        122     GET_ITER                        
                        124     CALL_FUNCTION                   1
                        126     CALL_FUNCTION                   1
                        128     LOAD_DEREF                      0: _var_var_11
                        130     STORE_ATTR                      9: Htr_op
                        132     LOAD_CONST                      11: 9
                        134     LOAD_FAST                       0: self
                        136     LOAD_ATTR                       10: Am
                        138     BINARY_MULTIPLY                 
                        140     LOAD_DEREF                      0: _var_var_11
                        142     STORE_ATTR                      11: Htr_ms
                        144     LOAD_CONST                      12: 1
                        146     LOAD_CONST                      12: 1
                        148     LOAD_DEREF                      0: _var_var_11
                        150     LOAD_ATTR                       9: Htr_op
                        152     LOAD_DEREF                      0: _var_var_11
                        154     LOAD_ATTR                       12: Af
                        156     BINARY_TRUE_DIVIDE              
                        158     BINARY_TRUE_DIVIDE              
                        160     LOAD_CONST                      12: 1
                        162     LOAD_DEREF                      0: _var_var_11
                        164     LOAD_ATTR                       11: Htr_ms
                        166     BINARY_TRUE_DIVIDE              
                        168     BINARY_SUBTRACT                 
                        170     BINARY_TRUE_DIVIDE              
                        172     LOAD_DEREF                      0: _var_var_11
                        174     STORE_ATTR                      13: Htr_em
                        176     LOAD_CONST                      12: 1
                        178     LOAD_FAST                       0: self
                        180     LOAD_ATTR                       10: Am
                        182     LOAD_FAST                       0: self
                        184     LOAD_ATTR                       3: At
                        186     BINARY_TRUE_DIVIDE              
                        188     BINARY_SUBTRACT                 
                        190     LOAD_DEREF                      0: _var_var_11
                        192     LOAD_ATTR                       8: Htr_w
                        194     LOAD_DEREF                      0: _var_var_11
                        196     LOAD_ATTR                       12: Af
                        198     BINARY_TRUE_DIVIDE              
                        200     LOAD_CONST                      13: 9.1
                        202     LOAD_FAST                       0: self
                        204     LOAD_ATTR                       3: At
                        206     BINARY_MULTIPLY                 
                        208     BINARY_TRUE_DIVIDE              
                        210     BINARY_SUBTRACT                 
                        212     LOAD_DEREF                      0: _var_var_11
                        214     STORE_ATTR                      14: prs
                        216     LOAD_FAST                       0: self
                        218     LOAD_ATTR                       10: Am
                        220     LOAD_FAST                       0: self
                        222     LOAD_ATTR                       3: At
                        224     BINARY_TRUE_DIVIDE              
                        226     LOAD_DEREF                      0: _var_var_11
                        228     STORE_ATTR                      15: prm
                        230     LOAD_FAST                       2: _var_var_22
                        232     LOAD_GLOBAL                     5: sum
                        234     LOAD_CONST                      14: <CODE> <listcomp>
                        236     LOAD_CONST                      9: 'Simulation.otherHeatGain.<locals>.<listcomp>'
                        238     MAKE_FUNCTION                   0
                        240     LOAD_GLOBAL                     0: list
                        242     LOAD_DEREF                      0: _var_var_11
                        244     LOAD_ATTR                       6: Envelopes
                        246     LOAD_ATTR                       7: __dict__
                        248     LOAD_METHOD                     2: items
                        250     CALL_METHOD                     0
                        252     CALL_FUNCTION                   1
                        254     GET_ITER                        
                        256     CALL_FUNCTION                   1
                        258     CALL_FUNCTION                   1
                        260     INPLACE_ADD                     
                        262     STORE_FAST                      2: _var_var_22
                        264     LOAD_GLOBAL                     5: sum
                        266     LOAD_CONST                      15: <CODE> <listcomp>
                        268     LOAD_CONST                      9: 'Simulation.otherHeatGain.<locals>.<listcomp>'
                        270     MAKE_FUNCTION                   0
                        272     LOAD_GLOBAL                     0: list
                        274     LOAD_DEREF                      0: _var_var_11
                        276     LOAD_ATTR                       6: Envelopes
                        278     LOAD_ATTR                       7: __dict__
                        280     LOAD_METHOD                     2: items
                        282     CALL_METHOD                     0
                        284     CALL_FUNCTION                   1
                        286     GET_ITER                        
                        288     CALL_FUNCTION                   1
                        290     CALL_FUNCTION                   1
                        292     LOAD_DEREF                      0: _var_var_11
                        294     LOAD_ATTR                       12: Af
                        296     BINARY_TRUE_DIVIDE              
                        298     LOAD_DEREF                      0: _var_var_11
                        300     STORE_ATTR                      16: ground_U
                        302     LOAD_DEREF                      0: _var_var_11
                        304     LOAD_ATTR                       17: occupancy_frac
                        306     LOAD_DEREF                      0: _var_var_11
                        308     LOAD_ATTR                       18: occupant_load
                        310     BINARY_MULTIPLY                 
                        312     LOAD_DEREF                      0: _var_var_11
                        314     STORE_ATTR                      19: qi_occ
                        316     LOAD_DEREF                      0: _var_var_11
                        318     LOAD_ATTR                       20: equipment_frac
                        320     LOAD_DEREF                      0: _var_var_11
                        322     LOAD_ATTR                       21: appliance_load
                        324     BINARY_MULTIPLY                 
                        326     LOAD_DEREF                      0: _var_var_11
                        328     STORE_ATTR                      22: qi_app
                        330     LOAD_DEREF                      0: _var_var_11
                        332     LOAD_ATTR                       23: light_frac
                        334     LOAD_DEREF                      0: _var_var_11
                        336     LOAD_ATTR                       24: lighting_load
                        338     BINARY_MULTIPLY                 
                        340     LOAD_DEREF                      0: _var_var_11
                        342     LOAD_ATTR                       25: Lightings
                        344     LOAD_ATTR                       26: P_pc
                        346     BINARY_ADD                      
                        348     LOAD_DEREF                      0: _var_var_11
                        350     STORE_ATTR                      27: qi_li
                        352     LOAD_DEREF                      0: _var_var_11
                        354     LOAD_ATTR                       19: qi_occ
                        356     LOAD_DEREF                      0: _var_var_11
                        358     LOAD_ATTR                       22: qi_app
                        360     BINARY_ADD                      
                        362     LOAD_DEREF                      0: _var_var_11
                        364     LOAD_ATTR                       27: qi_li
                        366     BINARY_ADD                      
                        368     LOAD_DEREF                      0: _var_var_11
                        370     STORE_ATTR                      28: q_int
                        372     LOAD_DEREF                      0: _var_var_11
                        374     LOAD_ATTR                       29: Ventilation
                        376     LOAD_ATTR                       30: supply
                        378     LOAD_DEREF                      0: _var_var_11
                        380     LOAD_ATTR                       29: Ventilation
                        382     LOAD_ATTR                       31: MV_sched
                        384     BINARY_MULTIPLY                 
                        386     LOAD_DEREF                      0: _var_var_11
                        388     STORE_ATTR                      32: qv_supp_fctrl
                        390     LOAD_DEREF                      0: _var_var_11
                        392     LOAD_ATTR                       32: qv_supp_fctrl
                        394     LOAD_DEREF                      0: _var_var_11
                        396     STORE_ATTR                      33: qv_exh
                        398     LOAD_DEREF                      0: _var_var_11
                        400     LOAD_ATTR                       32: qv_supp_fctrl
                        402     LOAD_DEREF                      0: _var_var_11
                        404     LOAD_ATTR                       33: qv_exh
                        406     BINARY_SUBTRACT                 
                        408     LOAD_DEREF                      0: _var_var_11
                        410     STORE_ATTR                      34: qv_diff
                        412     LOAD_DEREF                      0: _var_var_11
                        414     LOAD_ATTR                       32: qv_supp_fctrl
                        416     LOAD_CONST                      12: 1
                        418     LOAD_DEREF                      0: _var_var_11
                        420     LOAD_ATTR                       29: Ventilation
                        422     LOAD_ATTR                       35: HR_eff
                        424     BINARY_SUBTRACT                 
                        426     BINARY_MULTIPLY                 
                        428     LOAD_DEREF                      0: _var_var_11
                        430     STORE_ATTR                      36: qv_supp
                        432     LOAD_CONST                      16: 0.5
                        434     LOAD_DEREF                      0: _var_var_11
                        436     LOAD_ATTR                       28: q_int
                        438     BINARY_MULTIPLY                 
                        440     LOAD_DEREF                      0: _var_var_11
                        442     STORE_ATTR                      37: q_ia
                        444     LOAD_DEREF                      0: _var_var_11
                        446     LOAD_ATTR                       38: HVAC
                        448     LOAD_ATTR                       39: T_Swater_H
                        450     LOAD_CONST                      5: 0
                        452     COMPARE_OP                      3 (!=)
                        454     POP_JUMP_IF_FALSE               488
                        458     LOAD_DEREF                      0: _var_var_11
                        460     LOAD_ATTR                       38: HVAC
                        462     LOAD_ATTR                       40: T_Rwater_H
                        464     LOAD_CONST                      5: 0
                        466     COMPARE_OP                      3 (!=)
                        468     POP_JUMP_IF_FALSE               488
                        472     LOAD_DEREF                      0: _var_var_11
                        474     LOAD_ATTR                       38: HVAC
                        476     LOAD_ATTR                       39: T_Swater_H
                        478     LOAD_DEREF                      0: _var_var_11
                        480     LOAD_ATTR                       38: HVAC
                        482     LOAD_ATTR                       40: T_Rwater_H
                        484     BINARY_SUBTRACT                 
                        486     JUMP_FORWARD                    2 (to 490)
                        488     LOAD_CONST                      17: 11
                        490     LOAD_DEREF                      0: _var_var_11
                        492     STORE_ATTR                      41: deltaT_water_H
                        494     LOAD_DEREF                      0: _var_var_11
                        496     LOAD_ATTR                       38: HVAC
                        498     LOAD_ATTR                       42: T_Swater_C
                        500     LOAD_CONST                      5: 0
                        502     COMPARE_OP                      3 (!=)
                        504     POP_JUMP_IF_FALSE               538
                        508     LOAD_DEREF                      0: _var_var_11
                        510     LOAD_ATTR                       38: HVAC
                        512     LOAD_ATTR                       43: T_Rwater_C
                        514     LOAD_CONST                      5: 0
                        516     COMPARE_OP                      3 (!=)
                        518     POP_JUMP_IF_FALSE               538
                        522     LOAD_DEREF                      0: _var_var_11
                        524     LOAD_ATTR                       38: HVAC
                        526     LOAD_ATTR                       43: T_Rwater_C
                        528     LOAD_DEREF                      0: _var_var_11
                        530     LOAD_ATTR                       38: HVAC
                        532     LOAD_ATTR                       42: T_Swater_C
                        534     BINARY_SUBTRACT                 
                        536     JUMP_FORWARD                    2 (to 540)
                        538     LOAD_CONST                      18: 5
                        540     LOAD_DEREF                      0: _var_var_11
                        542     STORE_ATTR                      44: deltaT_water_C
                        544     LOAD_DEREF                      0: _var_var_11
                        546     LOAD_ATTR                       15: prm
                        548     LOAD_CONST                      16: 0.5
                        550     LOAD_DEREF                      0: _var_var_11
                        552     LOAD_ATTR                       28: q_int
                        554     BINARY_MULTIPLY                 
                        556     LOAD_DEREF                      0: _var_var_11
                        558     LOAD_ATTR                       45: q_sol
                        560     BINARY_ADD                      
                        562     BINARY_MULTIPLY                 
                        564     LOAD_DEREF                      0: _var_var_11
                        566     STORE_ATTR                      46: q_m
                        568     LOAD_DEREF                      0: _var_var_11
                        570     LOAD_ATTR                       14: prs
                        572     LOAD_CONST                      16: 0.5
                        574     LOAD_DEREF                      0: _var_var_11
                        576     LOAD_ATTR                       28: q_int
                        578     BINARY_MULTIPLY                 
                        580     LOAD_DEREF                      0: _var_var_11
                        582     LOAD_ATTR                       45: q_sol
                        584     BINARY_ADD                      
                        586     BINARY_MULTIPLY                 
                        588     LOAD_DEREF                      0: _var_var_11
                        590     STORE_ATTR                      47: q_st
                        592     JUMP_ABSOLUTE                   46
                        594     LOAD_FAST                       2: _var_var_22
                        596     LOAD_FAST                       0: self
                        598     LOAD_ATTR                       48: General
                        600     LOAD_ATTR                       49: building_area
                        602     BINARY_TRUE_DIVIDE              
                        604     STORE_FAST                      2: _var_var_22
                        606     LOAD_FAST                       2: _var_var_22
                        608     LOAD_FAST                       0: self
                        610     STORE_ATTR                      50: Htr_gr
                        612     LOAD_GLOBAL                     0: list
                        614     LOAD_FAST                       0: self
                        616     LOAD_ATTR                       1: pre_dict
                        618     LOAD_CONST                      6: 'Zones'
                        620     BINARY_SUBSCR                   
                        622     LOAD_METHOD                     2: items
                        624     CALL_METHOD                     0
                        626     CALL_FUNCTION                   1
                        628     GET_ITER                        
                        630     FOR_ITER                        186 (to 818)
                        632     UNPACK_SEQUENCE                 2
                        634     STORE_FAST                      3: _var_var_12
                        636     STORE_DEREF                     0: _var_var_11
                        638     LOAD_GLOBAL                     5: sum
                        640     LOAD_CLOSURE                    0: _var_var_11
                        642     BUILD_TUPLE                     1
                        644     LOAD_CONST                      19: <CODE> <listcomp>
                        646     LOAD_CONST                      9: 'Simulation.otherHeatGain.<locals>.<listcomp>'
                        648     MAKE_FUNCTION                   8
                        650     LOAD_GLOBAL                     0: list
                        652     LOAD_DEREF                      0: _var_var_11
                        654     LOAD_ATTR                       51: adj_wall_zone
                        656     LOAD_METHOD                     2: items
                        658     CALL_METHOD                     0
                        660     CALL_FUNCTION                   1
                        662     GET_ITER                        
                        664     CALL_FUNCTION                   1
                        666     CALL_FUNCTION                   1
                        668     LOAD_DEREF                      0: _var_var_11
                        670     LOAD_ATTR                       12: Af
                        672     BINARY_TRUE_DIVIDE              
                        674     LOAD_GLOBAL                     5: sum
                        676     LOAD_CLOSURE                    0: _var_var_11
                        678     BUILD_TUPLE                     1
                        680     LOAD_CONST                      20: <CODE> <listcomp>
                        682     LOAD_CONST                      9: 'Simulation.otherHeatGain.<locals>.<listcomp>'
                        684     MAKE_FUNCTION                   8
                        686     LOAD_GLOBAL                     0: list
                        688     LOAD_DEREF                      0: _var_var_11
                        690     LOAD_ATTR                       52: adj_ceiling_zone
                        692     LOAD_METHOD                     2: items
                        694     CALL_METHOD                     0
                        696     CALL_FUNCTION                   1
                        698     GET_ITER                        
                        700     CALL_FUNCTION                   1
                        702     CALL_FUNCTION                   1
                        704     LOAD_DEREF                      0: _var_var_11
                        706     LOAD_ATTR                       12: Af
                        708     BINARY_TRUE_DIVIDE              
                        710     BINARY_ADD                      
                        712     LOAD_DEREF                      0: _var_var_11
                        714     STORE_ATTR                      53: Htr_iw
                        716     LOAD_CONST                      5: 0
                        718     LOAD_DEREF                      0: _var_var_11
                        720     STORE_ATTR                      54: Htr_if
                        722     LOAD_GLOBAL                     0: list
                        724     LOAD_DEREF                      0: _var_var_11
                        726     LOAD_ATTR                       55: adj_floor_zone
                        728     LOAD_METHOD                     2: items
                        730     CALL_METHOD                     0
                        732     CALL_FUNCTION                   1
                        734     GET_ITER                        
                        736     FOR_ITER                        62 (to 800)
                        738     UNPACK_SEQUENCE                 2
                        740     STORE_FAST                      4: _var_var_23
                        742     STORE_FAST                      5: _var_var_24
                        744     LOAD_FAST                       4: _var_var_23
                        746     LOAD_CONST                      21: 'ground'
                        748     COMPARE_OP                      2 (==)
                        750     POP_JUMP_IF_FALSE               776
                        754     LOAD_DEREF                      0: _var_var_11
                        756     DUP_TOP                         
                        758     LOAD_ATTR                       54: Htr_if
                        760     LOAD_FAST                       0: self
                        762     LOAD_ATTR                       50: Htr_gr
                        764     LOAD_FAST                       5: _var_var_24
                        766     BINARY_MULTIPLY                 
                        768     INPLACE_ADD                     
                        770     ROT_TWO                         
                        772     STORE_ATTR                      54: Htr_if
                        774     JUMP_FORWARD                    20 (to 796)
                        776     LOAD_DEREF                      0: _var_var_11
                        778     DUP_TOP                         
                        780     LOAD_ATTR                       54: Htr_if
                        782     LOAD_DEREF                      0: _var_var_11
                        784     LOAD_ATTR                       56: U_if
                        786     LOAD_FAST                       5: _var_var_24
                        788     BINARY_MULTIPLY                 
                        790     INPLACE_ADD                     
                        792     ROT_TWO                         
                        794     STORE_ATTR                      54: Htr_if
                        796     JUMP_ABSOLUTE                   736
                        800     LOAD_DEREF                      0: _var_var_11
                        802     LOAD_ATTR                       54: Htr_if
                        804     LOAD_DEREF                      0: _var_var_11
                        806     LOAD_ATTR                       12: Af
                        808     BINARY_TRUE_DIVIDE              
                        810     LOAD_DEREF                      0: _var_var_11
                        812     STORE_ATTR                      54: Htr_if
                        814     JUMP_ABSOLUTE                   630
                        818     LOAD_GLOBAL                     57: copy
                        820     LOAD_METHOD                     58: deepcopy
                        822     LOAD_FAST                       0: self
                        824     LOAD_ATTR                       59: wea_dict
                        826     LOAD_CONST                      22: 'month'
                        828     BINARY_SUBSCR                   
                        830     CALL_METHOD                     1
                        832     LOAD_METHOD                     60: astype
                        834     LOAD_GLOBAL                     61: np
                        836     LOAD_ATTR                       62: float64
                        838     CALL_METHOD                     1
                        840     STORE_FAST                      6: _var_var_25
                        842     LOAD_GLOBAL                     63: range
                        844     LOAD_GLOBAL                     64: len
                        846     LOAD_FAST                       6: _var_var_25
                        848     CALL_FUNCTION                   1
                        850     CALL_FUNCTION                   1
                        852     GET_ITER                        
                        854     FOR_ITER                        34 (to 890)
                        856     STORE_FAST                      7: _var_var_26
                        858     LOAD_FAST                       0: self
                        860     LOAD_ATTR                       48: General
                        862     LOAD_ATTR                       65: ground_temperature
                        864     LOAD_GLOBAL                     66: int
                        866     LOAD_FAST                       6: _var_var_25
                        868     LOAD_FAST                       7: _var_var_26
                        870     BINARY_SUBSCR                   
                        872     CALL_FUNCTION                   1
                        874     LOAD_CONST                      12: 1
                        876     BINARY_SUBTRACT                 
                        878     BINARY_SUBSCR                   
                        880     LOAD_FAST                       6: _var_var_25
                        882     LOAD_FAST                       7: _var_var_26
                        884     STORE_SUBSCR                    
                        886     JUMP_ABSOLUTE                   854
                        890     LOAD_GLOBAL                     61: np
                        892     LOAD_METHOD                     67: array
                        894     LOAD_FAST                       6: _var_var_25
                        896     CALL_METHOD                     1
                        898     LOAD_FAST                       0: self
                        900     STORE_ATTR                      68: T_gr
                        902     POP_BLOCK                       
                        904     LOAD_CONST                      23: '__pyarmor_exit_47093__'
                        906     NOP                             
                        908     NOP                             
                        910     LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14t\x03\x00\x00\x00\x00\x00\x00'
                        912     CALL_FUNCTION                   1
                        914     POP_TOP                         
                        916     JUMP_FORWARD                    14 (to 932)
                        918     LOAD_CONST                      23: '__pyarmor_exit_47093__'
                        920     NOP                             
                        922     NOP                             
                        924     LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14t\x03\x00\x00\x00\x00\x00\x00'
                        926     CALL_FUNCTION                   1
                        928     POP_TOP                         
                        930     RERAISE                         
                        932     LOAD_CONST                      0: None
                        934     RETURN_VALUE                    
                'Simulation.otherHeatGain'
                [Code]
                    File Name: <frozen simulation>
                    Object Name: beforeIterate
                    Arg Count: 1
                    Pos Only Arg Count: 0
                    KW Only Arg Count: 0
                    Locals: 4
                    Stack Size: 8
                    Flags: 0x20000043 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NOFREE | CO_PYARMOR_OBFUSCATED)
                    [Names]
                        'list'
                        'pre_dict'
                        'items'
                        'T_m_t_hc'
                        'T_m_t_1_hc'
                        'T_m_t_1_un'
                        'T_m_t_1_0'
                    [Var Names]
                        'self'
                        '__assert_armored__'
                        '_var_var_12'
                        '_var_var_11'
                    [Free Vars]
                    [Cell Vars]
                    [Constants]
                        None
                        '__pyarmor_assert_47094__'
                        'Simulation.beforeIterate.<locals>.<lambda>'
                        '__pyarmor_enter_47095__'
                        b'<COAddr>\x01\x00\x00\x148\x00\x00\x00\x00\x00\x00\x00'
                        'Zones'
                        '__pyarmor_exit_47096__'
                    [Disassembly]
                        0       NOP                             
                        2       NOP                             
                        4       NOP                             
                        6       NOP                             
                        8       LOAD_CONST                      3: '__pyarmor_enter_47095__'
                        10      NOP                             
                        12      NOP                             
                        14      LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x148\x00\x00\x00\x00\x00\x00\x00'
                        16      CALL_FUNCTION                   1
                        18      POP_TOP                         
                        20      SETUP_FINALLY                   68 (to 90)
                        22      LOAD_GLOBAL                     0: list
                        24      LOAD_FAST                       0: self
                        26      LOAD_ATTR                       1: pre_dict
                        28      LOAD_CONST                      5: 'Zones'
                        30      BINARY_SUBSCR                   
                        32      LOAD_METHOD                     2: items
                        34      CALL_METHOD                     0
                        36      CALL_FUNCTION                   1
                        38      GET_ITER                        
                        40      FOR_ITER                        32 (to 74)
                        42      UNPACK_SEQUENCE                 2
                        44      STORE_FAST                      2: _var_var_12
                        46      STORE_FAST                      3: _var_var_11
                        48      LOAD_FAST                       3: _var_var_11
                        50      LOAD_ATTR                       3: T_m_t_hc
                        52      LOAD_FAST                       3: _var_var_11
                        54      STORE_ATTR                      4: T_m_t_1_hc
                        56      LOAD_FAST                       3: _var_var_11
                        58      LOAD_ATTR                       3: T_m_t_hc
                        60      LOAD_FAST                       3: _var_var_11
                        62      STORE_ATTR                      5: T_m_t_1_un
                        64      LOAD_FAST                       3: _var_var_11
                        66      LOAD_ATTR                       3: T_m_t_hc
                        68      LOAD_FAST                       3: _var_var_11
                        70      STORE_ATTR                      6: T_m_t_1_0
                        72      JUMP_ABSOLUTE                   40
                        74      POP_BLOCK                       
                        76      LOAD_CONST                      6: '__pyarmor_exit_47096__'
                        78      NOP                             
                        80      NOP                             
                        82      LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x148\x00\x00\x00\x00\x00\x00\x00'
                        84      CALL_FUNCTION                   1
                        86      POP_TOP                         
                        88      JUMP_FORWARD                    14 (to 104)
                        90      LOAD_CONST                      6: '__pyarmor_exit_47096__'
                        92      NOP                             
                        94      NOP                             
                        96      LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x148\x00\x00\x00\x00\x00\x00\x00'
                        98      CALL_FUNCTION                   1
                        100     POP_TOP                         
                        102     RERAISE                         
                        104     LOAD_CONST                      0: None
                        106     RETURN_VALUE                    
                'Simulation.beforeIterate'
                [Code]
                    File Name: <frozen simulation>
                    Object Name: initiate
                    Arg Count: 1
                    Pos Only Arg Count: 0
                    KW Only Arg Count: 0
                    Locals: 4
                    Stack Size: 8
                    Flags: 0x20000043 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NOFREE | CO_PYARMOR_OBFUSCATED)
                    [Names]
                        'hasattr'
                        'if_print'
                        'print'
                        'list'
                        'pre_dict'
                        'items'
                        'np'
                        'zeros'
                        'len'
                        'Te'
                        'T_m_t_hc'
                        'T_set_H'
                        'T_m_t_1_hc'
                        'T_m_t_0'
                        'T_m_t_1_0'
                        'T_m_t_un'
                        'T_m_t_1_un'
                        'q_m_tot_0'
                        'q_m_tot_un'
                        'q_m_tot_hc'
                        'q_a_tot_0'
                        'q_a_tot_un'
                        'q_a_tot_hc'
                        'T_op_0'
                        'T_op_un'
                        'T_op_hc'
                        'T_m_hc'
                        'T_m_0'
                        'T_m_un'
                        'T_s_hc'
                        'T_s_0'
                        'T_s_un'
                        'T_air_hc'
                        'T_air_set'
                        'T_air_un'
                        'free_float_T'
                        'Hve'
                        'H1'
                        'H2'
                        'H3'
                        'qv_stack'
                        'qv_infred'
                        'qv_inf'
                        'qv_wind'
                        'qv_sw'
                        'V'
                        'Ywind'
                        'Ytemp'
                        'Ropw'
                        'qv_airing'
                        'NV_hrs'
                        'qv_NV'
                        'qv_NV_calc'
                        'qv_tot'
                        'inf_ACH'
                        'mech_ACH'
                        'NV_ACH'
                        'q_es'
                        'q_em'
                        'T_es'
                        'T_em'
                        'q_hc'
                        'q_C_nd'
                        'q_H_nd'
                        'q_NV_ac'
                        'T_supp'
                        'q_inf'
                        'q_NV'
                    [Var Names]
                        'self'
                        '__assert_armored__'
                        '_var_var_12'
                        '_var_var_11'
                    [Free Vars]
                    [Cell Vars]
                    [Constants]
                        None
                        '__pyarmor_assert_47097__'
                        'Simulation.initiate.<locals>.<lambda>'
                        '__pyarmor_enter_47098__'
                        b'<COAddr>\x01\x00\x00\x14\xf4\x04\x00\x00\x00\x00\x00\x00'
                        'if_print'
                        True
                        'Initiating simulation...'
                        'Zones'
                        1
                        0
                        '__pyarmor_exit_47099__'
                    [Disassembly]
                        0       NOP                             
                        2       NOP                             
                        4       NOP                             
                        6       NOP                             
                        8       LOAD_CONST                      3: '__pyarmor_enter_47098__'
                        10      NOP                             
                        12      NOP                             
                        14      LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14\xf4\x04\x00\x00\x00\x00\x00\x00'
                        16      CALL_FUNCTION                   1
                        18      POP_TOP                         
                        20      SETUP_FINALLY                   1278 (to 1302)
                        24      LOAD_GLOBAL                     0: hasattr
                        26      LOAD_FAST                       0: self
                        28      LOAD_CONST                      5: 'if_print'
                        30      CALL_FUNCTION                   2
                        32      POP_JUMP_IF_FALSE               52
                        34      LOAD_FAST                       0: self
                        36      LOAD_ATTR                       1: if_print
                        38      LOAD_CONST                      6: True
                        40      COMPARE_OP                      2 (==)
                        42      POP_JUMP_IF_FALSE               52
                        44      LOAD_GLOBAL                     2: print
                        46      LOAD_CONST                      7: 'Initiating simulation...'
                        48      CALL_FUNCTION                   1
                        50      POP_TOP                         
                        52      LOAD_GLOBAL                     3: list
                        54      LOAD_FAST                       0: self
                        56      LOAD_ATTR                       4: pre_dict
                        58      LOAD_CONST                      8: 'Zones'
                        60      BINARY_SUBSCR                   
                        62      LOAD_METHOD                     5: items
                        64      CALL_METHOD                     0
                        66      CALL_FUNCTION                   1
                        68      GET_ITER                        
                        70      FOR_ITER                        1212 (to 1286)
                        74      UNPACK_SEQUENCE                 2
                        76      STORE_FAST                      2: _var_var_12
                        78      STORE_FAST                      3: _var_var_11
                        80      LOAD_GLOBAL                     6: np
                        82      LOAD_METHOD                     7: zeros
                        84      LOAD_GLOBAL                     8: len
                        86      LOAD_FAST                       0: self
                        88      LOAD_ATTR                       9: Te
                        90      CALL_FUNCTION                   1
                        92      LOAD_CONST                      9: 1
                        94      BINARY_ADD                      
                        96      CALL_METHOD                     1
                        98      LOAD_FAST                       3: _var_var_11
                        100     STORE_ATTR                      10: T_m_t_hc
                        102     LOAD_FAST                       3: _var_var_11
                        104     LOAD_ATTR                       11: T_set_H
                        106     LOAD_CONST                      10: 0
                        108     BINARY_SUBSCR                   
                        110     LOAD_FAST                       3: _var_var_11
                        112     LOAD_ATTR                       10: T_m_t_hc
                        114     LOAD_CONST                      10: 0
                        116     STORE_SUBSCR                    
                        118     LOAD_GLOBAL                     6: np
                        120     LOAD_METHOD                     7: zeros
                        122     LOAD_GLOBAL                     8: len
                        124     LOAD_FAST                       0: self
                        126     LOAD_ATTR                       9: Te
                        128     CALL_FUNCTION                   1
                        130     CALL_METHOD                     1
                        132     LOAD_FAST                       3: _var_var_11
                        134     STORE_ATTR                      12: T_m_t_1_hc
                        136     LOAD_GLOBAL                     6: np
                        138     LOAD_METHOD                     7: zeros
                        140     LOAD_GLOBAL                     8: len
                        142     LOAD_FAST                       0: self
                        144     LOAD_ATTR                       9: Te
                        146     CALL_FUNCTION                   1
                        148     LOAD_CONST                      9: 1
                        150     BINARY_ADD                      
                        152     CALL_METHOD                     1
                        154     LOAD_FAST                       3: _var_var_11
                        156     STORE_ATTR                      13: T_m_t_0
                        158     LOAD_FAST                       3: _var_var_11
                        160     LOAD_ATTR                       11: T_set_H
                        162     LOAD_CONST                      10: 0
                        164     BINARY_SUBSCR                   
                        166     LOAD_FAST                       3: _var_var_11
                        168     LOAD_ATTR                       13: T_m_t_0
                        170     LOAD_CONST                      10: 0
                        172     STORE_SUBSCR                    
                        174     LOAD_GLOBAL                     6: np
                        176     LOAD_METHOD                     7: zeros
                        178     LOAD_GLOBAL                     8: len
                        180     LOAD_FAST                       0: self
                        182     LOAD_ATTR                       9: Te
                        184     CALL_FUNCTION                   1
                        186     CALL_METHOD                     1
                        188     LOAD_FAST                       3: _var_var_11
                        190     STORE_ATTR                      14: T_m_t_1_0
                        192     LOAD_GLOBAL                     6: np
                        194     LOAD_METHOD                     7: zeros
                        196     LOAD_GLOBAL                     8: len
                        198     LOAD_FAST                       0: self
                        200     LOAD_ATTR                       9: Te
                        202     CALL_FUNCTION                   1
                        204     LOAD_CONST                      9: 1
                        206     BINARY_ADD                      
                        208     CALL_METHOD                     1
                        210     LOAD_FAST                       3: _var_var_11
                        212     STORE_ATTR                      15: T_m_t_un
                        214     LOAD_FAST                       3: _var_var_11
                        216     LOAD_ATTR                       11: T_set_H
                        218     LOAD_CONST                      10: 0
                        220     BINARY_SUBSCR                   
                        222     LOAD_FAST                       3: _var_var_11
                        224     LOAD_ATTR                       15: T_m_t_un
                        226     LOAD_CONST                      10: 0
                        228     STORE_SUBSCR                    
                        230     LOAD_GLOBAL                     6: np
                        232     LOAD_METHOD                     7: zeros
                        234     LOAD_GLOBAL                     8: len
                        236     LOAD_FAST                       0: self
                        238     LOAD_ATTR                       9: Te
                        240     CALL_FUNCTION                   1
                        242     CALL_METHOD                     1
                        244     LOAD_FAST                       3: _var_var_11
                        246     STORE_ATTR                      16: T_m_t_1_un
                        248     LOAD_GLOBAL                     6: np
                        250     LOAD_METHOD                     7: zeros
                        252     LOAD_GLOBAL                     8: len
                        254     LOAD_FAST                       0: self
                        256     LOAD_ATTR                       9: Te
                        258     CALL_FUNCTION                   1
                        260     CALL_METHOD                     1
                        262     LOAD_FAST                       3: _var_var_11
                        264     STORE_ATTR                      17: q_m_tot_0
                        266     LOAD_GLOBAL                     6: np
                        268     LOAD_METHOD                     7: zeros
                        270     LOAD_GLOBAL                     8: len
                        272     LOAD_FAST                       0: self
                        274     LOAD_ATTR                       9: Te
                        276     CALL_FUNCTION                   1
                        278     CALL_METHOD                     1
                        280     LOAD_FAST                       3: _var_var_11
                        282     STORE_ATTR                      18: q_m_tot_un
                        284     LOAD_GLOBAL                     6: np
                        286     LOAD_METHOD                     7: zeros
                        288     LOAD_GLOBAL                     8: len
                        290     LOAD_FAST                       0: self
                        292     LOAD_ATTR                       9: Te
                        294     CALL_FUNCTION                   1
                        296     CALL_METHOD                     1
                        298     LOAD_FAST                       3: _var_var_11
                        300     STORE_ATTR                      19: q_m_tot_hc
                        302     LOAD_GLOBAL                     6: np
                        304     LOAD_METHOD                     7: zeros
                        306     LOAD_GLOBAL                     8: len
                        308     LOAD_FAST                       0: self
                        310     LOAD_ATTR                       9: Te
                        312     CALL_FUNCTION                   1
                        314     CALL_METHOD                     1
                        316     LOAD_FAST                       3: _var_var_11
                        318     STORE_ATTR                      20: q_a_tot_0
                        320     LOAD_GLOBAL                     6: np
                        322     LOAD_METHOD                     7: zeros
                        324     LOAD_GLOBAL                     8: len
                        326     LOAD_FAST                       0: self
                        328     LOAD_ATTR                       9: Te
                        330     CALL_FUNCTION                   1
                        332     CALL_METHOD                     1
                        334     LOAD_FAST                       3: _var_var_11
                        336     STORE_ATTR                      21: q_a_tot_un
                        338     LOAD_GLOBAL                     6: np
                        340     LOAD_METHOD                     7: zeros
                        342     LOAD_GLOBAL                     8: len
                        344     LOAD_FAST                       0: self
                        346     LOAD_ATTR                       9: Te
                        348     CALL_FUNCTION                   1
                        350     CALL_METHOD                     1
                        352     LOAD_FAST                       3: _var_var_11
                        354     STORE_ATTR                      22: q_a_tot_hc
                        356     LOAD_GLOBAL                     6: np
                        358     LOAD_METHOD                     7: zeros
                        360     LOAD_GLOBAL                     8: len
                        362     LOAD_FAST                       0: self
                        364     LOAD_ATTR                       9: Te
                        366     CALL_FUNCTION                   1
                        368     CALL_METHOD                     1
                        370     LOAD_FAST                       3: _var_var_11
                        372     STORE_ATTR                      23: T_op_0
                        374     LOAD_GLOBAL                     6: np
                        376     LOAD_METHOD                     7: zeros
                        378     LOAD_GLOBAL                     8: len
                        380     LOAD_FAST                       0: self
                        382     LOAD_ATTR                       9: Te
                        384     CALL_FUNCTION                   1
                        386     CALL_METHOD                     1
                        388     LOAD_FAST                       3: _var_var_11
                        390     STORE_ATTR                      24: T_op_un
                        392     LOAD_GLOBAL                     6: np
                        394     LOAD_METHOD                     7: zeros
                        396     LOAD_GLOBAL                     8: len
                        398     LOAD_FAST                       0: self
                        400     LOAD_ATTR                       9: Te
                        402     CALL_FUNCTION                   1
                        404     CALL_METHOD                     1
                        406     LOAD_FAST                       3: _var_var_11
                        408     STORE_ATTR                      25: T_op_hc
                        410     LOAD_GLOBAL                     6: np
                        412     LOAD_METHOD                     7: zeros
                        414     LOAD_GLOBAL                     8: len
                        416     LOAD_FAST                       0: self
                        418     LOAD_ATTR                       9: Te
                        420     CALL_FUNCTION                   1
                        422     LOAD_CONST                      9: 1
                        424     BINARY_ADD                      
                        426     CALL_METHOD                     1
                        428     LOAD_FAST                       3: _var_var_11
                        430     STORE_ATTR                      26: T_m_hc
                        432     LOAD_GLOBAL                     6: np
                        434     LOAD_METHOD                     7: zeros
                        436     LOAD_GLOBAL                     8: len
                        438     LOAD_FAST                       0: self
                        440     LOAD_ATTR                       9: Te
                        442     CALL_FUNCTION                   1
                        444     LOAD_CONST                      9: 1
                        446     BINARY_ADD                      
                        448     CALL_METHOD                     1
                        450     LOAD_FAST                       3: _var_var_11
                        452     STORE_ATTR                      27: T_m_0
                        454     LOAD_GLOBAL                     6: np
                        456     LOAD_METHOD                     7: zeros
                        458     LOAD_GLOBAL                     8: len
                        460     LOAD_FAST                       0: self
                        462     LOAD_ATTR                       9: Te
                        464     CALL_FUNCTION                   1
                        466     LOAD_CONST                      9: 1
                        468     BINARY_ADD                      
                        470     CALL_METHOD                     1
                        472     LOAD_FAST                       3: _var_var_11
                        474     STORE_ATTR                      28: T_m_un
                        476     LOAD_GLOBAL                     6: np
                        478     LOAD_METHOD                     7: zeros
                        480     LOAD_GLOBAL                     8: len
                        482     LOAD_FAST                       0: self
                        484     LOAD_ATTR                       9: Te
                        486     CALL_FUNCTION                   1
                        488     LOAD_CONST                      9: 1
                        490     BINARY_ADD                      
                        492     CALL_METHOD                     1
                        494     LOAD_FAST                       3: _var_var_11
                        496     STORE_ATTR                      29: T_s_hc
                        498     LOAD_GLOBAL                     6: np
                        500     LOAD_METHOD                     7: zeros
                        502     LOAD_GLOBAL                     8: len
                        504     LOAD_FAST                       0: self
                        506     LOAD_ATTR                       9: Te
                        508     CALL_FUNCTION                   1
                        510     LOAD_CONST                      9: 1
                        512     BINARY_ADD                      
                        514     CALL_METHOD                     1
                        516     LOAD_FAST                       3: _var_var_11
                        518     STORE_ATTR                      30: T_s_0
                        520     LOAD_GLOBAL                     6: np
                        522     LOAD_METHOD                     7: zeros
                        524     LOAD_GLOBAL                     8: len
                        526     LOAD_FAST                       0: self
                        528     LOAD_ATTR                       9: Te
                        530     CALL_FUNCTION                   1
                        532     LOAD_CONST                      9: 1
                        534     BINARY_ADD                      
                        536     CALL_METHOD                     1
                        538     LOAD_FAST                       3: _var_var_11
                        540     STORE_ATTR                      31: T_s_un
                        542     LOAD_GLOBAL                     6: np
                        544     LOAD_METHOD                     7: zeros
                        546     LOAD_GLOBAL                     8: len
                        548     LOAD_FAST                       0: self
                        550     LOAD_ATTR                       9: Te
                        552     CALL_FUNCTION                   1
                        554     LOAD_CONST                      9: 1
                        556     BINARY_ADD                      
                        558     CALL_METHOD                     1
                        560     LOAD_FAST                       3: _var_var_11
                        562     STORE_ATTR                      32: T_air_hc
                        564     LOAD_FAST                       3: _var_var_11
                        566     LOAD_ATTR                       11: T_set_H
                        568     LOAD_CONST                      10: 0
                        570     BINARY_SUBSCR                   
                        572     LOAD_FAST                       3: _var_var_11
                        574     LOAD_ATTR                       32: T_air_hc
                        576     LOAD_CONST                      10: 0
                        578     STORE_SUBSCR                    
                        580     LOAD_GLOBAL                     6: np
                        582     LOAD_METHOD                     7: zeros
                        584     LOAD_GLOBAL                     8: len
                        586     LOAD_FAST                       0: self
                        588     LOAD_ATTR                       9: Te
                        590     CALL_FUNCTION                   1
                        592     LOAD_CONST                      9: 1
                        594     BINARY_ADD                      
                        596     CALL_METHOD                     1
                        598     LOAD_FAST                       3: _var_var_11
                        600     STORE_ATTR                      33: T_air_set
                        602     LOAD_FAST                       3: _var_var_11
                        604     LOAD_ATTR                       11: T_set_H
                        606     LOAD_CONST                      10: 0
                        608     BINARY_SUBSCR                   
                        610     LOAD_FAST                       3: _var_var_11
                        612     LOAD_ATTR                       33: T_air_set
                        614     LOAD_CONST                      10: 0
                        616     STORE_SUBSCR                    
                        618     LOAD_GLOBAL                     6: np
                        620     LOAD_METHOD                     7: zeros
                        622     LOAD_GLOBAL                     8: len
                        624     LOAD_FAST                       0: self
                        626     LOAD_ATTR                       9: Te
                        628     CALL_FUNCTION                   1
                        630     LOAD_CONST                      9: 1
                        632     BINARY_ADD                      
                        634     CALL_METHOD                     1
                        636     LOAD_FAST                       3: _var_var_11
                        638     STORE_ATTR                      34: T_air_un
                        640     LOAD_FAST                       3: _var_var_11
                        642     LOAD_ATTR                       11: T_set_H
                        644     LOAD_CONST                      10: 0
                        646     BINARY_SUBSCR                   
                        648     LOAD_FAST                       3: _var_var_11
                        650     LOAD_ATTR                       34: T_air_un
                        652     LOAD_CONST                      10: 0
                        654     STORE_SUBSCR                    
                        656     LOAD_GLOBAL                     6: np
                        658     LOAD_METHOD                     7: zeros
                        660     LOAD_GLOBAL                     8: len
                        662     LOAD_FAST                       0: self
                        664     LOAD_ATTR                       9: Te
                        666     CALL_FUNCTION                   1
                        668     LOAD_CONST                      9: 1
                        670     BINARY_ADD                      
                        672     CALL_METHOD                     1
                        674     LOAD_FAST                       3: _var_var_11
                        676     STORE_ATTR                      35: free_float_T
                        678     LOAD_FAST                       3: _var_var_11
                        680     LOAD_ATTR                       11: T_set_H
                        682     LOAD_CONST                      10: 0
                        684     BINARY_SUBSCR                   
                        686     LOAD_FAST                       3: _var_var_11
                        688     LOAD_ATTR                       35: free_float_T
                        690     LOAD_CONST                      10: 0
                        692     STORE_SUBSCR                    
                        694     LOAD_GLOBAL                     6: np
                        696     LOAD_METHOD                     7: zeros
                        698     LOAD_GLOBAL                     8: len
                        700     LOAD_FAST                       0: self
                        702     LOAD_ATTR                       9: Te
                        704     CALL_FUNCTION                   1
                        706     CALL_METHOD                     1
                        708     LOAD_FAST                       3: _var_var_11
                        710     STORE_ATTR                      36: Hve
                        712     LOAD_GLOBAL                     6: np
                        714     LOAD_METHOD                     7: zeros
                        716     LOAD_GLOBAL                     8: len
                        718     LOAD_FAST                       0: self
                        720     LOAD_ATTR                       9: Te
                        722     CALL_FUNCTION                   1
                        724     CALL_METHOD                     1
                        726     LOAD_FAST                       3: _var_var_11
                        728     STORE_ATTR                      37: H1
                        730     LOAD_GLOBAL                     6: np
                        732     LOAD_METHOD                     7: zeros
                        734     LOAD_GLOBAL                     8: len
                        736     LOAD_FAST                       0: self
                        738     LOAD_ATTR                       9: Te
                        740     CALL_FUNCTION                   1
                        742     CALL_METHOD                     1
                        744     LOAD_FAST                       3: _var_var_11
                        746     STORE_ATTR                      38: H2
                        748     LOAD_GLOBAL                     6: np
                        750     LOAD_METHOD                     7: zeros
                        752     LOAD_GLOBAL                     8: len
                        754     LOAD_FAST                       0: self
                        756     LOAD_ATTR                       9: Te
                        758     CALL_FUNCTION                   1
                        760     CALL_METHOD                     1
                        762     LOAD_FAST                       3: _var_var_11
                        764     STORE_ATTR                      39: H3
                        766     LOAD_GLOBAL                     6: np
                        768     LOAD_METHOD                     7: zeros
                        770     LOAD_GLOBAL                     8: len
                        772     LOAD_FAST                       0: self
                        774     LOAD_ATTR                       9: Te
                        776     CALL_FUNCTION                   1
                        778     CALL_METHOD                     1
                        780     LOAD_FAST                       3: _var_var_11
                        782     STORE_ATTR                      40: qv_stack
                        784     LOAD_GLOBAL                     6: np
                        786     LOAD_METHOD                     7: zeros
                        788     LOAD_GLOBAL                     8: len
                        790     LOAD_FAST                       0: self
                        792     LOAD_ATTR                       9: Te
                        794     CALL_FUNCTION                   1
                        796     CALL_METHOD                     1
                        798     LOAD_FAST                       3: _var_var_11
                        800     STORE_ATTR                      41: qv_infred
                        802     LOAD_GLOBAL                     6: np
                        804     LOAD_METHOD                     7: zeros
                        806     LOAD_GLOBAL                     8: len
                        808     LOAD_FAST                       0: self
                        810     LOAD_ATTR                       9: Te
                        812     CALL_FUNCTION                   1
                        814     CALL_METHOD                     1
                        816     LOAD_FAST                       3: _var_var_11
                        818     STORE_ATTR                      42: qv_inf
                        820     LOAD_GLOBAL                     6: np
                        822     LOAD_METHOD                     7: zeros
                        824     LOAD_GLOBAL                     8: len
                        826     LOAD_FAST                       0: self
                        828     LOAD_ATTR                       9: Te
                        830     CALL_FUNCTION                   1
                        832     CALL_METHOD                     1
                        834     LOAD_FAST                       3: _var_var_11
                        836     STORE_ATTR                      43: qv_wind
                        838     LOAD_GLOBAL                     6: np
                        840     LOAD_METHOD                     7: zeros
                        842     LOAD_GLOBAL                     8: len
                        844     LOAD_FAST                       0: self
                        846     LOAD_ATTR                       9: Te
                        848     CALL_FUNCTION                   1
                        850     CALL_METHOD                     1
                        852     LOAD_FAST                       3: _var_var_11
                        854     STORE_ATTR                      44: qv_sw
                        856     LOAD_GLOBAL                     6: np
                        858     LOAD_METHOD                     7: zeros
                        860     LOAD_GLOBAL                     8: len
                        862     LOAD_FAST                       0: self
                        864     LOAD_ATTR                       9: Te
                        866     CALL_FUNCTION                   1
                        868     CALL_METHOD                     1
                        870     LOAD_FAST                       3: _var_var_11
                        872     STORE_ATTR                      45: V
                        874     LOAD_GLOBAL                     6: np
                        876     LOAD_METHOD                     7: zeros
                        878     LOAD_GLOBAL                     8: len
                        880     LOAD_FAST                       0: self
                        882     LOAD_ATTR                       9: Te
                        884     CALL_FUNCTION                   1
                        886     CALL_METHOD                     1
                        888     LOAD_FAST                       3: _var_var_11
                        890     STORE_ATTR                      46: Ywind
                        892     LOAD_GLOBAL                     6: np
                        894     LOAD_METHOD                     7: zeros
                        896     LOAD_GLOBAL                     8: len
                        898     LOAD_FAST                       0: self
                        900     LOAD_ATTR                       9: Te
                        902     CALL_FUNCTION                   1
                        904     CALL_METHOD                     1
                        906     LOAD_FAST                       3: _var_var_11
                        908     STORE_ATTR                      47: Ytemp
                        910     LOAD_GLOBAL                     6: np
                        912     LOAD_METHOD                     7: zeros
                        914     LOAD_GLOBAL                     8: len
                        916     LOAD_FAST                       0: self
                        918     LOAD_ATTR                       9: Te
                        920     CALL_FUNCTION                   1
                        922     CALL_METHOD                     1
                        924     LOAD_FAST                       3: _var_var_11
                        926     STORE_ATTR                      48: Ropw
                        928     LOAD_GLOBAL                     6: np
                        930     LOAD_METHOD                     7: zeros
                        932     LOAD_GLOBAL                     8: len
                        934     LOAD_FAST                       0: self
                        936     LOAD_ATTR                       9: Te
                        938     CALL_FUNCTION                   1
                        940     CALL_METHOD                     1
                        942     LOAD_FAST                       3: _var_var_11
                        944     STORE_ATTR                      49: qv_airing
                        946     LOAD_GLOBAL                     6: np
                        948     LOAD_METHOD                     7: zeros
                        950     LOAD_GLOBAL                     8: len
                        952     LOAD_FAST                       0: self
                        954     LOAD_ATTR                       9: Te
                        956     CALL_FUNCTION                   1
                        958     CALL_METHOD                     1
                        960     LOAD_FAST                       3: _var_var_11
                        962     STORE_ATTR                      50: NV_hrs
                        964     LOAD_GLOBAL                     6: np
                        966     LOAD_METHOD                     7: zeros
                        968     LOAD_GLOBAL                     8: len
                        970     LOAD_FAST                       0: self
                        972     LOAD_ATTR                       9: Te
                        974     CALL_FUNCTION                   1
                        976     CALL_METHOD                     1
                        978     LOAD_FAST                       3: _var_var_11
                        980     STORE_ATTR                      51: qv_NV
                        982     LOAD_GLOBAL                     6: np
                        984     LOAD_METHOD                     7: zeros
                        986     LOAD_GLOBAL                     8: len
                        988     LOAD_FAST                       0: self
                        990     LOAD_ATTR                       9: Te
                        992     CALL_FUNCTION                   1
                        994     CALL_METHOD                     1
                        996     LOAD_FAST                       3: _var_var_11
                        998     STORE_ATTR                      52: qv_NV_calc
                        1000    LOAD_GLOBAL                     6: np
                        1002    LOAD_METHOD                     7: zeros
                        1004    LOAD_GLOBAL                     8: len
                        1006    LOAD_FAST                       0: self
                        1008    LOAD_ATTR                       9: Te
                        1010    CALL_FUNCTION                   1
                        1012    CALL_METHOD                     1
                        1014    LOAD_FAST                       3: _var_var_11
                        1016    STORE_ATTR                      53: qv_tot
                        1018    LOAD_GLOBAL                     6: np
                        1020    LOAD_METHOD                     7: zeros
                        1022    LOAD_GLOBAL                     8: len
                        1024    LOAD_FAST                       0: self
                        1026    LOAD_ATTR                       9: Te
                        1028    CALL_FUNCTION                   1
                        1030    CALL_METHOD                     1
                        1032    LOAD_FAST                       3: _var_var_11
                        1034    STORE_ATTR                      54: inf_ACH
                        1036    LOAD_GLOBAL                     6: np
                        1038    LOAD_METHOD                     7: zeros
                        1040    LOAD_GLOBAL                     8: len
                        1042    LOAD_FAST                       0: self
                        1044    LOAD_ATTR                       9: Te
                        1046    CALL_FUNCTION                   1
                        1048    CALL_METHOD                     1
                        1050    LOAD_FAST                       3: _var_var_11
                        1052    STORE_ATTR                      55: mech_ACH
                        1054    LOAD_GLOBAL                     6: np
                        1056    LOAD_METHOD                     7: zeros
                        1058    LOAD_GLOBAL                     8: len
                        1060    LOAD_FAST                       0: self
                        1062    LOAD_ATTR                       9: Te
                        1064    CALL_FUNCTION                   1
                        1066    CALL_METHOD                     1
                        1068    LOAD_FAST                       3: _var_var_11
                        1070    STORE_ATTR                      56: NV_ACH
                        1072    LOAD_GLOBAL                     6: np
                        1074    LOAD_METHOD                     7: zeros
                        1076    LOAD_GLOBAL                     8: len
                        1078    LOAD_FAST                       0: self
                        1080    LOAD_ATTR                       9: Te
                        1082    CALL_FUNCTION                   1
                        1084    CALL_METHOD                     1
                        1086    LOAD_FAST                       3: _var_var_11
                        1088    STORE_ATTR                      57: q_es
                        1090    LOAD_GLOBAL                     6: np
                        1092    LOAD_METHOD                     7: zeros
                        1094    LOAD_GLOBAL                     8: len
                        1096    LOAD_FAST                       0: self
                        1098    LOAD_ATTR                       9: Te
                        1100    CALL_FUNCTION                   1
                        1102    CALL_METHOD                     1
                        1104    LOAD_FAST                       3: _var_var_11
                        1106    STORE_ATTR                      58: q_em
                        1108    LOAD_GLOBAL                     6: np
                        1110    LOAD_METHOD                     7: zeros
                        1112    LOAD_GLOBAL                     8: len
                        1114    LOAD_FAST                       0: self
                        1116    LOAD_ATTR                       9: Te
                        1118    CALL_FUNCTION                   1
                        1120    CALL_METHOD                     1
                        1122    LOAD_FAST                       3: _var_var_11
                        1124    STORE_ATTR                      59: T_es
                        1126    LOAD_GLOBAL                     6: np
                        1128    LOAD_METHOD                     7: zeros
                        1130    LOAD_GLOBAL                     8: len
                        1132    LOAD_FAST                       0: self
                        1134    LOAD_ATTR                       9: Te
                        1136    CALL_FUNCTION                   1
                        1138    CALL_METHOD                     1
                        1140    LOAD_FAST                       3: _var_var_11
                        1142    STORE_ATTR                      60: T_em
                        1144    LOAD_GLOBAL                     6: np
                        1146    LOAD_METHOD                     7: zeros
                        1148    LOAD_GLOBAL                     8: len
                        1150    LOAD_FAST                       0: self
                        1152    LOAD_ATTR                       9: Te
                        1154    CALL_FUNCTION                   1
                        1156    CALL_METHOD                     1
                        1158    LOAD_FAST                       3: _var_var_11
                        1160    STORE_ATTR                      61: q_hc
                        1162    LOAD_GLOBAL                     6: np
                        1164    LOAD_METHOD                     7: zeros
                        1166    LOAD_GLOBAL                     8: len
                        1168    LOAD_FAST                       0: self
                        1170    LOAD_ATTR                       9: Te
                        1172    CALL_FUNCTION                   1
                        1174    LOAD_CONST                      9: 1
                        1176    BINARY_ADD                      
                        1178    CALL_METHOD                     1
                        1180    LOAD_FAST                       3: _var_var_11
                        1182    STORE_ATTR                      62: q_C_nd
                        1184    LOAD_CONST                      10: 0
                        1186    LOAD_FAST                       3: _var_var_11
                        1188    LOAD_ATTR                       62: q_C_nd
                        1190    LOAD_CONST                      10: 0
                        1192    STORE_SUBSCR                    
                        1194    LOAD_GLOBAL                     6: np
                        1196    LOAD_METHOD                     7: zeros
                        1198    LOAD_GLOBAL                     8: len
                        1200    LOAD_FAST                       0: self
                        1202    LOAD_ATTR                       9: Te
                        1204    CALL_FUNCTION                   1
                        1206    CALL_METHOD                     1
                        1208    LOAD_FAST                       3: _var_var_11
                        1210    STORE_ATTR                      63: q_H_nd
                        1212    LOAD_GLOBAL                     6: np
                        1214    LOAD_METHOD                     7: zeros
                        1216    LOAD_GLOBAL                     8: len
                        1218    LOAD_FAST                       0: self
                        1220    LOAD_ATTR                       9: Te
                        1222    CALL_FUNCTION                   1
                        1224    CALL_METHOD                     1
                        1226    LOAD_FAST                       3: _var_var_11
                        1228    STORE_ATTR                      64: q_NV_ac
                        1230    LOAD_GLOBAL                     6: np
                        1232    LOAD_METHOD                     7: zeros
                        1234    LOAD_GLOBAL                     8: len
                        1236    LOAD_FAST                       0: self
                        1238    LOAD_ATTR                       9: Te
                        1240    CALL_FUNCTION                   1
                        1242    CALL_METHOD                     1
                        1244    LOAD_FAST                       3: _var_var_11
                        1246    STORE_ATTR                      65: T_supp
                        1248    LOAD_GLOBAL                     6: np
                        1250    LOAD_METHOD                     7: zeros
                        1252    LOAD_GLOBAL                     8: len
                        1254    LOAD_FAST                       0: self
                        1256    LOAD_ATTR                       9: Te
                        1258    CALL_FUNCTION                   1
                        1260    CALL_METHOD                     1
                        1262    LOAD_FAST                       3: _var_var_11
                        1264    STORE_ATTR                      66: q_inf
                        1266    LOAD_GLOBAL                     6: np
                        1268    LOAD_METHOD                     7: zeros
                        1270    LOAD_GLOBAL                     8: len
                        1272    LOAD_FAST                       0: self
                        1274    LOAD_ATTR                       9: Te
                        1276    CALL_FUNCTION                   1
                        1278    CALL_METHOD                     1
                        1280    LOAD_FAST                       3: _var_var_11
                        1282    STORE_ATTR                      67: q_NV
                        1284    JUMP_ABSOLUTE                   70
                        1286    POP_BLOCK                       
                        1288    LOAD_CONST                      11: '__pyarmor_exit_47099__'
                        1290    NOP                             
                        1292    NOP                             
                        1294    LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14\xf4\x04\x00\x00\x00\x00\x00\x00'
                        1296    CALL_FUNCTION                   1
                        1298    POP_TOP                         
                        1300    JUMP_FORWARD                    14 (to 1316)
                        1302    LOAD_CONST                      11: '__pyarmor_exit_47099__'
                        1304    NOP                             
                        1306    NOP                             
                        1308    LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14\xf4\x04\x00\x00\x00\x00\x00\x00'
                        1310    CALL_FUNCTION                   1
                        1312    POP_TOP                         
                        1314    RERAISE                         
                        1316    LOAD_CONST                      0: None
                        1318    RETURN_VALUE                    
                'Simulation.initiate'
                [Code]
                    File Name: <frozen simulation>
                    Object Name: iterate
                    Arg Count: 1
                    Pos Only Arg Count: 0
                    KW Only Arg Count: 0
                    Locals: 67
                    Stack Size: 9
                    Flags: 0x20000003 (CO_OPTIMIZED | CO_NEWLOCALS | CO_PYARMOR_OBFUSCATED)
                    [Names]
                        'len'
                        'Te'
                        'time'
                        'print_progress_bar'
                        'start_time'
                        'solver'
                        'lower'
                        'list'
                        'pre_dict'
                        'items'
                        'ws'
                        'T_gr'
                        'Cm'
                        'order'
                        'Htr_gr'
                        'General'
                        'HVAC_dct'
                        'hasattr'
                        'if_print'
                        'getattr'
                        'adj_wall_zone'
                        'adj_ceiling_zone'
                        'adj_floor_zone'
                        'range'
                        'Q4Pa'
                        'T_air_set'
                        'infiltration_frac'
                        'Ventilation'
                        'flow_rate'
                        'max'
                        'height'
                        'abs'
                        'qv_stack'
                        'dCP'
                        'vsite'
                        'qv_wind'
                        'qv_sw'
                        'qv_diff'
                        'qv_infred'
                        'qv_inf'
                        'ValueError'
                        'vent_type'
                        'V'
                        'Ywind'
                        'Ytemp'
                        'Ropw'
                        'Aow'
                        'Af'
                        'qv_airing'
                        'NV_hrs'
                        'qv_NV'
                        'q_C_nd'
                        'qv_NV_calc'
                        'qv_supp'
                        'qv_tot'
                        'Htr_is'
                        'Htr_w'
                        'Htr_iw'
                        'Htr_ms'
                        'Hve'
                        'H1'
                        'H2'
                        'H3'
                        'q_es'
                        'sum'
                        'Htr_em'
                        'q_em'
                        'q_m'
                        'q_st'
                        'q_ia'
                        'Htr_if'
                        'q_m_tot_0'
                        'T_m_t_1_0'
                        'T_m_t_0'
                        'T_m_0'
                        'T_s_0'
                        'q_a_tot_0'
                        'free_float_T'
                        'Ct'
                        'T_op_0'
                        'T_set_H'
                        'T_set_C'
                        'q_m_tot_un'
                        'T_m_t_1_un'
                        'T_m_t_un'
                        'T_m_un'
                        'T_s_un'
                        'q_a_tot_un'
                        'T_air_un'
                        'T_op_un'
                        'HVAC_frac'
                        'q_hc'
                        'q_m_tot_hc'
                        'T_m_t_1_hc'
                        'T_m_t_hc'
                        'T_m_hc'
                        'T_s_hc'
                        'q_a_tot_hc'
                        'T_air_hc'
                        'T_op_hc'
                        'q_H_nd'
                        'HVAC'
                        'hvac_name'
                        'heat_cap'
                        'cool_cap'
                    [Var Names]
                        'self'
                        '__assert_armored__'
                        '_var_var_35'
                        '_var_var_36'
                        '_var_var_37'
                        '_var_var_38'
                        '_var_var_39'
                        '_var_var_40'
                        '_var_var_41'
                        '_var_var_42'
                        '_var_var_43'
                        '_var_var_44'
                        '_var_var_45'
                        '_var_var_46'
                        '_var_var_12'
                        '_var_var_47'
                        '_var_var_48'
                        '_var_var_49'
                        '_var_var_50'
                        '_var_var_51'
                        '_var_var_52'
                        '_var_var_53'
                        '_var_var_54'
                        '_var_var_55'
                        '_var_var_56'
                        '_var_var_57'
                        '_var_var_58'
                        '_var_var_59'
                        '_var_var_60'
                        '_var_var_61'
                        '_var_var_62'
                        '_var_var_63'
                        '_var_var_64'
                        '_var_var_65'
                        '_var_var_66'
                        '_var_var_67'
                        '_var_var_68'
                        '_var_var_69'
                        '_var_var_70'
                        '_var_var_71'
                        '_var_var_72'
                        '_var_var_73'
                        '_var_var_74'
                        '_var_var_75'
                        '_var_var_76'
                        '_var_var_77'
                        '_var_var_78'
                        '_var_var_79'
                        '_var_var_80'
                        '_var_var_81'
                        '_var_var_82'
                        '_var_var_83'
                        '_var_var_84'
                        '_var_var_85'
                        '_var_var_86'
                        '_var_var_87'
                        '_var_var_88'
                        '_var_var_89'
                        '_var_var_90'
                        '_var_var_91'
                        '_var_var_92'
                        '_var_var_93'
                        '_var_var_94'
                        '_var_var_95'
                        '_var_var_96'
                        '_var_var_97'
                        '_var_var_98'
                    [Free Vars]
                    [Cell Vars]
                        '_var_var_29'
                        '_var_var_30'
                        '_var_var_31'
                        '_var_var_32'
                        '_var_var_26'
                        '_var_var_33'
                        '_var_var_34'
                        'self'
                        '_var_var_11'
                    [Constants]
                        None
                        '__pyarmor_assert_47100__'
                        'Simulation.iterate.<locals>.<lambda>'
                        '__pyarmor_enter_47101__'
                        b'<COAddr>\x01\x00\x00\x14\x96\x0c\x00\x00\x00\x00\x00\x00'
                        'crank-nicholson'
                        [Code]
                            File Name: <frozen simulation>
                            Object Name: _solve
                            Arg Count: 4
                            Pos Only Arg Count: 0
                            KW Only Arg Count: 0
                            Locals: 5
                            Stack Size: 8
                            Flags: 0x20000053 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NESTED | CO_NOFREE | CO_PYARMOR_OBFUSCATED)
                            [Names]
                            [Var Names]
                                'T_prev'
                                'A'
                                'B'
                                'C'
                                '__assert_armored__'
                            [Free Vars]
                            [Cell Vars]
                            [Constants]
                                None
                                '__pyarmor_assert_47103__'
                                'Simulation.iterate.<locals>._solve.<locals>.<lambda>'
                                '__pyarmor_enter_47104__'
                                b'<COAddr>\x01\x00\x00\x14"\x00\x00\x00\x00\x00\x00\x00'
                                0.5
                                '__pyarmor_exit_47105__'
                            [Disassembly]
                                0       NOP                             
                                2       NOP                             
                                4       NOP                             
                                6       NOP                             
                                8       LOAD_CONST                      3: '__pyarmor_enter_47104__'
                                10      NOP                             
                                12      NOP                             
                                14      LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14"\x00\x00\x00\x00\x00\x00\x00'
                                16      CALL_FUNCTION                   1
                                18      POP_TOP                         
                                20      SETUP_FINALLY                   46 (to 68)
                                22      LOAD_FAST                       0: T_prev
                                24      LOAD_FAST                       1: A
                                26      LOAD_CONST                      5: 0.5
                                28      LOAD_FAST                       2: B
                                30      BINARY_MULTIPLY                 
                                32      BINARY_SUBTRACT                 
                                34      BINARY_MULTIPLY                 
                                36      LOAD_FAST                       3: C
                                38      BINARY_ADD                      
                                40      LOAD_FAST                       1: A
                                42      LOAD_CONST                      5: 0.5
                                44      LOAD_FAST                       2: B
                                46      BINARY_MULTIPLY                 
                                48      BINARY_ADD                      
                                50      BINARY_TRUE_DIVIDE              
                                52      POP_BLOCK                       
                                54      LOAD_CONST                      6: '__pyarmor_exit_47105__'
                                56      NOP                             
                                58      NOP                             
                                60      LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14"\x00\x00\x00\x00\x00\x00\x00'
                                62      CALL_FUNCTION                   1
                                64      POP_TOP                         
                                66      RETURN_VALUE                    
                                68      LOAD_CONST                      6: '__pyarmor_exit_47105__'
                                70      NOP                             
                                72      NOP                             
                                74      LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14"\x00\x00\x00\x00\x00\x00\x00'
                                76      CALL_FUNCTION                   1
                                78      POP_TOP                         
                                80      RERAISE                         
                                82      LOAD_CONST                      0: None
                                84      RETURN_VALUE                    
                        'Simulation.iterate.<locals>._solve'
                        'euler'
                        [Code]
                            File Name: <frozen simulation>
                            Object Name: _solve
                            Arg Count: 4
                            Pos Only Arg Count: 0
                            KW Only Arg Count: 0
                            Locals: 5
                            Stack Size: 8
                            Flags: 0x20000053 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NESTED | CO_NOFREE | CO_PYARMOR_OBFUSCATED)
                            [Names]
                            [Var Names]
                                'T_prev'
                                'A'
                                'B'
                                'C'
                                '__assert_armored__'
                            [Free Vars]
                            [Cell Vars]
                            [Constants]
                                None
                                '__pyarmor_assert_47106__'
                                'Simulation.iterate.<locals>._solve.<locals>.<lambda>'
                                '__pyarmor_enter_47107__'
                                b'<COAddr>\x01\x00\x00\x14\x16\x00\x00\x00\x00\x00\x00\x00'
                                '__pyarmor_exit_47108__'
                            [Disassembly]
                                0       NOP                             
                                2       NOP                             
                                4       NOP                             
                                6       NOP                             
                                8       LOAD_CONST                      3: '__pyarmor_enter_47107__'
                                10      NOP                             
                                12      NOP                             
                                14      LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14\x16\x00\x00\x00\x00\x00\x00\x00'
                                16      CALL_FUNCTION                   1
                                18      POP_TOP                         
                                20      SETUP_FINALLY                   34 (to 56)
                                22      LOAD_FAST                       0: T_prev
                                24      LOAD_FAST                       3: C
                                26      LOAD_FAST                       2: B
                                28      LOAD_FAST                       0: T_prev
                                30      BINARY_MULTIPLY                 
                                32      BINARY_SUBTRACT                 
                                34      LOAD_FAST                       1: A
                                36      BINARY_TRUE_DIVIDE              
                                38      BINARY_ADD                      
                                40      POP_BLOCK                       
                                42      LOAD_CONST                      5: '__pyarmor_exit_47108__'
                                44      NOP                             
                                46      NOP                             
                                48      LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14\x16\x00\x00\x00\x00\x00\x00\x00'
                                50      CALL_FUNCTION                   1
                                52      POP_TOP                         
                                54      RETURN_VALUE                    
                                56      LOAD_CONST                      5: '__pyarmor_exit_47108__'
                                58      NOP                             
                                60      NOP                             
                                62      LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14\x16\x00\x00\x00\x00\x00\x00\x00'
                                64      CALL_FUNCTION                   1
                                66      POP_TOP                         
                                68      RERAISE                         
                                70      LOAD_CONST                      0: None
                                72      RETURN_VALUE                    
                        'runge-kutta'
                        [Code]
                            File Name: <frozen simulation>
                            Object Name: _solve
                            Arg Count: 4
                            Pos Only Arg Count: 0
                            KW Only Arg Count: 0
                            Locals: 5
                            Stack Size: 8
                            Flags: 0x20000053 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NESTED | CO_NOFREE | CO_PYARMOR_OBFUSCATED)
                            [Names]
                            [Var Names]
                                'T_prev'
                                'A'
                                'B'
                                'C'
                                '__assert_armored__'
                            [Free Vars]
                            [Cell Vars]
                            [Constants]
                                None
                                '__pyarmor_assert_47109__'
                                'Simulation.iterate.<locals>._solve.<locals>.<lambda>'
                                '__pyarmor_enter_47110__'
                                b'<COAddr>\x01\x00\x00\x14*\x00\x00\x00\x00\x00\x00\x00'
                                2
                                '__pyarmor_exit_47111__'
                            [Disassembly]
                                0       NOP                             
                                2       NOP                             
                                4       NOP                             
                                6       NOP                             
                                8       LOAD_CONST                      3: '__pyarmor_enter_47110__'
                                10      NOP                             
                                12      NOP                             
                                14      LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14*\x00\x00\x00\x00\x00\x00\x00'
                                16      CALL_FUNCTION                   1
                                18      POP_TOP                         
                                20      SETUP_FINALLY                   54 (to 76)
                                22      LOAD_FAST                       0: T_prev
                                24      LOAD_FAST                       3: C
                                26      LOAD_FAST                       2: B
                                28      LOAD_FAST                       0: T_prev
                                30      LOAD_FAST                       3: C
                                32      LOAD_FAST                       2: B
                                34      LOAD_FAST                       0: T_prev
                                36      BINARY_MULTIPLY                 
                                38      BINARY_SUBTRACT                 
                                40      LOAD_FAST                       1: A
                                42      BINARY_TRUE_DIVIDE              
                                44      LOAD_CONST                      5: 2
                                46      BINARY_TRUE_DIVIDE              
                                48      BINARY_ADD                      
                                50      BINARY_MULTIPLY                 
                                52      BINARY_SUBTRACT                 
                                54      LOAD_FAST                       1: A
                                56      BINARY_TRUE_DIVIDE              
                                58      BINARY_ADD                      
                                60      POP_BLOCK                       
                                62      LOAD_CONST                      6: '__pyarmor_exit_47111__'
                                64      NOP                             
                                66      NOP                             
                                68      LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14*\x00\x00\x00\x00\x00\x00\x00'
                                70      CALL_FUNCTION                   1
                                72      POP_TOP                         
                                74      RETURN_VALUE                    
                                76      LOAD_CONST                      6: '__pyarmor_exit_47111__'
                                78      NOP                             
                                80      NOP                             
                                82      LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14*\x00\x00\x00\x00\x00\x00\x00'
                                84      CALL_FUNCTION                   1
                                86      POP_TOP                         
                                88      RERAISE                         
                                90      LOAD_CONST                      0: None
                                92      RETURN_VALUE                    
                        [Code]
                            File Name: <frozen simulation>
                            Object Name: _solve
                            Arg Count: 4
                            Pos Only Arg Count: 0
                            KW Only Arg Count: 0
                            Locals: 5
                            Stack Size: 8
                            Flags: 0x20000053 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NESTED | CO_NOFREE | CO_PYARMOR_OBFUSCATED)
                            [Names]
                            [Var Names]
                                'T_prev'
                                'A'
                                'B'
                                'C'
                                '__assert_armored__'
                            [Free Vars]
                            [Cell Vars]
                            [Constants]
                                None
                                '__pyarmor_assert_47112__'
                                'Simulation.iterate.<locals>._solve.<locals>.<lambda>'
                                '__pyarmor_enter_47113__'
                                b'<COAddr>\x03\x00\x00\x14"\x00\x00\x00\x00\x00\x00\x00'
                                0.5
                                '__pyarmor_exit_47114__'
                            [Disassembly]
                                0       NOP                             
                                2       NOP                             
                                4       NOP                             
                                6       NOP                             
                                8       LOAD_CONST                      3: '__pyarmor_enter_47113__'
                                10      NOP                             
                                12      NOP                             
                                14      LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x14"\x00\x00\x00\x00\x00\x00\x00'
                                16      CALL_FUNCTION                   1
                                18      POP_TOP                         
                                20      SETUP_FINALLY                   46 (to 68)
                                22      LOAD_FAST                       0: T_prev
                                24      LOAD_FAST                       1: A
                                26      LOAD_CONST                      5: 0.5
                                28      LOAD_FAST                       2: B
                                30      BINARY_MULTIPLY                 
                                32      BINARY_SUBTRACT                 
                                34      BINARY_MULTIPLY                 
                                36      LOAD_FAST                       3: C
                                38      BINARY_ADD                      
                                40      LOAD_FAST                       1: A
                                42      LOAD_CONST                      5: 0.5
                                44      LOAD_FAST                       2: B
                                46      BINARY_MULTIPLY                 
                                48      BINARY_ADD                      
                                50      BINARY_TRUE_DIVIDE              
                                52      POP_BLOCK                       
                                54      LOAD_CONST                      6: '__pyarmor_exit_47114__'
                                56      NOP                             
                                58      NOP                             
                                60      LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x14"\x00\x00\x00\x00\x00\x00\x00'
                                62      CALL_FUNCTION                   1
                                64      POP_TOP                         
                                66      RETURN_VALUE                    
                                68      LOAD_CONST                      6: '__pyarmor_exit_47114__'
                                70      NOP                             
                                72      NOP                             
                                74      LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x14"\x00\x00\x00\x00\x00\x00\x00'
                                76      CALL_FUNCTION                   1
                                78      POP_TOP                         
                                80      RERAISE                         
                                82      LOAD_CONST                      0: None
                                84      RETURN_VALUE                    
                        [Code]
                            File Name: <frozen simulation>
                            Object Name: _recalc_hc_node
                            Arg Count: 3
                            Pos Only Arg Count: 0
                            KW Only Arg Count: 0
                            Locals: 7
                            Stack Size: 8
                            Flags: 0x20000013 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NESTED | CO_PYARMOR_OBFUSCATED)
                            [Names]
                                'q_m'
                                'q_em'
                                'H3'
                                'q_st'
                                'q_es'
                                'H1'
                                'q_ia'
                                'q_hc'
                                'Hve'
                                'H2'
                                'q_m_tot_hc'
                                'Htr_em'
                                'Htr_if'
                                'T_m_t_1_hc'
                                'T_m_t_hc'
                                'T_m_hc'
                                'Htr_ms'
                                'Htr_w'
                                'Af'
                                'Htr_iw'
                                'T_s_hc'
                                'Htr_is'
                                'q_a_tot_hc'
                                'T_air_hc'
                                'Ct'
                                'T_op_hc'
                            [Var Names]
                                'zone'
                                'i'
                                'Te_i'
                                '__assert_armored__'
                                '_var_var_99'
                                '_var_var_100'
                                '_var_var_95'
                            [Free Vars]
                                'Cm'
                                '_solve'
                                'order'
                                'self'
                            [Cell Vars]
                            [Constants]
                                None
                                '__pyarmor_assert_47115__'
                                'Simulation.iterate.<locals>._recalc_hc_node.<locals>.<lambda>'
                                '__pyarmor_enter_47116__'
                                b'<COAddr>\x03\x00\x00\x142\x02\x00\x00\x00\x00\x00\x00'
                                1
                                2
                                2
                                0.3
                                0.7
                                '__pyarmor_exit_47117__'
                            [Disassembly]
                                0       NOP                             
                                2       NOP                             
                                4       NOP                             
                                6       NOP                             
                                8       LOAD_CONST                      3: '__pyarmor_enter_47116__'
                                10      NOP                             
                                12      NOP                             
                                14      LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x142\x02\x00\x00\x00\x00\x00\x00'
                                16      CALL_FUNCTION                   1
                                18      POP_TOP                         
                                20      SETUP_FINALLY                   572 (to 596)
                                24      LOAD_FAST                       0: zone
                                26      LOAD_ATTR                       0: q_m
                                28      LOAD_FAST                       1: i
                                30      BINARY_SUBSCR                   
                                32      LOAD_FAST                       0: zone
                                34      LOAD_ATTR                       1: q_em
                                36      LOAD_FAST                       1: i
                                38      BINARY_SUBSCR                   
                                40      BINARY_ADD                      
                                42      LOAD_FAST                       0: zone
                                44      LOAD_ATTR                       2: H3
                                46      LOAD_FAST                       1: i
                                48      BINARY_SUBSCR                   
                                50      LOAD_FAST                       0: zone
                                52      LOAD_ATTR                       3: q_st
                                54      LOAD_FAST                       1: i
                                56      BINARY_SUBSCR                   
                                58      LOAD_FAST                       0: zone
                                60      LOAD_ATTR                       4: q_es
                                62      LOAD_FAST                       1: i
                                64      BINARY_SUBSCR                   
                                66      BINARY_ADD                      
                                68      LOAD_FAST                       0: zone
                                70      LOAD_ATTR                       5: H1
                                72      LOAD_FAST                       1: i
                                74      BINARY_SUBSCR                   
                                76      LOAD_FAST                       0: zone
                                78      LOAD_ATTR                       6: q_ia
                                80      LOAD_FAST                       1: i
                                82      BINARY_SUBSCR                   
                                84      LOAD_FAST                       0: zone
                                86      LOAD_ATTR                       7: q_hc
                                88      LOAD_FAST                       1: i
                                90      BINARY_SUBSCR                   
                                92      BINARY_ADD                      
                                94      LOAD_FAST                       0: zone
                                96      LOAD_ATTR                       8: Hve
                                98      LOAD_FAST                       1: i
                                100     BINARY_SUBSCR                   
                                102     BINARY_TRUE_DIVIDE              
                                104     LOAD_FAST                       2: Te_i
                                106     BINARY_ADD                      
                                108     BINARY_MULTIPLY                 
                                110     BINARY_ADD                      
                                112     BINARY_MULTIPLY                 
                                114     LOAD_FAST                       0: zone
                                116     LOAD_ATTR                       9: H2
                                118     LOAD_FAST                       1: i
                                120     BINARY_SUBSCR                   
                                122     BINARY_TRUE_DIVIDE              
                                124     BINARY_ADD                      
                                126     LOAD_FAST                       0: zone
                                128     LOAD_ATTR                       10: q_m_tot_hc
                                130     LOAD_FAST                       1: i
                                132     STORE_SUBSCR                    
                                134     LOAD_DEREF                      0: Cm
                                136     STORE_FAST                      4: _var_var_99
                                138     LOAD_FAST                       0: zone
                                140     LOAD_ATTR                       2: H3
                                142     LOAD_FAST                       1: i
                                144     BINARY_SUBSCR                   
                                146     LOAD_FAST                       0: zone
                                148     LOAD_ATTR                       11: Htr_em
                                150     BINARY_ADD                      
                                152     LOAD_FAST                       0: zone
                                154     LOAD_ATTR                       12: Htr_if
                                156     BINARY_ADD                      
                                158     STORE_FAST                      5: _var_var_100
                                160     LOAD_DEREF                      1: _solve
                                162     LOAD_FAST                       0: zone
                                164     LOAD_ATTR                       13: T_m_t_1_hc
                                166     LOAD_FAST                       1: i
                                168     BINARY_SUBSCR                   
                                170     LOAD_FAST                       4: _var_var_99
                                172     LOAD_FAST                       5: _var_var_100
                                174     LOAD_FAST                       0: zone
                                176     LOAD_ATTR                       10: q_m_tot_hc
                                178     LOAD_FAST                       1: i
                                180     BINARY_SUBSCR                   
                                182     CALL_FUNCTION                   4
                                184     LOAD_FAST                       0: zone
                                186     LOAD_ATTR                       14: T_m_t_hc
                                188     LOAD_FAST                       1: i
                                190     LOAD_CONST                      5: 1
                                192     BINARY_ADD                      
                                194     STORE_SUBSCR                    
                                196     LOAD_FAST                       0: zone
                                198     LOAD_ATTR                       13: T_m_t_1_hc
                                200     LOAD_FAST                       1: i
                                202     BINARY_SUBSCR                   
                                204     LOAD_FAST                       0: zone
                                206     LOAD_ATTR                       14: T_m_t_hc
                                208     LOAD_FAST                       1: i
                                210     LOAD_CONST                      5: 1
                                212     BINARY_ADD                      
                                214     BINARY_SUBSCR                   
                                216     BINARY_ADD                      
                                218     LOAD_CONST                      6: 2
                                220     BINARY_TRUE_DIVIDE              
                                222     LOAD_FAST                       0: zone
                                224     LOAD_ATTR                       15: T_m_hc
                                226     LOAD_FAST                       1: i
                                228     STORE_SUBSCR                    
                                230     LOAD_FAST                       0: zone
                                232     LOAD_ATTR                       16: Htr_ms
                                234     LOAD_FAST                       0: zone
                                236     LOAD_ATTR                       15: T_m_hc
                                238     LOAD_FAST                       1: i
                                240     BINARY_SUBSCR                   
                                242     BINARY_MULTIPLY                 
                                244     LOAD_FAST                       0: zone
                                246     LOAD_ATTR                       3: q_st
                                248     LOAD_FAST                       1: i
                                250     BINARY_SUBSCR                   
                                252     BINARY_ADD                      
                                254     LOAD_FAST                       0: zone
                                256     LOAD_ATTR                       4: q_es
                                258     LOAD_FAST                       1: i
                                260     BINARY_SUBSCR                   
                                262     BINARY_ADD                      
                                264     LOAD_FAST                       0: zone
                                266     LOAD_ATTR                       5: H1
                                268     LOAD_FAST                       1: i
                                270     BINARY_SUBSCR                   
                                272     LOAD_FAST                       2: Te_i
                                274     LOAD_FAST                       0: zone
                                276     LOAD_ATTR                       6: q_ia
                                278     LOAD_FAST                       1: i
                                280     BINARY_SUBSCR                   
                                282     LOAD_FAST                       0: zone
                                284     LOAD_ATTR                       7: q_hc
                                286     LOAD_FAST                       1: i
                                288     BINARY_SUBSCR                   
                                290     BINARY_ADD                      
                                292     LOAD_FAST                       0: zone
                                294     LOAD_ATTR                       8: Hve
                                296     LOAD_FAST                       1: i
                                298     BINARY_SUBSCR                   
                                300     BINARY_TRUE_DIVIDE              
                                302     BINARY_ADD                      
                                304     BINARY_MULTIPLY                 
                                306     BINARY_ADD                      
                                308     LOAD_FAST                       0: zone
                                310     LOAD_ATTR                       16: Htr_ms
                                312     LOAD_FAST                       0: zone
                                314     LOAD_ATTR                       17: Htr_w
                                316     LOAD_FAST                       0: zone
                                318     LOAD_ATTR                       18: Af
                                320     BINARY_TRUE_DIVIDE              
                                322     BINARY_ADD                      
                                324     LOAD_FAST                       0: zone
                                326     LOAD_ATTR                       5: H1
                                328     LOAD_FAST                       1: i
                                330     BINARY_SUBSCR                   
                                332     BINARY_ADD                      
                                334     LOAD_FAST                       0: zone
                                336     LOAD_ATTR                       19: Htr_iw
                                338     BINARY_ADD                      
                                340     BINARY_TRUE_DIVIDE              
                                342     LOAD_FAST                       0: zone
                                344     LOAD_ATTR                       20: T_s_hc
                                346     LOAD_FAST                       1: i
                                348     STORE_SUBSCR                    
                                350     LOAD_DEREF                      2: order
                                352     LOAD_CONST                      7: 2
                                354     COMPARE_OP                      2 (==)
                                356     POP_JUMP_IF_FALSE               466
                                360     LOAD_FAST                       0: zone
                                362     LOAD_ATTR                       21: Htr_is
                                364     LOAD_FAST                       0: zone
                                366     LOAD_ATTR                       20: T_s_hc
                                368     LOAD_FAST                       1: i
                                370     BINARY_SUBSCR                   
                                372     BINARY_MULTIPLY                 
                                374     LOAD_FAST                       0: zone
                                376     LOAD_ATTR                       8: Hve
                                378     LOAD_FAST                       1: i
                                380     BINARY_SUBSCR                   
                                382     LOAD_FAST                       2: Te_i
                                384     BINARY_MULTIPLY                 
                                386     BINARY_ADD                      
                                388     LOAD_FAST                       0: zone
                                390     LOAD_ATTR                       6: q_ia
                                392     LOAD_FAST                       1: i
                                394     BINARY_SUBSCR                   
                                396     BINARY_ADD                      
                                398     LOAD_FAST                       0: zone
                                400     LOAD_ATTR                       7: q_hc
                                402     LOAD_FAST                       1: i
                                404     BINARY_SUBSCR                   
                                406     BINARY_ADD                      
                                408     STORE_FAST                      6: _var_var_95
                                410     LOAD_FAST                       6: _var_var_95
                                412     LOAD_FAST                       0: zone
                                414     LOAD_ATTR                       22: q_a_tot_hc
                                416     LOAD_FAST                       1: i
                                418     STORE_SUBSCR                    
                                420     LOAD_DEREF                      1: _solve
                                422     LOAD_FAST                       0: zone
                                424     LOAD_ATTR                       23: T_air_hc
                                426     LOAD_FAST                       1: i
                                428     BINARY_SUBSCR                   
                                430     LOAD_DEREF                      3: self
                                432     LOAD_ATTR                       24: Ct
                                434     LOAD_FAST                       0: zone
                                436     LOAD_ATTR                       21: Htr_is
                                438     LOAD_FAST                       0: zone
                                440     LOAD_ATTR                       8: Hve
                                442     LOAD_FAST                       1: i
                                444     BINARY_SUBSCR                   
                                446     BINARY_ADD                      
                                448     LOAD_FAST                       6: _var_var_95
                                450     CALL_FUNCTION                   4
                                452     LOAD_FAST                       0: zone
                                454     LOAD_ATTR                       23: T_air_hc
                                456     LOAD_FAST                       1: i
                                458     LOAD_CONST                      5: 1
                                460     BINARY_ADD                      
                                462     STORE_SUBSCR                    
                                464     JUMP_FORWARD                    76 (to 542)
                                466     LOAD_FAST                       0: zone
                                468     LOAD_ATTR                       21: Htr_is
                                470     LOAD_FAST                       0: zone
                                472     LOAD_ATTR                       20: T_s_hc
                                474     LOAD_FAST                       1: i
                                476     BINARY_SUBSCR                   
                                478     BINARY_MULTIPLY                 
                                480     LOAD_FAST                       0: zone
                                482     LOAD_ATTR                       8: Hve
                                484     LOAD_FAST                       1: i
                                486     BINARY_SUBSCR                   
                                488     LOAD_FAST                       2: Te_i
                                490     BINARY_MULTIPLY                 
                                492     BINARY_ADD                      
                                494     LOAD_FAST                       0: zone
                                496     LOAD_ATTR                       6: q_ia
                                498     LOAD_FAST                       1: i
                                500     BINARY_SUBSCR                   
                                502     BINARY_ADD                      
                                504     LOAD_FAST                       0: zone
                                506     LOAD_ATTR                       7: q_hc
                                508     LOAD_FAST                       1: i
                                510     BINARY_SUBSCR                   
                                512     BINARY_ADD                      
                                514     LOAD_FAST                       0: zone
                                516     LOAD_ATTR                       21: Htr_is
                                518     LOAD_FAST                       0: zone
                                520     LOAD_ATTR                       8: Hve
                                522     LOAD_FAST                       1: i
                                524     BINARY_SUBSCR                   
                                526     BINARY_ADD                      
                                528     BINARY_TRUE_DIVIDE              
                                530     LOAD_FAST                       0: zone
                                532     LOAD_ATTR                       23: T_air_hc
                                534     LOAD_FAST                       1: i
                                536     LOAD_CONST                      5: 1
                                538     BINARY_ADD                      
                                540     STORE_SUBSCR                    
                                542     LOAD_CONST                      8: 0.3
                                544     LOAD_FAST                       0: zone
                                546     LOAD_ATTR                       23: T_air_hc
                                548     LOAD_FAST                       1: i
                                550     LOAD_CONST                      5: 1
                                552     BINARY_ADD                      
                                554     BINARY_SUBSCR                   
                                556     BINARY_MULTIPLY                 
                                558     LOAD_CONST                      9: 0.7
                                560     LOAD_FAST                       0: zone
                                562     LOAD_ATTR                       20: T_s_hc
                                564     LOAD_FAST                       1: i
                                566     BINARY_SUBSCR                   
                                568     BINARY_MULTIPLY                 
                                570     BINARY_ADD                      
                                572     LOAD_FAST                       0: zone
                                574     LOAD_ATTR                       25: T_op_hc
                                576     LOAD_FAST                       1: i
                                578     STORE_SUBSCR                    
                                580     POP_BLOCK                       
                                582     LOAD_CONST                      10: '__pyarmor_exit_47117__'
                                584     NOP                             
                                586     NOP                             
                                588     LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x142\x02\x00\x00\x00\x00\x00\x00'
                                590     CALL_FUNCTION                   1
                                592     POP_TOP                         
                                594     JUMP_FORWARD                    14 (to 610)
                                596     LOAD_CONST                      10: '__pyarmor_exit_47117__'
                                598     NOP                             
                                600     NOP                             
                                602     LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x142\x02\x00\x00\x00\x00\x00\x00'
                                604     CALL_FUNCTION                   1
                                606     POP_TOP                         
                                608     RERAISE                         
                                610     LOAD_CONST                      0: None
                                612     RETURN_VALUE                    
                        'Simulation.iterate.<locals>._recalc_hc_node'
                        'Zones'
                        'if_print'
                        'infl_style'
                        1000
                        0
                        1
                        [Code]
                            File Name: <frozen simulation>
                            Object Name: <dictcomp>
                            Arg Count: 1
                            Pos Only Arg Count: 0
                            KW Only Arg Count: 0
                            Locals: 2
                            Stack Size: 5
                            Flags: 0x00000053 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NESTED | CO_NOFREE)
                            [Names]
                            [Var Names]
                                '.0'
                                '_var_var_96'
                            [Free Vars]
                            [Cell Vars]
                            [Constants]
                                0
                            [Disassembly]
                                0       BUILD_MAP                       0
                                2       LOAD_FAST                       0: .0
                                4       FOR_ITER                        14 (to 20)
                                6       STORE_FAST                      1: _var_var_96
                                8       LOAD_FAST                       1: _var_var_96
                                10      LOAD_CONST                      0: 0
                                12      LOAD_CONST                      0: 0
                                14      BUILD_LIST                      2
                                16      MAP_ADD                         2
                                18      JUMP_ABSOLUTE                   4
                                20      RETURN_VALUE                    
                        'Simulation.iterate.<locals>.<dictcomp>'
                        'real'
                        0.0146
                        0.7
                        0.667
                        0.001
                        0.0769
                        2
                        0.14
                        2
                        3
                        'constant'
                        0.01
                        0.0035
                        0.1
                        1
                        0
                        25
                        0.2
                        1800
                        0.5
                        16
                        0.333333
                        [Code]
                            File Name: <frozen simulation>
                            Object Name: <genexpr>
                            Arg Count: 1
                            Pos Only Arg Count: 0
                            KW Only Arg Count: 0
                            Locals: 3
                            Stack Size: 3
                            Flags: 0x00000033 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NESTED | CO_GENERATOR)
                            [Names]
                                'T_air_hc'
                                'U_iw'
                                'Af'
                            [Var Names]
                                '.0'
                                '_var_var_101'
                                '_var_var_102'
                            [Free Vars]
                                'i'
                                'pre_zones'
                                'zone'
                            [Cell Vars]
                            [Constants]
                                None
                            [Disassembly]
                                0       LOAD_FAST                       0: .0
                                2       FOR_ITER                        40 (to 44)
                                4       UNPACK_SEQUENCE                 2
                                6       STORE_FAST                      1: _var_var_101
                                8       STORE_FAST                      2: _var_var_102
                                10      LOAD_DEREF                      1: pre_zones
                                12      LOAD_FAST                       1: _var_var_101
                                14      BINARY_SUBSCR                   
                                16      LOAD_ATTR                       0: T_air_hc
                                18      LOAD_DEREF                      0: i
                                20      BINARY_SUBSCR                   
                                22      LOAD_DEREF                      2: zone
                                24      LOAD_ATTR                       1: U_iw
                                26      BINARY_MULTIPLY                 
                                28      LOAD_FAST                       2: _var_var_102
                                30      BINARY_MULTIPLY                 
                                32      LOAD_DEREF                      2: zone
                                34      LOAD_ATTR                       2: Af
                                36      BINARY_TRUE_DIVIDE              
                                38      YIELD_VALUE                     
                                40      POP_TOP                         
                                42      JUMP_ABSOLUTE                   2
                                44      LOAD_CONST                      0: None
                                46      RETURN_VALUE                    
                        'Simulation.iterate.<locals>.<genexpr>'
                        [Code]
                            File Name: <frozen simulation>
                            Object Name: <genexpr>
                            Arg Count: 1
                            Pos Only Arg Count: 0
                            KW Only Arg Count: 0
                            Locals: 3
                            Stack Size: 3
                            Flags: 0x00000033 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NESTED | CO_GENERATOR)
                            [Names]
                                'T_air_hc'
                                'U_if'
                                'Af'
                            [Var Names]
                                '.0'
                                '_var_var_101'
                                '_var_var_102'
                            [Free Vars]
                                'i'
                                'pre_zones'
                                'zone'
                            [Cell Vars]
                            [Constants]
                                None
                            [Disassembly]
                                0       LOAD_FAST                       0: .0
                                2       FOR_ITER                        40 (to 44)
                                4       UNPACK_SEQUENCE                 2
                                6       STORE_FAST                      1: _var_var_101
                                8       STORE_FAST                      2: _var_var_102
                                10      LOAD_DEREF                      1: pre_zones
                                12      LOAD_FAST                       1: _var_var_101
                                14      BINARY_SUBSCR                   
                                16      LOAD_ATTR                       0: T_air_hc
                                18      LOAD_DEREF                      0: i
                                20      BINARY_SUBSCR                   
                                22      LOAD_DEREF                      2: zone
                                24      LOAD_ATTR                       1: U_if
                                26      BINARY_MULTIPLY                 
                                28      LOAD_FAST                       2: _var_var_102
                                30      BINARY_MULTIPLY                 
                                32      LOAD_DEREF                      2: zone
                                34      LOAD_ATTR                       2: Af
                                36      BINARY_TRUE_DIVIDE              
                                38      YIELD_VALUE                     
                                40      POP_TOP                         
                                42      JUMP_ABSOLUTE                   2
                                44      LOAD_CONST                      0: None
                                46      RETURN_VALUE                    
                        [Code]
                            File Name: <frozen simulation>
                            Object Name: <listcomp>
                            Arg Count: 1
                            Pos Only Arg Count: 0
                            KW Only Arg Count: 0
                            Locals: 3
                            Stack Size: 4
                            Flags: 0x00000013 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NESTED)
                            [Names]
                                'Af'
                                'T_air_hc'
                                'U_if'
                            [Var Names]
                                '.0'
                                '_var_var_101'
                                '_var_var_102'
                            [Free Vars]
                                'Htr_gr'
                                'T_gr_i'
                                'i'
                                'pre_zones'
                                'zone'
                            [Cell Vars]
                            [Constants]
                                'ground'
                            [Disassembly]
                                0       BUILD_LIST                      0
                                2       LOAD_FAST                       0: .0
                                4       FOR_ITER                        64 (to 70)
                                6       UNPACK_SEQUENCE                 2
                                8       STORE_FAST                      1: _var_var_101
                                10      STORE_FAST                      2: _var_var_102
                                12      LOAD_FAST                       1: _var_var_101
                                14      LOAD_CONST                      0: 'ground'
                                16      COMPARE_OP                      2 (==)
                                18      POP_JUMP_IF_FALSE               38
                                20      LOAD_DEREF                      1: T_gr_i
                                22      LOAD_DEREF                      0: Htr_gr
                                24      BINARY_MULTIPLY                 
                                26      LOAD_FAST                       2: _var_var_102
                                28      BINARY_MULTIPLY                 
                                30      LOAD_DEREF                      4: zone
                                32      LOAD_ATTR                       0: Af
                                34      BINARY_TRUE_DIVIDE              
                                36      JUMP_FORWARD                    28 (to 66)
                                38      LOAD_DEREF                      3: pre_zones
                                40      LOAD_FAST                       1: _var_var_101
                                42      BINARY_SUBSCR                   
                                44      LOAD_ATTR                       1: T_air_hc
                                46      LOAD_DEREF                      2: i
                                48      BINARY_SUBSCR                   
                                50      LOAD_DEREF                      4: zone
                                52      LOAD_ATTR                       2: U_if
                                54      BINARY_MULTIPLY                 
                                56      LOAD_FAST                       2: _var_var_102
                                58      BINARY_MULTIPLY                 
                                60      LOAD_DEREF                      4: zone
                                62      LOAD_ATTR                       0: Af
                                64      BINARY_TRUE_DIVIDE              
                                66      LIST_APPEND                     2
                                68      JUMP_ABSOLUTE                   4
                                70      RETURN_VALUE                    
                        'Simulation.iterate.<locals>.<listcomp>'
                        0.3
                        10
                        '__pyarmor_exit_47102__'
                    [Disassembly]
                        0       NOP                             
                        2       NOP                             
                        4       NOP                             
                        6       NOP                             
                        8       LOAD_CONST                      3: '__pyarmor_enter_47101__'
                        10      NOP                             
                        12      NOP                             
                        14      LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14\x96\x0c\x00\x00\x00\x00\x00\x00'
                        16      CALL_FUNCTION                   1
                        18      POP_TOP                         
                        20      SETUP_FINALLY                   3232 (to 3256)
                        24      LOAD_GLOBAL                     0: len
                        26      LOAD_DEREF                      7: self
                        28      LOAD_ATTR                       1: Te
                        30      CALL_FUNCTION                   1
                        32      STORE_FAST                      2: _var_var_35
                        34      LOAD_GLOBAL                     2: time
                        36      LOAD_METHOD                     2: time
                        38      CALL_METHOD                     0
                        40      LOAD_GLOBAL                     3: print_progress_bar
                        42      STORE_ATTR                      4: start_time
                        44      LOAD_DEREF                      7: self
                        46      LOAD_ATTR                       5: solver
                        48      LOAD_METHOD                     6: lower
                        50      CALL_METHOD                     0
                        52      STORE_FAST                      3: _var_var_36
                        54      LOAD_FAST                       3: _var_var_36
                        56      LOAD_CONST                      5: 'crank-nicholson'
                        58      COMPARE_OP                      2 (==)
                        60      POP_JUMP_IF_FALSE               72
                        62      LOAD_CONST                      6: <CODE> _solve
                        64      LOAD_CONST                      7: 'Simulation.iterate.<locals>._solve'
                        66      MAKE_FUNCTION                   0
                        68      STORE_DEREF                     3: _var_var_32
                        70      JUMP_FORWARD                    44 (to 116)
                        72      LOAD_FAST                       3: _var_var_36
                        74      LOAD_CONST                      8: 'euler'
                        76      COMPARE_OP                      2 (==)
                        78      POP_JUMP_IF_FALSE               90
                        80      LOAD_CONST                      9: <CODE> _solve
                        82      LOAD_CONST                      7: 'Simulation.iterate.<locals>._solve'
                        84      MAKE_FUNCTION                   0
                        86      STORE_DEREF                     3: _var_var_32
                        88      JUMP_FORWARD                    26 (to 116)
                        90      LOAD_FAST                       3: _var_var_36
                        92      LOAD_CONST                      10: 'runge-kutta'
                        94      COMPARE_OP                      2 (==)
                        96      POP_JUMP_IF_FALSE               108
                        98      LOAD_CONST                      11: <CODE> _solve
                        100     LOAD_CONST                      7: 'Simulation.iterate.<locals>._solve'
                        102     MAKE_FUNCTION                   0
                        104     STORE_DEREF                     3: _var_var_32
                        106     JUMP_FORWARD                    8 (to 116)
                        108     LOAD_CONST                      12: <CODE> _solve
                        110     LOAD_CONST                      7: 'Simulation.iterate.<locals>._solve'
                        112     MAKE_FUNCTION                   0
                        114     STORE_DEREF                     3: _var_var_32
                        116     LOAD_CLOSURE                    0: _var_var_29
                        118     LOAD_CLOSURE                    3: _var_var_32
                        120     LOAD_CLOSURE                    5: _var_var_33
                        122     LOAD_CLOSURE                    7: self
                        124     BUILD_TUPLE                     4
                        126     LOAD_CONST                      13: <CODE> _recalc_hc_node
                        128     LOAD_CONST                      14: 'Simulation.iterate.<locals>._recalc_hc_node'
                        130     MAKE_FUNCTION                   8
                        132     STORE_FAST                      4: _var_var_37
                        134     LOAD_GLOBAL                     7: list
                        136     LOAD_DEREF                      7: self
                        138     LOAD_ATTR                       8: pre_dict
                        140     LOAD_CONST                      15: 'Zones'
                        142     BINARY_SUBSCR                   
                        144     LOAD_METHOD                     9: items
                        146     CALL_METHOD                     0
                        148     CALL_FUNCTION                   1
                        150     STORE_FAST                      5: _var_var_38
                        152     LOAD_DEREF                      7: self
                        154     LOAD_ATTR                       1: Te
                        156     STORE_FAST                      6: _var_var_39
                        158     LOAD_DEREF                      7: self
                        160     LOAD_ATTR                       10: ws
                        162     STORE_FAST                      7: _var_var_40
                        164     LOAD_DEREF                      7: self
                        166     LOAD_ATTR                       11: T_gr
                        168     STORE_FAST                      8: _var_var_41
                        170     LOAD_DEREF                      7: self
                        172     LOAD_ATTR                       12: Cm
                        174     STORE_DEREF                     0: _var_var_29
                        176     LOAD_DEREF                      7: self
                        178     LOAD_ATTR                       13: order
                        180     STORE_DEREF                     5: _var_var_33
                        182     LOAD_DEREF                      7: self
                        184     LOAD_ATTR                       14: Htr_gr
                        186     STORE_DEREF                     1: _var_var_30
                        188     LOAD_DEREF                      7: self
                        190     LOAD_ATTR                       8: pre_dict
                        192     LOAD_CONST                      15: 'Zones'
                        194     BINARY_SUBSCR                   
                        196     STORE_DEREF                     6: _var_var_34
                        198     LOAD_DEREF                      7: self
                        200     LOAD_ATTR                       15: General
                        202     LOAD_ATTR                       16: HVAC_dct
                        204     STORE_FAST                      9: _var_var_42
                        206     LOAD_GLOBAL                     17: hasattr
                        208     LOAD_DEREF                      7: self
                        210     LOAD_CONST                      16: 'if_print'
                        212     CALL_FUNCTION                   2
                        214     JUMP_IF_FALSE_OR_POP            220
                        216     LOAD_DEREF                      7: self
                        218     LOAD_ATTR                       18: if_print
                        220     STORE_FAST                      10: _var_var_43
                        222     LOAD_GLOBAL                     17: hasattr
                        224     LOAD_DEREF                      7: self
                        226     LOAD_CONST                      17: 'infl_style'
                        228     CALL_FUNCTION                   2
                        230     STORE_FAST                      11: _var_var_44
                        232     LOAD_GLOBAL                     19: getattr
                        234     LOAD_DEREF                      7: self
                        236     LOAD_CONST                      17: 'infl_style'
                        238     LOAD_CONST                      0: None
                        240     CALL_FUNCTION                   3
                        242     STORE_FAST                      12: _var_var_45
                        244     BUILD_MAP                       0
                        246     STORE_FAST                      13: _var_var_46
                        248     LOAD_FAST                       5: _var_var_38
                        250     GET_ITER                        
                        252     FOR_ITER                        52 (to 306)
                        254     UNPACK_SEQUENCE                 2
                        256     STORE_FAST                      14: _var_var_12
                        258     STORE_DEREF                     8: _var_var_11
                        260     LOAD_GLOBAL                     7: list
                        262     LOAD_DEREF                      8: _var_var_11
                        264     LOAD_ATTR                       20: adj_wall_zone
                        266     LOAD_METHOD                     9: items
                        268     CALL_METHOD                     0
                        270     CALL_FUNCTION                   1
                        272     LOAD_GLOBAL                     7: list
                        274     LOAD_DEREF                      8: _var_var_11
                        276     LOAD_ATTR                       21: adj_ceiling_zone
                        278     LOAD_METHOD                     9: items
                        280     CALL_METHOD                     0
                        282     CALL_FUNCTION                   1
                        284     LOAD_GLOBAL                     7: list
                        286     LOAD_DEREF                      8: _var_var_11
                        288     LOAD_ATTR                       22: adj_floor_zone
                        290     LOAD_METHOD                     9: items
                        292     CALL_METHOD                     0
                        294     CALL_FUNCTION                   1
                        296     BUILD_TUPLE                     3
                        298     LOAD_FAST                       13: _var_var_46
                        300     LOAD_FAST                       14: _var_var_12
                        302     STORE_SUBSCR                    
                        304     JUMP_ABSOLUTE                   252
                        306     LOAD_GLOBAL                     23: range
                        308     LOAD_FAST                       2: _var_var_35
                        310     CALL_FUNCTION                   1
                        312     GET_ITER                        
                        314     FOR_ITER                        2922 (to 3240)
                        318     STORE_DEREF                     4: _var_var_26
                        320     LOAD_FAST                       10: _var_var_43
                        322     POP_JUMP_IF_FALSE               374
                        326     LOAD_DEREF                      4: _var_var_26
                        328     LOAD_CONST                      18: 1000
                        330     BINARY_MODULO                   
                        332     LOAD_CONST                      19: 0
                        334     COMPARE_OP                      2 (==)
                        336     POP_JUMP_IF_FALSE               350
                        340     LOAD_GLOBAL                     3: print_progress_bar
                        342     LOAD_DEREF                      4: _var_var_26
                        344     LOAD_FAST                       2: _var_var_35
                        346     CALL_FUNCTION                   2
                        348     POP_TOP                         
                        350     LOAD_DEREF                      4: _var_var_26
                        352     LOAD_FAST                       2: _var_var_35
                        354     LOAD_CONST                      20: 1
                        356     BINARY_SUBTRACT                 
                        358     COMPARE_OP                      2 (==)
                        360     POP_JUMP_IF_FALSE               374
                        364     LOAD_GLOBAL                     3: print_progress_bar
                        366     LOAD_FAST                       2: _var_var_35
                        368     LOAD_FAST                       2: _var_var_35
                        370     CALL_FUNCTION                   2
                        372     POP_TOP                         
                        374     LOAD_FAST                       6: _var_var_39
                        376     LOAD_DEREF                      4: _var_var_26
                        378     BINARY_SUBSCR                   
                        380     STORE_FAST                      15: _var_var_47
                        382     LOAD_FAST                       7: _var_var_40
                        384     LOAD_DEREF                      4: _var_var_26
                        386     BINARY_SUBSCR                   
                        388     STORE_FAST                      16: _var_var_48
                        390     LOAD_FAST                       8: _var_var_41
                        392     LOAD_DEREF                      4: _var_var_26
                        394     BINARY_SUBSCR                   
                        396     STORE_DEREF                     2: _var_var_31
                        398     LOAD_CONST                      21: <CODE> <dictcomp>
                        400     LOAD_CONST                      22: 'Simulation.iterate.<locals>.<dictcomp>'
                        402     MAKE_FUNCTION                   0
                        404     LOAD_FAST                       9: _var_var_42
                        406     GET_ITER                        
                        408     CALL_FUNCTION                   1
                        410     STORE_FAST                      17: _var_var_49
                        412     LOAD_FAST                       5: _var_var_38
                        414     GET_ITER                        
                        416     FOR_ITER                        2576 (to 2996)
                        420     UNPACK_SEQUENCE                 2
                        422     STORE_FAST                      14: _var_var_12
                        424     STORE_DEREF                     8: _var_var_11
                        426     LOAD_FAST                       13: _var_var_46
                        428     LOAD_FAST                       14: _var_var_12
                        430     BINARY_SUBSCR                   
                        432     UNPACK_SEQUENCE                 3
                        434     STORE_FAST                      18: _var_var_50
                        436     STORE_FAST                      19: _var_var_51
                        438     STORE_FAST                      20: _var_var_52
                        440     LOAD_DEREF                      8: _var_var_11
                        442     LOAD_ATTR                       24: Q4Pa
                        444     LOAD_CONST                      19: 0
                        446     COMPARE_OP                      3 (!=)
                        448     POP_JUMP_IF_FALSE               796
                        452     LOAD_FAST                       11: _var_var_44
                        454     POP_JUMP_IF_FALSE               772
                        458     LOAD_FAST                       12: _var_var_45
                        460     LOAD_CONST                      23: 'real'
                        462     COMPARE_OP                      2 (==)
                        464     POP_JUMP_IF_FALSE               730
                        468     LOAD_DEREF                      8: _var_var_11
                        470     LOAD_ATTR                       25: T_air_set
                        472     LOAD_DEREF                      4: _var_var_26
                        474     BINARY_SUBSCR                   
                        476     STORE_FAST                      21: _var_var_53
                        478     LOAD_DEREF                      8: _var_var_11
                        480     LOAD_ATTR                       26: infiltration_frac
                        482     LOAD_DEREF                      4: _var_var_26
                        484     BINARY_SUBSCR                   
                        486     STORE_FAST                      22: _var_var_54
                        488     LOAD_DEREF                      8: _var_var_11
                        490     LOAD_ATTR                       27: Ventilation
                        492     LOAD_ATTR                       28: flow_rate
                        494     STORE_FAST                      23: _var_var_55
                        496     LOAD_GLOBAL                     29: max
                        498     LOAD_CONST                      24: 0.0146
                        500     LOAD_FAST                       23: _var_var_55
                        502     BINARY_MULTIPLY                 
                        504     LOAD_FAST                       22: _var_var_54
                        506     BINARY_MULTIPLY                 
                        508     LOAD_CONST                      25: 0.7
                        510     LOAD_DEREF                      8: _var_var_11
                        512     LOAD_ATTR                       30: height
                        514     BINARY_MULTIPLY                 
                        516     LOAD_GLOBAL                     31: abs
                        518     LOAD_FAST                       15: _var_var_47
                        520     LOAD_FAST                       21: _var_var_53
                        522     BINARY_SUBTRACT                 
                        524     CALL_FUNCTION                   1
                        526     BINARY_MULTIPLY                 
                        528     LOAD_CONST                      26: 0.667
                        530     BINARY_POWER                    
                        532     BINARY_MULTIPLY                 
                        534     LOAD_CONST                      27: 0.001
                        536     CALL_FUNCTION                   2
                        538     STORE_FAST                      24: _var_var_56
                        540     LOAD_FAST                       24: _var_var_56
                        542     LOAD_DEREF                      8: _var_var_11
                        544     LOAD_ATTR                       32: qv_stack
                        546     LOAD_DEREF                      4: _var_var_26
                        548     STORE_SUBSCR                    
                        550     LOAD_CONST                      28: 0.0769
                        552     LOAD_FAST                       23: _var_var_55
                        554     BINARY_MULTIPLY                 
                        556     LOAD_FAST                       22: _var_var_54
                        558     BINARY_MULTIPLY                 
                        560     LOAD_DEREF                      8: _var_var_11
                        562     LOAD_ATTR                       27: Ventilation
                        564     LOAD_ATTR                       33: dCP
                        566     LOAD_DEREF                      8: _var_var_11
                        568     LOAD_ATTR                       27: Ventilation
                        570     LOAD_ATTR                       34: vsite
                        572     BINARY_MULTIPLY                 
                        574     LOAD_FAST                       16: _var_var_48
                        576     LOAD_CONST                      29: 2
                        578     BINARY_POWER                    
                        580     BINARY_MULTIPLY                 
                        582     LOAD_CONST                      26: 0.667
                        584     BINARY_POWER                    
                        586     BINARY_MULTIPLY                 
                        588     STORE_FAST                      25: _var_var_57
                        590     LOAD_FAST                       25: _var_var_57
                        592     LOAD_DEREF                      8: _var_var_11
                        594     LOAD_ATTR                       35: qv_wind
                        596     LOAD_DEREF                      4: _var_var_26
                        598     STORE_SUBSCR                    
                        600     LOAD_GLOBAL                     29: max
                        602     LOAD_FAST                       24: _var_var_56
                        604     LOAD_FAST                       25: _var_var_57
                        606     CALL_FUNCTION                   2
                        608     LOAD_CONST                      30: 0.14
                        610     LOAD_FAST                       24: _var_var_56
                        612     BINARY_MULTIPLY                 
                        614     LOAD_FAST                       25: _var_var_57
                        616     BINARY_MULTIPLY                 
                        618     LOAD_FAST                       23: _var_var_55
                        620     LOAD_FAST                       22: _var_var_54
                        622     BINARY_MULTIPLY                 
                        624     BINARY_TRUE_DIVIDE              
                        626     BINARY_ADD                      
                        628     STORE_FAST                      26: _var_var_58
                        630     LOAD_FAST                       26: _var_var_58
                        632     LOAD_DEREF                      8: _var_var_11
                        634     LOAD_ATTR                       36: qv_sw
                        636     LOAD_DEREF                      4: _var_var_26
                        638     STORE_SUBSCR                    
                        640     LOAD_DEREF                      8: _var_var_11
                        642     LOAD_ATTR                       37: qv_diff
                        644     LOAD_DEREF                      4: _var_var_26
                        646     BINARY_SUBSCR                   
                        648     STORE_FAST                      27: _var_var_59
                        650     LOAD_GLOBAL                     29: max
                        652     LOAD_FAST                       26: _var_var_58
                        654     LOAD_FAST                       24: _var_var_56
                        656     LOAD_GLOBAL                     31: abs
                        658     LOAD_FAST                       27: _var_var_59
                        660     CALL_FUNCTION                   1
                        662     BINARY_MULTIPLY                 
                        664     LOAD_CONST                      31: 2
                        666     BINARY_TRUE_DIVIDE              
                        668     LOAD_FAST                       25: _var_var_57
                        670     LOAD_GLOBAL                     31: abs
                        672     LOAD_FAST                       27: _var_var_59
                        674     CALL_FUNCTION                   1
                        676     BINARY_MULTIPLY                 
                        678     LOAD_CONST                      29: 2
                        680     BINARY_MULTIPLY                 
                        682     LOAD_CONST                      32: 3
                        684     BINARY_TRUE_DIVIDE              
                        686     BINARY_ADD                      
                        688     LOAD_FAST                       24: _var_var_56
                        690     LOAD_FAST                       25: _var_var_57
                        692     BINARY_ADD                      
                        694     BINARY_TRUE_DIVIDE              
                        696     CALL_FUNCTION                   2
                        698     LOAD_DEREF                      8: _var_var_11
                        700     LOAD_ATTR                       38: qv_infred
                        702     LOAD_DEREF                      4: _var_var_26
                        704     STORE_SUBSCR                    
                        706     LOAD_GLOBAL                     29: max
                        708     LOAD_CONST                      19: 0
                        710     LOAD_FAST                       27: _var_var_59
                        712     UNARY_NEGATIVE                  
                        714     CALL_FUNCTION                   2
                        716     LOAD_FAST                       26: _var_var_58
                        718     BINARY_ADD                      
                        720     LOAD_DEREF                      8: _var_var_11
                        722     LOAD_ATTR                       39: qv_inf
                        724     LOAD_DEREF                      4: _var_var_26
                        726     STORE_SUBSCR                    
                        728     JUMP_FORWARD                    40 (to 770)
                        730     LOAD_FAST                       12: _var_var_45
                        732     LOAD_CONST                      33: 'constant'
                        734     COMPARE_OP                      2 (==)
                        736     POP_JUMP_IF_FALSE               766
                        740     LOAD_DEREF                      8: _var_var_11
                        742     LOAD_ATTR                       27: Ventilation
                        744     LOAD_ATTR                       28: flow_rate
                        746     LOAD_DEREF                      8: _var_var_11
                        748     LOAD_ATTR                       26: infiltration_frac
                        750     LOAD_DEREF                      4: _var_var_26
                        752     BINARY_SUBSCR                   
                        754     BINARY_MULTIPLY                 
                        756     LOAD_DEREF                      8: _var_var_11
                        758     LOAD_ATTR                       39: qv_inf
                        760     LOAD_DEREF                      4: _var_var_26
                        762     STORE_SUBSCR                    
                        764     JUMP_FORWARD                    4 (to 770)
                        766     LOAD_GLOBAL                     40: ValueError
                        768     RAISE_VARARGS                   1
                        770     JUMP_FORWARD                    24 (to 796)
                        772     LOAD_DEREF                      8: _var_var_11
                        774     LOAD_ATTR                       27: Ventilation
                        776     LOAD_ATTR                       28: flow_rate
                        778     LOAD_DEREF                      8: _var_var_11
                        780     LOAD_ATTR                       26: infiltration_frac
                        782     LOAD_DEREF                      4: _var_var_26
                        784     BINARY_SUBSCR                   
                        786     BINARY_MULTIPLY                 
                        788     LOAD_DEREF                      8: _var_var_11
                        790     LOAD_ATTR                       39: qv_inf
                        792     LOAD_DEREF                      4: _var_var_26
                        794     STORE_SUBSCR                    
                        796     LOAD_DEREF                      8: _var_var_11
                        798     LOAD_ATTR                       41: vent_type
                        800     LOAD_CONST                      20: 1
                        802     COMPARE_OP                      3 (!=)
                        804     POP_JUMP_IF_FALSE               1174
                        808     LOAD_DEREF                      8: _var_var_11
                        810     LOAD_ATTR                       25: T_air_set
                        812     LOAD_DEREF                      4: _var_var_26
                        814     BINARY_SUBSCR                   
                        816     STORE_FAST                      21: _var_var_53
                        818     LOAD_CONST                      34: 0.01
                        820     LOAD_CONST                      27: 0.001
                        822     LOAD_FAST                       16: _var_var_48
                        824     LOAD_CONST                      29: 2
                        826     BINARY_POWER                    
                        828     BINARY_MULTIPLY                 
                        830     BINARY_ADD                      
                        832     LOAD_CONST                      35: 0.0035
                        834     LOAD_DEREF                      8: _var_var_11
                        836     LOAD_ATTR                       27: Ventilation
                        838     LOAD_ATTR                       30: height
                        840     BINARY_MULTIPLY                 
                        842     LOAD_GLOBAL                     31: abs
                        844     LOAD_FAST                       21: _var_var_53
                        846     LOAD_FAST                       15: _var_var_47
                        848     BINARY_SUBTRACT                 
                        850     CALL_FUNCTION                   1
                        852     BINARY_MULTIPLY                 
                        854     BINARY_ADD                      
                        856     STORE_FAST                      28: _var_var_60
                        858     LOAD_FAST                       28: _var_var_60
                        860     LOAD_DEREF                      8: _var_var_11
                        862     LOAD_ATTR                       42: V
                        864     LOAD_DEREF                      4: _var_var_26
                        866     STORE_SUBSCR                    
                        868     LOAD_CONST                      20: 1
                        870     LOAD_CONST                      36: 0.1
                        872     LOAD_FAST                       16: _var_var_48
                        874     BINARY_MULTIPLY                 
                        876     BINARY_SUBTRACT                 
                        878     STORE_FAST                      29: _var_var_61
                        880     LOAD_FAST                       29: _var_var_61
                        882     LOAD_CONST                      20: 1
                        884     COMPARE_OP                      4 (>)
                        886     POP_JUMP_IF_FALSE               894
                        890     LOAD_CONST                      37: 1
                        892     JUMP_FORWARD                    16 (to 910)
                        894     LOAD_FAST                       29: _var_var_61
                        896     LOAD_CONST                      19: 0
                        898     COMPARE_OP                      0 (<)
                        900     POP_JUMP_IF_FALSE               908
                        904     LOAD_CONST                      38: 0
                        906     JUMP_FORWARD                    2 (to 910)
                        908     LOAD_FAST                       29: _var_var_61
                        910     STORE_FAST                      30: _var_var_62
                        912     LOAD_FAST                       15: _var_var_47
                        914     LOAD_CONST                      39: 25
                        916     BINARY_TRUE_DIVIDE              
                        918     LOAD_CONST                      40: 0.2
                        920     BINARY_ADD                      
                        922     STORE_FAST                      31: _var_var_63
                        924     LOAD_FAST                       31: _var_var_63
                        926     LOAD_CONST                      20: 1
                        928     COMPARE_OP                      4 (>)
                        930     POP_JUMP_IF_FALSE               938
                        934     LOAD_CONST                      37: 1
                        936     JUMP_FORWARD                    16 (to 954)
                        938     LOAD_FAST                       31: _var_var_63
                        940     LOAD_CONST                      19: 0
                        942     COMPARE_OP                      0 (<)
                        944     POP_JUMP_IF_FALSE               952
                        948     LOAD_CONST                      38: 0
                        950     JUMP_FORWARD                    2 (to 954)
                        952     LOAD_FAST                       31: _var_var_63
                        954     STORE_FAST                      32: _var_var_64
                        956     LOAD_FAST                       30: _var_var_62
                        958     LOAD_DEREF                      8: _var_var_11
                        960     LOAD_ATTR                       43: Ywind
                        962     LOAD_DEREF                      4: _var_var_26
                        964     STORE_SUBSCR                    
                        966     LOAD_FAST                       32: _var_var_64
                        968     LOAD_DEREF                      8: _var_var_11
                        970     LOAD_ATTR                       44: Ytemp
                        972     LOAD_DEREF                      4: _var_var_26
                        974     STORE_SUBSCR                    
                        976     LOAD_FAST                       30: _var_var_62
                        978     LOAD_FAST                       32: _var_var_64
                        980     BINARY_MULTIPLY                 
                        982     STORE_FAST                      33: _var_var_65
                        984     LOAD_FAST                       33: _var_var_65
                        986     LOAD_DEREF                      8: _var_var_11
                        988     LOAD_ATTR                       45: Ropw
                        990     LOAD_DEREF                      4: _var_var_26
                        992     STORE_SUBSCR                    
                        994     LOAD_FAST                       33: _var_var_65
                        996     LOAD_CONST                      41: 1800
                        998     LOAD_DEREF                      8: _var_var_11
                        1000    LOAD_ATTR                       27: Ventilation
                        1002    LOAD_ATTR                       46: Aow
                        1004    BINARY_MULTIPLY                 
                        1006    LOAD_FAST                       28: _var_var_60
                        1008    LOAD_CONST                      42: 0.5
                        1010    BINARY_POWER                    
                        1012    BINARY_MULTIPLY                 
                        1014    BINARY_MULTIPLY                 
                        1016    LOAD_DEREF                      8: _var_var_11
                        1018    LOAD_ATTR                       47: Af
                        1020    BINARY_TRUE_DIVIDE              
                        1022    STORE_FAST                      34: _var_var_66
                        1024    LOAD_FAST                       34: _var_var_66
                        1026    LOAD_DEREF                      8: _var_var_11
                        1028    LOAD_ATTR                       48: qv_airing
                        1030    LOAD_DEREF                      4: _var_var_26
                        1032    STORE_SUBSCR                    
                        1034    LOAD_DEREF                      8: _var_var_11
                        1036    LOAD_ATTR                       41: vent_type
                        1038    STORE_FAST                      35: _var_var_67
                        1040    LOAD_FAST                       35: _var_var_67
                        1042    LOAD_CONST                      32: 3
                        1044    COMPARE_OP                      2 (==)
                        1046    POP_JUMP_IF_FALSE               1072
                        1050    LOAD_CONST                      20: 1
                        1052    LOAD_DEREF                      8: _var_var_11
                        1054    LOAD_ATTR                       49: NV_hrs
                        1056    LOAD_DEREF                      4: _var_var_26
                        1058    STORE_SUBSCR                    
                        1060    LOAD_FAST                       34: _var_var_66
                        1062    LOAD_DEREF                      8: _var_var_11
                        1064    LOAD_ATTR                       50: qv_NV
                        1066    LOAD_DEREF                      4: _var_var_26
                        1068    STORE_SUBSCR                    
                        1070    JUMP_FORWARD                    72 (to 1144)
                        1072    LOAD_FAST                       35: _var_var_67
                        1074    LOAD_CONST                      29: 2
                        1076    COMPARE_OP                      2 (==)
                        1078    POP_JUMP_IF_FALSE               1134
                        1082    LOAD_DEREF                      8: _var_var_11
                        1084    LOAD_ATTR                       51: q_C_nd
                        1086    LOAD_DEREF                      4: _var_var_26
                        1088    BINARY_SUBSCR                   
                        1090    LOAD_CONST                      19: 0
                        1092    COMPARE_OP                      4 (>)
                        1094    POP_JUMP_IF_FALSE               1122
                        1098    LOAD_FAST                       15: _var_var_47
                        1100    LOAD_FAST                       21: _var_var_53
                        1102    COMPARE_OP                      0 (<)
                        1104    POP_JUMP_IF_FALSE               1122
                        1108    LOAD_FAST                       15: _var_var_47
                        1110    LOAD_CONST                      43: 16
                        1112    COMPARE_OP                      4 (>)
                        1114    POP_JUMP_IF_FALSE               1122
                        1118    LOAD_CONST                      20: 1
                        1120    JUMP_FORWARD                    2 (to 1124)
                        1122    LOAD_CONST                      19: 0
                        1124    LOAD_DEREF                      8: _var_var_11
                        1126    LOAD_ATTR                       49: NV_hrs
                        1128    LOAD_DEREF                      4: _var_var_26
                        1130    STORE_SUBSCR                    
                        1132    JUMP_FORWARD                    10 (to 1144)
                        1134    LOAD_CONST                      19: 0
                        1136    LOAD_DEREF                      8: _var_var_11
                        1138    LOAD_ATTR                       49: NV_hrs
                        1140    LOAD_DEREF                      4: _var_var_26
                        1142    STORE_SUBSCR                    
                        1144    LOAD_DEREF                      8: _var_var_11
                        1146    LOAD_ATTR                       49: NV_hrs
                        1148    LOAD_DEREF                      4: _var_var_26
                        1150    BINARY_SUBSCR                   
                        1152    LOAD_CONST                      20: 1
                        1154    COMPARE_OP                      2 (==)
                        1156    POP_JUMP_IF_FALSE               1164
                        1160    LOAD_FAST                       34: _var_var_66
                        1162    JUMP_FORWARD                    2 (to 1166)
                        1164    LOAD_CONST                      19: 0
                        1166    LOAD_DEREF                      8: _var_var_11
                        1168    LOAD_ATTR                       52: qv_NV_calc
                        1170    LOAD_DEREF                      4: _var_var_26
                        1172    STORE_SUBSCR                    
                        1174    LOAD_DEREF                      8: _var_var_11
                        1176    LOAD_ATTR                       53: qv_supp
                        1178    LOAD_DEREF                      4: _var_var_26
                        1180    BINARY_SUBSCR                   
                        1182    LOAD_DEREF                      8: _var_var_11
                        1184    LOAD_ATTR                       39: qv_inf
                        1186    LOAD_DEREF                      4: _var_var_26
                        1188    BINARY_SUBSCR                   
                        1190    BINARY_ADD                      
                        1192    LOAD_DEREF                      8: _var_var_11
                        1194    LOAD_ATTR                       52: qv_NV_calc
                        1196    LOAD_DEREF                      4: _var_var_26
                        1198    BINARY_SUBSCR                   
                        1200    BINARY_ADD                      
                        1202    LOAD_DEREF                      8: _var_var_11
                        1204    LOAD_ATTR                       54: qv_tot
                        1206    LOAD_DEREF                      4: _var_var_26
                        1208    STORE_SUBSCR                    
                        1210    LOAD_CONST                      44: 0.333333
                        1212    LOAD_DEREF                      8: _var_var_11
                        1214    LOAD_ATTR                       54: qv_tot
                        1216    LOAD_DEREF                      4: _var_var_26
                        1218    BINARY_SUBSCR                   
                        1220    BINARY_MULTIPLY                 
                        1222    STORE_FAST                      36: _var_var_68
                        1224    LOAD_CONST                      37: 1
                        1226    LOAD_CONST                      37: 1
                        1228    LOAD_DEREF                      8: _var_var_11
                        1230    LOAD_ATTR                       55: Htr_is
                        1232    BINARY_TRUE_DIVIDE              
                        1234    LOAD_CONST                      37: 1
                        1236    LOAD_FAST                       36: _var_var_68
                        1238    BINARY_TRUE_DIVIDE              
                        1240    BINARY_ADD                      
                        1242    BINARY_TRUE_DIVIDE              
                        1244    STORE_FAST                      37: _var_var_69
                        1246    LOAD_FAST                       37: _var_var_69
                        1248    LOAD_DEREF                      8: _var_var_11
                        1250    LOAD_ATTR                       56: Htr_w
                        1252    LOAD_DEREF                      8: _var_var_11
                        1254    LOAD_ATTR                       47: Af
                        1256    BINARY_TRUE_DIVIDE              
                        1258    BINARY_ADD                      
                        1260    LOAD_DEREF                      8: _var_var_11
                        1262    LOAD_ATTR                       57: Htr_iw
                        1264    BINARY_ADD                      
                        1266    STORE_FAST                      38: _var_var_70
                        1268    LOAD_CONST                      37: 1
                        1270    LOAD_CONST                      37: 1
                        1272    LOAD_FAST                       38: _var_var_70
                        1274    BINARY_TRUE_DIVIDE              
                        1276    LOAD_CONST                      37: 1
                        1278    LOAD_DEREF                      8: _var_var_11
                        1280    LOAD_ATTR                       58: Htr_ms
                        1282    BINARY_TRUE_DIVIDE              
                        1284    BINARY_ADD                      
                        1286    BINARY_TRUE_DIVIDE              
                        1288    STORE_FAST                      39: _var_var_71
                        1290    LOAD_FAST                       36: _var_var_68
                        1292    LOAD_DEREF                      8: _var_var_11
                        1294    LOAD_ATTR                       59: Hve
                        1296    LOAD_DEREF                      4: _var_var_26
                        1298    STORE_SUBSCR                    
                        1300    LOAD_FAST                       37: _var_var_69
                        1302    LOAD_DEREF                      8: _var_var_11
                        1304    LOAD_ATTR                       60: H1
                        1306    LOAD_DEREF                      4: _var_var_26
                        1308    STORE_SUBSCR                    
                        1310    LOAD_FAST                       38: _var_var_70
                        1312    LOAD_DEREF                      8: _var_var_11
                        1314    LOAD_ATTR                       61: H2
                        1316    LOAD_DEREF                      4: _var_var_26
                        1318    STORE_SUBSCR                    
                        1320    LOAD_FAST                       39: _var_var_71
                        1322    LOAD_DEREF                      8: _var_var_11
                        1324    LOAD_ATTR                       62: H3
                        1326    LOAD_DEREF                      4: _var_var_26
                        1328    STORE_SUBSCR                    
                        1330    LOAD_DEREF                      8: _var_var_11
                        1332    LOAD_ATTR                       56: Htr_w
                        1334    LOAD_DEREF                      8: _var_var_11
                        1336    LOAD_ATTR                       57: Htr_iw
                        1338    LOAD_DEREF                      8: _var_var_11
                        1340    LOAD_ATTR                       47: Af
                        1342    BINARY_MULTIPLY                 
                        1344    BINARY_ADD                      
                        1346    LOAD_CONST                      19: 0
                        1348    COMPARE_OP                      2 (==)
                        1350    POP_JUMP_IF_FALSE               1366
                        1354    LOAD_CONST                      38: 0
                        1356    LOAD_DEREF                      8: _var_var_11
                        1358    LOAD_ATTR                       63: q_es
                        1360    LOAD_DEREF                      4: _var_var_26
                        1362    STORE_SUBSCR                    
                        1364    JUMP_FORWARD                    74 (to 1440)
                        1366    LOAD_DEREF                      8: _var_var_11
                        1368    LOAD_ATTR                       56: Htr_w
                        1370    LOAD_DEREF                      8: _var_var_11
                        1372    LOAD_ATTR                       47: Af
                        1374    BINARY_TRUE_DIVIDE              
                        1376    LOAD_FAST                       15: _var_var_47
                        1378    BINARY_MULTIPLY                 
                        1380    LOAD_GLOBAL                     64: sum
                        1382    LOAD_CLOSURE                    4: _var_var_26
                        1384    LOAD_CLOSURE                    6: _var_var_34
                        1386    LOAD_CLOSURE                    8: _var_var_11
                        1388    BUILD_TUPLE                     3
                        1390    LOAD_CONST                      45: <CODE> <genexpr>
                        1392    LOAD_CONST                      46: 'Simulation.iterate.<locals>.<genexpr>'
                        1394    MAKE_FUNCTION                   8
                        1396    LOAD_FAST                       18: _var_var_50
                        1398    GET_ITER                        
                        1400    CALL_FUNCTION                   1
                        1402    CALL_FUNCTION                   1
                        1404    BINARY_ADD                      
                        1406    LOAD_GLOBAL                     64: sum
                        1408    LOAD_CLOSURE                    4: _var_var_26
                        1410    LOAD_CLOSURE                    6: _var_var_34
                        1412    LOAD_CLOSURE                    8: _var_var_11
                        1414    BUILD_TUPLE                     3
                        1416    LOAD_CONST                      47: <CODE> <genexpr>
                        1418    LOAD_CONST                      46: 'Simulation.iterate.<locals>.<genexpr>'
                        1420    MAKE_FUNCTION                   8
                        1422    LOAD_FAST                       19: _var_var_51
                        1424    GET_ITER                        
                        1426    CALL_FUNCTION                   1
                        1428    CALL_FUNCTION                   1
                        1430    BINARY_ADD                      
                        1432    LOAD_DEREF                      8: _var_var_11
                        1434    LOAD_ATTR                       63: q_es
                        1436    LOAD_DEREF                      4: _var_var_26
                        1438    STORE_SUBSCR                    
                        1440    LOAD_CLOSURE                    1: _var_var_30
                        1442    LOAD_CLOSURE                    2: _var_var_31
                        1444    LOAD_CLOSURE                    4: _var_var_26
                        1446    LOAD_CLOSURE                    6: _var_var_34
                        1448    LOAD_CLOSURE                    8: _var_var_11
                        1450    BUILD_TUPLE                     5
                        1452    LOAD_CONST                      48: <CODE> <listcomp>
                        1454    LOAD_CONST                      49: 'Simulation.iterate.<locals>.<listcomp>'
                        1456    MAKE_FUNCTION                   8
                        1458    LOAD_FAST                       20: _var_var_52
                        1460    GET_ITER                        
                        1462    CALL_FUNCTION                   1
                        1464    STORE_FAST                      40: _var_var_72
                        1466    LOAD_DEREF                      8: _var_var_11
                        1468    LOAD_ATTR                       65: Htr_em
                        1470    LOAD_FAST                       15: _var_var_47
                        1472    BINARY_MULTIPLY                 
                        1474    LOAD_GLOBAL                     64: sum
                        1476    LOAD_FAST                       40: _var_var_72
                        1478    CALL_FUNCTION                   1
                        1480    BINARY_ADD                      
                        1482    LOAD_DEREF                      8: _var_var_11
                        1484    LOAD_ATTR                       66: q_em
                        1486    LOAD_DEREF                      4: _var_var_26
                        1488    STORE_SUBSCR                    
                        1490    LOAD_DEREF                      8: _var_var_11
                        1492    LOAD_ATTR                       67: q_m
                        1494    LOAD_DEREF                      4: _var_var_26
                        1496    BINARY_SUBSCR                   
                        1498    STORE_FAST                      41: _var_var_73
                        1500    LOAD_DEREF                      8: _var_var_11
                        1502    LOAD_ATTR                       66: q_em
                        1504    LOAD_DEREF                      4: _var_var_26
                        1506    BINARY_SUBSCR                   
                        1508    STORE_FAST                      42: _var_var_74
                        1510    LOAD_DEREF                      8: _var_var_11
                        1512    LOAD_ATTR                       68: q_st
                        1514    LOAD_DEREF                      4: _var_var_26
                        1516    BINARY_SUBSCR                   
                        1518    STORE_FAST                      43: _var_var_75
                        1520    LOAD_DEREF                      8: _var_var_11
                        1522    LOAD_ATTR                       63: q_es
                        1524    LOAD_DEREF                      4: _var_var_26
                        1526    BINARY_SUBSCR                   
                        1528    STORE_FAST                      44: _var_var_76
                        1530    LOAD_DEREF                      8: _var_var_11
                        1532    LOAD_ATTR                       69: q_ia
                        1534    LOAD_DEREF                      4: _var_var_26
                        1536    BINARY_SUBSCR                   
                        1538    STORE_FAST                      45: _var_var_77
                        1540    LOAD_DEREF                      8: _var_var_11
                        1542    LOAD_ATTR                       65: Htr_em
                        1544    STORE_FAST                      46: _var_var_78
                        1546    LOAD_DEREF                      8: _var_var_11
                        1548    LOAD_ATTR                       70: Htr_if
                        1550    STORE_FAST                      47: _var_var_79
                        1552    LOAD_DEREF                      8: _var_var_11
                        1554    LOAD_ATTR                       58: Htr_ms
                        1556    STORE_FAST                      48: _var_var_80
                        1558    LOAD_DEREF                      8: _var_var_11
                        1560    LOAD_ATTR                       57: Htr_iw
                        1562    STORE_FAST                      49: _var_var_81
                        1564    LOAD_DEREF                      8: _var_var_11
                        1566    LOAD_ATTR                       56: Htr_w
                        1568    LOAD_DEREF                      8: _var_var_11
                        1570    LOAD_ATTR                       47: Af
                        1572    BINARY_TRUE_DIVIDE              
                        1574    STORE_FAST                      50: _var_var_82
                        1576    LOAD_FAST                       39: _var_var_71
                        1578    LOAD_FAST                       46: _var_var_78
                        1580    BINARY_ADD                      
                        1582    LOAD_FAST                       47: _var_var_79
                        1584    BINARY_ADD                      
                        1586    STORE_FAST                      51: _var_var_83
                        1588    LOAD_DEREF                      8: _var_var_11
                        1590    LOAD_ATTR                       55: Htr_is
                        1592    STORE_FAST                      52: _var_var_84
                        1594    LOAD_FAST                       41: _var_var_73
                        1596    LOAD_FAST                       42: _var_var_74
                        1598    BINARY_ADD                      
                        1600    LOAD_FAST                       39: _var_var_71
                        1602    LOAD_FAST                       43: _var_var_75
                        1604    LOAD_FAST                       44: _var_var_76
                        1606    BINARY_ADD                      
                        1608    LOAD_FAST                       37: _var_var_69
                        1610    LOAD_FAST                       45: _var_var_77
                        1612    LOAD_FAST                       36: _var_var_68
                        1614    BINARY_TRUE_DIVIDE              
                        1616    LOAD_FAST                       15: _var_var_47
                        1618    BINARY_ADD                      
                        1620    BINARY_MULTIPLY                 
                        1622    BINARY_ADD                      
                        1624    BINARY_MULTIPLY                 
                        1626    LOAD_FAST                       38: _var_var_70
                        1628    BINARY_TRUE_DIVIDE              
                        1630    BINARY_ADD                      
                        1632    STORE_FAST                      53: _var_var_85
                        1634    LOAD_FAST                       53: _var_var_85
                        1636    LOAD_DEREF                      8: _var_var_11
                        1638    LOAD_ATTR                       71: q_m_tot_0
                        1640    LOAD_DEREF                      4: _var_var_26
                        1642    STORE_SUBSCR                    
                        1644    LOAD_DEREF                      3: _var_var_32
                        1646    LOAD_DEREF                      8: _var_var_11
                        1648    LOAD_ATTR                       72: T_m_t_1_0
                        1650    LOAD_DEREF                      4: _var_var_26
                        1652    BINARY_SUBSCR                   
                        1654    LOAD_DEREF                      0: _var_var_29
                        1656    LOAD_FAST                       51: _var_var_83
                        1658    LOAD_FAST                       53: _var_var_85
                        1660    CALL_FUNCTION                   4
                        1662    LOAD_DEREF                      8: _var_var_11
                        1664    LOAD_ATTR                       73: T_m_t_0
                        1666    LOAD_DEREF                      4: _var_var_26
                        1668    LOAD_CONST                      20: 1
                        1670    BINARY_ADD                      
                        1672    STORE_SUBSCR                    
                        1674    LOAD_DEREF                      8: _var_var_11
                        1676    LOAD_ATTR                       72: T_m_t_1_0
                        1678    LOAD_DEREF                      4: _var_var_26
                        1680    BINARY_SUBSCR                   
                        1682    LOAD_DEREF                      8: _var_var_11
                        1684    LOAD_ATTR                       73: T_m_t_0
                        1686    LOAD_DEREF                      4: _var_var_26
                        1688    LOAD_CONST                      20: 1
                        1690    BINARY_ADD                      
                        1692    BINARY_SUBSCR                   
                        1694    BINARY_ADD                      
                        1696    LOAD_CONST                      31: 2
                        1698    BINARY_TRUE_DIVIDE              
                        1700    LOAD_DEREF                      8: _var_var_11
                        1702    LOAD_ATTR                       74: T_m_0
                        1704    LOAD_DEREF                      4: _var_var_26
                        1706    STORE_SUBSCR                    
                        1708    LOAD_FAST                       48: _var_var_80
                        1710    LOAD_DEREF                      8: _var_var_11
                        1712    LOAD_ATTR                       74: T_m_0
                        1714    LOAD_DEREF                      4: _var_var_26
                        1716    BINARY_SUBSCR                   
                        1718    BINARY_MULTIPLY                 
                        1720    LOAD_FAST                       43: _var_var_75
                        1722    BINARY_ADD                      
                        1724    LOAD_FAST                       44: _var_var_76
                        1726    BINARY_ADD                      
                        1728    LOAD_FAST                       37: _var_var_69
                        1730    LOAD_FAST                       15: _var_var_47
                        1732    LOAD_FAST                       45: _var_var_77
                        1734    LOAD_FAST                       36: _var_var_68
                        1736    BINARY_TRUE_DIVIDE              
                        1738    BINARY_ADD                      
                        1740    BINARY_MULTIPLY                 
                        1742    BINARY_ADD                      
                        1744    LOAD_FAST                       48: _var_var_80
                        1746    LOAD_FAST                       50: _var_var_82
                        1748    BINARY_ADD                      
                        1750    LOAD_FAST                       37: _var_var_69
                        1752    BINARY_ADD                      
                        1754    LOAD_FAST                       49: _var_var_81
                        1756    BINARY_ADD                      
                        1758    BINARY_TRUE_DIVIDE              
                        1760    LOAD_DEREF                      8: _var_var_11
                        1762    LOAD_ATTR                       75: T_s_0
                        1764    LOAD_DEREF                      4: _var_var_26
                        1766    STORE_SUBSCR                    
                        1768    LOAD_DEREF                      5: _var_var_33
                        1770    LOAD_CONST                      29: 2
                        1772    COMPARE_OP                      2 (==)
                        1774    POP_JUMP_IF_FALSE               1852
                        1778    LOAD_FAST                       52: _var_var_84
                        1780    LOAD_DEREF                      8: _var_var_11
                        1782    LOAD_ATTR                       75: T_s_0
                        1784    LOAD_DEREF                      4: _var_var_26
                        1786    BINARY_SUBSCR                   
                        1788    BINARY_MULTIPLY                 
                        1790    LOAD_FAST                       36: _var_var_68
                        1792    LOAD_FAST                       15: _var_var_47
                        1794    BINARY_MULTIPLY                 
                        1796    BINARY_ADD                      
                        1798    LOAD_FAST                       45: _var_var_77
                        1800    BINARY_ADD                      
                        1802    STORE_FAST                      54: _var_var_86
                        1804    LOAD_FAST                       54: _var_var_86
                        1806    LOAD_DEREF                      8: _var_var_11
                        1808    LOAD_ATTR                       76: q_a_tot_0
                        1810    LOAD_DEREF                      4: _var_var_26
                        1812    STORE_SUBSCR                    
                        1814    LOAD_DEREF                      3: _var_var_32
                        1816    LOAD_DEREF                      8: _var_var_11
                        1818    LOAD_ATTR                       77: free_float_T
                        1820    LOAD_DEREF                      4: _var_var_26
                        1822    BINARY_SUBSCR                   
                        1824    LOAD_DEREF                      7: self
                        1826    LOAD_ATTR                       78: Ct
                        1828    LOAD_FAST                       52: _var_var_84
                        1830    LOAD_FAST                       36: _var_var_68
                        1832    BINARY_ADD                      
                        1834    LOAD_FAST                       54: _var_var_86
                        1836    CALL_FUNCTION                   4
                        1838    LOAD_DEREF                      8: _var_var_11
                        1840    LOAD_ATTR                       77: free_float_T
                        1842    LOAD_DEREF                      4: _var_var_26
                        1844    LOAD_CONST                      20: 1
                        1846    BINARY_ADD                      
                        1848    STORE_SUBSCR                    
                        1850    JUMP_FORWARD                    44 (to 1896)
                        1852    LOAD_FAST                       52: _var_var_84
                        1854    LOAD_DEREF                      8: _var_var_11
                        1856    LOAD_ATTR                       75: T_s_0
                        1858    LOAD_DEREF                      4: _var_var_26
                        1860    BINARY_SUBSCR                   
                        1862    BINARY_MULTIPLY                 
                        1864    LOAD_FAST                       36: _var_var_68
                        1866    LOAD_FAST                       15: _var_var_47
                        1868    BINARY_MULTIPLY                 
                        1870    BINARY_ADD                      
                        1872    LOAD_FAST                       45: _var_var_77
                        1874    BINARY_ADD                      
                        1876    LOAD_FAST                       52: _var_var_84
                        1878    LOAD_FAST                       36: _var_var_68
                        1880    BINARY_ADD                      
                        1882    BINARY_TRUE_DIVIDE              
                        1884    LOAD_DEREF                      8: _var_var_11
                        1886    LOAD_ATTR                       77: free_float_T
                        1888    LOAD_DEREF                      4: _var_var_26
                        1890    LOAD_CONST                      20: 1
                        1892    BINARY_ADD                      
                        1894    STORE_SUBSCR                    
                        1896    LOAD_CONST                      50: 0.3
                        1898    LOAD_DEREF                      8: _var_var_11
                        1900    LOAD_ATTR                       77: free_float_T
                        1902    LOAD_DEREF                      4: _var_var_26
                        1904    BINARY_SUBSCR                   
                        1906    BINARY_MULTIPLY                 
                        1908    LOAD_CONST                      25: 0.7
                        1910    LOAD_DEREF                      8: _var_var_11
                        1912    LOAD_ATTR                       75: T_s_0
                        1914    LOAD_DEREF                      4: _var_var_26
                        1916    BINARY_SUBSCR                   
                        1918    BINARY_MULTIPLY                 
                        1920    BINARY_ADD                      
                        1922    LOAD_DEREF                      8: _var_var_11
                        1924    LOAD_ATTR                       79: T_op_0
                        1926    LOAD_DEREF                      4: _var_var_26
                        1928    STORE_SUBSCR                    
                        1930    LOAD_DEREF                      8: _var_var_11
                        1932    LOAD_ATTR                       77: free_float_T
                        1934    LOAD_DEREF                      4: _var_var_26
                        1936    LOAD_CONST                      20: 1
                        1938    BINARY_ADD                      
                        1940    BINARY_SUBSCR                   
                        1942    STORE_FAST                      55: _var_var_87
                        1944    LOAD_DEREF                      8: _var_var_11
                        1946    LOAD_ATTR                       80: T_set_H
                        1948    LOAD_DEREF                      4: _var_var_26
                        1950    BINARY_SUBSCR                   
                        1952    STORE_FAST                      56: _var_var_88
                        1954    LOAD_DEREF                      8: _var_var_11
                        1956    LOAD_ATTR                       81: T_set_C
                        1958    LOAD_DEREF                      4: _var_var_26
                        1960    BINARY_SUBSCR                   
                        1962    STORE_FAST                      57: _var_var_89
                        1964    LOAD_FAST                       55: _var_var_87
                        1966    LOAD_FAST                       56: _var_var_88
                        1968    COMPARE_OP                      0 (<)
                        1970    POP_JUMP_IF_FALSE               1978
                        1974    LOAD_FAST                       56: _var_var_88
                        1976    JUMP_FORWARD                    16 (to 1994)
                        1978    LOAD_FAST                       55: _var_var_87
                        1980    LOAD_FAST                       57: _var_var_89
                        1982    COMPARE_OP                      4 (>)
                        1984    POP_JUMP_IF_FALSE               1992
                        1988    LOAD_FAST                       57: _var_var_89
                        1990    JUMP_FORWARD                    2 (to 1994)
                        1992    LOAD_FAST                       55: _var_var_87
                        1994    LOAD_DEREF                      8: _var_var_11
                        1996    LOAD_ATTR                       25: T_air_set
                        1998    LOAD_DEREF                      4: _var_var_26
                        2000    LOAD_CONST                      20: 1
                        2002    BINARY_ADD                      
                        2004    STORE_SUBSCR                    
                        2006    LOAD_FAST                       41: _var_var_73
                        2008    LOAD_FAST                       42: _var_var_74
                        2010    BINARY_ADD                      
                        2012    LOAD_FAST                       39: _var_var_71
                        2014    LOAD_FAST                       43: _var_var_75
                        2016    LOAD_FAST                       44: _var_var_76
                        2018    BINARY_ADD                      
                        2020    LOAD_FAST                       37: _var_var_69
                        2022    LOAD_FAST                       45: _var_var_77
                        2024    LOAD_CONST                      51: 10
                        2026    BINARY_ADD                      
                        2028    LOAD_FAST                       36: _var_var_68
                        2030    BINARY_TRUE_DIVIDE              
                        2032    LOAD_FAST                       15: _var_var_47
                        2034    BINARY_ADD                      
                        2036    BINARY_MULTIPLY                 
                        2038    BINARY_ADD                      
                        2040    BINARY_MULTIPLY                 
                        2042    LOAD_FAST                       38: _var_var_70
                        2044    BINARY_TRUE_DIVIDE              
                        2046    BINARY_ADD                      
                        2048    STORE_FAST                      58: _var_var_90
                        2050    LOAD_FAST                       58: _var_var_90
                        2052    LOAD_DEREF                      8: _var_var_11
                        2054    LOAD_ATTR                       82: q_m_tot_un
                        2056    LOAD_DEREF                      4: _var_var_26
                        2058    STORE_SUBSCR                    
                        2060    LOAD_DEREF                      3: _var_var_32
                        2062    LOAD_DEREF                      8: _var_var_11
                        2064    LOAD_ATTR                       83: T_m_t_1_un
                        2066    LOAD_DEREF                      4: _var_var_26
                        2068    BINARY_SUBSCR                   
                        2070    LOAD_DEREF                      0: _var_var_29
                        2072    LOAD_FAST                       51: _var_var_83
                        2074    LOAD_FAST                       58: _var_var_90
                        2076    CALL_FUNCTION                   4
                        2078    LOAD_DEREF                      8: _var_var_11
                        2080    LOAD_ATTR                       84: T_m_t_un
                        2082    LOAD_DEREF                      4: _var_var_26
                        2084    LOAD_CONST                      20: 1
                        2086    BINARY_ADD                      
                        2088    STORE_SUBSCR                    
                        2090    LOAD_DEREF                      8: _var_var_11
                        2092    LOAD_ATTR                       83: T_m_t_1_un
                        2094    LOAD_DEREF                      4: _var_var_26
                        2096    BINARY_SUBSCR                   
                        2098    LOAD_DEREF                      8: _var_var_11
                        2100    LOAD_ATTR                       84: T_m_t_un
                        2102    LOAD_DEREF                      4: _var_var_26
                        2104    LOAD_CONST                      20: 1
                        2106    BINARY_ADD                      
                        2108    BINARY_SUBSCR                   
                        2110    BINARY_ADD                      
                        2112    LOAD_CONST                      31: 2
                        2114    BINARY_TRUE_DIVIDE              
                        2116    LOAD_DEREF                      8: _var_var_11
                        2118    LOAD_ATTR                       85: T_m_un
                        2120    LOAD_DEREF                      4: _var_var_26
                        2122    STORE_SUBSCR                    
                        2124    LOAD_FAST                       48: _var_var_80
                        2126    LOAD_DEREF                      8: _var_var_11
                        2128    LOAD_ATTR                       85: T_m_un
                        2130    LOAD_DEREF                      4: _var_var_26
                        2132    BINARY_SUBSCR                   
                        2134    BINARY_MULTIPLY                 
                        2136    LOAD_FAST                       43: _var_var_75
                        2138    BINARY_ADD                      
                        2140    LOAD_FAST                       44: _var_var_76
                        2142    BINARY_ADD                      
                        2144    LOAD_FAST                       37: _var_var_69
                        2146    LOAD_FAST                       15: _var_var_47
                        2148    LOAD_FAST                       45: _var_var_77
                        2150    LOAD_CONST                      51: 10
                        2152    BINARY_ADD                      
                        2154    LOAD_FAST                       36: _var_var_68
                        2156    BINARY_TRUE_DIVIDE              
                        2158    BINARY_ADD                      
                        2160    BINARY_MULTIPLY                 
                        2162    BINARY_ADD                      
                        2164    LOAD_FAST                       48: _var_var_80
                        2166    LOAD_FAST                       50: _var_var_82
                        2168    BINARY_ADD                      
                        2170    LOAD_FAST                       37: _var_var_69
                        2172    BINARY_ADD                      
                        2174    LOAD_FAST                       49: _var_var_81
                        2176    BINARY_ADD                      
                        2178    BINARY_TRUE_DIVIDE              
                        2180    LOAD_DEREF                      8: _var_var_11
                        2182    LOAD_ATTR                       86: T_s_un
                        2184    LOAD_DEREF                      4: _var_var_26
                        2186    STORE_SUBSCR                    
                        2188    LOAD_DEREF                      5: _var_var_33
                        2190    LOAD_CONST                      29: 2
                        2192    COMPARE_OP                      2 (==)
                        2194    POP_JUMP_IF_FALSE               2276
                        2198    LOAD_FAST                       52: _var_var_84
                        2200    LOAD_DEREF                      8: _var_var_11
                        2202    LOAD_ATTR                       86: T_s_un
                        2204    LOAD_DEREF                      4: _var_var_26
                        2206    BINARY_SUBSCR                   
                        2208    BINARY_MULTIPLY                 
                        2210    LOAD_FAST                       36: _var_var_68
                        2212    LOAD_FAST                       15: _var_var_47
                        2214    BINARY_MULTIPLY                 
                        2216    BINARY_ADD                      
                        2218    LOAD_FAST                       45: _var_var_77
                        2220    BINARY_ADD                      
                        2222    LOAD_CONST                      51: 10
                        2224    BINARY_ADD                      
                        2226    STORE_FAST                      59: _var_var_91
                        2228    LOAD_FAST                       59: _var_var_91
                        2230    LOAD_DEREF                      8: _var_var_11
                        2232    LOAD_ATTR                       87: q_a_tot_un
                        2234    LOAD_DEREF                      4: _var_var_26
                        2236    STORE_SUBSCR                    
                        2238    LOAD_DEREF                      3: _var_var_32
                        2240    LOAD_DEREF                      8: _var_var_11
                        2242    LOAD_ATTR                       88: T_air_un
                        2244    LOAD_DEREF                      4: _var_var_26
                        2246    BINARY_SUBSCR                   
                        2248    LOAD_DEREF                      7: self
                        2250    LOAD_ATTR                       78: Ct
                        2252    LOAD_FAST                       52: _var_var_84
                        2254    LOAD_FAST                       36: _var_var_68
                        2256    BINARY_ADD                      
                        2258    LOAD_FAST                       59: _var_var_91
                        2260    CALL_FUNCTION                   4
                        2262    LOAD_DEREF                      8: _var_var_11
                        2264    LOAD_ATTR                       88: T_air_un
                        2266    LOAD_DEREF                      4: _var_var_26
                        2268    LOAD_CONST                      20: 1
                        2270    BINARY_ADD                      
                        2272    STORE_SUBSCR                    
                        2274    JUMP_FORWARD                    48 (to 2324)
                        2276    LOAD_FAST                       52: _var_var_84
                        2278    LOAD_DEREF                      8: _var_var_11
                        2280    LOAD_ATTR                       86: T_s_un
                        2282    LOAD_DEREF                      4: _var_var_26
                        2284    BINARY_SUBSCR                   
                        2286    BINARY_MULTIPLY                 
                        2288    LOAD_FAST                       36: _var_var_68
                        2290    LOAD_FAST                       15: _var_var_47
                        2292    BINARY_MULTIPLY                 
                        2294    BINARY_ADD                      
                        2296    LOAD_FAST                       45: _var_var_77
                        2298    BINARY_ADD                      
                        2300    LOAD_CONST                      51: 10
                        2302    BINARY_ADD                      
                        2304    LOAD_FAST                       52: _var_var_84
                        2306    LOAD_FAST                       36: _var_var_68
                        2308    BINARY_ADD                      
                        2310    BINARY_TRUE_DIVIDE              
                        2312    LOAD_DEREF                      8: _var_var_11
                        2314    LOAD_ATTR                       88: T_air_un
                        2316    LOAD_DEREF                      4: _var_var_26
                        2318    LOAD_CONST                      20: 1
                        2320    BINARY_ADD                      
                        2322    STORE_SUBSCR                    
                        2324    LOAD_CONST                      50: 0.3
                        2326    LOAD_DEREF                      8: _var_var_11
                        2328    LOAD_ATTR                       88: T_air_un
                        2330    LOAD_DEREF                      4: _var_var_26
                        2332    BINARY_SUBSCR                   
                        2334    BINARY_MULTIPLY                 
                        2336    LOAD_CONST                      25: 0.7
                        2338    LOAD_DEREF                      8: _var_var_11
                        2340    LOAD_ATTR                       86: T_s_un
                        2342    LOAD_DEREF                      4: _var_var_26
                        2344    BINARY_SUBSCR                   
                        2346    BINARY_MULTIPLY                 
                        2348    BINARY_ADD                      
                        2350    LOAD_DEREF                      8: _var_var_11
                        2352    LOAD_ATTR                       89: T_op_un
                        2354    LOAD_DEREF                      4: _var_var_26
                        2356    STORE_SUBSCR                    
                        2358    LOAD_DEREF                      8: _var_var_11
                        2360    LOAD_ATTR                       25: T_air_set
                        2362    LOAD_DEREF                      4: _var_var_26
                        2364    LOAD_CONST                      20: 1
                        2366    BINARY_ADD                      
                        2368    BINARY_SUBSCR                   
                        2370    STORE_FAST                      60: _var_var_92
                        2372    LOAD_DEREF                      8: _var_var_11
                        2374    LOAD_ATTR                       88: T_air_un
                        2376    LOAD_DEREF                      4: _var_var_26
                        2378    LOAD_CONST                      20: 1
                        2380    BINARY_ADD                      
                        2382    BINARY_SUBSCR                   
                        2384    STORE_FAST                      61: _var_var_93
                        2386    LOAD_FAST                       56: _var_var_88
                        2388    LOAD_FAST                       55: _var_var_87
                        2390    DUP_TOP                         
                        2392    ROT_THREE                       
                        2394    COMPARE_OP                      1 (<=)
                        2396    POP_JUMP_IF_FALSE               2410
                        2400    LOAD_FAST                       57: _var_var_89
                        2402    COMPARE_OP                      1 (<=)
                        2404    POP_JUMP_IF_TRUE                2428
                        2408    JUMP_FORWARD                    2 (to 2412)
                        2410    POP_TOP                         
                        2412    LOAD_DEREF                      8: _var_var_11
                        2414    LOAD_ATTR                       90: HVAC_frac
                        2416    LOAD_DEREF                      4: _var_var_26
                        2418    BINARY_SUBSCR                   
                        2420    LOAD_CONST                      19: 0
                        2422    COMPARE_OP                      2 (==)
                        2424    POP_JUMP_IF_FALSE               2440
                        2428    LOAD_CONST                      38: 0
                        2430    LOAD_DEREF                      8: _var_var_11
                        2432    LOAD_ATTR                       91: q_hc
                        2434    LOAD_DEREF                      4: _var_var_26
                        2436    STORE_SUBSCR                    
                        2438    JUMP_FORWARD                    36 (to 2476)
                        2440    LOAD_DEREF                      8: _var_var_11
                        2442    LOAD_ATTR                       90: HVAC_frac
                        2444    LOAD_DEREF                      4: _var_var_26
                        2446    BINARY_SUBSCR                   
                        2448    LOAD_CONST                      51: 10
                        2450    BINARY_MULTIPLY                 
                        2452    LOAD_FAST                       60: _var_var_92
                        2454    LOAD_FAST                       55: _var_var_87
                        2456    BINARY_SUBTRACT                 
                        2458    BINARY_MULTIPLY                 
                        2460    LOAD_FAST                       61: _var_var_93
                        2462    LOAD_FAST                       55: _var_var_87
                        2464    BINARY_SUBTRACT                 
                        2466    BINARY_TRUE_DIVIDE              
                        2468    LOAD_DEREF                      8: _var_var_11
                        2470    LOAD_ATTR                       91: q_hc
                        2472    LOAD_DEREF                      4: _var_var_26
                        2474    STORE_SUBSCR                    
                        2476    LOAD_FAST                       41: _var_var_73
                        2478    LOAD_FAST                       42: _var_var_74
                        2480    BINARY_ADD                      
                        2482    LOAD_FAST                       39: _var_var_71
                        2484    LOAD_FAST                       43: _var_var_75
                        2486    LOAD_FAST                       44: _var_var_76
                        2488    BINARY_ADD                      
                        2490    LOAD_FAST                       37: _var_var_69
                        2492    LOAD_FAST                       45: _var_var_77
                        2494    LOAD_DEREF                      8: _var_var_11
                        2496    LOAD_ATTR                       91: q_hc
                        2498    LOAD_DEREF                      4: _var_var_26
                        2500    BINARY_SUBSCR                   
                        2502    BINARY_ADD                      
                        2504    LOAD_FAST                       36: _var_var_68
                        2506    BINARY_TRUE_DIVIDE              
                        2508    LOAD_FAST                       15: _var_var_47
                        2510    BINARY_ADD                      
                        2512    BINARY_MULTIPLY                 
                        2514    BINARY_ADD                      
                        2516    BINARY_MULTIPLY                 
                        2518    LOAD_FAST                       38: _var_var_70
                        2520    BINARY_TRUE_DIVIDE              
                        2522    BINARY_ADD                      
                        2524    STORE_FAST                      62: _var_var_94
                        2526    LOAD_FAST                       62: _var_var_94
                        2528    LOAD_DEREF                      8: _var_var_11
                        2530    LOAD_ATTR                       92: q_m_tot_hc
                        2532    LOAD_DEREF                      4: _var_var_26
                        2534    STORE_SUBSCR                    
                        2536    LOAD_DEREF                      3: _var_var_32
                        2538    LOAD_DEREF                      8: _var_var_11
                        2540    LOAD_ATTR                       93: T_m_t_1_hc
                        2542    LOAD_DEREF                      4: _var_var_26
                        2544    BINARY_SUBSCR                   
                        2546    LOAD_DEREF                      0: _var_var_29
                        2548    LOAD_FAST                       51: _var_var_83
                        2550    LOAD_FAST                       62: _var_var_94
                        2552    CALL_FUNCTION                   4
                        2554    LOAD_DEREF                      8: _var_var_11
                        2556    LOAD_ATTR                       94: T_m_t_hc
                        2558    LOAD_DEREF                      4: _var_var_26
                        2560    LOAD_CONST                      20: 1
                        2562    BINARY_ADD                      
                        2564    STORE_SUBSCR                    
                        2566    LOAD_DEREF                      8: _var_var_11
                        2568    LOAD_ATTR                       93: T_m_t_1_hc
                        2570    LOAD_DEREF                      4: _var_var_26
                        2572    BINARY_SUBSCR                   
                        2574    LOAD_DEREF                      8: _var_var_11
                        2576    LOAD_ATTR                       94: T_m_t_hc
                        2578    LOAD_DEREF                      4: _var_var_26
                        2580    LOAD_CONST                      20: 1
                        2582    BINARY_ADD                      
                        2584    BINARY_SUBSCR                   
                        2586    BINARY_ADD                      
                        2588    LOAD_CONST                      31: 2
                        2590    BINARY_TRUE_DIVIDE              
                        2592    LOAD_DEREF                      8: _var_var_11
                        2594    LOAD_ATTR                       95: T_m_hc
                        2596    LOAD_DEREF                      4: _var_var_26
                        2598    STORE_SUBSCR                    
                        2600    LOAD_FAST                       48: _var_var_80
                        2602    LOAD_DEREF                      8: _var_var_11
                        2604    LOAD_ATTR                       95: T_m_hc
                        2606    LOAD_DEREF                      4: _var_var_26
                        2608    BINARY_SUBSCR                   
                        2610    BINARY_MULTIPLY                 
                        2612    LOAD_FAST                       43: _var_var_75
                        2614    BINARY_ADD                      
                        2616    LOAD_FAST                       44: _var_var_76
                        2618    BINARY_ADD                      
                        2620    LOAD_FAST                       37: _var_var_69
                        2622    LOAD_FAST                       15: _var_var_47
                        2624    LOAD_FAST                       45: _var_var_77
                        2626    LOAD_DEREF                      8: _var_var_11
                        2628    LOAD_ATTR                       91: q_hc
                        2630    LOAD_DEREF                      4: _var_var_26
                        2632    BINARY_SUBSCR                   
                        2634    BINARY_ADD                      
                        2636    LOAD_FAST                       36: _var_var_68
                        2638    BINARY_TRUE_DIVIDE              
                        2640    BINARY_ADD                      
                        2642    BINARY_MULTIPLY                 
                        2644    BINARY_ADD                      
                        2646    LOAD_FAST                       48: _var_var_80
                        2648    LOAD_FAST                       50: _var_var_82
                        2650    BINARY_ADD                      
                        2652    LOAD_FAST                       37: _var_var_69
                        2654    BINARY_ADD                      
                        2656    LOAD_FAST                       49: _var_var_81
                        2658    BINARY_ADD                      
                        2660    BINARY_TRUE_DIVIDE              
                        2662    LOAD_DEREF                      8: _var_var_11
                        2664    LOAD_ATTR                       96: T_s_hc
                        2666    LOAD_DEREF                      4: _var_var_26
                        2668    STORE_SUBSCR                    
                        2670    LOAD_DEREF                      5: _var_var_33
                        2672    LOAD_CONST                      29: 2
                        2674    COMPARE_OP                      2 (==)
                        2676    POP_JUMP_IF_FALSE               2764
                        2680    LOAD_FAST                       52: _var_var_84
                        2682    LOAD_DEREF                      8: _var_var_11
                        2684    LOAD_ATTR                       96: T_s_hc
                        2686    LOAD_DEREF                      4: _var_var_26
                        2688    BINARY_SUBSCR                   
                        2690    BINARY_MULTIPLY                 
                        2692    LOAD_FAST                       36: _var_var_68
                        2694    LOAD_FAST                       15: _var_var_47
                        2696    BINARY_MULTIPLY                 
                        2698    BINARY_ADD                      
                        2700    LOAD_FAST                       45: _var_var_77
                        2702    BINARY_ADD                      
                        2704    LOAD_DEREF                      8: _var_var_11
                        2706    LOAD_ATTR                       91: q_hc
                        2708    LOAD_DEREF                      4: _var_var_26
                        2710    BINARY_SUBSCR                   
                        2712    BINARY_ADD                      
                        2714    STORE_FAST                      63: _var_var_95
                        2716    LOAD_FAST                       63: _var_var_95
                        2718    LOAD_DEREF                      8: _var_var_11
                        2720    LOAD_ATTR                       97: q_a_tot_hc
                        2722    LOAD_DEREF                      4: _var_var_26
                        2724    STORE_SUBSCR                    
                        2726    LOAD_DEREF                      3: _var_var_32
                        2728    LOAD_DEREF                      8: _var_var_11
                        2730    LOAD_ATTR                       98: T_air_hc
                        2732    LOAD_DEREF                      4: _var_var_26
                        2734    BINARY_SUBSCR                   
                        2736    LOAD_DEREF                      7: self
                        2738    LOAD_ATTR                       78: Ct
                        2740    LOAD_FAST                       52: _var_var_84
                        2742    LOAD_FAST                       36: _var_var_68
                        2744    BINARY_ADD                      
                        2746    LOAD_FAST                       63: _var_var_95
                        2748    CALL_FUNCTION                   4
                        2750    LOAD_DEREF                      8: _var_var_11
                        2752    LOAD_ATTR                       98: T_air_hc
                        2754    LOAD_DEREF                      4: _var_var_26
                        2756    LOAD_CONST                      20: 1
                        2758    BINARY_ADD                      
                        2760    STORE_SUBSCR                    
                        2762    JUMP_FORWARD                    54 (to 2818)
                        2764    LOAD_FAST                       52: _var_var_84
                        2766    LOAD_DEREF                      8: _var_var_11
                        2768    LOAD_ATTR                       96: T_s_hc
                        2770    LOAD_DEREF                      4: _var_var_26
                        2772    BINARY_SUBSCR                   
                        2774    BINARY_MULTIPLY                 
                        2776    LOAD_FAST                       36: _var_var_68
                        2778    LOAD_FAST                       15: _var_var_47
                        2780    BINARY_MULTIPLY                 
                        2782    BINARY_ADD                      
                        2784    LOAD_FAST                       45: _var_var_77
                        2786    BINARY_ADD                      
                        2788    LOAD_DEREF                      8: _var_var_11
                        2790    LOAD_ATTR                       91: q_hc
                        2792    LOAD_DEREF                      4: _var_var_26
                        2794    BINARY_SUBSCR                   
                        2796    BINARY_ADD                      
                        2798    LOAD_FAST                       52: _var_var_84
                        2800    LOAD_FAST                       36: _var_var_68
                        2802    BINARY_ADD                      
                        2804    BINARY_TRUE_DIVIDE              
                        2806    LOAD_DEREF                      8: _var_var_11
                        2808    LOAD_ATTR                       98: T_air_hc
                        2810    LOAD_DEREF                      4: _var_var_26
                        2812    LOAD_CONST                      20: 1
                        2814    BINARY_ADD                      
                        2816    STORE_SUBSCR                    
                        2818    LOAD_CONST                      50: 0.3
                        2820    LOAD_DEREF                      8: _var_var_11
                        2822    LOAD_ATTR                       98: T_air_hc
                        2824    LOAD_DEREF                      4: _var_var_26
                        2826    LOAD_CONST                      20: 1
                        2828    BINARY_ADD                      
                        2830    BINARY_SUBSCR                   
                        2832    BINARY_MULTIPLY                 
                        2834    LOAD_CONST                      25: 0.7
                        2836    LOAD_DEREF                      8: _var_var_11
                        2838    LOAD_ATTR                       96: T_s_hc
                        2840    LOAD_DEREF                      4: _var_var_26
                        2842    BINARY_SUBSCR                   
                        2844    BINARY_MULTIPLY                 
                        2846    BINARY_ADD                      
                        2848    LOAD_DEREF                      8: _var_var_11
                        2850    LOAD_ATTR                       99: T_op_hc
                        2852    LOAD_DEREF                      4: _var_var_26
                        2854    STORE_SUBSCR                    
                        2856    LOAD_DEREF                      8: _var_var_11
                        2858    LOAD_ATTR                       91: q_hc
                        2860    LOAD_DEREF                      4: _var_var_26
                        2862    BINARY_SUBSCR                   
                        2864    LOAD_CONST                      19: 0
                        2866    COMPARE_OP                      4 (>)
                        2868    POP_JUMP_IF_FALSE               2930
                        2872    LOAD_DEREF                      8: _var_var_11
                        2874    LOAD_ATTR                       91: q_hc
                        2876    LOAD_DEREF                      4: _var_var_26
                        2878    BINARY_SUBSCR                   
                        2880    LOAD_DEREF                      8: _var_var_11
                        2882    LOAD_ATTR                       100: q_H_nd
                        2884    LOAD_DEREF                      4: _var_var_26
                        2886    STORE_SUBSCR                    
                        2888    LOAD_FAST                       17: _var_var_49
                        2890    LOAD_DEREF                      8: _var_var_11
                        2892    LOAD_ATTR                       101: HVAC
                        2894    LOAD_ATTR                       102: hvac_name
                        2896    BINARY_SUBSCR                   
                        2898    LOAD_CONST                      19: 0
                        2900    DUP_TOP_TWO                     
                        2902    BINARY_SUBSCR                   
                        2904    LOAD_DEREF                      8: _var_var_11
                        2906    LOAD_ATTR                       100: q_H_nd
                        2908    LOAD_DEREF                      4: _var_var_26
                        2910    BINARY_SUBSCR                   
                        2912    LOAD_DEREF                      8: _var_var_11
                        2914    LOAD_ATTR                       47: Af
                        2916    BINARY_MULTIPLY                 
                        2918    LOAD_CONST                      18: 1000
                        2920    BINARY_TRUE_DIVIDE              
                        2922    INPLACE_ADD                     
                        2924    ROT_THREE                       
                        2926    STORE_SUBSCR                    
                        2928    JUMP_FORWARD                    62 (to 2992)
                        2930    LOAD_DEREF                      8: _var_var_11
                        2932    LOAD_ATTR                       91: q_hc
                        2934    LOAD_DEREF                      4: _var_var_26
                        2936    BINARY_SUBSCR                   
                        2938    UNARY_NEGATIVE                  
                        2940    LOAD_DEREF                      8: _var_var_11
                        2942    LOAD_ATTR                       51: q_C_nd
                        2944    LOAD_DEREF                      4: _var_var_26
                        2946    LOAD_CONST                      20: 1
                        2948    BINARY_ADD                      
                        2950    STORE_SUBSCR                    
                        2952    LOAD_FAST                       17: _var_var_49
                        2954    LOAD_DEREF                      8: _var_var_11
                        2956    LOAD_ATTR                       101: HVAC
                        2958    LOAD_ATTR                       102: hvac_name
                        2960    BINARY_SUBSCR                   
                        2962    LOAD_CONST                      20: 1
                        2964    DUP_TOP_TWO                     
                        2966    BINARY_SUBSCR                   
                        2968    LOAD_DEREF                      8: _var_var_11
                        2970    LOAD_ATTR                       51: q_C_nd
                        2972    LOAD_DEREF                      4: _var_var_26
                        2974    BINARY_SUBSCR                   
                        2976    LOAD_DEREF                      8: _var_var_11
                        2978    LOAD_ATTR                       47: Af
                        2980    BINARY_MULTIPLY                 
                        2982    LOAD_CONST                      18: 1000
                        2984    BINARY_TRUE_DIVIDE              
                        2986    INPLACE_ADD                     
                        2988    ROT_THREE                       
                        2990    STORE_SUBSCR                    
                        2992    JUMP_ABSOLUTE                   416
                        2996    LOAD_FAST                       17: _var_var_49
                        2998    LOAD_METHOD                     9: items
                        3000    CALL_METHOD                     0
                        3002    GET_ITER                        
                        3004    FOR_ITER                        230 (to 3236)
                        3006    UNPACK_SEQUENCE                 2
                        3008    STORE_FAST                      64: _var_var_96
                        3010    STORE_FAST                      65: _var_var_97
                        3012    LOAD_DEREF                      6: _var_var_34
                        3014    LOAD_FAST                       9: _var_var_42
                        3016    LOAD_FAST                       64: _var_var_96
                        3018    BINARY_SUBSCR                   
                        3020    LOAD_CONST                      19: 0
                        3022    BINARY_SUBSCR                   
                        3024    BINARY_SUBSCR                   
                        3026    STORE_FAST                      66: _var_var_98
                        3028    LOAD_FAST                       65: _var_var_97
                        3030    LOAD_CONST                      19: 0
                        3032    BINARY_SUBSCR                   
                        3034    LOAD_FAST                       66: _var_var_98
                        3036    LOAD_ATTR                       101: HVAC
                        3038    LOAD_ATTR                       103: heat_cap
                        3040    COMPARE_OP                      4 (>)
                        3042    POP_JUMP_IF_FALSE               3130
                        3046    LOAD_FAST                       9: _var_var_42
                        3048    LOAD_FAST                       64: _var_var_96
                        3050    BINARY_SUBSCR                   
                        3052    GET_ITER                        
                        3054    FOR_ITER                        74 (to 3130)
                        3056    STORE_FAST                      14: _var_var_12
                        3058    LOAD_DEREF                      6: _var_var_34
                        3060    LOAD_FAST                       14: _var_var_12
                        3062    BINARY_SUBSCR                   
                        3064    STORE_DEREF                     8: _var_var_11
                        3066    LOAD_DEREF                      8: _var_var_11
                        3068    LOAD_ATTR                       91: q_hc
                        3070    LOAD_DEREF                      4: _var_var_26
                        3072    BINARY_SUBSCR                   
                        3074    LOAD_CONST                      19: 0
                        3076    COMPARE_OP                      4 (>)
                        3078    POP_JUMP_IF_FALSE               3054
                        3082    LOAD_DEREF                      8: _var_var_11
                        3084    LOAD_ATTR                       91: q_hc
                        3086    LOAD_DEREF                      4: _var_var_26
                        3088    BINARY_SUBSCR                   
                        3090    LOAD_FAST                       65: _var_var_97
                        3092    LOAD_CONST                      19: 0
                        3094    BINARY_SUBSCR                   
                        3096    BINARY_TRUE_DIVIDE              
                        3098    LOAD_DEREF                      8: _var_var_11
                        3100    LOAD_ATTR                       101: HVAC
                        3102    LOAD_ATTR                       103: heat_cap
                        3104    BINARY_MULTIPLY                 
                        3106    LOAD_DEREF                      8: _var_var_11
                        3108    LOAD_ATTR                       91: q_hc
                        3110    LOAD_DEREF                      4: _var_var_26
                        3112    STORE_SUBSCR                    
                        3114    LOAD_FAST                       4: _var_var_37
                        3116    LOAD_DEREF                      8: _var_var_11
                        3118    LOAD_DEREF                      4: _var_var_26
                        3120    LOAD_FAST                       15: _var_var_47
                        3122    CALL_FUNCTION                   3
                        3124    POP_TOP                         
                        3126    JUMP_ABSOLUTE                   3054
                        3130    LOAD_FAST                       65: _var_var_97
                        3132    LOAD_CONST                      20: 1
                        3134    BINARY_SUBSCR                   
                        3136    LOAD_FAST                       66: _var_var_98
                        3138    LOAD_ATTR                       101: HVAC
                        3140    LOAD_ATTR                       104: cool_cap
                        3142    COMPARE_OP                      4 (>)
                        3144    POP_JUMP_IF_FALSE               3004
                        3148    LOAD_FAST                       9: _var_var_42
                        3150    LOAD_FAST                       64: _var_var_96
                        3152    BINARY_SUBSCR                   
                        3154    GET_ITER                        
                        3156    FOR_ITER                        74 (to 3232)
                        3158    STORE_FAST                      14: _var_var_12
                        3160    LOAD_DEREF                      6: _var_var_34
                        3162    LOAD_FAST                       14: _var_var_12
                        3164    BINARY_SUBSCR                   
                        3166    STORE_DEREF                     8: _var_var_11
                        3168    LOAD_DEREF                      8: _var_var_11
                        3170    LOAD_ATTR                       91: q_hc
                        3172    LOAD_DEREF                      4: _var_var_26
                        3174    BINARY_SUBSCR                   
                        3176    LOAD_CONST                      19: 0
                        3178    COMPARE_OP                      0 (<)
                        3180    POP_JUMP_IF_FALSE               3156
                        3184    LOAD_DEREF                      8: _var_var_11
                        3186    LOAD_ATTR                       91: q_hc
                        3188    LOAD_DEREF                      4: _var_var_26
                        3190    BINARY_SUBSCR                   
                        3192    LOAD_FAST                       65: _var_var_97
                        3194    LOAD_CONST                      20: 1
                        3196    BINARY_SUBSCR                   
                        3198    BINARY_TRUE_DIVIDE              
                        3200    LOAD_DEREF                      8: _var_var_11
                        3202    LOAD_ATTR                       101: HVAC
                        3204    LOAD_ATTR                       104: cool_cap
                        3206    BINARY_MULTIPLY                 
                        3208    LOAD_DEREF                      8: _var_var_11
                        3210    LOAD_ATTR                       91: q_hc
                        3212    LOAD_DEREF                      4: _var_var_26
                        3214    STORE_SUBSCR                    
                        3216    LOAD_FAST                       4: _var_var_37
                        3218    LOAD_DEREF                      8: _var_var_11
                        3220    LOAD_DEREF                      4: _var_var_26
                        3222    LOAD_FAST                       15: _var_var_47
                        3224    CALL_FUNCTION                   3
                        3226    POP_TOP                         
                        3228    JUMP_ABSOLUTE                   3156
                        3232    JUMP_ABSOLUTE                   3004
                        3236    JUMP_ABSOLUTE                   314
                        3240    POP_BLOCK                       
                        3242    LOAD_CONST                      52: '__pyarmor_exit_47102__'
                        3244    NOP                             
                        3246    NOP                             
                        3248    LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14\x96\x0c\x00\x00\x00\x00\x00\x00'
                        3250    CALL_FUNCTION                   1
                        3252    POP_TOP                         
                        3254    JUMP_FORWARD                    14 (to 3270)
                        3256    LOAD_CONST                      52: '__pyarmor_exit_47102__'
                        3258    NOP                             
                        3260    NOP                             
                        3262    LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14\x96\x0c\x00\x00\x00\x00\x00\x00'
                        3264    CALL_FUNCTION                   1
                        3266    POP_TOP                         
                        3268    RERAISE                         
                        3270    LOAD_CONST                      0: None
                        3272    RETURN_VALUE                    
                'Simulation.iterate'
                [Code]
                    File Name: <frozen simulation>
                    Object Name: hourlyAggregate
                    Arg Count: 1
                    Pos Only Arg Count: 0
                    KW Only Arg Count: 0
                    Locals: 4
                    Stack Size: 8
                    Flags: 0x20000043 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NOFREE | CO_PYARMOR_OBFUSCATED)
                    [Names]
                        'list'
                        'pre_dict'
                        'items'
                        'q_hc'
                        'Af'
                        'q_H_nd'
                        'q_C_nd'
                        'np'
                        'where'
                        'NV_hrs'
                        'q_NV_ac'
                        'T_air_hc'
                        'T_s_hc'
                        'qi_li'
                        'qi_app'
                        'q_sol_w'
                        'q_sol'
                        'q_sol_op'
                        'qv_inf'
                        'q_inf'
                        'qv_NV'
                        'q_NV'
                    [Var Names]
                        'self'
                        '__assert_armored__'
                        '_var_var_12'
                        '_var_var_11'
                    [Free Vars]
                    [Cell Vars]
                    [Constants]
                        None
                        '__pyarmor_assert_47118__'
                        'Simulation.hourlyAggregate.<locals>.<lambda>'
                        '__pyarmor_enter_47119__'
                        b'<COAddr>\x03\x00\x00\x14.\x01\x00\x00\x00\x00\x00\x00'
                        'Zones'
                        3600
                        1
                        0
                        0.333333
                        '__pyarmor_exit_47120__'
                    [Disassembly]
                        0       NOP                             
                        2       NOP                             
                        4       NOP                             
                        6       NOP                             
                        8       LOAD_CONST                      3: '__pyarmor_enter_47119__'
                        10      NOP                             
                        12      NOP                             
                        14      LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x14.\x01\x00\x00\x00\x00\x00\x00'
                        16      CALL_FUNCTION                   1
                        18      POP_TOP                         
                        20      SETUP_FINALLY                   312 (to 336)
                        24      LOAD_GLOBAL                     0: list
                        26      LOAD_FAST                       0: self
                        28      LOAD_ATTR                       1: pre_dict
                        30      LOAD_CONST                      5: 'Zones'
                        32      BINARY_SUBSCR                   
                        34      LOAD_METHOD                     2: items
                        36      CALL_METHOD                     0
                        38      CALL_FUNCTION                   1
                        40      GET_ITER                        
                        42      FOR_ITER                        274 (to 320)
                        46      UNPACK_SEQUENCE                 2
                        48      STORE_FAST                      2: _var_var_12
                        50      STORE_FAST                      3: _var_var_11
                        52      LOAD_FAST                       3: _var_var_11
                        54      DUP_TOP                         
                        56      LOAD_ATTR                       3: q_hc
                        58      LOAD_FAST                       3: _var_var_11
                        60      LOAD_ATTR                       4: Af
                        62      LOAD_CONST                      6: 3600
                        64      BINARY_MULTIPLY                 
                        66      INPLACE_MULTIPLY                
                        68      ROT_TWO                         
                        70      STORE_ATTR                      3: q_hc
                        72      LOAD_FAST                       3: _var_var_11
                        74      DUP_TOP                         
                        76      LOAD_ATTR                       5: q_H_nd
                        78      LOAD_FAST                       3: _var_var_11
                        80      LOAD_ATTR                       4: Af
                        82      LOAD_CONST                      6: 3600
                        84      BINARY_MULTIPLY                 
                        86      INPLACE_MULTIPLY                
                        88      ROT_TWO                         
                        90      STORE_ATTR                      5: q_H_nd
                        92      LOAD_FAST                       3: _var_var_11
                        94      LOAD_ATTR                       6: q_C_nd
                        96      LOAD_CONST                      7: 1
                        98      LOAD_CONST                      0: None
                        100     BUILD_SLICE                     2
                        102     BINARY_SUBSCR                   
                        104     LOAD_FAST                       3: _var_var_11
                        106     LOAD_ATTR                       4: Af
                        108     BINARY_MULTIPLY                 
                        110     LOAD_CONST                      6: 3600
                        112     BINARY_MULTIPLY                 
                        114     LOAD_FAST                       3: _var_var_11
                        116     STORE_ATTR                      6: q_C_nd
                        118     LOAD_GLOBAL                     7: np
                        120     LOAD_METHOD                     8: where
                        122     LOAD_FAST                       3: _var_var_11
                        124     LOAD_ATTR                       9: NV_hrs
                        126     LOAD_CONST                      8: 0
                        128     COMPARE_OP                      2 (==)
                        130     LOAD_CONST                      8: 0
                        132     LOAD_FAST                       3: _var_var_11
                        134     LOAD_ATTR                       6: q_C_nd
                        136     CALL_METHOD                     3
                        138     LOAD_FAST                       3: _var_var_11
                        140     STORE_ATTR                      10: q_NV_ac
                        142     LOAD_FAST                       3: _var_var_11
                        144     LOAD_ATTR                       11: T_air_hc
                        146     LOAD_CONST                      7: 1
                        148     LOAD_CONST                      0: None
                        150     BUILD_SLICE                     2
                        152     BINARY_SUBSCR                   
                        154     LOAD_FAST                       3: _var_var_11
                        156     STORE_ATTR                      11: T_air_hc
                        158     LOAD_FAST                       3: _var_var_11
                        160     LOAD_ATTR                       12: T_s_hc
                        162     LOAD_CONST                      7: 1
                        164     LOAD_CONST                      0: None
                        166     BUILD_SLICE                     2
                        168     BINARY_SUBSCR                   
                        170     LOAD_FAST                       3: _var_var_11
                        172     STORE_ATTR                      12: T_s_hc
                        174     LOAD_FAST                       3: _var_var_11
                        176     DUP_TOP                         
                        178     LOAD_ATTR                       13: qi_li
                        180     LOAD_FAST                       3: _var_var_11
                        182     LOAD_ATTR                       4: Af
                        184     LOAD_CONST                      6: 3600
                        186     BINARY_MULTIPLY                 
                        188     INPLACE_MULTIPLY                
                        190     ROT_TWO                         
                        192     STORE_ATTR                      13: qi_li
                        194     LOAD_FAST                       3: _var_var_11
                        196     DUP_TOP                         
                        198     LOAD_ATTR                       14: qi_app
                        200     LOAD_FAST                       3: _var_var_11
                        202     LOAD_ATTR                       4: Af
                        204     LOAD_CONST                      6: 3600
                        206     BINARY_MULTIPLY                 
                        208     INPLACE_MULTIPLY                
                        210     ROT_TWO                         
                        212     STORE_ATTR                      14: qi_app
                        214     LOAD_FAST                       3: _var_var_11
                        216     DUP_TOP                         
                        218     LOAD_ATTR                       15: q_sol_w
                        220     LOAD_FAST                       3: _var_var_11
                        222     LOAD_ATTR                       4: Af
                        224     LOAD_CONST                      6: 3600
                        226     BINARY_MULTIPLY                 
                        228     INPLACE_MULTIPLY                
                        230     ROT_TWO                         
                        232     STORE_ATTR                      15: q_sol_w
                        234     LOAD_FAST                       3: _var_var_11
                        236     DUP_TOP                         
                        238     LOAD_ATTR                       16: q_sol
                        240     LOAD_FAST                       3: _var_var_11
                        242     LOAD_ATTR                       4: Af
                        244     LOAD_CONST                      6: 3600
                        246     BINARY_MULTIPLY                 
                        248     INPLACE_MULTIPLY                
                        250     ROT_TWO                         
                        252     STORE_ATTR                      16: q_sol
                        254     LOAD_FAST                       3: _var_var_11
                        256     DUP_TOP                         
                        258     LOAD_ATTR                       17: q_sol_op
                        260     LOAD_FAST                       3: _var_var_11
                        262     LOAD_ATTR                       4: Af
                        264     LOAD_CONST                      6: 3600
                        266     BINARY_MULTIPLY                 
                        268     INPLACE_MULTIPLY                
                        270     ROT_TWO                         
                        272     STORE_ATTR                      17: q_sol_op
                        274     LOAD_CONST                      9: 0.333333
                        276     LOAD_FAST                       3: _var_var_11
                        278     LOAD_ATTR                       18: qv_inf
                        280     BINARY_MULTIPLY                 
                        282     LOAD_FAST                       3: _var_var_11
                        284     LOAD_ATTR                       4: Af
                        286     BINARY_MULTIPLY                 
                        288     LOAD_CONST                      6: 3600
                        290     BINARY_MULTIPLY                 
                        292     LOAD_FAST                       3: _var_var_11
                        294     STORE_ATTR                      19: q_inf
                        296     LOAD_CONST                      9: 0.333333
                        298     LOAD_FAST                       3: _var_var_11
                        300     LOAD_ATTR                       20: qv_NV
                        302     BINARY_MULTIPLY                 
                        304     LOAD_FAST                       3: _var_var_11
                        306     LOAD_ATTR                       4: Af
                        308     BINARY_MULTIPLY                 
                        310     LOAD_CONST                      6: 3600
                        312     BINARY_MULTIPLY                 
                        314     LOAD_FAST                       3: _var_var_11
                        316     STORE_ATTR                      21: q_NV
                        318     JUMP_ABSOLUTE                   42
                        320     POP_BLOCK                       
                        322     LOAD_CONST                      10: '__pyarmor_exit_47120__'
                        324     NOP                             
                        326     NOP                             
                        328     LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x14.\x01\x00\x00\x00\x00\x00\x00'
                        330     CALL_FUNCTION                   1
                        332     POP_TOP                         
                        334     JUMP_FORWARD                    14 (to 350)
                        336     LOAD_CONST                      10: '__pyarmor_exit_47120__'
                        338     NOP                             
                        340     NOP                             
                        342     LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x14.\x01\x00\x00\x00\x00\x00\x00'
                        344     CALL_FUNCTION                   1
                        346     POP_TOP                         
                        348     RERAISE                         
                        350     LOAD_CONST                      0: None
                        352     RETURN_VALUE                    
                'Simulation.hourlyAggregate'
                [Code]
                    File Name: <frozen simulation>
                    Object Name: energy
                    Arg Count: 1
                    Pos Only Arg Count: 0
                    KW Only Arg Count: 0
                    Locals: 5
                    Stack Size: 11
                    Flags: 0x20000043 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NOFREE | CO_PYARMOR_OBFUSCATED)
                    [Names]
                        'Af'
                        'list'
                        'pre_dict'
                        'items'
                        'q_H_nd'
                        'Fans'
                        'T_supply_H'
                        'T_air_hc'
                        'rho'
                        'heat_supply_air'
                        'q_C_nd'
                        'T_supply_C'
                        'HVAC'
                        'reheat_deltaT'
                        'cool_supply_air'
                        'reheat_summer'
                        'rh_threshold_summer'
                        'np'
                        'where'
                        'rh'
                        'q_C_nd_HVAC'
                        'q_hc'
                        'q_H_nd_HVAC'
                        'qv_tot'
                        'fresh_air'
                        'maximum'
                        'qv_exh'
                        'fan_volume'
                        'array'
                        'max'
                        'len'
                        'Te'
                        'fan_power'
                        'fan_flow_control_factor'
                        'BEM'
                        'f_BAC_e'
                        'fan_energy'
                        'Pumps'
                        'pump_power_H'
                        'deltaT_water_H'
                        'zeros'
                        'heat_supply_water'
                        'pump_power_C'
                        'deltaT_water_C'
                        'cool_supply_water'
                        'fcntrl'
                        'pump_volume_H'
                        'pump_volume_C'
                        'sum'
                        'f_dem_heat'
                        'f_dem_cool'
                        'a_cool'
                        'f_waste'
                        'dist_cool'
                        'a_heat'
                        'dist_heat'
                        'interp'
                        'PLV_x'
                        'heating_PLV'
                        'heating_efficiency'
                        'cooling_PLV'
                        'cooling_COP'
                        'heat_loss'
                        'f_BAC_hc'
                        'heat_energy'
                        'cool_loss'
                        'cool_energy'
                        'qi_app'
                        'qi_equip'
                        'DHW'
                        'DHW_q'
                        'hasattr'
                        'DHW_style'
                        'DHW_dem'
                        'occupancy_frac'
                        'count_nonzero'
                        'wea_dict'
                        'Wind_Turbines'
                        'R_air'
                        'Multiplier'
                        'Swept_Area'
                        'Efficiency'
                        'ws'
                        'Egen_wind'
                    [Var Names]
                        'self'
                        '__assert_armored__'
                        '_var_var_12'
                        '_var_var_11'
                        '_var_var_103'
                    [Free Vars]
                    [Cell Vars]
                    [Constants]
                        None
                        '__pyarmor_assert_47121__'
                        'Simulation.energy.<locals>.<lambda>'
                        '__pyarmor_enter_47122__'
                        b'<COAddr>\x03\x00\x00\x14\xe0\x05\x00\x00\x00\x00\x00\x00'
                        0
                        'Zones'
                        3600
                        1000
                        3.6
                        1
                        25
                        100
                        1.2
                        1000000
                        0.5
                        0.8
                        0.1
                        12
                        4.18
                        45
                        'DHW_style'
                        'avg'
                        'occ'
                        'pressure'
                        273
                        3
                        '__pyarmor_exit_47123__'
                    [Disassembly]
                        0       NOP                             
                        2       NOP                             
                        4       NOP                             
                        6       NOP                             
                        8       LOAD_CONST                      3: '__pyarmor_enter_47122__'
                        10      NOP                             
                        12      NOP                             
                        14      LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x14\xe0\x05\x00\x00\x00\x00\x00\x00'
                        16      CALL_FUNCTION                   1
                        18      POP_TOP                         
                        20      SETUP_FINALLY                   1514 (to 1538)
                        24      LOAD_CONST                      5: 0
                        26      LOAD_FAST                       0: self
                        28      STORE_ATTR                      0: Af
                        30      LOAD_GLOBAL                     1: list
                        32      LOAD_FAST                       0: self
                        34      LOAD_ATTR                       2: pre_dict
                        36      LOAD_CONST                      6: 'Zones'
                        38      BINARY_SUBSCR                   
                        40      LOAD_METHOD                     3: items
                        42      CALL_METHOD                     0
                        44      CALL_FUNCTION                   1
                        46      GET_ITER                        
                        48      FOR_ITER                        1394 (to 1446)
                        52      UNPACK_SEQUENCE                 2
                        54      STORE_FAST                      2: _var_var_12
                        56      STORE_FAST                      3: _var_var_11
                        58      LOAD_FAST                       3: _var_var_11
                        60      LOAD_ATTR                       4: q_H_nd
                        62      LOAD_FAST                       3: _var_var_11
                        64      LOAD_ATTR                       0: Af
                        66      LOAD_CONST                      7: 3600
                        68      BINARY_MULTIPLY                 
                        70      BINARY_TRUE_DIVIDE              
                        72      LOAD_CONST                      8: 1000
                        74      BINARY_TRUE_DIVIDE              
                        76      LOAD_CONST                      9: 3.6
                        78      BINARY_MULTIPLY                 
                        80      LOAD_FAST                       3: _var_var_11
                        82      LOAD_ATTR                       5: Fans
                        84      LOAD_ATTR                       6: T_supply_H
                        86      LOAD_FAST                       3: _var_var_11
                        88      LOAD_ATTR                       7: T_air_hc
                        90      BINARY_SUBTRACT                 
                        92      BINARY_TRUE_DIVIDE              
                        94      LOAD_FAST                       3: _var_var_11
                        96      LOAD_ATTR                       5: Fans
                        98      LOAD_ATTR                       8: rho
                        100     BINARY_TRUE_DIVIDE              
                        102     LOAD_FAST                       3: _var_var_11
                        104     STORE_ATTR                      9: heat_supply_air
                        106     LOAD_FAST                       3: _var_var_11
                        108     LOAD_ATTR                       10: q_C_nd
                        110     LOAD_FAST                       3: _var_var_11
                        112     LOAD_ATTR                       0: Af
                        114     LOAD_CONST                      7: 3600
                        116     BINARY_MULTIPLY                 
                        118     BINARY_TRUE_DIVIDE              
                        120     LOAD_CONST                      8: 1000
                        122     BINARY_TRUE_DIVIDE              
                        124     LOAD_CONST                      9: 3.6
                        126     BINARY_MULTIPLY                 
                        128     LOAD_FAST                       3: _var_var_11
                        130     LOAD_ATTR                       7: T_air_hc
                        132     LOAD_FAST                       3: _var_var_11
                        134     LOAD_ATTR                       5: Fans
                        136     LOAD_ATTR                       11: T_supply_C
                        138     LOAD_FAST                       3: _var_var_11
                        140     LOAD_ATTR                       12: HVAC
                        142     LOAD_ATTR                       13: reheat_deltaT
                        144     BINARY_ADD                      
                        146     BINARY_SUBTRACT                 
                        148     BINARY_TRUE_DIVIDE              
                        150     LOAD_FAST                       3: _var_var_11
                        152     LOAD_ATTR                       5: Fans
                        154     LOAD_ATTR                       8: rho
                        156     BINARY_TRUE_DIVIDE              
                        158     LOAD_FAST                       3: _var_var_11
                        160     STORE_ATTR                      14: cool_supply_air
                        162     LOAD_FAST                       3: _var_var_11
                        164     LOAD_ATTR                       12: HVAC
                        166     LOAD_ATTR                       15: reheat_summer
                        168     LOAD_CONST                      10: 1
                        170     COMPARE_OP                      2 (==)
                        172     POP_JUMP_IF_FALSE               348
                        176     LOAD_FAST                       3: _var_var_11
                        178     LOAD_ATTR                       12: HVAC
                        180     LOAD_ATTR                       15: reheat_summer
                        182     LOAD_CONST                      10: 1
                        184     COMPARE_OP                      2 (==)
                        186     POP_JUMP_IF_FALSE               192
                        188     LOAD_CONST                      11: 25
                        190     JUMP_FORWARD                    2 (to 194)
                        192     LOAD_CONST                      12: 100
                        194     LOAD_FAST                       3: _var_var_11
                        196     STORE_ATTR                      16: rh_threshold_summer
                        198     LOAD_GLOBAL                     17: np
                        200     LOAD_METHOD                     18: where
                        202     LOAD_FAST                       0: self
                        204     LOAD_ATTR                       19: rh
                        206     LOAD_FAST                       3: _var_var_11
                        208     LOAD_ATTR                       16: rh_threshold_summer
                        210     COMPARE_OP                      4 (>)
                        212     LOAD_FAST                       3: _var_var_11
                        214     LOAD_ATTR                       7: T_air_hc
                        216     LOAD_FAST                       3: _var_var_11
                        218     LOAD_ATTR                       5: Fans
                        220     LOAD_ATTR                       11: T_supply_C
                        222     BINARY_SUBTRACT                 
                        224     LOAD_FAST                       3: _var_var_11
                        226     LOAD_ATTR                       14: cool_supply_air
                        228     BINARY_MULTIPLY                 
                        230     LOAD_FAST                       3: _var_var_11
                        232     LOAD_ATTR                       5: Fans
                        234     LOAD_ATTR                       8: rho
                        236     BINARY_MULTIPLY                 
                        238     LOAD_CONST                      8: 1000
                        240     BINARY_MULTIPLY                 
                        242     LOAD_CONST                      9: 3.6
                        244     BINARY_TRUE_DIVIDE              
                        246     LOAD_FAST                       3: _var_var_11
                        248     LOAD_ATTR                       0: Af
                        250     LOAD_CONST                      7: 3600
                        252     BINARY_MULTIPLY                 
                        254     BINARY_MULTIPLY                 
                        256     LOAD_FAST                       3: _var_var_11
                        258     LOAD_ATTR                       10: q_C_nd
                        260     CALL_METHOD                     3
                        262     LOAD_FAST                       3: _var_var_11
                        264     STORE_ATTR                      20: q_C_nd_HVAC
                        266     LOAD_GLOBAL                     17: np
                        268     LOAD_METHOD                     18: where
                        270     LOAD_FAST                       3: _var_var_11
                        272     LOAD_ATTR                       21: q_hc
                        274     LOAD_CONST                      5: 0
                        276     COMPARE_OP                      4 (>)
                        278     LOAD_FAST                       3: _var_var_11
                        280     LOAD_ATTR                       4: q_H_nd
                        282     LOAD_GLOBAL                     17: np
                        284     LOAD_METHOD                     18: where
                        286     LOAD_FAST                       0: self
                        288     LOAD_ATTR                       19: rh
                        290     LOAD_FAST                       3: _var_var_11
                        292     LOAD_ATTR                       16: rh_threshold_summer
                        294     COMPARE_OP                      4 (>)
                        296     LOAD_FAST                       3: _var_var_11
                        298     LOAD_ATTR                       12: HVAC
                        300     LOAD_ATTR                       13: reheat_deltaT
                        302     LOAD_FAST                       3: _var_var_11
                        304     LOAD_ATTR                       14: cool_supply_air
                        306     BINARY_MULTIPLY                 
                        308     LOAD_FAST                       3: _var_var_11
                        310     LOAD_ATTR                       5: Fans
                        312     LOAD_ATTR                       8: rho
                        314     BINARY_MULTIPLY                 
                        316     LOAD_CONST                      8: 1000
                        318     BINARY_MULTIPLY                 
                        320     LOAD_CONST                      9: 3.6
                        322     BINARY_TRUE_DIVIDE              
                        324     LOAD_FAST                       3: _var_var_11
                        326     LOAD_ATTR                       0: Af
                        328     LOAD_CONST                      7: 3600
                        330     BINARY_MULTIPLY                 
                        332     BINARY_MULTIPLY                 
                        334     LOAD_FAST                       3: _var_var_11
                        336     LOAD_ATTR                       4: q_H_nd
                        338     CALL_METHOD                     3
                        340     CALL_METHOD                     3
                        342     LOAD_FAST                       3: _var_var_11
                        344     STORE_ATTR                      22: q_H_nd_HVAC
                        346     JUMP_FORWARD                    16 (to 364)
                        348     LOAD_FAST                       3: _var_var_11
                        350     LOAD_ATTR                       10: q_C_nd
                        352     LOAD_FAST                       3: _var_var_11
                        354     STORE_ATTR                      20: q_C_nd_HVAC
                        356     LOAD_FAST                       3: _var_var_11
                        358     LOAD_ATTR                       4: q_H_nd
                        360     LOAD_FAST                       3: _var_var_11
                        362     STORE_ATTR                      22: q_H_nd_HVAC
                        364     LOAD_FAST                       3: _var_var_11
                        366     LOAD_ATTR                       23: qv_tot
                        368     LOAD_FAST                       3: _var_var_11
                        370     STORE_ATTR                      24: fresh_air
                        372     LOAD_GLOBAL                     17: np
                        374     LOAD_METHOD                     25: maximum
                        376     LOAD_FAST                       3: _var_var_11
                        378     LOAD_ATTR                       9: heat_supply_air
                        380     LOAD_FAST                       3: _var_var_11
                        382     LOAD_ATTR                       14: cool_supply_air
                        384     CALL_METHOD                     2
                        386     LOAD_FAST                       3: _var_var_11
                        388     LOAD_ATTR                       26: qv_exh
                        390     BINARY_ADD                      
                        392     LOAD_FAST                       3: _var_var_11
                        394     STORE_ATTR                      27: fan_volume
                        396     LOAD_FAST                       3: _var_var_11
                        398     DUP_TOP                         
                        400     LOAD_ATTR                       27: fan_volume
                        402     LOAD_CONST                      13: 1.2
                        404     LOAD_FAST                       3: _var_var_11
                        406     LOAD_ATTR                       0: Af
                        408     BINARY_MULTIPLY                 
                        410     LOAD_CONST                      7: 3600
                        412     BINARY_TRUE_DIVIDE              
                        414     INPLACE_MULTIPLY                
                        416     ROT_TWO                         
                        418     STORE_ATTR                      27: fan_volume
                        420     LOAD_GLOBAL                     17: np
                        422     LOAD_METHOD                     18: where
                        424     LOAD_FAST                       3: _var_var_11
                        426     LOAD_ATTR                       27: fan_volume
                        428     LOAD_CONST                      5: 0
                        430     COMPARE_OP                      4 (>)
                        432     LOAD_GLOBAL                     17: np
                        434     LOAD_METHOD                     28: array
                        436     LOAD_GLOBAL                     29: max
                        438     LOAD_FAST                       3: _var_var_11
                        440     LOAD_ATTR                       27: fan_volume
                        442     CALL_FUNCTION                   1
                        444     BUILD_LIST                      1
                        446     LOAD_GLOBAL                     30: len
                        448     LOAD_FAST                       0: self
                        450     LOAD_ATTR                       31: Te
                        452     CALL_FUNCTION                   1
                        454     BINARY_MULTIPLY                 
                        456     CALL_METHOD                     1
                        458     LOAD_FAST                       3: _var_var_11
                        460     LOAD_ATTR                       5: Fans
                        462     LOAD_ATTR                       32: fan_power
                        464     BINARY_MULTIPLY                 
                        466     LOAD_FAST                       3: _var_var_11
                        468     LOAD_ATTR                       5: Fans
                        470     LOAD_ATTR                       33: fan_flow_control_factor
                        472     BINARY_MULTIPLY                 
                        474     LOAD_FAST                       0: self
                        476     LOAD_ATTR                       34: BEM
                        478     LOAD_ATTR                       35: f_BAC_e
                        480     BINARY_MULTIPLY                 
                        482     LOAD_CONST                      7: 3600
                        484     BINARY_MULTIPLY                 
                        486     LOAD_CONST                      5: 0
                        488     CALL_METHOD                     3
                        490     LOAD_FAST                       3: _var_var_11
                        492     STORE_ATTR                      36: fan_energy
                        494     LOAD_FAST                       0: self
                        496     LOAD_ATTR                       37: Pumps
                        498     LOAD_ATTR                       38: pump_power_H
                        500     LOAD_CONST                      5: 0
                        502     COMPARE_OP                      3 (!=)
                        504     POP_JUMP_IF_FALSE               532
                        508     LOAD_FAST                       3: _var_var_11
                        510     LOAD_ATTR                       22: q_H_nd_HVAC
                        512     LOAD_CONST                      14: 1000000
                        514     BINARY_TRUE_DIVIDE              
                        516     LOAD_FAST                       3: _var_var_11
                        518     LOAD_ATTR                       39: deltaT_water_H
                        520     BINARY_TRUE_DIVIDE              
                        522     LOAD_FAST                       0: self
                        524     LOAD_ATTR                       37: Pumps
                        526     LOAD_ATTR                       8: rho
                        528     BINARY_TRUE_DIVIDE              
                        530     JUMP_FORWARD                    14 (to 546)
                        532     LOAD_GLOBAL                     17: np
                        534     LOAD_METHOD                     40: zeros
                        536     LOAD_GLOBAL                     30: len
                        538     LOAD_FAST                       0: self
                        540     LOAD_ATTR                       31: Te
                        542     CALL_FUNCTION                   1
                        544     CALL_METHOD                     1
                        546     LOAD_FAST                       3: _var_var_11
                        548     STORE_ATTR                      41: heat_supply_water
                        550     LOAD_FAST                       0: self
                        552     LOAD_ATTR                       37: Pumps
                        554     LOAD_ATTR                       42: pump_power_C
                        556     LOAD_CONST                      5: 0
                        558     COMPARE_OP                      3 (!=)
                        560     POP_JUMP_IF_FALSE               588
                        564     LOAD_FAST                       3: _var_var_11
                        566     LOAD_ATTR                       20: q_C_nd_HVAC
                        568     LOAD_CONST                      14: 1000000
                        570     BINARY_TRUE_DIVIDE              
                        572     LOAD_FAST                       3: _var_var_11
                        574     LOAD_ATTR                       43: deltaT_water_C
                        576     BINARY_TRUE_DIVIDE              
                        578     LOAD_FAST                       0: self
                        580     LOAD_ATTR                       37: Pumps
                        582     LOAD_ATTR                       8: rho
                        584     BINARY_TRUE_DIVIDE              
                        586     JUMP_FORWARD                    14 (to 602)
                        588     LOAD_GLOBAL                     17: np
                        590     LOAD_METHOD                     40: zeros
                        592     LOAD_GLOBAL                     30: len
                        594     LOAD_FAST                       0: self
                        596     LOAD_ATTR                       31: Te
                        598     CALL_FUNCTION                   1
                        600     CALL_METHOD                     1
                        602     LOAD_FAST                       3: _var_var_11
                        604     STORE_ATTR                      44: cool_supply_water
                        606     LOAD_FAST                       0: self
                        608     LOAD_ATTR                       37: Pumps
                        610     LOAD_ATTR                       45: fcntrl
                        612     LOAD_CONST                      15: 0.5
                        614     COMPARE_OP                      2 (==)
                        616     POP_JUMP_IF_FALSE               646
                        620     LOAD_FAST                       3: _var_var_11
                        622     LOAD_ATTR                       41: heat_supply_water
                        624     LOAD_CONST                      7: 3600
                        626     BINARY_TRUE_DIVIDE              
                        628     LOAD_FAST                       3: _var_var_11
                        630     STORE_ATTR                      46: pump_volume_H
                        632     LOAD_FAST                       3: _var_var_11
                        634     LOAD_ATTR                       44: cool_supply_water
                        636     LOAD_CONST                      7: 3600
                        638     BINARY_TRUE_DIVIDE              
                        640     LOAD_FAST                       3: _var_var_11
                        642     STORE_ATTR                      47: pump_volume_C
                        644     JUMP_FORWARD                    68 (to 714)
                        646     LOAD_FAST                       0: self
                        648     LOAD_ATTR                       37: Pumps
                        650     LOAD_ATTR                       45: fcntrl
                        652     LOAD_CONST                      10: 1
                        654     COMPARE_OP                      2 (==)
                        656     POP_JUMP_IF_FALSE               702
                        660     LOAD_CONST                      16: 0.8
                        662     LOAD_GLOBAL                     29: max
                        664     LOAD_FAST                       3: _var_var_11
                        666     LOAD_ATTR                       41: heat_supply_water
                        668     CALL_FUNCTION                   1
                        670     BINARY_MULTIPLY                 
                        672     LOAD_CONST                      7: 3600
                        674     BINARY_TRUE_DIVIDE              
                        676     LOAD_FAST                       3: _var_var_11
                        678     STORE_ATTR                      46: pump_volume_H
                        680     LOAD_CONST                      16: 0.8
                        682     LOAD_GLOBAL                     29: max
                        684     LOAD_FAST                       3: _var_var_11
                        686     LOAD_ATTR                       44: cool_supply_water
                        688     CALL_FUNCTION                   1
                        690     BINARY_MULTIPLY                 
                        692     LOAD_CONST                      7: 3600
                        694     BINARY_TRUE_DIVIDE              
                        696     LOAD_FAST                       3: _var_var_11
                        698     STORE_ATTR                      47: pump_volume_C
                        700     JUMP_FORWARD                    12 (to 714)
                        702     LOAD_CONST                      5: 0
                        704     LOAD_FAST                       3: _var_var_11
                        706     STORE_ATTR                      46: pump_volume_H
                        708     LOAD_CONST                      5: 0
                        710     LOAD_FAST                       3: _var_var_11
                        712     STORE_ATTR                      47: pump_volume_C
                        714     LOAD_GLOBAL                     29: max
                        716     LOAD_CONST                      17: 0.1
                        718     LOAD_GLOBAL                     48: sum
                        720     LOAD_FAST                       3: _var_var_11
                        722     LOAD_ATTR                       22: q_H_nd_HVAC
                        724     CALL_FUNCTION                   1
                        726     LOAD_GLOBAL                     48: sum
                        728     LOAD_FAST                       3: _var_var_11
                        730     LOAD_ATTR                       22: q_H_nd_HVAC
                        732     CALL_FUNCTION                   1
                        734     LOAD_GLOBAL                     48: sum
                        736     LOAD_FAST                       3: _var_var_11
                        738     LOAD_ATTR                       20: q_C_nd_HVAC
                        740     CALL_FUNCTION                   1
                        742     BINARY_ADD                      
                        744     BINARY_TRUE_DIVIDE              
                        746     CALL_FUNCTION                   2
                        748     LOAD_FAST                       3: _var_var_11
                        750     STORE_ATTR                      49: f_dem_heat
                        752     LOAD_GLOBAL                     29: max
                        754     LOAD_CONST                      10: 1
                        756     LOAD_FAST                       3: _var_var_11
                        758     LOAD_ATTR                       49: f_dem_heat
                        760     BINARY_SUBTRACT                 
                        762     LOAD_CONST                      17: 0.1
                        764     CALL_FUNCTION                   2
                        766     LOAD_FAST                       3: _var_var_11
                        768     STORE_ATTR                      50: f_dem_cool
                        770     LOAD_CONST                      10: 1
                        772     LOAD_CONST                      10: 1
                        774     LOAD_FAST                       3: _var_var_11
                        776     LOAD_ATTR                       12: HVAC
                        778     LOAD_ATTR                       51: a_cool
                        780     BINARY_ADD                      
                        782     LOAD_FAST                       3: _var_var_11
                        784     LOAD_ATTR                       12: HVAC
                        786     LOAD_ATTR                       52: f_waste
                        788     LOAD_FAST                       3: _var_var_11
                        790     LOAD_ATTR                       50: f_dem_cool
                        792     BINARY_TRUE_DIVIDE              
                        794     BINARY_ADD                      
                        796     BINARY_TRUE_DIVIDE              
                        798     LOAD_FAST                       3: _var_var_11
                        800     STORE_ATTR                      53: dist_cool
                        802     LOAD_CONST                      10: 1
                        804     LOAD_CONST                      10: 1
                        806     LOAD_FAST                       3: _var_var_11
                        808     LOAD_ATTR                       12: HVAC
                        810     LOAD_ATTR                       54: a_heat
                        812     BINARY_ADD                      
                        814     LOAD_FAST                       3: _var_var_11
                        816     LOAD_ATTR                       12: HVAC
                        818     LOAD_ATTR                       52: f_waste
                        820     LOAD_FAST                       3: _var_var_11
                        822     LOAD_ATTR                       49: f_dem_heat
                        824     BINARY_TRUE_DIVIDE              
                        826     BINARY_ADD                      
                        828     BINARY_TRUE_DIVIDE              
                        830     LOAD_FAST                       3: _var_var_11
                        832     STORE_ATTR                      55: dist_heat
                        834     LOAD_GLOBAL                     29: max
                        836     LOAD_FAST                       3: _var_var_11
                        838     LOAD_ATTR                       22: q_H_nd_HVAC
                        840     CALL_FUNCTION                   1
                        842     LOAD_CONST                      5: 0
                        844     COMPARE_OP                      3 (!=)
                        846     POP_JUMP_IF_FALSE               892
                        850     LOAD_GLOBAL                     17: np
                        852     LOAD_METHOD                     56: interp
                        854     LOAD_FAST                       3: _var_var_11
                        856     LOAD_ATTR                       22: q_H_nd_HVAC
                        858     LOAD_GLOBAL                     29: max
                        860     LOAD_FAST                       3: _var_var_11
                        862     LOAD_ATTR                       22: q_H_nd_HVAC
                        864     CALL_FUNCTION                   1
                        866     BINARY_TRUE_DIVIDE              
                        868     LOAD_FAST                       3: _var_var_11
                        870     LOAD_ATTR                       12: HVAC
                        872     LOAD_ATTR                       57: PLV_x
                        874     LOAD_FAST                       3: _var_var_11
                        876     LOAD_ATTR                       12: HVAC
                        878     LOAD_ATTR                       58: heating_PLV
                        880     LOAD_FAST                       3: _var_var_11
                        882     LOAD_ATTR                       12: HVAC
                        884     LOAD_ATTR                       59: heating_efficiency
                        886     BINARY_MULTIPLY                 
                        888     CALL_METHOD                     3
                        890     JUMP_FORWARD                    2 (to 894)
                        892     LOAD_CONST                      5: 0
                        894     LOAD_FAST                       3: _var_var_11
                        896     STORE_ATTR                      59: heating_efficiency
                        898     LOAD_GLOBAL                     29: max
                        900     LOAD_FAST                       3: _var_var_11
                        902     LOAD_ATTR                       20: q_C_nd_HVAC
                        904     CALL_FUNCTION                   1
                        906     LOAD_CONST                      5: 0
                        908     COMPARE_OP                      3 (!=)
                        910     POP_JUMP_IF_FALSE               956
                        914     LOAD_GLOBAL                     17: np
                        916     LOAD_METHOD                     56: interp
                        918     LOAD_FAST                       3: _var_var_11
                        920     LOAD_ATTR                       20: q_C_nd_HVAC
                        922     LOAD_GLOBAL                     29: max
                        924     LOAD_FAST                       3: _var_var_11
                        926     LOAD_ATTR                       20: q_C_nd_HVAC
                        928     CALL_FUNCTION                   1
                        930     BINARY_TRUE_DIVIDE              
                        932     LOAD_FAST                       3: _var_var_11
                        934     LOAD_ATTR                       12: HVAC
                        936     LOAD_ATTR                       57: PLV_x
                        938     LOAD_FAST                       3: _var_var_11
                        940     LOAD_ATTR                       12: HVAC
                        942     LOAD_ATTR                       60: cooling_PLV
                        944     LOAD_FAST                       3: _var_var_11
                        946     LOAD_ATTR                       12: HVAC
                        948     LOAD_ATTR                       61: cooling_COP
                        950     BINARY_MULTIPLY                 
                        952     CALL_METHOD                     3
                        954     JUMP_FORWARD                    2 (to 958)
                        956     LOAD_CONST                      5: 0
                        958     LOAD_FAST                       3: _var_var_11
                        960     STORE_ATTR                      61: cooling_COP
                        962     LOAD_FAST                       3: _var_var_11
                        964     LOAD_ATTR                       22: q_H_nd_HVAC
                        966     LOAD_CONST                      10: 1
                        968     LOAD_FAST                       3: _var_var_11
                        970     LOAD_ATTR                       55: dist_heat
                        972     BINARY_SUBTRACT                 
                        974     BINARY_MULTIPLY                 
                        976     LOAD_FAST                       3: _var_var_11
                        978     LOAD_ATTR                       55: dist_heat
                        980     BINARY_TRUE_DIVIDE              
                        982     LOAD_FAST                       3: _var_var_11
                        984     STORE_ATTR                      62: heat_loss
                        986     LOAD_GLOBAL                     17: np
                        988     LOAD_METHOD                     18: where
                        990     LOAD_FAST                       3: _var_var_11
                        992     LOAD_ATTR                       59: heating_efficiency
                        994     LOAD_CONST                      5: 0
                        996     COMPARE_OP                      2 (==)
                        998     LOAD_GLOBAL                     17: np
                        1000    LOAD_METHOD                     40: zeros
                        1002    LOAD_GLOBAL                     30: len
                        1004    LOAD_FAST                       0: self
                        1006    LOAD_ATTR                       31: Te
                        1008    CALL_FUNCTION                   1
                        1010    CALL_METHOD                     1
                        1012    LOAD_FAST                       3: _var_var_11
                        1014    LOAD_ATTR                       22: q_H_nd_HVAC
                        1016    LOAD_FAST                       3: _var_var_11
                        1018    LOAD_ATTR                       62: heat_loss
                        1020    BINARY_ADD                      
                        1022    LOAD_FAST                       0: self
                        1024    LOAD_ATTR                       34: BEM
                        1026    LOAD_ATTR                       63: f_BAC_hc
                        1028    BINARY_MULTIPLY                 
                        1030    LOAD_FAST                       3: _var_var_11
                        1032    LOAD_ATTR                       59: heating_efficiency
                        1034    BINARY_TRUE_DIVIDE              
                        1036    CALL_METHOD                     3
                        1038    LOAD_FAST                       3: _var_var_11
                        1040    STORE_ATTR                      64: heat_energy
                        1042    LOAD_FAST                       3: _var_var_11
                        1044    LOAD_ATTR                       20: q_C_nd_HVAC
                        1046    LOAD_CONST                      10: 1
                        1048    LOAD_FAST                       3: _var_var_11
                        1050    LOAD_ATTR                       53: dist_cool
                        1052    BINARY_SUBTRACT                 
                        1054    BINARY_MULTIPLY                 
                        1056    LOAD_FAST                       3: _var_var_11
                        1058    LOAD_ATTR                       53: dist_cool
                        1060    BINARY_TRUE_DIVIDE              
                        1062    LOAD_FAST                       3: _var_var_11
                        1064    STORE_ATTR                      65: cool_loss
                        1066    LOAD_GLOBAL                     17: np
                        1068    LOAD_METHOD                     18: where
                        1070    LOAD_FAST                       3: _var_var_11
                        1072    LOAD_ATTR                       61: cooling_COP
                        1074    LOAD_CONST                      5: 0
                        1076    COMPARE_OP                      2 (==)
                        1078    LOAD_GLOBAL                     17: np
                        1080    LOAD_METHOD                     40: zeros
                        1082    LOAD_GLOBAL                     30: len
                        1084    LOAD_FAST                       0: self
                        1086    LOAD_ATTR                       31: Te
                        1088    CALL_FUNCTION                   1
                        1090    CALL_METHOD                     1
                        1092    LOAD_FAST                       3: _var_var_11
                        1094    LOAD_ATTR                       20: q_C_nd_HVAC
                        1096    LOAD_FAST                       3: _var_var_11
                        1098    LOAD_ATTR                       65: cool_loss
                        1100    BINARY_ADD                      
                        1102    LOAD_FAST                       0: self
                        1104    LOAD_ATTR                       34: BEM
                        1106    LOAD_ATTR                       63: f_BAC_hc
                        1108    BINARY_MULTIPLY                 
                        1110    LOAD_FAST                       3: _var_var_11
                        1112    LOAD_ATTR                       61: cooling_COP
                        1114    BINARY_TRUE_DIVIDE              
                        1116    CALL_METHOD                     3
                        1118    LOAD_FAST                       3: _var_var_11
                        1120    STORE_ATTR                      66: cool_energy
                        1122    LOAD_FAST                       3: _var_var_11
                        1124    LOAD_ATTR                       67: qi_app
                        1126    LOAD_FAST                       3: _var_var_11
                        1128    STORE_ATTR                      68: qi_equip
                        1130    LOAD_CONST                      18: 12
                        1132    LOAD_FAST                       3: _var_var_11
                        1134    LOAD_ATTR                       69: DHW
                        1136    LOAD_CONST                      19: 4.18
                        1138    BINARY_MULTIPLY                 
                        1140    LOAD_CONST                      8: 1000
                        1142    BINARY_MULTIPLY                 
                        1144    LOAD_CONST                      20: 45
                        1146    BINARY_MULTIPLY                 
                        1148    BINARY_MULTIPLY                 
                        1150    LOAD_FAST                       3: _var_var_11
                        1152    LOAD_ATTR                       0: Af
                        1154    BINARY_MULTIPLY                 
                        1156    LOAD_FAST                       3: _var_var_11
                        1158    STORE_ATTR                      70: DHW_q
                        1160    LOAD_GLOBAL                     71: hasattr
                        1162    LOAD_FAST                       0: self
                        1164    LOAD_CONST                      21: 'DHW_style'
                        1166    CALL_FUNCTION                   2
                        1168    POP_JUMP_IF_FALSE               1350
                        1172    LOAD_FAST                       0: self
                        1174    LOAD_ATTR                       72: DHW_style
                        1176    LOAD_CONST                      22: 'avg'
                        1178    COMPARE_OP                      2 (==)
                        1180    POP_JUMP_IF_FALSE               1222
                        1184    LOAD_GLOBAL                     17: np
                        1186    LOAD_METHOD                     28: array
                        1188    LOAD_FAST                       3: _var_var_11
                        1190    LOAD_ATTR                       70: DHW_q
                        1192    LOAD_GLOBAL                     30: len
                        1194    LOAD_FAST                       0: self
                        1196    LOAD_ATTR                       31: Te
                        1198    CALL_FUNCTION                   1
                        1200    BINARY_TRUE_DIVIDE              
                        1202    BUILD_LIST                      1
                        1204    LOAD_GLOBAL                     30: len
                        1206    LOAD_FAST                       0: self
                        1208    LOAD_ATTR                       31: Te
                        1210    CALL_FUNCTION                   1
                        1212    BINARY_MULTIPLY                 
                        1214    CALL_METHOD                     1
                        1216    LOAD_FAST                       3: _var_var_11
                        1218    STORE_ATTR                      73: DHW_dem
                        1220    JUMP_FORWARD                    126 (to 1348)
                        1222    LOAD_FAST                       0: self
                        1224    LOAD_ATTR                       72: DHW_style
                        1226    LOAD_CONST                      23: 'occ'
                        1228    COMPARE_OP                      2 (==)
                        1230    POP_JUMP_IF_FALSE               1292
                        1234    LOAD_GLOBAL                     48: sum
                        1236    LOAD_FAST                       3: _var_var_11
                        1238    LOAD_ATTR                       74: occupancy_frac
                        1240    CALL_FUNCTION                   1
                        1242    LOAD_CONST                      5: 0
                        1244    COMPARE_OP                      3 (!=)
                        1246    POP_JUMP_IF_FALSE               1272
                        1250    LOAD_FAST                       3: _var_var_11
                        1252    LOAD_ATTR                       70: DHW_q
                        1254    LOAD_FAST                       3: _var_var_11
                        1256    LOAD_ATTR                       74: occupancy_frac
                        1258    BINARY_MULTIPLY                 
                        1260    LOAD_GLOBAL                     48: sum
                        1262    LOAD_FAST                       3: _var_var_11
                        1264    LOAD_ATTR                       74: occupancy_frac
                        1266    CALL_FUNCTION                   1
                        1268    BINARY_TRUE_DIVIDE              
                        1270    JUMP_FORWARD                    14 (to 1286)
                        1272    LOAD_GLOBAL                     17: np
                        1274    LOAD_METHOD                     40: zeros
                        1276    LOAD_GLOBAL                     30: len
                        1278    LOAD_FAST                       0: self
                        1280    LOAD_ATTR                       31: Te
                        1282    CALL_FUNCTION                   1
                        1284    CALL_METHOD                     1
                        1286    LOAD_FAST                       3: _var_var_11
                        1288    STORE_ATTR                      73: DHW_dem
                        1290    JUMP_FORWARD                    56 (to 1348)
                        1292    LOAD_GLOBAL                     48: sum
                        1294    LOAD_FAST                       3: _var_var_11
                        1296    LOAD_ATTR                       74: occupancy_frac
                        1298    CALL_FUNCTION                   1
                        1300    LOAD_CONST                      5: 0
                        1302    COMPARE_OP                      3 (!=)
                        1304    POP_JUMP_IF_FALSE               1330
                        1308    LOAD_FAST                       3: _var_var_11
                        1310    LOAD_ATTR                       70: DHW_q
                        1312    LOAD_FAST                       3: _var_var_11
                        1314    LOAD_ATTR                       74: occupancy_frac
                        1316    BINARY_MULTIPLY                 
                        1318    LOAD_GLOBAL                     48: sum
                        1320    LOAD_FAST                       3: _var_var_11
                        1322    LOAD_ATTR                       74: occupancy_frac
                        1324    CALL_FUNCTION                   1
                        1326    BINARY_TRUE_DIVIDE              
                        1328    JUMP_FORWARD                    14 (to 1344)
                        1330    LOAD_GLOBAL                     17: np
                        1332    LOAD_METHOD                     40: zeros
                        1334    LOAD_GLOBAL                     30: len
                        1336    LOAD_FAST                       0: self
                        1338    LOAD_ATTR                       31: Te
                        1340    CALL_FUNCTION                   1
                        1342    CALL_METHOD                     1
                        1344    LOAD_FAST                       3: _var_var_11
                        1346    STORE_ATTR                      73: DHW_dem
                        1348    JUMP_FORWARD                    56 (to 1406)
                        1350    LOAD_GLOBAL                     48: sum
                        1352    LOAD_FAST                       3: _var_var_11
                        1354    LOAD_ATTR                       74: occupancy_frac
                        1356    CALL_FUNCTION                   1
                        1358    LOAD_CONST                      5: 0
                        1360    COMPARE_OP                      3 (!=)
                        1362    POP_JUMP_IF_FALSE               1388
                        1366    LOAD_FAST                       3: _var_var_11
                        1368    LOAD_ATTR                       70: DHW_q
                        1370    LOAD_FAST                       3: _var_var_11
                        1372    LOAD_ATTR                       74: occupancy_frac
                        1374    BINARY_MULTIPLY                 
                        1376    LOAD_GLOBAL                     48: sum
                        1378    LOAD_FAST                       3: _var_var_11
                        1380    LOAD_ATTR                       74: occupancy_frac
                        1382    CALL_FUNCTION                   1
                        1384    BINARY_TRUE_DIVIDE              
                        1386    JUMP_FORWARD                    14 (to 1402)
                        1388    LOAD_GLOBAL                     17: np
                        1390    LOAD_METHOD                     40: zeros
                        1392    LOAD_GLOBAL                     30: len
                        1394    LOAD_FAST                       0: self
                        1396    LOAD_ATTR                       31: Te
                        1398    CALL_FUNCTION                   1
                        1400    CALL_METHOD                     1
                        1402    LOAD_FAST                       3: _var_var_11
                        1404    STORE_ATTR                      73: DHW_dem
                        1406    LOAD_FAST                       0: self
                        1408    DUP_TOP                         
                        1410    LOAD_ATTR                       0: Af
                        1412    LOAD_GLOBAL                     17: np
                        1414    LOAD_METHOD                     75: count_nonzero
                        1416    LOAD_FAST                       3: _var_var_11
                        1418    LOAD_ATTR                       21: q_hc
                        1420    CALL_METHOD                     1
                        1422    LOAD_CONST                      5: 0
                        1424    COMPARE_OP                      4 (>)
                        1426    POP_JUMP_IF_FALSE               1436
                        1430    LOAD_FAST                       3: _var_var_11
                        1432    LOAD_ATTR                       0: Af
                        1434    JUMP_FORWARD                    2 (to 1438)
                        1436    LOAD_CONST                      5: 0
                        1438    INPLACE_ADD                     
                        1440    ROT_TWO                         
                        1442    STORE_ATTR                      0: Af
                        1444    JUMP_ABSOLUTE                   48
                        1446    LOAD_FAST                       0: self
                        1448    LOAD_ATTR                       76: wea_dict
                        1450    LOAD_CONST                      24: 'pressure'
                        1452    BINARY_SUBSCR                   
                        1454    LOAD_FAST                       0: self
                        1456    LOAD_ATTR                       77: Wind_Turbines
                        1458    LOAD_ATTR                       78: R_air
                        1460    BINARY_TRUE_DIVIDE              
                        1462    LOAD_CONST                      25: 273
                        1464    LOAD_FAST                       0: self
                        1466    LOAD_ATTR                       31: Te
                        1468    BINARY_ADD                      
                        1470    BINARY_TRUE_DIVIDE              
                        1472    STORE_FAST                      4: _var_var_103
                        1474    LOAD_CONST                      15: 0.5
                        1476    LOAD_FAST                       4: _var_var_103
                        1478    BINARY_MULTIPLY                 
                        1480    LOAD_FAST                       0: self
                        1482    LOAD_ATTR                       77: Wind_Turbines
                        1484    LOAD_ATTR                       79: Multiplier
                        1486    BINARY_MULTIPLY                 
                        1488    LOAD_FAST                       0: self
                        1490    LOAD_ATTR                       77: Wind_Turbines
                        1492    LOAD_ATTR                       80: Swept_Area
                        1494    BINARY_MULTIPLY                 
                        1496    LOAD_FAST                       0: self
                        1498    LOAD_ATTR                       77: Wind_Turbines
                        1500    LOAD_ATTR                       81: Efficiency
                        1502    BINARY_MULTIPLY                 
                        1504    LOAD_FAST                       0: self
                        1506    LOAD_ATTR                       82: ws
                        1508    LOAD_CONST                      26: 3
                        1510    BINARY_POWER                    
                        1512    BINARY_MULTIPLY                 
                        1514    LOAD_CONST                      7: 3600
                        1516    BINARY_MULTIPLY                 
                        1518    LOAD_FAST                       0: self
                        1520    STORE_ATTR                      83: Egen_wind
                        1522    POP_BLOCK                       
                        1524    LOAD_CONST                      27: '__pyarmor_exit_47123__'
                        1526    NOP                             
                        1528    NOP                             
                        1530    LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x14\xe0\x05\x00\x00\x00\x00\x00\x00'
                        1532    CALL_FUNCTION                   1
                        1534    POP_TOP                         
                        1536    JUMP_FORWARD                    14 (to 1552)
                        1538    LOAD_CONST                      27: '__pyarmor_exit_47123__'
                        1540    NOP                             
                        1542    NOP                             
                        1544    LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x14\xe0\x05\x00\x00\x00\x00\x00\x00'
                        1546    CALL_FUNCTION                   1
                        1548    POP_TOP                         
                        1550    RERAISE                         
                        1552    LOAD_CONST                      0: None
                        1554    RETURN_VALUE                    
                'Simulation.energy'
                [Code]
                    File Name: <frozen simulation>
                    Object Name: renewables
                    Arg Count: 1
                    Pos Only Arg Count: 0
                    KW Only Arg Count: 0
                    Locals: 2
                    Stack Size: 8
                    Flags: 0x20000043 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NOFREE | CO_PYARMOR_OBFUSCATED)
                    [Names]
                        'int'
                        'PV'
                        'PV_Area'
                        'ValueError'
                        'np'
                        'zeros'
                        'len'
                        'Te'
                        'Esol_PV'
                        'PV_Angle'
                        'wea_dict'
                        'SCal_dict'
                        'Orientation'
                        'Ppk'
                        'fperf'
                        'Egen_PV'
                        'DHW'
                        'SWH_Area'
                        'Esol_SWH'
                        'SWH_Angle'
                        'SWH_Orientation'
                    [Var Names]
                        'self'
                        '__assert_armored__'
                    [Free Vars]
                    [Cell Vars]
                    [Constants]
                        None
                        '__pyarmor_assert_47124__'
                        'Simulation.renewables.<locals>.<lambda>'
                        '__pyarmor_enter_47125__'
                        b'<COAddr>\x01\x00\x00\x14\xe4\x01\x00\x00\x00\x00\x00\x00'
                        0
                        'Egh'
                        1000
                        'Esol'
                        3600000
                        '__pyarmor_exit_47126__'
                    [Disassembly]
                        0       NOP                             
                        2       NOP                             
                        4       NOP                             
                        6       NOP                             
                        8       LOAD_CONST                      3: '__pyarmor_enter_47125__'
                        10      NOP                             
                        12      NOP                             
                        14      LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14\xe4\x01\x00\x00\x00\x00\x00\x00'
                        16      CALL_FUNCTION                   1
                        18      POP_TOP                         
                        20      SETUP_FINALLY                   494 (to 518)
                        24      SETUP_FINALLY                   16 (to 42)
                        26      LOAD_GLOBAL                     0: int
                        28      LOAD_FAST                       0: self
                        30      LOAD_ATTR                       1: PV
                        32      LOAD_ATTR                       2: PV_Area
                        34      CALL_FUNCTION                   1
                        36      POP_TOP                         
                        38      POP_BLOCK                       
                        40      JUMP_FORWARD                    36 (to 78)
                        42      DUP_TOP                         
                        44      LOAD_GLOBAL                     3: ValueError
                        46      JUMP_IF_NOT_EXC_MATCH           76
                        48      POP_TOP                         
                        50      POP_TOP                         
                        52      POP_TOP                         
                        54      LOAD_GLOBAL                     4: np
                        56      LOAD_METHOD                     5: zeros
                        58      LOAD_GLOBAL                     6: len
                        60      LOAD_FAST                       0: self
                        62      LOAD_ATTR                       7: Te
                        64      CALL_FUNCTION                   1
                        66      CALL_METHOD                     1
                        68      LOAD_FAST                       0: self
                        70      STORE_ATTR                      8: Esol_PV
                        72      POP_EXCEPT                      
                        74      JUMP_FORWARD                    162 (to 238)
                        76      RERAISE                         
                        78      LOAD_GLOBAL                     0: int
                        80      LOAD_FAST                       0: self
                        82      LOAD_ATTR                       1: PV
                        84      LOAD_ATTR                       2: PV_Area
                        86      CALL_FUNCTION                   1
                        88      LOAD_CONST                      5: 0
                        90      COMPARE_OP                      3 (!=)
                        92      POP_JUMP_IF_FALSE               220
                        94      SETUP_FINALLY                   16 (to 112)
                        96      LOAD_GLOBAL                     0: int
                        98      LOAD_FAST                       0: self
                        100     LOAD_ATTR                       1: PV
                        102     LOAD_ATTR                       9: PV_Angle
                        104     CALL_FUNCTION                   1
                        106     POP_TOP                         
                        108     POP_BLOCK                       
                        110     JUMP_FORWARD                    36 (to 148)
                        112     DUP_TOP                         
                        114     LOAD_GLOBAL                     3: ValueError
                        116     JUMP_IF_NOT_EXC_MATCH           146
                        118     POP_TOP                         
                        120     POP_TOP                         
                        122     POP_TOP                         
                        124     LOAD_GLOBAL                     4: np
                        126     LOAD_METHOD                     5: zeros
                        128     LOAD_GLOBAL                     6: len
                        130     LOAD_FAST                       0: self
                        132     LOAD_ATTR                       7: Te
                        134     CALL_FUNCTION                   1
                        136     CALL_METHOD                     1
                        138     LOAD_FAST                       0: self
                        140     STORE_ATTR                      8: Esol_PV
                        142     POP_EXCEPT                      
                        144     JUMP_ABSOLUTE                   238
                        146     RERAISE                         
                        148     LOAD_GLOBAL                     0: int
                        150     LOAD_FAST                       0: self
                        152     LOAD_ATTR                       1: PV
                        154     LOAD_ATTR                       9: PV_Angle
                        156     CALL_FUNCTION                   1
                        158     LOAD_CONST                      5: 0
                        160     COMPARE_OP                      2 (==)
                        162     POP_JUMP_IF_FALSE               182
                        164     LOAD_FAST                       0: self
                        166     LOAD_ATTR                       10: wea_dict
                        168     LOAD_CONST                      6: 'Egh'
                        170     BINARY_SUBSCR                   
                        172     LOAD_CONST                      7: 1000
                        174     BINARY_TRUE_DIVIDE              
                        176     LOAD_FAST                       0: self
                        178     STORE_ATTR                      8: Esol_PV
                        180     JUMP_ABSOLUTE                   238
                        182     LOAD_FAST                       0: self
                        184     LOAD_ATTR                       11: SCal_dict
                        186     LOAD_CONST                      8: 'Esol'
                        188     BINARY_SUBSCR                   
                        190     LOAD_GLOBAL                     0: int
                        192     LOAD_FAST                       0: self
                        194     LOAD_ATTR                       1: PV
                        196     LOAD_ATTR                       9: PV_Angle
                        198     CALL_FUNCTION                   1
                        200     BINARY_SUBSCR                   
                        202     LOAD_FAST                       0: self
                        204     LOAD_ATTR                       1: PV
                        206     LOAD_ATTR                       12: Orientation
                        208     BINARY_SUBSCR                   
                        210     LOAD_CONST                      7: 1000
                        212     BINARY_TRUE_DIVIDE              
                        214     LOAD_FAST                       0: self
                        216     STORE_ATTR                      8: Esol_PV
                        218     JUMP_FORWARD                    18 (to 238)
                        220     LOAD_GLOBAL                     4: np
                        222     LOAD_METHOD                     5: zeros
                        224     LOAD_GLOBAL                     6: len
                        226     LOAD_FAST                       0: self
                        228     LOAD_ATTR                       7: Te
                        230     CALL_FUNCTION                   1
                        232     CALL_METHOD                     1
                        234     LOAD_FAST                       0: self
                        236     STORE_ATTR                      8: Esol_PV
                        238     LOAD_FAST                       0: self
                        240     LOAD_ATTR                       8: Esol_PV
                        242     LOAD_FAST                       0: self
                        244     LOAD_ATTR                       1: PV
                        246     LOAD_ATTR                       13: Ppk
                        248     BINARY_MULTIPLY                 
                        250     LOAD_FAST                       0: self
                        252     LOAD_ATTR                       1: PV
                        254     LOAD_ATTR                       14: fperf
                        256     BINARY_MULTIPLY                 
                        258     LOAD_CONST                      9: 3600000
                        260     BINARY_MULTIPLY                 
                        262     LOAD_FAST                       0: self
                        264     STORE_ATTR                      15: Egen_PV
                        266     SETUP_FINALLY                   16 (to 284)
                        268     LOAD_GLOBAL                     0: int
                        270     LOAD_FAST                       0: self
                        272     LOAD_ATTR                       16: DHW
                        274     LOAD_ATTR                       17: SWH_Area
                        276     CALL_FUNCTION                   1
                        278     POP_TOP                         
                        280     POP_BLOCK                       
                        282     JUMP_FORWARD                    38 (to 322)
                        284     DUP_TOP                         
                        286     LOAD_GLOBAL                     3: ValueError
                        288     JUMP_IF_NOT_EXC_MATCH           320
                        292     POP_TOP                         
                        294     POP_TOP                         
                        296     POP_TOP                         
                        298     LOAD_GLOBAL                     4: np
                        300     LOAD_METHOD                     5: zeros
                        302     LOAD_GLOBAL                     6: len
                        304     LOAD_FAST                       0: self
                        306     LOAD_ATTR                       7: Te
                        308     CALL_FUNCTION                   1
                        310     CALL_METHOD                     1
                        312     LOAD_FAST                       0: self
                        314     STORE_ATTR                      18: Esol_SWH
                        316     POP_EXCEPT                      
                        318     JUMP_FORWARD                    168 (to 488)
                        320     RERAISE                         
                        322     LOAD_GLOBAL                     0: int
                        324     LOAD_FAST                       0: self
                        326     LOAD_ATTR                       16: DHW
                        328     LOAD_ATTR                       17: SWH_Area
                        330     CALL_FUNCTION                   1
                        332     LOAD_CONST                      5: 0
                        334     COMPARE_OP                      3 (!=)
                        336     POP_JUMP_IF_FALSE               470
                        340     SETUP_FINALLY                   16 (to 358)
                        342     LOAD_GLOBAL                     0: int
                        344     LOAD_FAST                       0: self
                        346     LOAD_ATTR                       16: DHW
                        348     LOAD_ATTR                       19: SWH_Angle
                        350     CALL_FUNCTION                   1
                        352     POP_TOP                         
                        354     POP_BLOCK                       
                        356     JUMP_FORWARD                    38 (to 396)
                        358     DUP_TOP                         
                        360     LOAD_GLOBAL                     3: ValueError
                        362     JUMP_IF_NOT_EXC_MATCH           394
                        366     POP_TOP                         
                        368     POP_TOP                         
                        370     POP_TOP                         
                        372     LOAD_GLOBAL                     4: np
                        374     LOAD_METHOD                     5: zeros
                        376     LOAD_GLOBAL                     6: len
                        378     LOAD_FAST                       0: self
                        380     LOAD_ATTR                       7: Te
                        382     CALL_FUNCTION                   1
                        384     CALL_METHOD                     1
                        386     LOAD_FAST                       0: self
                        388     STORE_ATTR                      8: Esol_PV
                        390     POP_EXCEPT                      
                        392     JUMP_FORWARD                    74 (to 468)
                        394     RERAISE                         
                        396     LOAD_GLOBAL                     0: int
                        398     LOAD_FAST                       0: self
                        400     LOAD_ATTR                       16: DHW
                        402     LOAD_ATTR                       19: SWH_Angle
                        404     CALL_FUNCTION                   1
                        406     LOAD_CONST                      5: 0
                        408     COMPARE_OP                      2 (==)
                        410     POP_JUMP_IF_FALSE               432
                        414     LOAD_FAST                       0: self
                        416     LOAD_ATTR                       10: wea_dict
                        418     LOAD_CONST                      6: 'Egh'
                        420     BINARY_SUBSCR                   
                        422     LOAD_CONST                      7: 1000
                        424     BINARY_TRUE_DIVIDE              
                        426     LOAD_FAST                       0: self
                        428     STORE_ATTR                      18: Esol_SWH
                        430     JUMP_FORWARD                    36 (to 468)
                        432     LOAD_FAST                       0: self
                        434     LOAD_ATTR                       11: SCal_dict
                        436     LOAD_CONST                      8: 'Esol'
                        438     BINARY_SUBSCR                   
                        440     LOAD_GLOBAL                     0: int
                        442     LOAD_FAST                       0: self
                        444     LOAD_ATTR                       16: DHW
                        446     LOAD_ATTR                       19: SWH_Angle
                        448     CALL_FUNCTION                   1
                        450     BINARY_SUBSCR                   
                        452     LOAD_FAST                       0: self
                        454     LOAD_ATTR                       16: DHW
                        456     LOAD_ATTR                       20: SWH_Orientation
                        458     BINARY_SUBSCR                   
                        460     LOAD_CONST                      7: 1000
                        462     BINARY_TRUE_DIVIDE              
                        464     LOAD_FAST                       0: self
                        466     STORE_ATTR                      18: Esol_SWH
                        468     JUMP_FORWARD                    18 (to 488)
                        470     LOAD_GLOBAL                     4: np
                        472     LOAD_METHOD                     5: zeros
                        474     LOAD_GLOBAL                     6: len
                        476     LOAD_FAST                       0: self
                        478     LOAD_ATTR                       7: Te
                        480     CALL_FUNCTION                   1
                        482     CALL_METHOD                     1
                        484     LOAD_FAST                       0: self
                        486     STORE_ATTR                      18: Esol_SWH
                        488     LOAD_FAST                       0: self
                        490     DUP_TOP                         
                        492     LOAD_ATTR                       18: Esol_SWH
                        494     LOAD_CONST                      9: 3600000
                        496     INPLACE_MULTIPLY                
                        498     ROT_TWO                         
                        500     STORE_ATTR                      18: Esol_SWH
                        502     POP_BLOCK                       
                        504     LOAD_CONST                      10: '__pyarmor_exit_47126__'
                        506     NOP                             
                        508     NOP                             
                        510     LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14\xe4\x01\x00\x00\x00\x00\x00\x00'
                        512     CALL_FUNCTION                   1
                        514     POP_TOP                         
                        516     JUMP_FORWARD                    14 (to 532)
                        518     LOAD_CONST                      10: '__pyarmor_exit_47126__'
                        520     NOP                             
                        522     NOP                             
                        524     LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14\xe4\x01\x00\x00\x00\x00\x00\x00'
                        526     CALL_FUNCTION                   1
                        528     POP_TOP                         
                        530     RERAISE                         
                        532     LOAD_CONST                      0: None
                        534     RETURN_VALUE                    
                'Simulation.renewables'
                [Code]
                    File Name: <frozen simulation>
                    Object Name: aggregate
                    Arg Count: 1
                    Pos Only Arg Count: 0
                    KW Only Arg Count: 0
                    Locals: 6
                    Stack Size: 19
                    Flags: 0x20000043 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NOFREE | CO_PYARMOR_OBFUSCATED)
                    [Names]
                        'hasattr'
                        'if_print'
                        'print'
                        'collections'
                        'OrderedDict'
                        'pump_volume_H'
                        'pump_volume_C'
                        'list'
                        'pre_dict'
                        'items'
                        'T_air_hc'
                        'q_sol_w'
                        'q_sol_op'
                        'q_inf'
                        'q_NV'
                        'q_H_nd'
                        'q_C_nd'
                        'heat_energy'
                        'cool_energy'
                        'qi_li'
                        'qi_app'
                        'DHW_dem'
                        'fan_energy'
                        'occupants'
                        'occupancy_frac'
                        'Htr_op'
                        'Te'
                        'Htr_w'
                        'pd'
                        'DataFrame'
                        'from_dict'
                        'sum'
                        'lighting_energy'
                        'equipment_energy'
                        'q_cond_wall'
                        'q_cond_window'
                        'Pumps'
                        'pump_power_H'
                        'np'
                        'where'
                        'pump_energy_H'
                        'pump_power_C'
                        'pump_energy_C'
                        'pump_energy_HVAC'
                        'copy'
                        'deepcopy'
                        'DHW_dem_1'
                        'Esol_SWH'
                        'DHW'
                        'SWH_Area'
                        'dstr_eff'
                        'gen_eff'
                        'DHW_energy'
                        'Egen_SWH'
                        'DHW_flow'
                        'DHW_supply_water'
                        'fcntrl'
                        'pump_volume_D'
                        'max'
                        'pump_power_D'
                        'pump_energy_DHW'
                        'pump_energy'
                        'agg_dict'
                    [Var Names]
                        'self'
                        '__assert_armored__'
                        '_var_var_104'
                        '_var_var_12'
                        '_var_var_11'
                        '_var_var_27'
                    [Free Vars]
                    [Cell Vars]
                    [Constants]
                        None
                        '__pyarmor_assert_47127__'
                        'Simulation.aggregate.<locals>.<lambda>'
                        '__pyarmor_enter_47128__'
                        b'<COAddr>\x03\x00\x00\x14*\x04\x00\x00\x00\x00\x00\x00'
                        'if_print'
                        True
                        'Processing simulation results...'
                        (
                            'indoor_temperature'
                            'q_sol_w'
                            'q_sol_op'
                            'q_inf'
                            'q_NV'
                            'q_H_nd'
                            'q_C_nd'
                            'heat_energy'
                            'cool_energy'
                            'lighting_energy'
                            'equipment_energy'
                            'DHW_dem'
                            'fan_energy'
                            'occupants'
                            'q_cond_wall'
                            'q_cond_window'
                        )
                        0
                        'Zones'
                        'indoor_temperature'
                        'q_sol_w'
                        'q_sol_op'
                        'q_inf'
                        'q_NV'
                        'q_H_nd'
                        'q_C_nd'
                        'heat_energy'
                        'cool_energy'
                        'lighting_energy'
                        'equipment_energy'
                        'DHW_dem'
                        'fan_energy'
                        'occupants'
                        3600
                        'q_cond_wall'
                        'q_cond_window'
                        1
                        (
                            'axis'
                        )
                        0.5
                        0.8
                        '__pyarmor_exit_47129__'
                    [Disassembly]
                        0       NOP                             
                        2       NOP                             
                        4       NOP                             
                        6       NOP                             
                        8       LOAD_CONST                      3: '__pyarmor_enter_47128__'
                        10      NOP                             
                        12      NOP                             
                        14      LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x14*\x04\x00\x00\x00\x00\x00\x00'
                        16      CALL_FUNCTION                   1
                        18      POP_TOP                         
                        20      SETUP_FINALLY                   1076 (to 1100)
                        24      LOAD_GLOBAL                     0: hasattr
                        26      LOAD_FAST                       0: self
                        28      LOAD_CONST                      5: 'if_print'
                        30      CALL_FUNCTION                   2
                        32      POP_JUMP_IF_FALSE               52
                        34      LOAD_FAST                       0: self
                        36      LOAD_ATTR                       1: if_print
                        38      LOAD_CONST                      6: True
                        40      COMPARE_OP                      2 (==)
                        42      POP_JUMP_IF_FALSE               52
                        44      LOAD_GLOBAL                     2: print
                        46      LOAD_CONST                      7: 'Processing simulation results...'
                        48      CALL_FUNCTION                   1
                        50      POP_TOP                         
                        52      LOAD_GLOBAL                     3: collections
                        54      LOAD_METHOD                     4: OrderedDict
                        56      BUILD_MAP                       0
                        58      BUILD_MAP                       0
                        60      BUILD_MAP                       0
                        62      BUILD_MAP                       0
                        64      BUILD_MAP                       0
                        66      BUILD_MAP                       0
                        68      BUILD_MAP                       0
                        70      BUILD_MAP                       0
                        72      BUILD_MAP                       0
                        74      BUILD_MAP                       0
                        76      BUILD_MAP                       0
                        78      BUILD_MAP                       0
                        80      BUILD_MAP                       0
                        82      BUILD_MAP                       0
                        84      BUILD_MAP                       0
                        86      BUILD_MAP                       0
                        88      LOAD_CONST                      8: ('indoor_temperature', 'q_sol_w', 'q_sol_op', 'q_inf', 'q_NV', 'q_H_nd', 'q_C_nd', 'heat_energy', 'cool_energy', 'lighting_energy', 'equipment_energy', 'DHW_dem', 'fan_energy', 'occupants', 'q_cond_wall', 'q_cond_window')
                        90      BUILD_CONST_KEY_MAP             16
                        92      CALL_METHOD                     1
                        94      STORE_FAST                      2: _var_var_104
                        96      LOAD_CONST                      9: 0
                        98      LOAD_FAST                       0: self
                        100     STORE_ATTR                      5: pump_volume_H
                        102     LOAD_CONST                      9: 0
                        104     LOAD_FAST                       0: self
                        106     STORE_ATTR                      6: pump_volume_C
                        108     LOAD_GLOBAL                     7: list
                        110     LOAD_FAST                       0: self
                        112     LOAD_ATTR                       8: pre_dict
                        114     LOAD_CONST                      10: 'Zones'
                        116     BINARY_SUBSCR                   
                        118     LOAD_METHOD                     9: items
                        120     CALL_METHOD                     0
                        122     CALL_FUNCTION                   1
                        124     GET_ITER                        
                        126     FOR_ITER                        302 (to 432)
                        130     UNPACK_SEQUENCE                 2
                        132     STORE_FAST                      3: _var_var_12
                        134     STORE_FAST                      4: _var_var_11
                        136     LOAD_FAST                       4: _var_var_11
                        138     LOAD_ATTR                       10: T_air_hc
                        140     LOAD_FAST                       2: _var_var_104
                        142     LOAD_CONST                      11: 'indoor_temperature'
                        144     BINARY_SUBSCR                   
                        146     LOAD_FAST                       3: _var_var_12
                        148     STORE_SUBSCR                    
                        150     LOAD_FAST                       4: _var_var_11
                        152     LOAD_ATTR                       11: q_sol_w
                        154     LOAD_FAST                       2: _var_var_104
                        156     LOAD_CONST                      12: 'q_sol_w'
                        158     BINARY_SUBSCR                   
                        160     LOAD_FAST                       3: _var_var_12
                        162     STORE_SUBSCR                    
                        164     LOAD_FAST                       4: _var_var_11
                        166     LOAD_ATTR                       12: q_sol_op
                        168     LOAD_FAST                       2: _var_var_104
                        170     LOAD_CONST                      13: 'q_sol_op'
                        172     BINARY_SUBSCR                   
                        174     LOAD_FAST                       3: _var_var_12
                        176     STORE_SUBSCR                    
                        178     LOAD_FAST                       4: _var_var_11
                        180     LOAD_ATTR                       13: q_inf
                        182     LOAD_FAST                       2: _var_var_104
                        184     LOAD_CONST                      14: 'q_inf'
                        186     BINARY_SUBSCR                   
                        188     LOAD_FAST                       3: _var_var_12
                        190     STORE_SUBSCR                    
                        192     LOAD_FAST                       4: _var_var_11
                        194     LOAD_ATTR                       14: q_NV
                        196     LOAD_FAST                       2: _var_var_104
                        198     LOAD_CONST                      15: 'q_NV'
                        200     BINARY_SUBSCR                   
                        202     LOAD_FAST                       3: _var_var_12
                        204     STORE_SUBSCR                    
                        206     LOAD_FAST                       4: _var_var_11
                        208     LOAD_ATTR                       15: q_H_nd
                        210     LOAD_FAST                       2: _var_var_104
                        212     LOAD_CONST                      16: 'q_H_nd'
                        214     BINARY_SUBSCR                   
                        216     LOAD_FAST                       3: _var_var_12
                        218     STORE_SUBSCR                    
                        220     LOAD_FAST                       4: _var_var_11
                        222     LOAD_ATTR                       16: q_C_nd
                        224     LOAD_FAST                       2: _var_var_104
                        226     LOAD_CONST                      17: 'q_C_nd'
                        228     BINARY_SUBSCR                   
                        230     LOAD_FAST                       3: _var_var_12
                        232     STORE_SUBSCR                    
                        234     LOAD_FAST                       4: _var_var_11
                        236     LOAD_ATTR                       17: heat_energy
                        238     LOAD_FAST                       2: _var_var_104
                        240     LOAD_CONST                      18: 'heat_energy'
                        242     BINARY_SUBSCR                   
                        244     LOAD_FAST                       3: _var_var_12
                        246     STORE_SUBSCR                    
                        248     LOAD_FAST                       4: _var_var_11
                        250     LOAD_ATTR                       18: cool_energy
                        252     LOAD_FAST                       2: _var_var_104
                        254     LOAD_CONST                      19: 'cool_energy'
                        256     BINARY_SUBSCR                   
                        258     LOAD_FAST                       3: _var_var_12
                        260     STORE_SUBSCR                    
                        262     LOAD_FAST                       4: _var_var_11
                        264     LOAD_ATTR                       19: qi_li
                        266     LOAD_FAST                       2: _var_var_104
                        268     LOAD_CONST                      20: 'lighting_energy'
                        270     BINARY_SUBSCR                   
                        272     LOAD_FAST                       3: _var_var_12
                        274     STORE_SUBSCR                    
                        276     LOAD_FAST                       4: _var_var_11
                        278     LOAD_ATTR                       20: qi_app
                        280     LOAD_FAST                       2: _var_var_104
                        282     LOAD_CONST                      21: 'equipment_energy'
                        284     BINARY_SUBSCR                   
                        286     LOAD_FAST                       3: _var_var_12
                        288     STORE_SUBSCR                    
                        290     LOAD_FAST                       4: _var_var_11
                        292     LOAD_ATTR                       21: DHW_dem
                        294     LOAD_FAST                       2: _var_var_104
                        296     LOAD_CONST                      22: 'DHW_dem'
                        298     BINARY_SUBSCR                   
                        300     LOAD_FAST                       3: _var_var_12
                        302     STORE_SUBSCR                    
                        304     LOAD_FAST                       4: _var_var_11
                        306     LOAD_ATTR                       22: fan_energy
                        308     LOAD_FAST                       2: _var_var_104
                        310     LOAD_CONST                      23: 'fan_energy'
                        312     BINARY_SUBSCR                   
                        314     LOAD_FAST                       3: _var_var_12
                        316     STORE_SUBSCR                    
                        318     LOAD_FAST                       4: _var_var_11
                        320     LOAD_ATTR                       23: occupants
                        322     LOAD_FAST                       4: _var_var_11
                        324     LOAD_ATTR                       24: occupancy_frac
                        326     BINARY_MULTIPLY                 
                        328     LOAD_FAST                       2: _var_var_104
                        330     LOAD_CONST                      24: 'occupants'
                        332     BINARY_SUBSCR                   
                        334     LOAD_FAST                       3: _var_var_12
                        336     STORE_SUBSCR                    
                        338     LOAD_FAST                       4: _var_var_11
                        340     LOAD_ATTR                       25: Htr_op
                        342     LOAD_FAST                       0: self
                        344     LOAD_ATTR                       26: Te
                        346     LOAD_FAST                       4: _var_var_11
                        348     LOAD_ATTR                       10: T_air_hc
                        350     BINARY_SUBTRACT                 
                        352     BINARY_MULTIPLY                 
                        354     LOAD_CONST                      25: 3600
                        356     BINARY_MULTIPLY                 
                        358     LOAD_FAST                       2: _var_var_104
                        360     LOAD_CONST                      26: 'q_cond_wall'
                        362     BINARY_SUBSCR                   
                        364     LOAD_FAST                       3: _var_var_12
                        366     STORE_SUBSCR                    
                        368     LOAD_FAST                       4: _var_var_11
                        370     LOAD_ATTR                       27: Htr_w
                        372     LOAD_FAST                       0: self
                        374     LOAD_ATTR                       26: Te
                        376     LOAD_FAST                       4: _var_var_11
                        378     LOAD_ATTR                       10: T_air_hc
                        380     BINARY_SUBTRACT                 
                        382     BINARY_MULTIPLY                 
                        384     LOAD_CONST                      25: 3600
                        386     BINARY_MULTIPLY                 
                        388     LOAD_FAST                       2: _var_var_104
                        390     LOAD_CONST                      27: 'q_cond_window'
                        392     BINARY_SUBSCR                   
                        394     LOAD_FAST                       3: _var_var_12
                        396     STORE_SUBSCR                    
                        398     LOAD_FAST                       0: self
                        400     DUP_TOP                         
                        402     LOAD_ATTR                       5: pump_volume_H
                        404     LOAD_FAST                       4: _var_var_11
                        406     LOAD_ATTR                       5: pump_volume_H
                        408     INPLACE_ADD                     
                        410     ROT_TWO                         
                        412     STORE_ATTR                      5: pump_volume_H
                        414     LOAD_FAST                       0: self
                        416     DUP_TOP                         
                        418     LOAD_ATTR                       6: pump_volume_C
                        420     LOAD_FAST                       4: _var_var_11
                        422     LOAD_ATTR                       6: pump_volume_C
                        424     INPLACE_ADD                     
                        426     ROT_TWO                         
                        428     STORE_ATTR                      6: pump_volume_C
                        430     JUMP_ABSOLUTE                   126
                        432     LOAD_FAST                       2: _var_var_104
                        434     GET_ITER                        
                        436     FOR_ITER                        26 (to 464)
                        438     STORE_FAST                      5: _var_var_27
                        440     LOAD_GLOBAL                     28: pd
                        442     LOAD_ATTR                       29: DataFrame
                        444     LOAD_METHOD                     30: from_dict
                        446     LOAD_FAST                       2: _var_var_104
                        448     LOAD_FAST                       5: _var_var_27
                        450     BINARY_SUBSCR                   
                        452     CALL_METHOD                     1
                        454     LOAD_FAST                       2: _var_var_104
                        456     LOAD_FAST                       5: _var_var_27
                        458     STORE_SUBSCR                    
                        460     JUMP_ABSOLUTE                   436
                        464     LOAD_FAST                       2: _var_var_104
                        466     LOAD_CONST                      12: 'q_sol_w'
                        468     BINARY_SUBSCR                   
                        470     LOAD_ATTR                       31: sum
                        472     LOAD_CONST                      28: 1
                        474     LOAD_CONST                      29: ('axis',)
                        476     CALL_FUNCTION_KW                1
                        478     LOAD_FAST                       0: self
                        480     STORE_ATTR                      11: q_sol_w
                        482     LOAD_FAST                       2: _var_var_104
                        484     LOAD_CONST                      13: 'q_sol_op'
                        486     BINARY_SUBSCR                   
                        488     LOAD_ATTR                       31: sum
                        490     LOAD_CONST                      28: 1
                        492     LOAD_CONST                      29: ('axis',)
                        494     CALL_FUNCTION_KW                1
                        496     LOAD_FAST                       0: self
                        498     STORE_ATTR                      12: q_sol_op
                        500     LOAD_FAST                       2: _var_var_104
                        502     LOAD_CONST                      14: 'q_inf'
                        504     BINARY_SUBSCR                   
                        506     LOAD_ATTR                       31: sum
                        508     LOAD_CONST                      28: 1
                        510     LOAD_CONST                      29: ('axis',)
                        512     CALL_FUNCTION_KW                1
                        514     LOAD_FAST                       0: self
                        516     STORE_ATTR                      13: q_inf
                        518     LOAD_FAST                       2: _var_var_104
                        520     LOAD_CONST                      15: 'q_NV'
                        522     BINARY_SUBSCR                   
                        524     LOAD_ATTR                       31: sum
                        526     LOAD_CONST                      28: 1
                        528     LOAD_CONST                      29: ('axis',)
                        530     CALL_FUNCTION_KW                1
                        532     LOAD_FAST                       0: self
                        534     STORE_ATTR                      14: q_NV
                        536     LOAD_FAST                       2: _var_var_104
                        538     LOAD_CONST                      20: 'lighting_energy'
                        540     BINARY_SUBSCR                   
                        542     LOAD_ATTR                       31: sum
                        544     LOAD_CONST                      28: 1
                        546     LOAD_CONST                      29: ('axis',)
                        548     CALL_FUNCTION_KW                1
                        550     LOAD_FAST                       0: self
                        552     STORE_ATTR                      32: lighting_energy
                        554     LOAD_FAST                       2: _var_var_104
                        556     LOAD_CONST                      21: 'equipment_energy'
                        558     BINARY_SUBSCR                   
                        560     LOAD_ATTR                       31: sum
                        562     LOAD_CONST                      28: 1
                        564     LOAD_CONST                      29: ('axis',)
                        566     CALL_FUNCTION_KW                1
                        568     LOAD_FAST                       0: self
                        570     STORE_ATTR                      33: equipment_energy
                        572     LOAD_FAST                       2: _var_var_104
                        574     LOAD_CONST                      16: 'q_H_nd'
                        576     BINARY_SUBSCR                   
                        578     LOAD_ATTR                       31: sum
                        580     LOAD_CONST                      28: 1
                        582     LOAD_CONST                      29: ('axis',)
                        584     CALL_FUNCTION_KW                1
                        586     LOAD_FAST                       0: self
                        588     STORE_ATTR                      15: q_H_nd
                        590     LOAD_FAST                       2: _var_var_104
                        592     LOAD_CONST                      17: 'q_C_nd'
                        594     BINARY_SUBSCR                   
                        596     LOAD_ATTR                       31: sum
                        598     LOAD_CONST                      28: 1
                        600     LOAD_CONST                      29: ('axis',)
                        602     CALL_FUNCTION_KW                1
                        604     LOAD_FAST                       0: self
                        606     STORE_ATTR                      16: q_C_nd
                        608     LOAD_FAST                       2: _var_var_104
                        610     LOAD_CONST                      18: 'heat_energy'
                        612     BINARY_SUBSCR                   
                        614     LOAD_ATTR                       31: sum
                        616     LOAD_CONST                      28: 1
                        618     LOAD_CONST                      29: ('axis',)
                        620     CALL_FUNCTION_KW                1
                        622     LOAD_FAST                       0: self
                        624     STORE_ATTR                      17: heat_energy
                        626     LOAD_FAST                       2: _var_var_104
                        628     LOAD_CONST                      19: 'cool_energy'
                        630     BINARY_SUBSCR                   
                        632     LOAD_ATTR                       31: sum
                        634     LOAD_CONST                      28: 1
                        636     LOAD_CONST                      29: ('axis',)
                        638     CALL_FUNCTION_KW                1
                        640     LOAD_FAST                       0: self
                        642     STORE_ATTR                      18: cool_energy
                        644     LOAD_FAST                       2: _var_var_104
                        646     LOAD_CONST                      22: 'DHW_dem'
                        648     BINARY_SUBSCR                   
                        650     LOAD_ATTR                       31: sum
                        652     LOAD_CONST                      28: 1
                        654     LOAD_CONST                      29: ('axis',)
                        656     CALL_FUNCTION_KW                1
                        658     LOAD_FAST                       0: self
                        660     STORE_ATTR                      21: DHW_dem
                        662     LOAD_FAST                       2: _var_var_104
                        664     LOAD_CONST                      23: 'fan_energy'
                        666     BINARY_SUBSCR                   
                        668     LOAD_ATTR                       31: sum
                        670     LOAD_CONST                      28: 1
                        672     LOAD_CONST                      29: ('axis',)
                        674     CALL_FUNCTION_KW                1
                        676     LOAD_FAST                       0: self
                        678     STORE_ATTR                      22: fan_energy
                        680     LOAD_FAST                       2: _var_var_104
                        682     LOAD_CONST                      24: 'occupants'
                        684     BINARY_SUBSCR                   
                        686     LOAD_ATTR                       31: sum
                        688     LOAD_CONST                      28: 1
                        690     LOAD_CONST                      29: ('axis',)
                        692     CALL_FUNCTION_KW                1
                        694     LOAD_FAST                       0: self
                        696     STORE_ATTR                      23: occupants
                        698     LOAD_FAST                       2: _var_var_104
                        700     LOAD_CONST                      26: 'q_cond_wall'
                        702     BINARY_SUBSCR                   
                        704     LOAD_ATTR                       31: sum
                        706     LOAD_CONST                      28: 1
                        708     LOAD_CONST                      29: ('axis',)
                        710     CALL_FUNCTION_KW                1
                        712     LOAD_FAST                       0: self
                        714     STORE_ATTR                      34: q_cond_wall
                        716     LOAD_FAST                       2: _var_var_104
                        718     LOAD_CONST                      27: 'q_cond_window'
                        720     BINARY_SUBSCR                   
                        722     LOAD_ATTR                       31: sum
                        724     LOAD_CONST                      28: 1
                        726     LOAD_CONST                      29: ('axis',)
                        728     CALL_FUNCTION_KW                1
                        730     LOAD_FAST                       0: self
                        732     STORE_ATTR                      35: q_cond_window
                        734     LOAD_FAST                       0: self
                        736     LOAD_ATTR                       36: Pumps
                        738     LOAD_ATTR                       37: pump_power_H
                        740     LOAD_FAST                       0: self
                        742     LOAD_ATTR                       5: pump_volume_H
                        744     BINARY_MULTIPLY                 
                        746     LOAD_GLOBAL                     38: np
                        748     LOAD_METHOD                     39: where
                        750     LOAD_FAST                       0: self
                        752     LOAD_ATTR                       17: heat_energy
                        754     LOAD_CONST                      9: 0
                        756     COMPARE_OP                      4 (>)
                        758     LOAD_CONST                      28: 1
                        760     LOAD_CONST                      9: 0
                        762     CALL_METHOD                     3
                        764     BINARY_MULTIPLY                 
                        766     LOAD_CONST                      25: 3600
                        768     BINARY_MULTIPLY                 
                        770     LOAD_FAST                       0: self
                        772     STORE_ATTR                      40: pump_energy_H
                        774     LOAD_FAST                       0: self
                        776     LOAD_ATTR                       36: Pumps
                        778     LOAD_ATTR                       41: pump_power_C
                        780     LOAD_FAST                       0: self
                        782     LOAD_ATTR                       6: pump_volume_C
                        784     BINARY_MULTIPLY                 
                        786     LOAD_GLOBAL                     38: np
                        788     LOAD_METHOD                     39: where
                        790     LOAD_FAST                       0: self
                        792     LOAD_ATTR                       18: cool_energy
                        794     LOAD_CONST                      9: 0
                        796     COMPARE_OP                      4 (>)
                        798     LOAD_CONST                      28: 1
                        800     LOAD_CONST                      9: 0
                        802     CALL_METHOD                     3
                        804     BINARY_MULTIPLY                 
                        806     LOAD_CONST                      25: 3600
                        808     BINARY_MULTIPLY                 
                        810     LOAD_FAST                       0: self
                        812     STORE_ATTR                      42: pump_energy_C
                        814     LOAD_FAST                       0: self
                        816     LOAD_ATTR                       42: pump_energy_C
                        818     LOAD_FAST                       0: self
                        820     LOAD_ATTR                       40: pump_energy_H
                        822     BINARY_ADD                      
                        824     LOAD_FAST                       0: self
                        826     STORE_ATTR                      43: pump_energy_HVAC
                        828     LOAD_GLOBAL                     44: copy
                        830     LOAD_METHOD                     45: deepcopy
                        832     LOAD_FAST                       0: self
                        834     LOAD_ATTR                       21: DHW_dem
                        836     CALL_METHOD                     1
                        838     LOAD_FAST                       0: self
                        840     STORE_ATTR                      46: DHW_dem_1
                        842     LOAD_FAST                       0: self
                        844     DUP_TOP                         
                        846     LOAD_ATTR                       21: DHW_dem
                        848     LOAD_FAST                       0: self
                        850     LOAD_ATTR                       47: Esol_SWH
                        852     LOAD_FAST                       0: self
                        854     LOAD_ATTR                       48: DHW
                        856     LOAD_ATTR                       49: SWH_Area
                        858     BINARY_MULTIPLY                 
                        860     LOAD_CONST                      30: 0.5
                        862     BINARY_MULTIPLY                 
                        864     INPLACE_SUBTRACT                
                        866     ROT_TWO                         
                        868     STORE_ATTR                      21: DHW_dem
                        870     LOAD_GLOBAL                     38: np
                        872     LOAD_METHOD                     39: where
                        874     LOAD_FAST                       0: self
                        876     LOAD_ATTR                       21: DHW_dem
                        878     LOAD_CONST                      9: 0
                        880     COMPARE_OP                      4 (>)
                        882     LOAD_FAST                       0: self
                        884     LOAD_ATTR                       21: DHW_dem
                        886     LOAD_CONST                      9: 0
                        888     CALL_METHOD                     3
                        890     LOAD_FAST                       0: self
                        892     STORE_ATTR                      21: DHW_dem
                        894     LOAD_FAST                       0: self
                        896     LOAD_ATTR                       21: DHW_dem
                        898     LOAD_FAST                       0: self
                        900     LOAD_ATTR                       48: DHW
                        902     LOAD_ATTR                       50: dstr_eff
                        904     LOAD_FAST                       0: self
                        906     LOAD_ATTR                       48: DHW
                        908     LOAD_ATTR                       51: gen_eff
                        910     BINARY_MULTIPLY                 
                        912     BINARY_TRUE_DIVIDE              
                        914     LOAD_FAST                       0: self
                        916     STORE_ATTR                      52: DHW_energy
                        918     LOAD_GLOBAL                     38: np
                        920     LOAD_METHOD                     39: where
                        922     LOAD_FAST                       0: self
                        924     LOAD_ATTR                       52: DHW_energy
                        926     LOAD_CONST                      9: 0
                        928     COMPARE_OP                      4 (>)
                        930     LOAD_FAST                       0: self
                        932     LOAD_ATTR                       47: Esol_SWH
                        934     LOAD_FAST                       0: self
                        936     LOAD_ATTR                       48: DHW
                        938     LOAD_ATTR                       49: SWH_Area
                        940     BINARY_MULTIPLY                 
                        942     LOAD_CONST                      30: 0.5
                        944     BINARY_MULTIPLY                 
                        946     LOAD_FAST                       0: self
                        948     LOAD_ATTR                       46: DHW_dem_1
                        950     CALL_METHOD                     3
                        952     LOAD_FAST                       0: self
                        954     STORE_ATTR                      53: Egen_SWH
                        956     LOAD_GLOBAL                     38: np
                        958     LOAD_METHOD                     39: where
                        960     LOAD_FAST                       0: self
                        962     LOAD_ATTR                       21: DHW_dem
                        964     LOAD_CONST                      9: 0
                        966     COMPARE_OP                      3 (!=)
                        968     LOAD_FAST                       0: self
                        970     LOAD_ATTR                       36: Pumps
                        972     LOAD_ATTR                       54: DHW_flow
                        974     LOAD_CONST                      9: 0
                        976     CALL_METHOD                     3
                        978     LOAD_FAST                       0: self
                        980     STORE_ATTR                      55: DHW_supply_water
                        982     LOAD_FAST                       0: self
                        984     LOAD_ATTR                       36: Pumps
                        986     LOAD_ATTR                       56: fcntrl
                        988     LOAD_CONST                      30: 0.5
                        990     COMPARE_OP                      2 (==)
                        992     POP_JUMP_IF_FALSE               1006
                        996     LOAD_FAST                       0: self
                        998     LOAD_ATTR                       55: DHW_supply_water
                        1000    LOAD_FAST                       0: self
                        1002    STORE_ATTR                      57: pump_volume_D
                        1004    JUMP_FORWARD                    38 (to 1044)
                        1006    LOAD_FAST                       0: self
                        1008    LOAD_ATTR                       36: Pumps
                        1010    LOAD_ATTR                       56: fcntrl
                        1012    LOAD_CONST                      28: 1
                        1014    COMPARE_OP                      2 (==)
                        1016    POP_JUMP_IF_FALSE               1038
                        1020    LOAD_CONST                      31: 0.8
                        1022    LOAD_GLOBAL                     58: max
                        1024    LOAD_FAST                       0: self
                        1026    LOAD_ATTR                       55: DHW_supply_water
                        1028    CALL_FUNCTION                   1
                        1030    BINARY_MULTIPLY                 
                        1032    LOAD_FAST                       0: self
                        1034    STORE_ATTR                      57: pump_volume_D
                        1036    JUMP_FORWARD                    6 (to 1044)
                        1038    LOAD_CONST                      9: 0
                        1040    LOAD_FAST                       0: self
                        1042    STORE_ATTR                      57: pump_volume_D
                        1044    LOAD_FAST                       0: self
                        1046    LOAD_ATTR                       36: Pumps
                        1048    LOAD_ATTR                       59: pump_power_D
                        1050    LOAD_FAST                       0: self
                        1052    LOAD_ATTR                       57: pump_volume_D
                        1054    BINARY_MULTIPLY                 
                        1056    LOAD_CONST                      25: 3600
                        1058    BINARY_MULTIPLY                 
                        1060    LOAD_FAST                       0: self
                        1062    STORE_ATTR                      60: pump_energy_DHW
                        1064    LOAD_FAST                       0: self
                        1066    LOAD_ATTR                       43: pump_energy_HVAC
                        1068    LOAD_FAST                       0: self
                        1070    LOAD_ATTR                       60: pump_energy_DHW
                        1072    BINARY_ADD                      
                        1074    LOAD_FAST                       0: self
                        1076    STORE_ATTR                      61: pump_energy
                        1078    LOAD_FAST                       2: _var_var_104
                        1080    LOAD_FAST                       0: self
                        1082    STORE_ATTR                      62: agg_dict
                        1084    POP_BLOCK                       
                        1086    LOAD_CONST                      32: '__pyarmor_exit_47129__'
                        1088    NOP                             
                        1090    NOP                             
                        1092    LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x14*\x04\x00\x00\x00\x00\x00\x00'
                        1094    CALL_FUNCTION                   1
                        1096    POP_TOP                         
                        1098    JUMP_FORWARD                    14 (to 1114)
                        1100    LOAD_CONST                      32: '__pyarmor_exit_47129__'
                        1102    NOP                             
                        1104    NOP                             
                        1106    LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x14*\x04\x00\x00\x00\x00\x00\x00'
                        1108    CALL_FUNCTION                   1
                        1110    POP_TOP                         
                        1112    RERAISE                         
                        1114    LOAD_CONST                      0: None
                        1116    RETURN_VALUE                    
                'Simulation.aggregate'
                [Code]
                    File Name: <frozen simulation>
                    Object Name: comfAnalysis
                    Arg Count: 1
                    Pos Only Arg Count: 0
                    KW Only Arg Count: 0
                    Locals: 9
                    Stack Size: 9
                    Flags: 0x20000043 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NOFREE | CO_PYARMOR_OBFUSCATED)
                    [Names]
                        'pd'
                        'DataFrame'
                        'list'
                        'pre_dict'
                        'items'
                        'range'
                        'len'
                        'Te'
                        'T_air_hc'
                        'T_s_hc'
                        'occupancy_frac'
                        'comfort'
                        'comfPMVElevatedAirspeed'
                        'values'
                        'where'
                    [Var Names]
                        'self'
                        '__assert_armored__'
                        '_var_var_105'
                        '_var_var_106'
                        '_var_var_107'
                        '_var_var_12'
                        '_var_var_11'
                        '_var_var_108'
                        '_var_var_109'
                    [Free Vars]
                    [Cell Vars]
                    [Constants]
                        None
                        '__pyarmor_assert_47130__'
                        'Simulation.comfAnalysis.<locals>.<lambda>'
                        '__pyarmor_enter_47131__'
                        b'<COAddr>\x01\x00\x00\x14>\x01\x00\x00\x00\x00\x00\x00'
                        [Code]
                            File Name: <frozen simulation>
                            Object Name: <listcomp>
                            Arg Count: 1
                            Pos Only Arg Count: 0
                            KW Only Arg Count: 0
                            Locals: 3
                            Stack Size: 4
                            Flags: 0x00000053 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NESTED | CO_NOFREE)
                            [Names]
                            [Var Names]
                                '.0'
                                '_var_var_12'
                                '_var_var_11'
                            [Free Vars]
                            [Cell Vars]
                            [Constants]
                            [Disassembly]
                                0       BUILD_LIST                      0
                                2       LOAD_FAST                       0: .0
                                4       FOR_ITER                        12 (to 18)
                                6       UNPACK_SEQUENCE                 2
                                8       STORE_FAST                      1: _var_var_12
                                10      STORE_FAST                      2: _var_var_11
                                12      LOAD_FAST                       1: _var_var_12
                                14      LIST_APPEND                     2
                                16      JUMP_ABSOLUTE                   4
                                18      RETURN_VALUE                    
                        'Simulation.comfAnalysis.<locals>.<listcomp>'
                        'Zones'
                        (
                            'columns'
                            'index'
                        )
                        [Code]
                            File Name: <frozen simulation>
                            Object Name: <listcomp>
                            Arg Count: 1
                            Pos Only Arg Count: 0
                            KW Only Arg Count: 0
                            Locals: 3
                            Stack Size: 4
                            Flags: 0x00000053 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NESTED | CO_NOFREE)
                            [Names]
                            [Var Names]
                                '.0'
                                '_var_var_12'
                                '_var_var_11'
                            [Free Vars]
                            [Cell Vars]
                            [Constants]
                            [Disassembly]
                                0       BUILD_LIST                      0
                                2       LOAD_FAST                       0: .0
                                4       FOR_ITER                        12 (to 18)
                                6       UNPACK_SEQUENCE                 2
                                8       STORE_FAST                      1: _var_var_12
                                10      STORE_FAST                      2: _var_var_11
                                12      LOAD_FAST                       1: _var_var_12
                                14      LIST_APPEND                     2
                                16      JUMP_ABSOLUTE                   4
                                18      RETURN_VALUE                    
                        [Code]
                            File Name: <frozen simulation>
                            Object Name: <listcomp>
                            Arg Count: 1
                            Pos Only Arg Count: 0
                            KW Only Arg Count: 0
                            Locals: 3
                            Stack Size: 4
                            Flags: 0x00000053 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NESTED | CO_NOFREE)
                            [Names]
                            [Var Names]
                                '.0'
                                '_var_var_12'
                                '_var_var_11'
                            [Free Vars]
                            [Cell Vars]
                            [Constants]
                            [Disassembly]
                                0       BUILD_LIST                      0
                                2       LOAD_FAST                       0: .0
                                4       FOR_ITER                        12 (to 18)
                                6       UNPACK_SEQUENCE                 2
                                8       STORE_FAST                      1: _var_var_12
                                10      STORE_FAST                      2: _var_var_11
                                12      LOAD_FAST                       1: _var_var_12
                                14      LIST_APPEND                     2
                                16      JUMP_ABSOLUTE                   4
                                18      RETURN_VALUE                    
                        0.1
                        55
                        1.1
                        0.5
                        0
                        [Code]
                            File Name: <frozen simulation>
                            Object Name: <listcomp>
                            Arg Count: 1
                            Pos Only Arg Count: 0
                            KW Only Arg Count: 0
                            Locals: 3
                            Stack Size: 4
                            Flags: 0x00000053 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NESTED | CO_NOFREE)
                            [Names]
                            [Var Names]
                                '.0'
                                '_var_var_12'
                                '_var_var_11'
                            [Free Vars]
                            [Cell Vars]
                            [Constants]
                            [Disassembly]
                                0       BUILD_LIST                      0
                                2       LOAD_FAST                       0: .0
                                4       FOR_ITER                        12 (to 18)
                                6       UNPACK_SEQUENCE                 2
                                8       STORE_FAST                      1: _var_var_12
                                10      STORE_FAST                      2: _var_var_11
                                12      LOAD_FAST                       1: _var_var_12
                                14      LIST_APPEND                     2
                                16      JUMP_ABSOLUTE                   4
                                18      RETURN_VALUE                    
                        (
                            'data'
                            'columns'
                            'index'
                        )
                        '__pyarmor_exit_47132__'
                    [Disassembly]
                        0       NOP                             
                        2       NOP                             
                        4       NOP                             
                        6       NOP                             
                        8       LOAD_CONST                      3: '__pyarmor_enter_47131__'
                        10      NOP                             
                        12      NOP                             
                        14      LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14>\x01\x00\x00\x00\x00\x00\x00'
                        16      CALL_FUNCTION                   1
                        18      POP_TOP                         
                        20      SETUP_FINALLY                   328 (to 352)
                        24      LOAD_GLOBAL                     0: pd
                        26      LOAD_ATTR                       1: DataFrame
                        28      LOAD_CONST                      5: <CODE> <listcomp>
                        30      LOAD_CONST                      6: 'Simulation.comfAnalysis.<locals>.<listcomp>'
                        32      MAKE_FUNCTION                   0
                        34      LOAD_GLOBAL                     2: list
                        36      LOAD_FAST                       0: self
                        38      LOAD_ATTR                       3: pre_dict
                        40      LOAD_CONST                      7: 'Zones'
                        42      BINARY_SUBSCR                   
                        44      LOAD_METHOD                     4: items
                        46      CALL_METHOD                     0
                        48      CALL_FUNCTION                   1
                        50      GET_ITER                        
                        52      CALL_FUNCTION                   1
                        54      LOAD_GLOBAL                     2: list
                        56      LOAD_GLOBAL                     5: range
                        58      LOAD_GLOBAL                     6: len
                        60      LOAD_FAST                       0: self
                        62      LOAD_ATTR                       7: Te
                        64      CALL_FUNCTION                   1
                        66      CALL_FUNCTION                   1
                        68      CALL_FUNCTION                   1
                        70      LOAD_CONST                      8: ('columns', 'index')
                        72      CALL_FUNCTION_KW                2
                        74      STORE_FAST                      2: _var_var_105
                        76      LOAD_GLOBAL                     0: pd
                        78      LOAD_ATTR                       1: DataFrame
                        80      LOAD_CONST                      9: <CODE> <listcomp>
                        82      LOAD_CONST                      6: 'Simulation.comfAnalysis.<locals>.<listcomp>'
                        84      MAKE_FUNCTION                   0
                        86      LOAD_GLOBAL                     2: list
                        88      LOAD_FAST                       0: self
                        90      LOAD_ATTR                       3: pre_dict
                        92      LOAD_CONST                      7: 'Zones'
                        94      BINARY_SUBSCR                   
                        96      LOAD_METHOD                     4: items
                        98      CALL_METHOD                     0
                        100     CALL_FUNCTION                   1
                        102     GET_ITER                        
                        104     CALL_FUNCTION                   1
                        106     LOAD_GLOBAL                     2: list
                        108     LOAD_GLOBAL                     5: range
                        110     LOAD_GLOBAL                     6: len
                        112     LOAD_FAST                       0: self
                        114     LOAD_ATTR                       7: Te
                        116     CALL_FUNCTION                   1
                        118     CALL_FUNCTION                   1
                        120     CALL_FUNCTION                   1
                        122     LOAD_CONST                      8: ('columns', 'index')
                        124     CALL_FUNCTION_KW                2
                        126     STORE_FAST                      3: _var_var_106
                        128     LOAD_GLOBAL                     0: pd
                        130     LOAD_ATTR                       1: DataFrame
                        132     LOAD_CONST                      10: <CODE> <listcomp>
                        134     LOAD_CONST                      6: 'Simulation.comfAnalysis.<locals>.<listcomp>'
                        136     MAKE_FUNCTION                   0
                        138     LOAD_GLOBAL                     2: list
                        140     LOAD_FAST                       0: self
                        142     LOAD_ATTR                       3: pre_dict
                        144     LOAD_CONST                      7: 'Zones'
                        146     BINARY_SUBSCR                   
                        148     LOAD_METHOD                     4: items
                        150     CALL_METHOD                     0
                        152     CALL_FUNCTION                   1
                        154     GET_ITER                        
                        156     CALL_FUNCTION                   1
                        158     LOAD_GLOBAL                     2: list
                        160     LOAD_GLOBAL                     5: range
                        162     LOAD_GLOBAL                     6: len
                        164     LOAD_FAST                       0: self
                        166     LOAD_ATTR                       7: Te
                        168     CALL_FUNCTION                   1
                        170     CALL_FUNCTION                   1
                        172     CALL_FUNCTION                   1
                        174     LOAD_CONST                      8: ('columns', 'index')
                        176     CALL_FUNCTION_KW                2
                        178     STORE_FAST                      4: _var_var_107
                        180     LOAD_GLOBAL                     2: list
                        182     LOAD_FAST                       0: self
                        184     LOAD_ATTR                       3: pre_dict
                        186     LOAD_CONST                      7: 'Zones'
                        188     BINARY_SUBSCR                   
                        190     LOAD_METHOD                     4: items
                        192     CALL_METHOD                     0
                        194     CALL_FUNCTION                   1
                        196     GET_ITER                        
                        198     FOR_ITER                        38 (to 238)
                        200     UNPACK_SEQUENCE                 2
                        202     STORE_FAST                      5: _var_var_12
                        204     STORE_FAST                      6: _var_var_11
                        206     LOAD_FAST                       6: _var_var_11
                        208     LOAD_ATTR                       8: T_air_hc
                        210     LOAD_FAST                       2: _var_var_105
                        212     LOAD_FAST                       5: _var_var_12
                        214     STORE_SUBSCR                    
                        216     LOAD_FAST                       6: _var_var_11
                        218     LOAD_ATTR                       9: T_s_hc
                        220     LOAD_FAST                       3: _var_var_106
                        222     LOAD_FAST                       5: _var_var_12
                        224     STORE_SUBSCR                    
                        226     LOAD_FAST                       6: _var_var_11
                        228     LOAD_ATTR                       10: occupancy_frac
                        230     LOAD_FAST                       4: _var_var_107
                        232     LOAD_FAST                       5: _var_var_12
                        234     STORE_SUBSCR                    
                        236     JUMP_ABSOLUTE                   198
                        238     LOAD_GLOBAL                     11: comfort
                        240     LOAD_METHOD                     12: comfPMVElevatedAirspeed
                        242     LOAD_FAST                       2: _var_var_105
                        244     LOAD_ATTR                       13: values
                        246     LOAD_FAST                       3: _var_var_106
                        248     LOAD_ATTR                       13: values
                        250     LOAD_CONST                      11: 0.1
                        252     LOAD_CONST                      12: 55
                        254     LOAD_CONST                      13: 1.1
                        256     LOAD_CONST                      14: 0.5
                        258     LOAD_CONST                      15: 0
                        260     CALL_METHOD                     7
                        262     STORE_FAST                      7: _var_var_108
                        264     LOAD_GLOBAL                     0: pd
                        266     LOAD_ATTR                       1: DataFrame
                        268     LOAD_FAST                       7: _var_var_108
                        270     LOAD_CONST                      16: <CODE> <listcomp>
                        272     LOAD_CONST                      6: 'Simulation.comfAnalysis.<locals>.<listcomp>'
                        274     MAKE_FUNCTION                   0
                        276     LOAD_GLOBAL                     2: list
                        278     LOAD_FAST                       0: self
                        280     LOAD_ATTR                       3: pre_dict
                        282     LOAD_CONST                      7: 'Zones'
                        284     BINARY_SUBSCR                   
                        286     LOAD_METHOD                     4: items
                        288     CALL_METHOD                     0
                        290     CALL_FUNCTION                   1
                        292     GET_ITER                        
                        294     CALL_FUNCTION                   1
                        296     LOAD_GLOBAL                     2: list
                        298     LOAD_GLOBAL                     5: range
                        300     LOAD_GLOBAL                     6: len
                        302     LOAD_FAST                       0: self
                        304     LOAD_ATTR                       7: Te
                        306     CALL_FUNCTION                   1
                        308     CALL_FUNCTION                   1
                        310     CALL_FUNCTION                   1
                        312     LOAD_CONST                      17: ('data', 'columns', 'index')
                        314     CALL_FUNCTION_KW                3
                        316     STORE_FAST                      8: _var_var_109
                        318     LOAD_FAST                       4: _var_var_107
                        320     LOAD_METHOD                     14: where
                        322     LOAD_FAST                       4: _var_var_107
                        324     LOAD_CONST                      15: 0
                        326     COMPARE_OP                      2 (==)
                        328     LOAD_FAST                       8: _var_var_109
                        330     CALL_METHOD                     2
                        332     STORE_FAST                      8: _var_var_109
                        334     LOAD_FAST                       8: _var_var_109
                        336     POP_BLOCK                       
                        338     LOAD_CONST                      18: '__pyarmor_exit_47132__'
                        340     NOP                             
                        342     NOP                             
                        344     LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14>\x01\x00\x00\x00\x00\x00\x00'
                        346     CALL_FUNCTION                   1
                        348     POP_TOP                         
                        350     RETURN_VALUE                    
                        352     LOAD_CONST                      18: '__pyarmor_exit_47132__'
                        354     NOP                             
                        356     NOP                             
                        358     LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14>\x01\x00\x00\x00\x00\x00\x00'
                        360     CALL_FUNCTION                   1
                        362     POP_TOP                         
                        364     RERAISE                         
                        366     LOAD_CONST                      0: None
                        368     RETURN_VALUE                    
                'Simulation.comfAnalysis'
                [Code]
                    File Name: <frozen simulation>
                    Object Name: postProcess
                    Arg Count: 1
                    Pos Only Arg Count: 0
                    KW Only Arg Count: 0
                    Locals: 8
                    Stack Size: 16
                    Flags: 0x20000043 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NOFREE | CO_PYARMOR_OBFUSCATED)
                    [Names]
                        'collections'
                        'OrderedDict'
                        'wea_dict'
                        'Te'
                        'q_cond_wall'
                        'q_cond_window'
                        'q_sol_w'
                        'q_sol_op'
                        'q_inf'
                        'q_NV'
                        'q_H_nd'
                        'q_C_nd'
                        'lighting_energy'
                        'equipment_energy'
                        'heat_energy'
                        'cool_energy'
                        'DHW_energy'
                        'pump_energy'
                        'fan_energy'
                        'General'
                        'cool_source'
                        'cls'
                        'heat_source'
                        'DHW_source'
                        'elec_dem'
                        'np'
                        'where'
                        'Egen_PV'
                        'Egen_wind'
                        'range'
                        'int'
                        'input_dict'
                        'copy'
                        'deepcopy'
                        'list'
                        'keys'
                        'items'
                        'Egen_SWH'
                        'if_pmv'
                        'comfAnalysis'
                        'abs'
                        'mean'
                        'occupants'
                        'output_dict'
                    [Var Names]
                        'self'
                        '__assert_armored__'
                        '_var_var_110'
                        '_var_var_111'
                        '_var_var_112'
                        '_var_var_26'
                        '_var_var_7'
                        '_var_var_8'
                    [Free Vars]
                    [Cell Vars]
                    [Constants]
                        'update the wea_dict and cal_dict, and dump the needed weather and calculated results\n        to wea_calculation.csv under Outputs folder'
                        '__pyarmor_assert_47133__'
                        'Simulation.postProcess.<locals>.<lambda>'
                        '__pyarmor_enter_47134__'
                        b'<COAddr>\x01\x00\x00\x14X\x03\x00\x00\x00\x00\x00\x00'
                        'year'
                        'month'
                        'day'
                        'hour'
                        'outdoor_temperature'
                        'heat_conduction_wall'
                        'heat_conduction_window'
                        'heat_solar_gain_window'
                        'heat_solar_gain_wall'
                        'heat_transfer_infiltration'
                        'heat_transfer_natural_vent'
                        'heating_load'
                        'cooling_load'
                        'lighting_energy'
                        'equipment_energy'
                        'heat_energy'
                        'cool_energy'
                        'DHW_energy'
                        'pump_energy'
                        'fan_energy'
                        1
                        0
                        'total_electricity'
                        'electricity'
                        'gas'
                        'district_cooling'
                        'district_heating'
                        'steam'
                        'gasoline'
                        'diesel'
                        'coal'
                        'fuel oil'
                        'propane'
                        'kerosene'
                        'traditional bio'
                        'others'
                        (
                            1
                            2
                            3
                            4
                            5
                            6
                            7
                            8
                            9
                            10
                            11
                            12
                            13
                        )
                        7
                        'Energy Sources'
                        'Cooling Energy Source'
                        'Heating Energy Source'
                        'DHW Energy Source'
                        'total_'
                        'SWH_production'
                        2
                        'PV_production'
                        'wind_production'
                        True
                        (
                            'axis'
                        )
                        'PMV'
                        'occupants'
                        '__pyarmor_exit_47135__'
                        None
                    [Disassembly]
                        0       NOP                             
                        2       NOP                             
                        4       NOP                             
                        6       NOP                             
                        8       LOAD_CONST                      3: '__pyarmor_enter_47134__'
                        10      NOP                             
                        12      NOP                             
                        14      LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14X\x03\x00\x00\x00\x00\x00\x00'
                        16      CALL_FUNCTION                   1
                        18      POP_TOP                         
                        20      SETUP_FINALLY                   866 (to 890)
                        24      LOAD_GLOBAL                     0: collections
                        26      LOAD_METHOD                     1: OrderedDict
                        28      CALL_METHOD                     0
                        30      STORE_FAST                      2: _var_var_110
                        32      LOAD_FAST                       0: self
                        34      LOAD_ATTR                       2: wea_dict
                        36      LOAD_CONST                      5: 'year'
                        38      BINARY_SUBSCR                   
                        40      LOAD_FAST                       2: _var_var_110
                        42      LOAD_CONST                      5: 'year'
                        44      STORE_SUBSCR                    
                        46      LOAD_FAST                       0: self
                        48      LOAD_ATTR                       2: wea_dict
                        50      LOAD_CONST                      6: 'month'
                        52      BINARY_SUBSCR                   
                        54      LOAD_FAST                       2: _var_var_110
                        56      LOAD_CONST                      6: 'month'
                        58      STORE_SUBSCR                    
                        60      LOAD_FAST                       0: self
                        62      LOAD_ATTR                       2: wea_dict
                        64      LOAD_CONST                      7: 'day'
                        66      BINARY_SUBSCR                   
                        68      LOAD_FAST                       2: _var_var_110
                        70      LOAD_CONST                      7: 'day'
                        72      STORE_SUBSCR                    
                        74      LOAD_FAST                       0: self
                        76      LOAD_ATTR                       2: wea_dict
                        78      LOAD_CONST                      8: 'hour'
                        80      BINARY_SUBSCR                   
                        82      LOAD_FAST                       2: _var_var_110
                        84      LOAD_CONST                      8: 'hour'
                        86      STORE_SUBSCR                    
                        88      LOAD_FAST                       0: self
                        90      LOAD_ATTR                       3: Te
                        92      LOAD_FAST                       2: _var_var_110
                        94      LOAD_CONST                      9: 'outdoor_temperature'
                        96      STORE_SUBSCR                    
                        98      LOAD_FAST                       0: self
                        100     LOAD_ATTR                       4: q_cond_wall
                        102     LOAD_FAST                       2: _var_var_110
                        104     LOAD_CONST                      10: 'heat_conduction_wall'
                        106     STORE_SUBSCR                    
                        108     LOAD_FAST                       0: self
                        110     LOAD_ATTR                       5: q_cond_window
                        112     LOAD_FAST                       2: _var_var_110
                        114     LOAD_CONST                      11: 'heat_conduction_window'
                        116     STORE_SUBSCR                    
                        118     LOAD_FAST                       0: self
                        120     LOAD_ATTR                       6: q_sol_w
                        122     LOAD_FAST                       2: _var_var_110
                        124     LOAD_CONST                      12: 'heat_solar_gain_window'
                        126     STORE_SUBSCR                    
                        128     LOAD_FAST                       0: self
                        130     LOAD_ATTR                       7: q_sol_op
                        132     LOAD_FAST                       2: _var_var_110
                        134     LOAD_CONST                      13: 'heat_solar_gain_wall'
                        136     STORE_SUBSCR                    
                        138     LOAD_FAST                       0: self
                        140     LOAD_ATTR                       8: q_inf
                        142     LOAD_FAST                       2: _var_var_110
                        144     LOAD_CONST                      14: 'heat_transfer_infiltration'
                        146     STORE_SUBSCR                    
                        148     LOAD_FAST                       0: self
                        150     LOAD_ATTR                       9: q_NV
                        152     LOAD_FAST                       2: _var_var_110
                        154     LOAD_CONST                      15: 'heat_transfer_natural_vent'
                        156     STORE_SUBSCR                    
                        158     LOAD_FAST                       0: self
                        160     LOAD_ATTR                       10: q_H_nd
                        162     LOAD_FAST                       2: _var_var_110
                        164     LOAD_CONST                      16: 'heating_load'
                        166     STORE_SUBSCR                    
                        168     LOAD_FAST                       0: self
                        170     LOAD_ATTR                       11: q_C_nd
                        172     LOAD_FAST                       2: _var_var_110
                        174     LOAD_CONST                      17: 'cooling_load'
                        176     STORE_SUBSCR                    
                        178     LOAD_FAST                       0: self
                        180     LOAD_ATTR                       12: lighting_energy
                        182     LOAD_FAST                       2: _var_var_110
                        184     LOAD_CONST                      18: 'lighting_energy'
                        186     STORE_SUBSCR                    
                        188     LOAD_FAST                       0: self
                        190     LOAD_ATTR                       13: equipment_energy
                        192     LOAD_FAST                       2: _var_var_110
                        194     LOAD_CONST                      19: 'equipment_energy'
                        196     STORE_SUBSCR                    
                        198     LOAD_FAST                       0: self
                        200     LOAD_ATTR                       14: heat_energy
                        202     LOAD_FAST                       2: _var_var_110
                        204     LOAD_CONST                      20: 'heat_energy'
                        206     STORE_SUBSCR                    
                        208     LOAD_FAST                       0: self
                        210     LOAD_ATTR                       15: cool_energy
                        212     LOAD_FAST                       2: _var_var_110
                        214     LOAD_CONST                      21: 'cool_energy'
                        216     STORE_SUBSCR                    
                        218     LOAD_FAST                       0: self
                        220     LOAD_ATTR                       16: DHW_energy
                        222     LOAD_FAST                       2: _var_var_110
                        224     LOAD_CONST                      22: 'DHW_energy'
                        226     STORE_SUBSCR                    
                        228     LOAD_FAST                       0: self
                        230     LOAD_ATTR                       17: pump_energy
                        232     LOAD_FAST                       2: _var_var_110
                        234     LOAD_CONST                      23: 'pump_energy'
                        236     STORE_SUBSCR                    
                        238     LOAD_FAST                       0: self
                        240     LOAD_ATTR                       18: fan_energy
                        242     LOAD_FAST                       2: _var_var_110
                        244     LOAD_CONST                      24: 'fan_energy'
                        246     STORE_SUBSCR                    
                        248     LOAD_FAST                       0: self
                        250     LOAD_ATTR                       12: lighting_energy
                        252     LOAD_FAST                       0: self
                        254     LOAD_ATTR                       13: equipment_energy
                        256     BINARY_ADD                      
                        258     LOAD_FAST                       0: self
                        260     LOAD_ATTR                       19: General
                        262     LOAD_ATTR                       20: cool_source
                        264     LOAD_ATTR                       21: cls
                        266     LOAD_CONST                      25: 1
                        268     COMPARE_OP                      2 (==)
                        270     POP_JUMP_IF_FALSE               280
                        274     LOAD_FAST                       0: self
                        276     LOAD_ATTR                       15: cool_energy
                        278     JUMP_FORWARD                    2 (to 282)
                        280     LOAD_CONST                      26: 0
                        282     BINARY_ADD                      
                        284     LOAD_FAST                       0: self
                        286     LOAD_ATTR                       17: pump_energy
                        288     BINARY_ADD                      
                        290     LOAD_FAST                       0: self
                        292     LOAD_ATTR                       18: fan_energy
                        294     BINARY_ADD                      
                        296     LOAD_FAST                       0: self
                        298     LOAD_ATTR                       19: General
                        300     LOAD_ATTR                       22: heat_source
                        302     LOAD_ATTR                       21: cls
                        304     LOAD_CONST                      25: 1
                        306     COMPARE_OP                      2 (==)
                        308     POP_JUMP_IF_FALSE               318
                        312     LOAD_FAST                       0: self
                        314     LOAD_ATTR                       14: heat_energy
                        316     JUMP_FORWARD                    2 (to 320)
                        318     LOAD_CONST                      26: 0
                        320     BINARY_ADD                      
                        322     LOAD_FAST                       0: self
                        324     LOAD_ATTR                       19: General
                        326     LOAD_ATTR                       23: DHW_source
                        328     LOAD_ATTR                       21: cls
                        330     LOAD_CONST                      25: 1
                        332     COMPARE_OP                      2 (==)
                        334     POP_JUMP_IF_FALSE               344
                        338     LOAD_FAST                       0: self
                        340     LOAD_ATTR                       16: DHW_energy
                        342     JUMP_FORWARD                    2 (to 346)
                        344     LOAD_CONST                      26: 0
                        346     BINARY_ADD                      
                        348     LOAD_FAST                       0: self
                        350     STORE_ATTR                      24: elec_dem
                        352     LOAD_GLOBAL                     25: np
                        354     LOAD_METHOD                     26: where
                        356     LOAD_FAST                       0: self
                        358     LOAD_ATTR                       24: elec_dem
                        360     LOAD_FAST                       0: self
                        362     LOAD_ATTR                       27: Egen_PV
                        364     BINARY_SUBTRACT                 
                        366     LOAD_FAST                       0: self
                        368     LOAD_ATTR                       28: Egen_wind
                        370     BINARY_SUBTRACT                 
                        372     LOAD_CONST                      26: 0
                        374     COMPARE_OP                      4 (>)
                        376     LOAD_FAST                       0: self
                        378     LOAD_ATTR                       24: elec_dem
                        380     LOAD_FAST                       0: self
                        382     LOAD_ATTR                       27: Egen_PV
                        384     BINARY_SUBTRACT                 
                        386     LOAD_FAST                       0: self
                        388     LOAD_ATTR                       28: Egen_wind
                        390     BINARY_SUBTRACT                 
                        392     LOAD_CONST                      26: 0
                        394     CALL_METHOD                     3
                        396     LOAD_FAST                       2: _var_var_110
                        398     LOAD_CONST                      27: 'total_electricity'
                        400     STORE_SUBSCR                    
                        402     BUILD_MAP                       0
                        404     STORE_FAST                      3: _var_var_111
                        406     LOAD_GLOBAL                     0: collections
                        408     LOAD_METHOD                     1: OrderedDict
                        410     LOAD_CONST                      28: 'electricity'
                        412     LOAD_CONST                      29: 'gas'
                        414     LOAD_CONST                      30: 'district_cooling'
                        416     LOAD_CONST                      31: 'district_heating'
                        418     LOAD_CONST                      32: 'steam'
                        420     LOAD_CONST                      33: 'gasoline'
                        422     LOAD_CONST                      34: 'diesel'
                        424     LOAD_CONST                      35: 'coal'
                        426     LOAD_CONST                      36: 'fuel oil'
                        428     LOAD_CONST                      37: 'propane'
                        430     LOAD_CONST                      38: 'kerosene'
                        432     LOAD_CONST                      39: 'traditional bio'
                        434     LOAD_CONST                      40: 'others'
                        436     LOAD_CONST                      41: (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13)
                        438     BUILD_CONST_KEY_MAP             13
                        440     CALL_METHOD                     1
                        442     STORE_FAST                      4: _var_var_112
                        444     LOAD_GLOBAL                     29: range
                        446     LOAD_CONST                      25: 1
                        448     LOAD_CONST                      42: 7
                        450     CALL_FUNCTION                   2
                        452     GET_ITER                        
                        454     FOR_ITER                        214 (to 670)
                        456     STORE_FAST                      5: _var_var_26
                        458     LOAD_GLOBAL                     30: int
                        460     LOAD_FAST                       0: self
                        462     LOAD_ATTR                       31: input_dict
                        464     LOAD_CONST                      43: 'Energy Sources'
                        466     BINARY_SUBSCR                   
                        468     LOAD_CONST                      44: 'Cooling Energy Source'
                        470     BINARY_SUBSCR                   
                        472     CALL_FUNCTION                   1
                        474     LOAD_FAST                       5: _var_var_26
                        476     COMPARE_OP                      2 (==)
                        478     POP_JUMP_IF_FALSE               498
                        482     LOAD_GLOBAL                     32: copy
                        484     LOAD_METHOD                     33: deepcopy
                        486     LOAD_FAST                       0: self
                        488     LOAD_ATTR                       15: cool_energy
                        490     CALL_METHOD                     1
                        492     LOAD_FAST                       3: _var_var_111
                        494     LOAD_FAST                       5: _var_var_26
                        496     STORE_SUBSCR                    
                        498     LOAD_GLOBAL                     30: int
                        500     LOAD_FAST                       0: self
                        502     LOAD_ATTR                       31: input_dict
                        504     LOAD_CONST                      43: 'Energy Sources'
                        506     BINARY_SUBSCR                   
                        508     LOAD_CONST                      45: 'Heating Energy Source'
                        510     BINARY_SUBSCR                   
                        512     CALL_FUNCTION                   1
                        514     LOAD_FAST                       5: _var_var_26
                        516     COMPARE_OP                      2 (==)
                        518     POP_JUMP_IF_FALSE               582
                        522     LOAD_FAST                       5: _var_var_26
                        524     LOAD_GLOBAL                     34: list
                        526     LOAD_FAST                       3: _var_var_111
                        528     LOAD_METHOD                     35: keys
                        530     CALL_METHOD                     0
                        532     CALL_FUNCTION                   1
                        534     CONTAINS_OP                     1 (not in)
                        536     POP_JUMP_IF_FALSE               558
                        540     LOAD_GLOBAL                     32: copy
                        542     LOAD_METHOD                     33: deepcopy
                        544     LOAD_FAST                       0: self
                        546     LOAD_ATTR                       14: heat_energy
                        548     CALL_METHOD                     1
                        550     LOAD_FAST                       3: _var_var_111
                        552     LOAD_FAST                       5: _var_var_26
                        554     STORE_SUBSCR                    
                        556     JUMP_FORWARD                    24 (to 582)
                        558     LOAD_FAST                       3: _var_var_111
                        560     LOAD_FAST                       5: _var_var_26
                        562     DUP_TOP_TWO                     
                        564     BINARY_SUBSCR                   
                        566     LOAD_GLOBAL                     32: copy
                        568     LOAD_METHOD                     33: deepcopy
                        570     LOAD_FAST                       0: self
                        572     LOAD_ATTR                       14: heat_energy
                        574     CALL_METHOD                     1
                        576     INPLACE_ADD                     
                        578     ROT_THREE                       
                        580     STORE_SUBSCR                    
                        582     LOAD_GLOBAL                     30: int
                        584     LOAD_FAST                       0: self
                        586     LOAD_ATTR                       31: input_dict
                        588     LOAD_CONST                      43: 'Energy Sources'
                        590     BINARY_SUBSCR                   
                        592     LOAD_CONST                      46: 'DHW Energy Source'
                        594     BINARY_SUBSCR                   
                        596     CALL_FUNCTION                   1
                        598     LOAD_FAST                       5: _var_var_26
                        600     COMPARE_OP                      2 (==)
                        602     POP_JUMP_IF_FALSE               454
                        606     LOAD_FAST                       5: _var_var_26
                        608     LOAD_GLOBAL                     34: list
                        610     LOAD_FAST                       3: _var_var_111
                        612     LOAD_METHOD                     35: keys
                        614     CALL_METHOD                     0
                        616     CALL_FUNCTION                   1
                        618     CONTAINS_OP                     1 (not in)
                        620     POP_JUMP_IF_FALSE               642
                        624     LOAD_GLOBAL                     32: copy
                        626     LOAD_METHOD                     33: deepcopy
                        628     LOAD_FAST                       0: self
                        630     LOAD_ATTR                       16: DHW_energy
                        632     CALL_METHOD                     1
                        634     LOAD_FAST                       3: _var_var_111
                        636     LOAD_FAST                       5: _var_var_26
                        638     STORE_SUBSCR                    
                        640     JUMP_FORWARD                    24 (to 666)
                        642     LOAD_FAST                       3: _var_var_111
                        644     LOAD_FAST                       5: _var_var_26
                        646     DUP_TOP_TWO                     
                        648     BINARY_SUBSCR                   
                        650     LOAD_GLOBAL                     32: copy
                        652     LOAD_METHOD                     33: deepcopy
                        654     LOAD_FAST                       0: self
                        656     LOAD_ATTR                       16: DHW_energy
                        658     CALL_METHOD                     1
                        660     INPLACE_ADD                     
                        662     ROT_THREE                       
                        664     STORE_SUBSCR                    
                        666     JUMP_ABSOLUTE                   454
                        670     LOAD_GLOBAL                     34: list
                        672     LOAD_FAST                       3: _var_var_111
                        674     LOAD_METHOD                     36: items
                        676     CALL_METHOD                     0
                        678     CALL_FUNCTION                   1
                        680     GET_ITER                        
                        682     FOR_ITER                        36 (to 720)
                        684     UNPACK_SEQUENCE                 2
                        686     STORE_FAST                      6: _var_var_7
                        688     STORE_FAST                      7: _var_var_8
                        690     LOAD_FAST                       6: _var_var_7
                        692     LOAD_CONST                      25: 1
                        694     COMPARE_OP                      3 (!=)
                        696     POP_JUMP_IF_FALSE               682
                        700     LOAD_FAST                       7: _var_var_8
                        702     LOAD_FAST                       2: _var_var_110
                        704     LOAD_CONST                      47: 'total_'
                        706     LOAD_FAST                       4: _var_var_112
                        708     LOAD_FAST                       6: _var_var_7
                        710     BINARY_SUBSCR                   
                        712     BINARY_ADD                      
                        714     STORE_SUBSCR                    
                        716     JUMP_ABSOLUTE                   682
                        720     LOAD_FAST                       0: self
                        722     LOAD_ATTR                       37: Egen_SWH
                        724     LOAD_FAST                       2: _var_var_110
                        726     LOAD_CONST                      48: 'SWH_production'
                        728     STORE_SUBSCR                    
                        730     LOAD_GLOBAL                     25: np
                        732     LOAD_METHOD                     26: where
                        734     LOAD_FAST                       2: _var_var_110
                        736     LOAD_CONST                      27: 'total_electricity'
                        738     BINARY_SUBSCR                   
                        740     LOAD_CONST                      26: 0
                        742     COMPARE_OP                      4 (>)
                        744     LOAD_FAST                       0: self
                        746     LOAD_ATTR                       27: Egen_PV
                        748     LOAD_FAST                       0: self
                        750     LOAD_ATTR                       27: Egen_PV
                        752     LOAD_CONST                      49: 2
                        754     BINARY_POWER                    
                        756     LOAD_FAST                       0: self
                        758     LOAD_ATTR                       27: Egen_PV
                        760     LOAD_FAST                       0: self
                        762     LOAD_ATTR                       28: Egen_wind
                        764     BINARY_ADD                      
                        766     BINARY_TRUE_DIVIDE              
                        768     CALL_METHOD                     3
                        770     LOAD_FAST                       2: _var_var_110
                        772     LOAD_CONST                      50: 'PV_production'
                        774     STORE_SUBSCR                    
                        776     LOAD_GLOBAL                     25: np
                        778     LOAD_METHOD                     26: where
                        780     LOAD_FAST                       2: _var_var_110
                        782     LOAD_CONST                      27: 'total_electricity'
                        784     BINARY_SUBSCR                   
                        786     LOAD_CONST                      26: 0
                        788     COMPARE_OP                      4 (>)
                        790     LOAD_FAST                       0: self
                        792     LOAD_ATTR                       28: Egen_wind
                        794     LOAD_FAST                       0: self
                        796     LOAD_ATTR                       28: Egen_wind
                        798     LOAD_CONST                      49: 2
                        800     BINARY_POWER                    
                        802     LOAD_FAST                       0: self
                        804     LOAD_ATTR                       27: Egen_PV
                        806     LOAD_FAST                       0: self
                        808     LOAD_ATTR                       28: Egen_wind
                        810     BINARY_ADD                      
                        812     BINARY_TRUE_DIVIDE              
                        814     CALL_METHOD                     3
                        816     LOAD_FAST                       2: _var_var_110
                        818     LOAD_CONST                      51: 'wind_production'
                        820     STORE_SUBSCR                    
                        822     LOAD_FAST                       0: self
                        824     LOAD_ATTR                       38: if_pmv
                        826     LOAD_CONST                      52: True
                        828     COMPARE_OP                      2 (==)
                        830     POP_JUMP_IF_FALSE               858
                        834     LOAD_FAST                       0: self
                        836     LOAD_METHOD                     39: comfAnalysis
                        838     CALL_METHOD                     0
                        840     LOAD_METHOD                     40: abs
                        842     CALL_METHOD                     0
                        844     LOAD_ATTR                       41: mean
                        846     LOAD_CONST                      25: 1
                        848     LOAD_CONST                      53: ('axis',)
                        850     CALL_FUNCTION_KW                1
                        852     LOAD_FAST                       2: _var_var_110
                        854     LOAD_CONST                      54: 'PMV'
                        856     STORE_SUBSCR                    
                        858     LOAD_FAST                       0: self
                        860     LOAD_ATTR                       42: occupants
                        862     LOAD_FAST                       2: _var_var_110
                        864     LOAD_CONST                      55: 'occupants'
                        866     STORE_SUBSCR                    
                        868     LOAD_FAST                       2: _var_var_110
                        870     LOAD_FAST                       0: self
                        872     STORE_ATTR                      43: output_dict
                        874     POP_BLOCK                       
                        876     LOAD_CONST                      56: '__pyarmor_exit_47135__'
                        878     NOP                             
                        880     NOP                             
                        882     LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14X\x03\x00\x00\x00\x00\x00\x00'
                        884     CALL_FUNCTION                   1
                        886     POP_TOP                         
                        888     JUMP_FORWARD                    14 (to 904)
                        890     LOAD_CONST                      56: '__pyarmor_exit_47135__'
                        892     NOP                             
                        894     NOP                             
                        896     LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14X\x03\x00\x00\x00\x00\x00\x00'
                        898     CALL_FUNCTION                   1
                        900     POP_TOP                         
                        902     RERAISE                         
                        904     LOAD_CONST                      57: None
                        906     RETURN_VALUE                    
                'Simulation.postProcess'
                [Code]
                    File Name: <frozen simulation>
                    Object Name: dumpResults
                    Arg Count: 2
                    Pos Only Arg Count: 0
                    KW Only Arg Count: 0
                    Locals: 8
                    Stack Size: 8
                    Flags: 0x20000043 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NOFREE | CO_PYARMOR_OBFUSCATED)
                    [Names]
                        'pd'
                        'DataFrame'
                        'from_dict'
                        'output_dict'
                        'to_csv'
                        'agg_dict'
                        'groupby'
                        'sum'
                        'mean'
                        'drop'
                        'os'
                        'path'
                        'dirname'
                        'hasattr'
                        'if_print'
                        'print'
                    [Var Names]
                        'self'
                        'results_file'
                        '__assert_armored__'
                        '_var_var_113'
                        '_var_var_114'
                        '_var_var_115'
                        '_var_var_116'
                        '_var_var_117'
                    [Free Vars]
                    [Cell Vars]
                    [Constants]
                        None
                        '__pyarmor_assert_47136__'
                        'Simulation.dumpResults.<locals>.<lambda>'
                        '__pyarmor_enter_47137__'
                        b'<COAddr>\x01\x00\x00\x14\x0c\x01\x00\x00\x00\x00\x00\x00'
                        '_hourly.csv'
                        'indoor_temperature'
                        'year'
                        'month'
                        'day'
                        'hour'
                        'outdoor_temperature'
                        1e-06
                        'occupants'
                        1
                        True
                        (
                            'axis'
                            'inplace'
                        )
                        '_monthly.csv'
                        '_indoor_temperature.csv'
                        'if_print'
                        'Simulation complete! Results are successfully dumped to '
                        '__pyarmor_exit_47138__'
                    [Disassembly]
                        0       NOP                             
                        2       NOP                             
                        4       NOP                             
                        6       NOP                             
                        8       LOAD_CONST                      3: '__pyarmor_enter_47137__'
                        10      NOP                             
                        12      NOP                             
                        14      LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14\x0c\x01\x00\x00\x00\x00\x00\x00'
                        16      CALL_FUNCTION                   1
                        18      POP_TOP                         
                        20      SETUP_FINALLY                   278 (to 302)
                        24      LOAD_GLOBAL                     0: pd
                        26      LOAD_ATTR                       1: DataFrame
                        28      LOAD_METHOD                     2: from_dict
                        30      LOAD_FAST                       0: self
                        32      LOAD_ATTR                       3: output_dict
                        34      CALL_METHOD                     1
                        36      STORE_FAST                      3: _var_var_113
                        38      LOAD_FAST                       3: _var_var_113
                        40      LOAD_METHOD                     4: to_csv
                        42      LOAD_FAST                       1: results_file
                        44      LOAD_CONST                      5: '_hourly.csv'
                        46      BINARY_ADD                      
                        48      CALL_METHOD                     1
                        50      POP_TOP                         
                        52      LOAD_GLOBAL                     0: pd
                        54      LOAD_METHOD                     1: DataFrame
                        56      CALL_METHOD                     0
                        58      STORE_FAST                      4: _var_var_114
                        60      LOAD_GLOBAL                     0: pd
                        62      LOAD_ATTR                       1: DataFrame
                        64      LOAD_METHOD                     2: from_dict
                        66      LOAD_FAST                       0: self
                        68      LOAD_ATTR                       5: agg_dict
                        70      LOAD_CONST                      6: 'indoor_temperature'
                        72      BINARY_SUBSCR                   
                        74      CALL_METHOD                     1
                        76      STORE_FAST                      5: _var_var_115
                        78      LOAD_FAST                       3: _var_var_113
                        80      GET_ITER                        
                        82      FOR_ITER                        106 (to 190)
                        84      STORE_FAST                      6: _var_var_116
                        86      LOAD_FAST                       6: _var_var_116
                        88      LOAD_CONST                      7: 'year'
                        90      COMPARE_OP                      3 (!=)
                        92      POP_JUMP_IF_FALSE               156
                        94      LOAD_FAST                       6: _var_var_116
                        96      LOAD_CONST                      8: 'month'
                        98      COMPARE_OP                      3 (!=)
                        100     POP_JUMP_IF_FALSE               156
                        102     LOAD_FAST                       6: _var_var_116
                        104     LOAD_CONST                      9: 'day'
                        106     COMPARE_OP                      3 (!=)
                        108     POP_JUMP_IF_FALSE               156
                        110     LOAD_FAST                       6: _var_var_116
                        112     LOAD_CONST                      10: 'hour'
                        114     COMPARE_OP                      3 (!=)
                        116     POP_JUMP_IF_FALSE               156
                        118     LOAD_FAST                       6: _var_var_116
                        120     LOAD_CONST                      11: 'outdoor_temperature'
                        122     COMPARE_OP                      3 (!=)
                        124     POP_JUMP_IF_FALSE               156
                        126     LOAD_FAST                       3: _var_var_113
                        128     LOAD_METHOD                     6: groupby
                        130     LOAD_CONST                      8: 'month'
                        132     BUILD_LIST                      1
                        134     CALL_METHOD                     1
                        136     LOAD_FAST                       6: _var_var_116
                        138     BINARY_SUBSCR                   
                        140     LOAD_METHOD                     7: sum
                        142     CALL_METHOD                     0
                        144     LOAD_CONST                      12: 1e-06
                        146     BINARY_MULTIPLY                 
                        148     LOAD_FAST                       4: _var_var_114
                        150     LOAD_FAST                       6: _var_var_116
                        152     STORE_SUBSCR                    
                        154     JUMP_ABSOLUTE                   82
                        156     LOAD_FAST                       6: _var_var_116
                        158     LOAD_CONST                      11: 'outdoor_temperature'
                        160     COMPARE_OP                      2 (==)
                        162     POP_JUMP_IF_FALSE               82
                        164     LOAD_FAST                       3: _var_var_113
                        166     LOAD_METHOD                     6: groupby
                        168     LOAD_CONST                      8: 'month'
                        170     BUILD_LIST                      1
                        172     CALL_METHOD                     1
                        174     LOAD_FAST                       6: _var_var_116
                        176     BINARY_SUBSCR                   
                        178     LOAD_METHOD                     8: mean
                        180     CALL_METHOD                     0
                        182     LOAD_FAST                       4: _var_var_114
                        184     LOAD_FAST                       6: _var_var_116
                        186     STORE_SUBSCR                    
                        188     JUMP_ABSOLUTE                   82
                        190     LOAD_FAST                       4: _var_var_114
                        192     LOAD_ATTR                       9: drop
                        194     LOAD_CONST                      13: 'occupants'
                        196     LOAD_CONST                      14: 1
                        198     LOAD_CONST                      15: True
                        200     LOAD_CONST                      16: ('axis', 'inplace')
                        202     CALL_FUNCTION_KW                3
                        204     POP_TOP                         
                        206     LOAD_FAST                       4: _var_var_114
                        208     LOAD_METHOD                     4: to_csv
                        210     LOAD_FAST                       1: results_file
                        212     LOAD_CONST                      17: '_monthly.csv'
                        214     BINARY_ADD                      
                        216     CALL_METHOD                     1
                        218     POP_TOP                         
                        220     LOAD_FAST                       5: _var_var_115
                        222     LOAD_METHOD                     4: to_csv
                        224     LOAD_FAST                       1: results_file
                        226     LOAD_CONST                      18: '_indoor_temperature.csv'
                        228     BINARY_ADD                      
                        230     CALL_METHOD                     1
                        232     POP_TOP                         
                        234     LOAD_GLOBAL                     10: os
                        236     LOAD_ATTR                       11: path
                        238     LOAD_METHOD                     12: dirname
                        240     LOAD_FAST                       1: results_file
                        242     CALL_METHOD                     1
                        244     STORE_FAST                      7: _var_var_117
                        246     LOAD_GLOBAL                     13: hasattr
                        248     LOAD_FAST                       0: self
                        250     LOAD_CONST                      19: 'if_print'
                        252     CALL_FUNCTION                   2
                        254     POP_JUMP_IF_FALSE               282
                        258     LOAD_FAST                       0: self
                        260     LOAD_ATTR                       14: if_print
                        262     LOAD_CONST                      15: True
                        264     COMPARE_OP                      2 (==)
                        266     POP_JUMP_IF_FALSE               282
                        270     LOAD_GLOBAL                     15: print
                        272     LOAD_CONST                      20: 'Simulation complete! Results are successfully dumped to '
                        274     LOAD_FAST                       7: _var_var_117
                        276     BINARY_ADD                      
                        278     CALL_FUNCTION                   1
                        280     JUMP_FORWARD                    2 (to 284)
                        282     LOAD_CONST                      0: None
                        284     POP_TOP                         
                        286     POP_BLOCK                       
                        288     LOAD_CONST                      21: '__pyarmor_exit_47138__'
                        290     NOP                             
                        292     NOP                             
                        294     LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14\x0c\x01\x00\x00\x00\x00\x00\x00'
                        296     CALL_FUNCTION                   1
                        298     POP_TOP                         
                        300     JUMP_FORWARD                    14 (to 316)
                        302     LOAD_CONST                      21: '__pyarmor_exit_47138__'
                        304     NOP                             
                        306     NOP                             
                        308     LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14\x0c\x01\x00\x00\x00\x00\x00\x00'
                        310     CALL_FUNCTION                   1
                        312     POP_TOP                         
                        314     RERAISE                         
                        316     LOAD_CONST                      0: None
                        318     RETURN_VALUE                    
                'Simulation.dumpResults'
                [Code]
                    File Name: <frozen simulation>
                    Object Name: run
                    Arg Count: 1
                    Pos Only Arg Count: 0
                    KW Only Arg Count: 0
                    Locals: 2
                    Stack Size: 8
                    Flags: 0x20000043 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NOFREE | CO_PYARMOR_OBFUSCATED)
                    [Names]
                        'solarGain'
                        'otherHeatGain'
                        'initiate'
                        'beforeIterate'
                        'iterate'
                        'hourlyAggregate'
                        'energy'
                        'renewables'
                        'aggregate'
                        'postProcess'
                    [Var Names]
                        'self'
                        '__assert_armored__'
                    [Free Vars]
                    [Cell Vars]
                    [Constants]
                        None
                        '__pyarmor_assert_47139__'
                        'Simulation.run.<locals>.<lambda>'
                        '__pyarmor_enter_47140__'
                        b'<COAddr>\x03\x00\x00\x14T\x00\x00\x00\x00\x00\x00\x00'
                        '__pyarmor_exit_47141__'
                    [Disassembly]
                        0       NOP                             
                        2       NOP                             
                        4       NOP                             
                        6       NOP                             
                        8       LOAD_CONST                      3: '__pyarmor_enter_47140__'
                        10      NOP                             
                        12      NOP                             
                        14      LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x14T\x00\x00\x00\x00\x00\x00\x00'
                        16      CALL_FUNCTION                   1
                        18      POP_TOP                         
                        20      SETUP_FINALLY                   96 (to 118)
                        22      LOAD_FAST                       0: self
                        24      LOAD_METHOD                     0: solarGain
                        26      CALL_METHOD                     0
                        28      POP_TOP                         
                        30      LOAD_FAST                       0: self
                        32      LOAD_METHOD                     1: otherHeatGain
                        34      CALL_METHOD                     0
                        36      POP_TOP                         
                        38      LOAD_FAST                       0: self
                        40      LOAD_METHOD                     2: initiate
                        42      CALL_METHOD                     0
                        44      POP_TOP                         
                        46      LOAD_FAST                       0: self
                        48      LOAD_METHOD                     3: beforeIterate
                        50      CALL_METHOD                     0
                        52      POP_TOP                         
                        54      LOAD_FAST                       0: self
                        56      LOAD_METHOD                     4: iterate
                        58      CALL_METHOD                     0
                        60      POP_TOP                         
                        62      LOAD_FAST                       0: self
                        64      LOAD_METHOD                     5: hourlyAggregate
                        66      CALL_METHOD                     0
                        68      POP_TOP                         
                        70      LOAD_FAST                       0: self
                        72      LOAD_METHOD                     6: energy
                        74      CALL_METHOD                     0
                        76      POP_TOP                         
                        78      LOAD_FAST                       0: self
                        80      LOAD_METHOD                     7: renewables
                        82      CALL_METHOD                     0
                        84      POP_TOP                         
                        86      LOAD_FAST                       0: self
                        88      LOAD_METHOD                     8: aggregate
                        90      CALL_METHOD                     0
                        92      POP_TOP                         
                        94      LOAD_FAST                       0: self
                        96      LOAD_METHOD                     9: postProcess
                        98      CALL_METHOD                     0
                        100     POP_TOP                         
                        102     POP_BLOCK                       
                        104     LOAD_CONST                      5: '__pyarmor_exit_47141__'
                        106     NOP                             
                        108     NOP                             
                        110     LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x14T\x00\x00\x00\x00\x00\x00\x00'
                        112     CALL_FUNCTION                   1
                        114     POP_TOP                         
                        116     JUMP_FORWARD                    14 (to 132)
                        118     LOAD_CONST                      5: '__pyarmor_exit_47141__'
                        120     NOP                             
                        122     NOP                             
                        124     LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x14T\x00\x00\x00\x00\x00\x00\x00'
                        126     CALL_FUNCTION                   1
                        128     POP_TOP                         
                        130     RERAISE                         
                        132     LOAD_CONST                      0: None
                        134     RETURN_VALUE                    
                'Simulation.run'
                '__pyarmor_exit_47081__'
                None
            [Disassembly]
                0       LOAD_NAME                       0: __name__
                2       STORE_NAME                      1: __module__
                4       LOAD_CONST                      0: 'Simulation'
                6       STORE_NAME                      2: __qualname__
                8       NOP                             
                10      NOP                             
                12      NOP                             
                14      NOP                             
                16      LOAD_CONST                      3: '__pyarmor_enter_47080__'
                18      NOP                             
                20      NOP                             
                22      LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x1c|\x00\x00\x00\x00\x00\x00\x00'
                24      CALL_FUNCTION                   1
                26      POP_TOP                         
                28      SETUP_FINALLY                   136 (to 166)
                30      LOAD_CONST                      5: <CODE> __init__
                32      LOAD_CONST                      6: 'Simulation.__init__'
                34      MAKE_FUNCTION                   0
                36      STORE_NAME                      4: __init__
                38      LOAD_CONST                      7: <CODE> getInputClass
                40      LOAD_CONST                      8: 'Simulation.getInputClass'
                42      MAKE_FUNCTION                   0
                44      STORE_NAME                      5: getInputClass
                46      LOAD_CONST                      9: <CODE> solarGain
                48      LOAD_CONST                      10: 'Simulation.solarGain'
                50      MAKE_FUNCTION                   0
                52      STORE_NAME                      6: solarGain
                54      LOAD_CONST                      11: <CODE> otherHeatGain
                56      LOAD_CONST                      12: 'Simulation.otherHeatGain'
                58      MAKE_FUNCTION                   0
                60      STORE_NAME                      7: otherHeatGain
                62      LOAD_CONST                      13: <CODE> beforeIterate
                64      LOAD_CONST                      14: 'Simulation.beforeIterate'
                66      MAKE_FUNCTION                   0
                68      STORE_NAME                      8: beforeIterate
                70      LOAD_CONST                      15: <CODE> initiate
                72      LOAD_CONST                      16: 'Simulation.initiate'
                74      MAKE_FUNCTION                   0
                76      STORE_NAME                      9: initiate
                78      LOAD_CONST                      17: <CODE> iterate
                80      LOAD_CONST                      18: 'Simulation.iterate'
                82      MAKE_FUNCTION                   0
                84      STORE_NAME                      10: iterate
                86      LOAD_CONST                      19: <CODE> hourlyAggregate
                88      LOAD_CONST                      20: 'Simulation.hourlyAggregate'
                90      MAKE_FUNCTION                   0
                92      STORE_NAME                      11: hourlyAggregate
                94      LOAD_CONST                      21: <CODE> energy
                96      LOAD_CONST                      22: 'Simulation.energy'
                98      MAKE_FUNCTION                   0
                100     STORE_NAME                      12: energy
                102     LOAD_CONST                      23: <CODE> renewables
                104     LOAD_CONST                      24: 'Simulation.renewables'
                106     MAKE_FUNCTION                   0
                108     STORE_NAME                      13: renewables
                110     LOAD_CONST                      25: <CODE> aggregate
                112     LOAD_CONST                      26: 'Simulation.aggregate'
                114     MAKE_FUNCTION                   0
                116     STORE_NAME                      14: aggregate
                118     LOAD_CONST                      27: <CODE> comfAnalysis
                120     LOAD_CONST                      28: 'Simulation.comfAnalysis'
                122     MAKE_FUNCTION                   0
                124     STORE_NAME                      15: comfAnalysis
                126     LOAD_CONST                      29: <CODE> postProcess
                128     LOAD_CONST                      30: 'Simulation.postProcess'
                130     MAKE_FUNCTION                   0
                132     STORE_NAME                      16: postProcess
                134     LOAD_CONST                      31: <CODE> dumpResults
                136     LOAD_CONST                      32: 'Simulation.dumpResults'
                138     MAKE_FUNCTION                   0
                140     STORE_NAME                      17: dumpResults
                142     LOAD_CONST                      33: <CODE> run
                144     LOAD_CONST                      34: 'Simulation.run'
                146     MAKE_FUNCTION                   0
                148     STORE_NAME                      18: run
                150     POP_BLOCK                       
                152     LOAD_CONST                      35: '__pyarmor_exit_47081__'
                154     NOP                             
                156     NOP                             
                158     LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x1c|\x00\x00\x00\x00\x00\x00\x00'
                160     CALL_FUNCTION                   1
                162     POP_TOP                         
                164     JUMP_FORWARD                    14 (to 180)
                166     LOAD_CONST                      35: '__pyarmor_exit_47081__'
                168     NOP                             
                170     NOP                             
                172     LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x1c|\x00\x00\x00\x00\x00\x00\x00'
                174     CALL_FUNCTION                   1
                176     POP_TOP                         
                178     RERAISE                         
                180     LOAD_CONST                      36: None
                182     RETURN_VALUE                    
        'Simulation'
        '__pyarmor_exit_47075__'
        (
            'Progress:'
            'Complete'
            50
        )
    [Disassembly]
        0       NOP                             
        2       NOP                             
        4       NOP                             
        6       NOP                             
        8       LOAD_CONST                      2: '__pyarmor_enter_47074__'
        10      NOP                             
        12      NOP                             
        14      LOAD_CONST                      3: b'<COAddr>\x01\x00\x00\x14\x84\x00\x00\x00\x00\x00\x00\x00'
        16      CALL_FUNCTION                   1
        18      POP_TOP                         
        20      SETUP_FINALLY                   144 (to 166)
        22      LOAD_CONST                      4: 0
        24      LOAD_CONST                      5: None
        26      IMPORT_NAME                     1: os
        28      STORE_NAME                      1: os
        30      LOAD_CONST                      4: 0
        32      LOAD_CONST                      5: None
        34      IMPORT_NAME                     2: collections
        36      STORE_NAME                      2: collections
        38      LOAD_CONST                      4: 0
        40      LOAD_CONST                      5: None
        42      IMPORT_NAME                     3: copy
        44      STORE_NAME                      3: copy
        46      LOAD_CONST                      4: 0
        48      LOAD_CONST                      5: None
        50      IMPORT_NAME                     4: comfort
        52      STORE_NAME                      4: comfort
        54      LOAD_CONST                      4: 0
        56      LOAD_CONST                      5: None
        58      IMPORT_NAME                     5: weather
        60      STORE_NAME                      5: weather
        62      LOAD_CONST                      4: 0
        64      LOAD_CONST                      5: None
        66      IMPORT_NAME                     6: time
        68      STORE_NAME                      6: time
        70      LOAD_CONST                      4: 0
        72      LOAD_CONST                      5: None
        74      IMPORT_NAME                     7: numpy
        76      STORE_NAME                      8: np
        78      LOAD_CONST                      4: 0
        80      LOAD_CONST                      5: None
        82      IMPORT_NAME                     9: lib
        84      STORE_NAME                      9: lib
        86      LOAD_CONST                      4: 0
        88      LOAD_CONST                      5: None
        90      IMPORT_NAME                     10: pandas
        92      STORE_NAME                      11: pd
        94      LOAD_NAME                       1: os
        96      LOAD_ATTR                       12: path
        98      LOAD_METHOD                     13: abspath
        100     LOAD_NAME                       1: os
        102     LOAD_ATTR                       12: path
        104     LOAD_METHOD                     14: join
        106     LOAD_NAME                       1: os
        108     LOAD_METHOD                     15: getcwd
        110     CALL_METHOD                     0
        112     LOAD_NAME                       1: os
        114     LOAD_ATTR                       16: pardir
        116     CALL_METHOD                     2
        118     CALL_METHOD                     1
        120     LOAD_CONST                      6: '\\'
        122     BINARY_ADD                      
        124     STORE_NAME                      17: parent_folder
        126     LOAD_CONST                      15: ('Progress:', 'Complete', 50)
        128     LOAD_CONST                      10: <CODE> print_progress_bar
        130     LOAD_CONST                      11: 'print_progress_bar'
        132     MAKE_FUNCTION                   1
        134     STORE_NAME                      18: print_progress_bar
        136     LOAD_BUILD_CLASS                
        138     LOAD_CONST                      12: <CODE> Simulation
        140     LOAD_CONST                      13: 'Simulation'
        142     MAKE_FUNCTION                   0
        144     LOAD_CONST                      13: 'Simulation'
        146     CALL_FUNCTION                   2
        148     STORE_NAME                      19: Simulation
        150     POP_BLOCK                       
        152     LOAD_CONST                      14: '__pyarmor_exit_47075__'
        154     NOP                             
        156     NOP                             
        158     LOAD_CONST                      3: b'<COAddr>\x01\x00\x00\x14\x84\x00\x00\x00\x00\x00\x00\x00'
        160     CALL_FUNCTION                   1
        162     POP_TOP                         
        164     JUMP_FORWARD                    14 (to 180)
        166     LOAD_CONST                      14: '__pyarmor_exit_47075__'
        168     NOP                             
        170     NOP                             
        172     LOAD_CONST                      3: b'<COAddr>\x01\x00\x00\x14\x84\x00\x00\x00\x00\x00\x00\x00'
        174     CALL_FUNCTION                   1
        176     POP_TOP                         
        178     RERAISE                         
        180     LOAD_CONST                      5: None
        182     RETURN_VALUE                    
