[Code]
    File Name: <frozen comfort>
    Object Name: <module>
    Arg Count: 0
    Pos Only Arg Count: 0
    KW Only Arg Count: 0
    Locals: 0
    Stack Size: 8
    Flags: 0x20000040 (CO_NOFREE | CO_PYARMOR_OBFUSCATED)
    [Names]
        '__doc__'
        '__assert_armored__'
        'numpy'
        'np'
        'findSaturatedVaporPressureTorr'
        'comfPMVElevatedAirspeed'
        'comfPMV'
        'comfPierceSET'
        'calcHumidRatio'
    [Var Names]
    [Free Vars]
    [Cell Vars]
    [Constants]
        '\nOptimized version of the CBE Comfort tool comfort models.\n'
        '__pyarmor_assert_47466__'
        '<lambda>'
        '__pyarmor_enter_47467__'
        b'<COAddr>\x03\x00\x00\x184\x00\x00\x00\x00\x00\x00\x00'
        0
        None
        [Code]
            File Name: <frozen comfort>
            Object Name: findSaturatedVaporPressureTorr
            Arg Count: 1
            Pos Only Arg Count: 0
            KW Only Arg Count: 0
            Locals: 2
            Stack Size: 8
            Flags: 0x20000043 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NOFREE | CO_PYARMOR_OBFUSCATED)
            [Names]
                'np'
                'exp'
            [Var Names]
                'T'
                '__assert_armored__'
            [Free Vars]
            [Cell Vars]
            [Constants]
                None
                '__pyarmor_assert_47469__'
                'findSaturatedVaporPressureTorr.<locals>.<lambda>'
                '__pyarmor_enter_47470__'
                b'<COAddr>\x01\x00\x00\x14\x18\x00\x00\x00\x00\x00\x00\x00'
                18.6686
                4030.18
                235
                '__pyarmor_exit_47471__'
            [Disassembly]
                0       NOP                             
                2       NOP                             
                4       NOP                             
                6       NOP                             
                8       LOAD_CONST                      3: '__pyarmor_enter_47470__'
                10      NOP                             
                12      NOP                             
                14      LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14\x18\x00\x00\x00\x00\x00\x00\x00'
                16      CALL_FUNCTION                   1
                18      POP_TOP                         
                20      SETUP_FINALLY                   36 (to 58)
                22      LOAD_GLOBAL                     0: np
                24      LOAD_METHOD                     1: exp
                26      LOAD_CONST                      5: 18.6686
                28      LOAD_CONST                      6: 4030.18
                30      LOAD_FAST                       0: T
                32      LOAD_CONST                      7: 235
                34      BINARY_ADD                      
                36      BINARY_TRUE_DIVIDE              
                38      BINARY_SUBTRACT                 
                40      CALL_METHOD                     1
                42      POP_BLOCK                       
                44      LOAD_CONST                      8: '__pyarmor_exit_47471__'
                46      NOP                             
                48      NOP                             
                50      LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14\x18\x00\x00\x00\x00\x00\x00\x00'
                52      CALL_FUNCTION                   1
                54      POP_TOP                         
                56      RETURN_VALUE                    
                58      LOAD_CONST                      8: '__pyarmor_exit_47471__'
                60      NOP                             
                62      NOP                             
                64      LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14\x18\x00\x00\x00\x00\x00\x00\x00'
                66      CALL_FUNCTION                   1
                68      POP_TOP                         
                70      RERAISE                         
                72      LOAD_CONST                      0: None
                74      RETURN_VALUE                    
        'findSaturatedVaporPressureTorr'
        [Code]
            File Name: <frozen comfort>
            Object Name: comfPMVElevatedAirspeed
            Arg Count: 7
            Pos Only Arg Count: 0
            KW Only Arg Count: 0
            Locals: 13
            Stack Size: 8
            Flags: 0x20000003 (CO_OPTIMIZED | CO_NEWLOCALS | CO_PYARMOR_OBFUSCATED)
            [Names]
                'comfPierceSET'
                'np'
                'all'
                'comfPMV'
                'zeros_like'
                'full_like'
            [Var Names]
                'ta'
                'tr'
                'vel'
                'rh'
                'met'
                'clo'
                'wme'
                '__assert_armored__'
                '_var_var_2'
                '_var_var_3'
                '_var_var_4'
                '_var_var_5'
                '_var_var_6'
            [Free Vars]
            [Cell Vars]
                'clo'
                'met'
                'rh'
                '_var_var_0'
                '_var_var_1'
                'ta'
                'tr'
                'wme'
            [Constants]
                None
                '__pyarmor_assert_47472__'
                'comfPMVElevatedAirspeed.<locals>.<lambda>'
                '__pyarmor_enter_47473__'
                b'<COAddr>\x01\x00\x00\x14\xb0\x00\x00\x00\x00\x00\x00\x00'
                0.1
                [Code]
                    File Name: <frozen comfort>
                    Object Name: utilSecant
                    Arg Count: 3
                    Pos Only Arg Count: 0
                    KW Only Arg Count: 0
                    Locals: 6
                    Stack Size: 13
                    Flags: 0x20000013 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NESTED | CO_PYARMOR_OBFUSCATED)
                    [Names]
                        'np'
                        'where'
                        'abs'
                    [Var Names]
                        'a'
                        'b'
                        'epsilon'
                        '__assert_armored__'
                        '_var_var_7'
                        '_var_var_8'
                    [Free Vars]
                        'clo'
                        'met'
                        'rh'
                        'set'
                        'stillAirThreshold'
                        'ta'
                        'tr'
                        'wme'
                    [Cell Vars]
                    [Constants]
                        None
                        '__pyarmor_assert_47475__'
                        'comfPMVElevatedAirspeed.<locals>.utilSecant.<locals>.<lambda>'
                        '__pyarmor_enter_47476__'
                        b'<COAddr>\x03\x00\x00\x14p\x00\x00\x00\x00\x00\x00\x00'
                        [Code]
                            File Name: <frozen comfort>
                            Object Name: fn
                            Arg Count: 1
                            Pos Only Arg Count: 0
                            KW Only Arg Count: 0
                            Locals: 2
                            Stack Size: 9
                            Flags: 0x20000013 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NESTED | CO_PYARMOR_OBFUSCATED)
                            [Names]
                                'comfPierceSET'
                            [Var Names]
                                't'
                                '__assert_armored__'
                            [Free Vars]
                                'clo'
                                'met'
                                'rh'
                                'set'
                                'stillAirThreshold'
                                'ta'
                                'tr'
                                'wme'
                            [Cell Vars]
                            [Constants]
                                None
                                '__pyarmor_assert_47478__'
                                'comfPMVElevatedAirspeed.<locals>.utilSecant.<locals>.fn.<locals>.<lambda>'
                                '__pyarmor_enter_47479__'
                                b'<COAddr>\x01\x00\x00\x14"\x00\x00\x00\x00\x00\x00\x00'
                                '__pyarmor_exit_47480__'
                            [Disassembly]
                                0       NOP                             
                                2       NOP                             
                                4       NOP                             
                                6       NOP                             
                                8       LOAD_CONST                      3: '__pyarmor_enter_47479__'
                                10      NOP                             
                                12      NOP                             
                                14      LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14"\x00\x00\x00\x00\x00\x00\x00'
                                16      CALL_FUNCTION                   1
                                18      POP_TOP                         
                                20      SETUP_FINALLY                   46 (to 68)
                                22      LOAD_DEREF                      3: set
                                24      LOAD_GLOBAL                     0: comfPierceSET
                                26      LOAD_DEREF                      5: ta
                                28      LOAD_FAST                       0: t
                                30      BINARY_SUBTRACT                 
                                32      LOAD_DEREF                      6: tr
                                34      LOAD_FAST                       0: t
                                36      BINARY_SUBTRACT                 
                                38      LOAD_DEREF                      4: stillAirThreshold
                                40      LOAD_DEREF                      2: rh
                                42      LOAD_DEREF                      1: met
                                44      LOAD_DEREF                      0: clo
                                46      LOAD_DEREF                      7: wme
                                48      CALL_FUNCTION                   7
                                50      BINARY_SUBTRACT                 
                                52      POP_BLOCK                       
                                54      LOAD_CONST                      5: '__pyarmor_exit_47480__'
                                56      NOP                             
                                58      NOP                             
                                60      LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14"\x00\x00\x00\x00\x00\x00\x00'
                                62      CALL_FUNCTION                   1
                                64      POP_TOP                         
                                66      RETURN_VALUE                    
                                68      LOAD_CONST                      5: '__pyarmor_exit_47480__'
                                70      NOP                             
                                72      NOP                             
                                74      LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14"\x00\x00\x00\x00\x00\x00\x00'
                                76      CALL_FUNCTION                   1
                                78      POP_TOP                         
                                80      RERAISE                         
                                82      LOAD_CONST                      0: None
                                84      RETURN_VALUE                    
                        'comfPMVElevatedAirspeed.<locals>.utilSecant.<locals>.fn'
                        '__pyarmor_exit_47477__'
                    [Disassembly]
                        0       NOP                             
                        2       NOP                             
                        4       NOP                             
                        6       NOP                             
                        8       LOAD_CONST                      3: '__pyarmor_enter_47476__'
                        10      NOP                             
                        12      NOP                             
                        14      LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x14p\x00\x00\x00\x00\x00\x00\x00'
                        16      CALL_FUNCTION                   1
                        18      POP_TOP                         
                        20      SETUP_FINALLY                   124 (to 146)
                        22      LOAD_CLOSURE                    0: clo
                        24      LOAD_CLOSURE                    1: met
                        26      LOAD_CLOSURE                    2: rh
                        28      LOAD_CLOSURE                    3: set
                        30      LOAD_CLOSURE                    4: stillAirThreshold
                        32      LOAD_CLOSURE                    5: ta
                        34      LOAD_CLOSURE                    6: tr
                        36      LOAD_CLOSURE                    7: wme
                        38      BUILD_TUPLE                     8
                        40      LOAD_CONST                      5: <CODE> fn
                        42      LOAD_CONST                      6: 'comfPMVElevatedAirspeed.<locals>.utilSecant.<locals>.fn'
                        44      MAKE_FUNCTION                   8
                        46      STORE_FAST                      4: _var_var_7
                        48      LOAD_FAST                       4: _var_var_7
                        50      LOAD_FAST                       0: a
                        52      CALL_FUNCTION                   1
                        54      STORE_FAST                      5: _var_var_8
                        56      LOAD_GLOBAL                     0: np
                        58      LOAD_METHOD                     1: where
                        60      LOAD_GLOBAL                     0: np
                        62      LOAD_METHOD                     2: abs
                        64      LOAD_FAST                       5: _var_var_8
                        66      CALL_METHOD                     1
                        68      LOAD_FAST                       2: epsilon
                        70      COMPARE_OP                      1 (<=)
                        72      LOAD_FAST                       0: a
                        74      LOAD_GLOBAL                     0: np
                        76      LOAD_METHOD                     1: where
                        78      LOAD_GLOBAL                     0: np
                        80      LOAD_METHOD                     2: abs
                        82      LOAD_FAST                       4: _var_var_7
                        84      LOAD_FAST                       1: b
                        86      CALL_FUNCTION                   1
                        88      CALL_METHOD                     1
                        90      LOAD_FAST                       2: epsilon
                        92      COMPARE_OP                      1 (<=)
                        94      LOAD_FAST                       1: b
                        96      LOAD_FAST                       1: b
                        98      LOAD_FAST                       4: _var_var_7
                        100     LOAD_FAST                       1: b
                        102     CALL_FUNCTION                   1
                        104     LOAD_FAST                       4: _var_var_7
                        106     LOAD_FAST                       1: b
                        108     CALL_FUNCTION                   1
                        110     LOAD_FAST                       5: _var_var_8
                        112     BINARY_SUBTRACT                 
                        114     LOAD_FAST                       1: b
                        116     LOAD_FAST                       0: a
                        118     BINARY_SUBTRACT                 
                        120     BINARY_TRUE_DIVIDE              
                        122     BINARY_TRUE_DIVIDE              
                        124     BINARY_SUBTRACT                 
                        126     CALL_METHOD                     3
                        128     CALL_METHOD                     3
                        130     POP_BLOCK                       
                        132     LOAD_CONST                      7: '__pyarmor_exit_47477__'
                        134     NOP                             
                        136     NOP                             
                        138     LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x14p\x00\x00\x00\x00\x00\x00\x00'
                        140     CALL_FUNCTION                   1
                        142     POP_TOP                         
                        144     RETURN_VALUE                    
                        146     LOAD_CONST                      7: '__pyarmor_exit_47477__'
                        148     NOP                             
                        150     NOP                             
                        152     LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x14p\x00\x00\x00\x00\x00\x00\x00'
                        154     CALL_FUNCTION                   1
                        156     POP_TOP                         
                        158     RERAISE                         
                        160     LOAD_CONST                      0: None
                        162     RETURN_VALUE                    
                'comfPMVElevatedAirspeed.<locals>.utilSecant'
                40
                0.001
                '__pyarmor_exit_47474__'
            [Disassembly]
                0       NOP                             
                2       NOP                             
                4       NOP                             
                6       NOP                             
                8       LOAD_CONST                      3: '__pyarmor_enter_47473__'
                10      NOP                             
                12      NOP                             
                14      LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14\xb0\x00\x00\x00\x00\x00\x00\x00'
                16      CALL_FUNCTION                   1
                18      POP_TOP                         
                20      SETUP_FINALLY                   188 (to 210)
                22      LOAD_GLOBAL                     0: comfPierceSET
                24      LOAD_DEREF                      5: ta
                26      LOAD_DEREF                      6: tr
                28      LOAD_FAST                       2: vel
                30      LOAD_DEREF                      2: rh
                32      LOAD_DEREF                      1: met
                34      LOAD_DEREF                      0: clo
                36      LOAD_DEREF                      7: wme
                38      CALL_FUNCTION                   7
                40      STORE_DEREF                     3: _var_var_0
                42      LOAD_CONST                      5: 0.1
                44      STORE_DEREF                     4: _var_var_1
                46      LOAD_CLOSURE                    0: clo
                48      LOAD_CLOSURE                    1: met
                50      LOAD_CLOSURE                    2: rh
                52      LOAD_CLOSURE                    3: _var_var_0
                54      LOAD_CLOSURE                    4: _var_var_1
                56      LOAD_CLOSURE                    5: ta
                58      LOAD_CLOSURE                    6: tr
                60      LOAD_CLOSURE                    7: wme
                62      BUILD_TUPLE                     8
                64      LOAD_CONST                      6: <CODE> utilSecant
                66      LOAD_CONST                      7: 'comfPMVElevatedAirspeed.<locals>.utilSecant'
                68      MAKE_FUNCTION                   8
                70      STORE_FAST                      8: _var_var_2
                72      LOAD_GLOBAL                     1: np
                74      LOAD_METHOD                     2: all
                76      LOAD_FAST                       2: vel
                78      LOAD_DEREF                      4: _var_var_1
                80      COMPARE_OP                      1 (<=)
                82      CALL_METHOD                     1
                84      POP_JUMP_IF_FALSE               126
                86      LOAD_GLOBAL                     3: comfPMV
                88      LOAD_DEREF                      5: ta
                90      LOAD_DEREF                      6: tr
                92      LOAD_FAST                       2: vel
                94      LOAD_DEREF                      2: rh
                96      LOAD_DEREF                      1: met
                98      LOAD_DEREF                      0: clo
                100     LOAD_DEREF                      7: wme
                102     CALL_FUNCTION                   7
                104     UNPACK_SEQUENCE                 2
                106     STORE_FAST                      9: _var_var_3
                108     STORE_FAST                      10: _var_var_4
                110     LOAD_DEREF                      5: ta
                112     STORE_FAST                      11: _var_var_5
                114     LOAD_GLOBAL                     1: np
                116     LOAD_METHOD                     4: zeros_like
                118     LOAD_DEREF                      5: ta
                120     CALL_METHOD                     1
                122     STORE_FAST                      12: _var_var_6
                124     JUMP_FORWARD                    66 (to 192)
                126     LOAD_FAST                       8: _var_var_2
                128     LOAD_GLOBAL                     1: np
                130     LOAD_METHOD                     4: zeros_like
                132     LOAD_DEREF                      5: ta
                134     CALL_METHOD                     1
                136     LOAD_GLOBAL                     1: np
                138     LOAD_METHOD                     5: full_like
                140     LOAD_DEREF                      5: ta
                142     LOAD_CONST                      8: 40
                144     CALL_METHOD                     2
                146     LOAD_CONST                      9: 0.001
                148     CALL_FUNCTION                   3
                150     STORE_FAST                      12: _var_var_6
                152     LOAD_GLOBAL                     3: comfPMV
                154     LOAD_DEREF                      5: ta
                156     LOAD_FAST                       12: _var_var_6
                158     BINARY_SUBTRACT                 
                160     LOAD_DEREF                      6: tr
                162     LOAD_FAST                       12: _var_var_6
                164     BINARY_SUBTRACT                 
                166     LOAD_DEREF                      4: _var_var_1
                168     LOAD_DEREF                      2: rh
                170     LOAD_DEREF                      1: met
                172     LOAD_DEREF                      0: clo
                174     LOAD_DEREF                      7: wme
                176     CALL_FUNCTION                   7
                178     UNPACK_SEQUENCE                 2
                180     STORE_FAST                      9: _var_var_3
                182     STORE_FAST                      10: _var_var_4
                184     LOAD_DEREF                      5: ta
                186     LOAD_FAST                       12: _var_var_6
                188     BINARY_SUBTRACT                 
                190     STORE_FAST                      11: _var_var_5
                192     LOAD_FAST                       9: _var_var_3
                194     POP_BLOCK                       
                196     LOAD_CONST                      10: '__pyarmor_exit_47474__'
                198     NOP                             
                200     NOP                             
                202     LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14\xb0\x00\x00\x00\x00\x00\x00\x00'
                204     CALL_FUNCTION                   1
                206     POP_TOP                         
                208     RETURN_VALUE                    
                210     LOAD_CONST                      10: '__pyarmor_exit_47474__'
                212     NOP                             
                214     NOP                             
                216     LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14\xb0\x00\x00\x00\x00\x00\x00\x00'
                218     CALL_FUNCTION                   1
                220     POP_TOP                         
                222     RERAISE                         
                224     LOAD_CONST                      0: None
                226     RETURN_VALUE                    
        'comfPMVElevatedAirspeed'
        [Code]
            File Name: <frozen comfort>
            Object Name: comfPMV
            Arg Count: 7
            Pos Only Arg Count: 0
            KW Only Arg Count: 0
            Locals: 39
            Stack Size: 10
            Flags: 0x20000043 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NOFREE | CO_PYARMOR_OBFUSCATED)
            [Names]
                'np'
                'exp'
                'where'
                'sqrt'
                'power'
                'any'
                'abs'
            [Var Names]
                'ta'
                'tr'
                'vel'
                'rh'
                'met'
                'clo'
                'wme'
                '__assert_armored__'
                '_var_var_9'
                '_var_var_10'
                '_var_var_11'
                '_var_var_12'
                '_var_var_13'
                '_var_var_14'
                '_var_var_15'
                '_var_var_16'
                '_var_var_17'
                '_var_var_18'
                '_var_var_19'
                '_var_var_20'
                '_var_var_21'
                '_var_var_22'
                '_var_var_23'
                '_var_var_24'
                '_var_var_25'
                '_var_var_26'
                '_var_var_27'
                '_var_var_28'
                '_var_var_29'
                '_var_var_30'
                '_var_var_31'
                '_var_var_32'
                '_var_var_33'
                '_var_var_34'
                '_var_var_35'
                '_var_var_36'
                '_var_var_37'
                '_var_var_3'
                '_var_var_4'
            [Free Vars]
            [Cell Vars]
            [Constants]
                None
                '__pyarmor_assert_47481__'
                'comfPMV.<locals>.<lambda>'
                '__pyarmor_enter_47482__'
                b'<COAddr>\x03\x00\x00\x14\x80\x02\x00\x00\x00\x00\x00\x00'
                10
                16.6536
                4030.18
                235
                0.155
                58.15
                0.078
                1
                1.29
                1.05
                0.645
                12.1
                273
                35.5
                3.5
                0.1
                3.96
                100
                308.7
                0.028
                4
                50
                0
                0.00015
                150
                2
                2.38
                100
                0.25
                0.00305
                5733
                6.99
                0.42
                1.7e-05
                5867
                0.0014
                34
                0.303
                -0.036
                95
                -0.03353
                4
                0.2179
                2
                '__pyarmor_exit_47483__'
            [Disassembly]
                0       NOP                             
                2       NOP                             
                4       NOP                             
                6       NOP                             
                8       LOAD_CONST                      3: '__pyarmor_enter_47482__'
                10      NOP                             
                12      NOP                             
                14      LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x14\x80\x02\x00\x00\x00\x00\x00\x00'
                16      CALL_FUNCTION                   1
                18      POP_TOP                         
                20      SETUP_FINALLY                   650 (to 674)
                24      LOAD_FAST                       3: rh
                26      LOAD_CONST                      5: 10
                28      BINARY_MULTIPLY                 
                30      LOAD_GLOBAL                     0: np
                32      LOAD_METHOD                     1: exp
                34      LOAD_CONST                      6: 16.6536
                36      LOAD_CONST                      7: 4030.18
                38      LOAD_FAST                       0: ta
                40      LOAD_CONST                      8: 235
                42      BINARY_ADD                      
                44      BINARY_TRUE_DIVIDE              
                46      BINARY_SUBTRACT                 
                48      CALL_METHOD                     1
                50      BINARY_MULTIPLY                 
                52      STORE_FAST                      8: _var_var_9
                54      LOAD_CONST                      9: 0.155
                56      LOAD_FAST                       5: clo
                58      BINARY_MULTIPLY                 
                60      STORE_FAST                      9: _var_var_10
                62      LOAD_FAST                       4: met
                64      LOAD_CONST                      10: 58.15
                66      BINARY_MULTIPLY                 
                68      STORE_FAST                      10: _var_var_11
                70      LOAD_FAST                       6: wme
                72      LOAD_CONST                      10: 58.15
                74      BINARY_MULTIPLY                 
                76      STORE_FAST                      11: _var_var_12
                78      LOAD_FAST                       10: _var_var_11
                80      LOAD_FAST                       11: _var_var_12
                82      BINARY_SUBTRACT                 
                84      STORE_FAST                      12: _var_var_13
                86      LOAD_GLOBAL                     0: np
                88      LOAD_METHOD                     2: where
                90      LOAD_FAST                       9: _var_var_10
                92      LOAD_CONST                      11: 0.078
                94      COMPARE_OP                      1 (<=)
                96      LOAD_CONST                      12: 1
                98      LOAD_CONST                      13: 1.29
                100     LOAD_FAST                       9: _var_var_10
                102     BINARY_MULTIPLY                 
                104     BINARY_ADD                      
                106     LOAD_CONST                      14: 1.05
                108     LOAD_CONST                      15: 0.645
                110     LOAD_FAST                       9: _var_var_10
                112     BINARY_MULTIPLY                 
                114     BINARY_ADD                      
                116     CALL_METHOD                     3
                118     STORE_FAST                      13: _var_var_14
                120     LOAD_CONST                      16: 12.1
                122     LOAD_GLOBAL                     0: np
                124     LOAD_METHOD                     3: sqrt
                126     LOAD_FAST                       2: vel
                128     CALL_METHOD                     1
                130     BINARY_MULTIPLY                 
                132     STORE_FAST                      14: _var_var_15
                134     LOAD_FAST                       0: ta
                136     LOAD_CONST                      17: 273
                138     BINARY_ADD                      
                140     STORE_FAST                      15: _var_var_16
                142     LOAD_FAST                       1: tr
                144     LOAD_CONST                      17: 273
                146     BINARY_ADD                      
                148     STORE_FAST                      16: _var_var_17
                150     LOAD_FAST                       15: _var_var_16
                152     LOAD_CONST                      18: 35.5
                154     LOAD_FAST                       0: ta
                156     BINARY_SUBTRACT                 
                158     LOAD_CONST                      19: 3.5
                160     LOAD_FAST                       9: _var_var_10
                162     BINARY_MULTIPLY                 
                164     LOAD_CONST                      20: 0.1
                166     BINARY_ADD                      
                168     BINARY_TRUE_DIVIDE              
                170     BINARY_ADD                      
                172     STORE_FAST                      17: _var_var_18
                174     LOAD_FAST                       9: _var_var_10
                176     LOAD_FAST                       13: _var_var_14
                178     BINARY_MULTIPLY                 
                180     STORE_FAST                      18: _var_var_19
                182     LOAD_FAST                       18: _var_var_19
                184     LOAD_CONST                      21: 3.96
                186     BINARY_MULTIPLY                 
                188     STORE_FAST                      19: _var_var_20
                190     LOAD_FAST                       18: _var_var_19
                192     LOAD_CONST                      22: 100
                194     BINARY_MULTIPLY                 
                196     STORE_FAST                      20: _var_var_21
                198     LOAD_FAST                       18: _var_var_19
                200     LOAD_FAST                       15: _var_var_16
                202     BINARY_MULTIPLY                 
                204     STORE_FAST                      21: _var_var_22
                206     LOAD_CONST                      23: 308.7
                208     LOAD_CONST                      24: 0.028
                210     LOAD_FAST                       12: _var_var_13
                212     BINARY_MULTIPLY                 
                214     BINARY_SUBTRACT                 
                216     LOAD_FAST                       19: _var_var_20
                218     LOAD_GLOBAL                     0: np
                220     LOAD_METHOD                     4: power
                222     LOAD_FAST                       16: _var_var_17
                224     LOAD_CONST                      22: 100
                226     BINARY_TRUE_DIVIDE              
                228     LOAD_CONST                      25: 4
                230     CALL_METHOD                     2
                232     BINARY_MULTIPLY                 
                234     BINARY_ADD                      
                236     STORE_FAST                      22: _var_var_23
                238     LOAD_FAST                       17: _var_var_18
                240     LOAD_CONST                      22: 100
                242     BINARY_TRUE_DIVIDE              
                244     STORE_FAST                      23: _var_var_24
                246     LOAD_FAST                       17: _var_var_18
                248     LOAD_CONST                      26: 50
                250     BINARY_TRUE_DIVIDE              
                252     STORE_FAST                      24: _var_var_25
                254     LOAD_CONST                      27: 0
                256     STORE_FAST                      25: _var_var_26
                258     LOAD_CONST                      28: 0.00015
                260     STORE_FAST                      26: _var_var_27
                262     LOAD_GLOBAL                     0: np
                264     LOAD_METHOD                     5: any
                266     LOAD_GLOBAL                     0: np
                268     LOAD_METHOD                     6: abs
                270     LOAD_FAST                       23: _var_var_24
                272     LOAD_FAST                       24: _var_var_25
                274     BINARY_SUBTRACT                 
                276     CALL_METHOD                     1
                278     LOAD_FAST                       26: _var_var_27
                280     COMPARE_OP                      4 (>)
                282     CALL_METHOD                     1
                284     POP_JUMP_IF_FALSE               410
                288     LOAD_FAST                       25: _var_var_26
                290     LOAD_CONST                      29: 150
                292     COMPARE_OP                      0 (<)
                294     POP_JUMP_IF_FALSE               410
                298     LOAD_FAST                       24: _var_var_25
                300     LOAD_FAST                       23: _var_var_24
                302     BINARY_ADD                      
                304     LOAD_CONST                      30: 2
                306     BINARY_TRUE_DIVIDE              
                308     STORE_FAST                      24: _var_var_25
                310     LOAD_CONST                      31: 2.38
                312     LOAD_GLOBAL                     0: np
                314     LOAD_METHOD                     4: power
                316     LOAD_GLOBAL                     0: np
                318     LOAD_METHOD                     6: abs
                320     LOAD_CONST                      32: 100
                322     LOAD_FAST                       24: _var_var_25
                324     BINARY_MULTIPLY                 
                326     LOAD_FAST                       15: _var_var_16
                328     BINARY_SUBTRACT                 
                330     CALL_METHOD                     1
                332     LOAD_CONST                      33: 0.25
                334     CALL_METHOD                     2
                336     BINARY_MULTIPLY                 
                338     STORE_FAST                      27: _var_var_28
                340     LOAD_GLOBAL                     0: np
                342     LOAD_METHOD                     2: where
                344     LOAD_FAST                       14: _var_var_15
                346     LOAD_FAST                       27: _var_var_28
                348     COMPARE_OP                      4 (>)
                350     LOAD_FAST                       14: _var_var_15
                352     LOAD_FAST                       27: _var_var_28
                354     CALL_METHOD                     3
                356     STORE_FAST                      28: _var_var_29
                358     LOAD_FAST                       22: _var_var_23
                360     LOAD_FAST                       21: _var_var_22
                362     LOAD_FAST                       28: _var_var_29
                364     BINARY_MULTIPLY                 
                366     BINARY_ADD                      
                368     LOAD_FAST                       19: _var_var_20
                370     LOAD_GLOBAL                     0: np
                372     LOAD_METHOD                     4: power
                374     LOAD_FAST                       24: _var_var_25
                376     LOAD_CONST                      25: 4
                378     CALL_METHOD                     2
                380     BINARY_MULTIPLY                 
                382     BINARY_SUBTRACT                 
                384     LOAD_CONST                      22: 100
                386     LOAD_FAST                       20: _var_var_21
                388     LOAD_FAST                       28: _var_var_29
                390     BINARY_MULTIPLY                 
                392     BINARY_ADD                      
                394     BINARY_TRUE_DIVIDE              
                396     STORE_FAST                      23: _var_var_24
                398     LOAD_FAST                       25: _var_var_26
                400     LOAD_CONST                      12: 1
                402     INPLACE_ADD                     
                404     STORE_FAST                      25: _var_var_26
                406     JUMP_ABSOLUTE                   262
                410     LOAD_CONST                      22: 100
                412     LOAD_FAST                       23: _var_var_24
                414     BINARY_MULTIPLY                 
                416     LOAD_CONST                      17: 273
                418     BINARY_SUBTRACT                 
                420     STORE_FAST                      29: _var_var_30
                422     LOAD_CONST                      34: 0.00305
                424     LOAD_CONST                      35: 5733
                426     LOAD_CONST                      36: 6.99
                428     LOAD_FAST                       12: _var_var_13
                430     BINARY_MULTIPLY                 
                432     BINARY_SUBTRACT                 
                434     LOAD_FAST                       8: _var_var_9
                436     BINARY_SUBTRACT                 
                438     BINARY_MULTIPLY                 
                440     STORE_FAST                      30: _var_var_31
                442     LOAD_GLOBAL                     0: np
                444     LOAD_METHOD                     2: where
                446     LOAD_FAST                       12: _var_var_13
                448     LOAD_CONST                      10: 58.15
                450     COMPARE_OP                      4 (>)
                452     LOAD_CONST                      37: 0.42
                454     LOAD_FAST                       12: _var_var_13
                456     LOAD_CONST                      10: 58.15
                458     BINARY_SUBTRACT                 
                460     BINARY_MULTIPLY                 
                462     LOAD_CONST                      27: 0
                464     CALL_METHOD                     3
                466     STORE_FAST                      31: _var_var_32
                468     LOAD_CONST                      38: 1.7e-05
                470     LOAD_FAST                       10: _var_var_11
                472     BINARY_MULTIPLY                 
                474     LOAD_CONST                      39: 5867
                476     LOAD_FAST                       8: _var_var_9
                478     BINARY_SUBTRACT                 
                480     BINARY_MULTIPLY                 
                482     STORE_FAST                      32: _var_var_33
                484     LOAD_CONST                      40: 0.0014
                486     LOAD_FAST                       10: _var_var_11
                488     BINARY_MULTIPLY                 
                490     LOAD_CONST                      41: 34
                492     LOAD_FAST                       0: ta
                494     BINARY_SUBTRACT                 
                496     BINARY_MULTIPLY                 
                498     STORE_FAST                      33: _var_var_34
                500     LOAD_CONST                      21: 3.96
                502     LOAD_FAST                       13: _var_var_14
                504     BINARY_MULTIPLY                 
                506     LOAD_GLOBAL                     0: np
                508     LOAD_METHOD                     4: power
                510     LOAD_FAST                       23: _var_var_24
                512     LOAD_CONST                      25: 4
                514     CALL_METHOD                     2
                516     LOAD_GLOBAL                     0: np
                518     LOAD_METHOD                     4: power
                520     LOAD_FAST                       16: _var_var_17
                522     LOAD_CONST                      22: 100
                524     BINARY_TRUE_DIVIDE              
                526     LOAD_CONST                      25: 4
                528     CALL_METHOD                     2
                530     BINARY_SUBTRACT                 
                532     BINARY_MULTIPLY                 
                534     STORE_FAST                      34: _var_var_35
                536     LOAD_FAST                       13: _var_var_14
                538     LOAD_FAST                       28: _var_var_29
                540     BINARY_MULTIPLY                 
                542     LOAD_FAST                       29: _var_var_30
                544     LOAD_FAST                       0: ta
                546     BINARY_SUBTRACT                 
                548     BINARY_MULTIPLY                 
                550     STORE_FAST                      35: _var_var_36
                552     LOAD_CONST                      42: 0.303
                554     LOAD_GLOBAL                     0: np
                556     LOAD_METHOD                     1: exp
                558     LOAD_CONST                      43: -0.036
                560     LOAD_FAST                       10: _var_var_11
                562     BINARY_MULTIPLY                 
                564     CALL_METHOD                     1
                566     BINARY_MULTIPLY                 
                568     LOAD_CONST                      24: 0.028
                570     BINARY_ADD                      
                572     STORE_FAST                      36: _var_var_37
                574     LOAD_FAST                       36: _var_var_37
                576     LOAD_FAST                       12: _var_var_13
                578     LOAD_FAST                       30: _var_var_31
                580     BINARY_SUBTRACT                 
                582     LOAD_FAST                       31: _var_var_32
                584     BINARY_SUBTRACT                 
                586     LOAD_FAST                       32: _var_var_33
                588     BINARY_SUBTRACT                 
                590     LOAD_FAST                       33: _var_var_34
                592     BINARY_SUBTRACT                 
                594     LOAD_FAST                       34: _var_var_35
                596     BINARY_SUBTRACT                 
                598     LOAD_FAST                       35: _var_var_36
                600     BINARY_SUBTRACT                 
                602     BINARY_MULTIPLY                 
                604     STORE_FAST                      37: _var_var_3
                606     LOAD_CONST                      32: 100
                608     LOAD_CONST                      44: 95
                610     LOAD_GLOBAL                     0: np
                612     LOAD_METHOD                     1: exp
                614     LOAD_CONST                      45: -0.03353
                616     LOAD_GLOBAL                     0: np
                618     LOAD_METHOD                     4: power
                620     LOAD_FAST                       37: _var_var_3
                622     LOAD_CONST                      46: 4
                624     CALL_METHOD                     2
                626     BINARY_MULTIPLY                 
                628     LOAD_CONST                      47: 0.2179
                630     LOAD_GLOBAL                     0: np
                632     LOAD_METHOD                     4: power
                634     LOAD_FAST                       37: _var_var_3
                636     LOAD_CONST                      48: 2
                638     CALL_METHOD                     2
                640     BINARY_MULTIPLY                 
                642     BINARY_SUBTRACT                 
                644     CALL_METHOD                     1
                646     BINARY_MULTIPLY                 
                648     BINARY_SUBTRACT                 
                650     STORE_FAST                      38: _var_var_4
                652     LOAD_FAST                       37: _var_var_3
                654     LOAD_FAST                       38: _var_var_4
                656     BUILD_TUPLE                     2
                658     POP_BLOCK                       
                660     LOAD_CONST                      49: '__pyarmor_exit_47483__'
                662     NOP                             
                664     NOP                             
                666     LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x14\x80\x02\x00\x00\x00\x00\x00\x00'
                668     CALL_FUNCTION                   1
                670     POP_TOP                         
                672     RETURN_VALUE                    
                674     LOAD_CONST                      49: '__pyarmor_exit_47483__'
                676     NOP                             
                678     NOP                             
                680     LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x14\x80\x02\x00\x00\x00\x00\x00\x00'
                682     CALL_FUNCTION                   1
                684     POP_TOP                         
                686     RERAISE                         
                688     LOAD_CONST                      0: None
                690     RETURN_VALUE                    
        'comfPMV'
        [Code]
            File Name: <frozen comfort>
            Object Name: comfPierceSET
            Arg Count: 7
            Pos Only Arg Count: 0
            KW Only Arg Count: 0
            Locals: 98
            Stack Size: 12
            Flags: 0x20000043 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NOFREE | CO_PYARMOR_OBFUSCATED)
            [Names]
                'findSaturatedVaporPressureTorr'
                'np'
                'maximum'
                'where'
                'power'
                'range'
                'clip'
                'exp'
                'all'
                'abs'
            [Var Names]
                'ta'
                'tr'
                'vel'
                'rh'
                'met'
                'clo'
                'wme'
                '__assert_armored__'
                '_var_var_38'
                '_var_var_39'
                '_var_var_40'
                '_var_var_41'
                '_var_var_42'
                '_var_var_43'
                '_var_var_44'
                '_var_var_45'
                '_var_var_46'
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
                '_var_var_99'
                '_var_var_100'
                '_var_var_101'
                '_var_var_102'
                '_var_var_103'
                '_var_var_104'
                '_var_var_105'
                '_var_var_106'
                '_var_var_107'
                '_var_var_108'
                '_var_var_109'
                '_var_var_110'
                '_var_var_111'
                '_var_var_112'
                '_var_var_113'
                '_var_var_114'
                '_var_var_115'
                '_var_var_116'
                '_var_var_117'
                '_var_var_118'
                '_var_var_119'
                '_var_var_120'
                '_var_var_121'
                '_var_var_122'
                '_var_var_123'
                '_var_var_124'
                '_var_var_125'
                '_var_var_126'
                '_var_var_127'
            [Free Vars]
            [Cell Vars]
            [Constants]
                None
                '__pyarmor_assert_47484__'
                'comfPierceSET.<locals>.<lambda>'
                '__pyarmor_enter_47485__'
                b'<COAddr>\x01\x00\x00\x14H\x05\x00\x00\x00\x00\x00\x00'
                100
                0.1
                0.25
                69.9
                1.8258
                58.2
                5.6697e-08
                170
                120
                0.5
                33.7
                36.49
                6.3
                0
                101.325
                0.009869
                60
                60
                0.155
                1
                0.15
                2.2
                0
                0.38
                -0.29
                0.59
                -0.08
                0.45
                3
                0.53
                8.6
                4.7
                5.28
                1.163
                0.0023
                44
                0.0014
                34
                0.97
                1
                90
                10.7
                500
                0.68
                0.06
                0.94
                19.4
                0.0417737
                0.745183
                0.585417
                0.42
                0.85
                5.66
                0.39
                1.52
                0.6944
                0.1835
                0.0001
                0.01
                '__pyarmor_exit_47486__'
            [Disassembly]
                0       NOP                             
                2       NOP                             
                4       NOP                             
                6       NOP                             
                8       LOAD_CONST                      3: '__pyarmor_enter_47485__'
                10      NOP                             
                12      NOP                             
                14      LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14H\x05\x00\x00\x00\x00\x00\x00'
                16      CALL_FUNCTION                   1
                18      POP_TOP                         
                20      SETUP_FINALLY                   1362 (to 1386)
                24      LOAD_FAST                       3: rh
                26      LOAD_GLOBAL                     0: findSaturatedVaporPressureTorr
                28      LOAD_FAST                       0: ta
                30      CALL_FUNCTION                   1
                32      BINARY_MULTIPLY                 
                34      LOAD_CONST                      5: 100
                36      BINARY_TRUE_DIVIDE              
                38      STORE_FAST                      8: _var_var_38
                40      LOAD_GLOBAL                     1: np
                42      LOAD_METHOD                     2: maximum
                44      LOAD_FAST                       2: vel
                46      LOAD_CONST                      6: 0.1
                48      CALL_METHOD                     2
                50      STORE_FAST                      9: _var_var_39
                52      LOAD_CONST                      7: 0.25
                54      STORE_FAST                      10: _var_var_40
                56      LOAD_CONST                      8: 69.9
                58      STORE_FAST                      11: _var_var_41
                60      LOAD_CONST                      9: 1.8258
                62      STORE_FAST                      12: _var_var_42
                64      LOAD_CONST                      10: 58.2
                66      STORE_FAST                      13: _var_var_43
                68      LOAD_CONST                      11: 5.6697e-08
                70      STORE_FAST                      14: _var_var_44
                72      LOAD_CONST                      12: 170
                74      STORE_FAST                      15: _var_var_45
                76      LOAD_CONST                      13: 120
                78      STORE_FAST                      16: _var_var_46
                80      LOAD_CONST                      14: 0.5
                82      STORE_FAST                      17: _var_var_47
                84      LOAD_CONST                      15: 33.7
                86      STORE_FAST                      18: _var_var_48
                88      LOAD_CONST                      16: 36.49
                90      STORE_FAST                      19: _var_var_49
                92      LOAD_CONST                      16: 36.49
                94      STORE_FAST                      20: _var_var_50
                96      LOAD_CONST                      17: 6.3
                98      STORE_FAST                      21: _var_var_51
                100     LOAD_FAST                       18: _var_var_48
                102     STORE_FAST                      22: _var_var_52
                104     LOAD_FAST                       19: _var_var_49
                106     STORE_FAST                      23: _var_var_53
                108     LOAD_FAST                       21: _var_var_51
                110     STORE_FAST                      24: _var_var_54
                112     LOAD_CONST                      18: 0
                114     STORE_FAST                      25: _var_var_55
                116     LOAD_CONST                      6: 0.1
                118     STORE_FAST                      26: _var_var_56
                120     LOAD_CONST                      6: 0.1
                122     LOAD_FAST                       4: met
                124     BINARY_MULTIPLY                 
                126     STORE_FAST                      27: _var_var_57
                128     LOAD_CONST                      19: 101.325
                130     STORE_FAST                      28: _var_var_58
                132     LOAD_FAST                       28: _var_var_58
                134     LOAD_CONST                      20: 0.009869
                136     BINARY_MULTIPLY                 
                138     STORE_FAST                      29: _var_var_59
                140     LOAD_CONST                      21: 60
                142     STORE_FAST                      30: _var_var_60
                144     LOAD_FAST                       30: _var_var_60
                146     LOAD_CONST                      22: 60
                148     BINARY_TRUE_DIVIDE              
                150     STORE_FAST                      31: _var_var_61
                152     LOAD_CONST                      23: 0.155
                154     LOAD_FAST                       5: clo
                156     BINARY_MULTIPLY                 
                158     STORE_FAST                      32: _var_var_62
                160     LOAD_CONST                      24: 1
                162     LOAD_CONST                      25: 0.15
                164     LOAD_FAST                       5: clo
                166     BINARY_MULTIPLY                 
                168     BINARY_ADD                      
                170     STORE_FAST                      33: _var_var_63
                172     LOAD_CONST                      26: 2.2
                174     LOAD_FAST                       29: _var_var_59
                176     BINARY_TRUE_DIVIDE              
                178     STORE_FAST                      34: _var_var_64
                180     LOAD_FAST                       4: met
                182     LOAD_FAST                       13: _var_var_43
                184     BINARY_MULTIPLY                 
                186     STORE_FAST                      35: _var_var_65
                188     LOAD_FAST                       4: met
                190     LOAD_FAST                       13: _var_var_43
                192     BINARY_MULTIPLY                 
                194     STORE_FAST                      36: _var_var_66
                196     LOAD_GLOBAL                     1: np
                198     LOAD_METHOD                     3: where
                200     LOAD_FAST                       5: clo
                202     LOAD_CONST                      27: 0
                204     COMPARE_OP                      1 (<=)
                206     LOAD_CONST                      28: 0.38
                208     LOAD_GLOBAL                     1: np
                210     LOAD_METHOD                     4: power
                212     LOAD_FAST                       9: _var_var_39
                214     LOAD_CONST                      29: -0.29
                216     CALL_METHOD                     2
                218     BINARY_MULTIPLY                 
                220     LOAD_CONST                      30: 0.59
                222     LOAD_GLOBAL                     1: np
                224     LOAD_METHOD                     4: power
                226     LOAD_FAST                       9: _var_var_39
                228     LOAD_CONST                      31: -0.08
                230     CALL_METHOD                     2
                232     BINARY_MULTIPLY                 
                234     CALL_METHOD                     3
                236     STORE_FAST                      37: _var_var_67
                238     LOAD_GLOBAL                     1: np
                240     LOAD_METHOD                     3: where
                242     LOAD_FAST                       5: clo
                244     LOAD_CONST                      27: 0
                246     COMPARE_OP                      1 (<=)
                248     LOAD_CONST                      24: 1
                250     LOAD_CONST                      32: 0.45
                252     CALL_METHOD                     3
                254     STORE_FAST                      38: _var_var_68
                256     LOAD_GLOBAL                     1: np
                258     LOAD_METHOD                     2: maximum
                260     LOAD_CONST                      33: 3
                262     LOAD_GLOBAL                     1: np
                264     LOAD_METHOD                     4: power
                266     LOAD_FAST                       29: _var_var_59
                268     LOAD_CONST                      34: 0.53
                270     CALL_METHOD                     2
                272     BINARY_MULTIPLY                 
                274     LOAD_CONST                      35: 8.6
                276     LOAD_GLOBAL                     1: np
                278     LOAD_METHOD                     4: power
                280     LOAD_FAST                       9: _var_var_39
                282     LOAD_FAST                       29: _var_var_59
                284     BINARY_MULTIPLY                 
                286     LOAD_CONST                      34: 0.53
                288     CALL_METHOD                     2
                290     BINARY_MULTIPLY                 
                292     CALL_METHOD                     2
                294     STORE_FAST                      39: _var_var_69
                296     LOAD_CONST                      36: 4.7
                298     STORE_FAST                      40: _var_var_70
                300     LOAD_FAST                       40: _var_var_70
                302     LOAD_FAST                       39: _var_var_69
                304     BINARY_ADD                      
                306     STORE_FAST                      41: _var_var_71
                308     LOAD_CONST                      24: 1
                310     LOAD_FAST                       33: _var_var_63
                312     LOAD_FAST                       41: _var_var_71
                314     BINARY_MULTIPLY                 
                316     BINARY_TRUE_DIVIDE              
                318     STORE_FAST                      42: _var_var_72
                320     LOAD_FAST                       40: _var_var_70
                322     LOAD_FAST                       1: tr
                324     BINARY_MULTIPLY                 
                326     LOAD_FAST                       39: _var_var_69
                328     LOAD_FAST                       0: ta
                330     BINARY_MULTIPLY                 
                332     BINARY_ADD                      
                334     LOAD_FAST                       41: _var_var_71
                336     BINARY_TRUE_DIVIDE              
                338     STORE_FAST                      43: _var_var_73
                340     LOAD_FAST                       43: _var_var_73
                342     LOAD_FAST                       22: _var_var_52
                344     LOAD_FAST                       43: _var_var_73
                346     BINARY_SUBTRACT                 
                348     LOAD_FAST                       41: _var_var_71
                350     LOAD_FAST                       42: _var_var_72
                352     LOAD_FAST                       32: _var_var_62
                354     BINARY_ADD                      
                356     BINARY_MULTIPLY                 
                358     BINARY_TRUE_DIVIDE              
                360     BINARY_ADD                      
                362     STORE_FAST                      44: _var_var_74
                364     LOAD_GLOBAL                     5: range
                366     LOAD_FAST                       30: _var_var_60
                368     CALL_FUNCTION                   1
                370     GET_ITER                        
                372     FOR_ITER                        522 (to 898)
                376     STORE_FAST                      45: _var_var_75
                378     LOAD_FAST                       22: _var_var_52
                380     LOAD_FAST                       43: _var_var_73
                382     BINARY_SUBTRACT                 
                384     LOAD_FAST                       42: _var_var_72
                386     LOAD_FAST                       32: _var_var_62
                388     BINARY_ADD                      
                390     BINARY_TRUE_DIVIDE              
                392     STORE_FAST                      46: _var_var_76
                394     LOAD_FAST                       23: _var_var_53
                396     LOAD_FAST                       22: _var_var_52
                398     BINARY_SUBTRACT                 
                400     LOAD_CONST                      37: 5.28
                402     LOAD_CONST                      38: 1.163
                404     LOAD_FAST                       24: _var_var_54
                406     BINARY_MULTIPLY                 
                408     BINARY_ADD                      
                410     BINARY_MULTIPLY                 
                412     STORE_FAST                      47: _var_var_77
                414     LOAD_CONST                      39: 0.0023
                416     LOAD_FAST                       36: _var_var_66
                418     BINARY_MULTIPLY                 
                420     LOAD_CONST                      40: 44
                422     LOAD_FAST                       8: _var_var_38
                424     BINARY_SUBTRACT                 
                426     BINARY_MULTIPLY                 
                428     STORE_FAST                      48: _var_var_78
                430     LOAD_CONST                      41: 0.0014
                432     LOAD_FAST                       36: _var_var_66
                434     BINARY_MULTIPLY                 
                436     LOAD_CONST                      42: 34
                438     LOAD_FAST                       0: ta
                440     BINARY_SUBTRACT                 
                442     BINARY_MULTIPLY                 
                444     STORE_FAST                      49: _var_var_79
                446     LOAD_FAST                       36: _var_var_66
                448     LOAD_FAST                       47: _var_var_77
                450     BINARY_SUBTRACT                 
                452     LOAD_FAST                       48: _var_var_78
                454     BINARY_SUBTRACT                 
                456     LOAD_FAST                       49: _var_var_79
                458     BINARY_SUBTRACT                 
                460     LOAD_FAST                       6: wme
                462     BINARY_SUBTRACT                 
                464     STORE_FAST                      50: _var_var_80
                466     LOAD_FAST                       47: _var_var_77
                468     LOAD_FAST                       46: _var_var_76
                470     BINARY_SUBTRACT                 
                472     LOAD_FAST                       27: _var_var_57
                474     BINARY_SUBTRACT                 
                476     STORE_FAST                      51: _var_var_81
                478     LOAD_CONST                      43: 0.97
                480     LOAD_FAST                       26: _var_var_56
                482     BINARY_MULTIPLY                 
                484     LOAD_FAST                       11: _var_var_41
                486     BINARY_MULTIPLY                 
                488     STORE_FAST                      52: _var_var_82
                490     LOAD_CONST                      43: 0.97
                492     LOAD_CONST                      44: 1
                494     LOAD_FAST                       26: _var_var_56
                496     BINARY_SUBTRACT                 
                498     BINARY_MULTIPLY                 
                500     LOAD_FAST                       11: _var_var_41
                502     BINARY_MULTIPLY                 
                504     STORE_FAST                      53: _var_var_83
                506     LOAD_FAST                       51: _var_var_81
                508     LOAD_FAST                       12: _var_var_42
                510     BINARY_MULTIPLY                 
                512     LOAD_FAST                       52: _var_var_82
                514     LOAD_CONST                      22: 60
                516     BINARY_MULTIPLY                 
                518     BINARY_TRUE_DIVIDE              
                520     STORE_FAST                      54: _var_var_84
                522     LOAD_FAST                       50: _var_var_80
                524     LOAD_FAST                       12: _var_var_42
                526     BINARY_MULTIPLY                 
                528     LOAD_FAST                       53: _var_var_83
                530     LOAD_CONST                      22: 60
                532     BINARY_MULTIPLY                 
                534     BINARY_TRUE_DIVIDE              
                536     STORE_FAST                      55: _var_var_85
                538     LOAD_FAST                       22: _var_var_52
                540     LOAD_FAST                       54: _var_var_84
                542     BINARY_ADD                      
                544     STORE_FAST                      22: _var_var_52
                546     LOAD_FAST                       23: _var_var_53
                548     LOAD_FAST                       55: _var_var_85
                550     BINARY_ADD                      
                552     STORE_FAST                      23: _var_var_53
                554     LOAD_FAST                       26: _var_var_56
                556     LOAD_FAST                       22: _var_var_52
                558     BINARY_MULTIPLY                 
                560     LOAD_CONST                      44: 1
                562     LOAD_FAST                       26: _var_var_56
                564     BINARY_SUBTRACT                 
                566     LOAD_FAST                       23: _var_var_53
                568     BINARY_MULTIPLY                 
                570     BINARY_ADD                      
                572     STORE_FAST                      56: _var_var_86
                574     LOAD_FAST                       22: _var_var_52
                576     LOAD_FAST                       18: _var_var_48
                578     BINARY_SUBTRACT                 
                580     STORE_FAST                      57: _var_var_87
                582     LOAD_GLOBAL                     1: np
                584     LOAD_METHOD                     2: maximum
                586     LOAD_CONST                      27: 0
                588     LOAD_FAST                       57: _var_var_87
                590     CALL_METHOD                     2
                592     STORE_FAST                      58: _var_var_88
                594     LOAD_GLOBAL                     1: np
                596     LOAD_METHOD                     2: maximum
                598     LOAD_CONST                      27: 0
                600     LOAD_FAST                       57: _var_var_87
                602     UNARY_NEGATIVE                  
                604     CALL_METHOD                     2
                606     STORE_FAST                      59: _var_var_89
                608     LOAD_FAST                       23: _var_var_53
                610     LOAD_FAST                       19: _var_var_49
                612     BINARY_SUBTRACT                 
                614     STORE_FAST                      60: _var_var_90
                616     LOAD_GLOBAL                     1: np
                618     LOAD_METHOD                     2: maximum
                620     LOAD_CONST                      27: 0
                622     LOAD_FAST                       60: _var_var_90
                624     CALL_METHOD                     2
                626     STORE_FAST                      61: _var_var_91
                628     LOAD_GLOBAL                     1: np
                630     LOAD_METHOD                     2: maximum
                632     LOAD_CONST                      27: 0
                634     LOAD_FAST                       60: _var_var_90
                636     UNARY_NEGATIVE                  
                638     CALL_METHOD                     2
                640     STORE_FAST                      62: _var_var_92
                642     LOAD_FAST                       56: _var_var_86
                644     LOAD_FAST                       20: _var_var_50
                646     BINARY_SUBTRACT                 
                648     STORE_FAST                      63: _var_var_93
                650     LOAD_GLOBAL                     1: np
                652     LOAD_METHOD                     2: maximum
                654     LOAD_CONST                      27: 0
                656     LOAD_FAST                       63: _var_var_93
                658     CALL_METHOD                     2
                660     STORE_FAST                      64: _var_var_94
                662     LOAD_GLOBAL                     1: np
                664     LOAD_METHOD                     2: maximum
                666     LOAD_CONST                      27: 0
                668     LOAD_FAST                       63: _var_var_93
                670     UNARY_NEGATIVE                  
                672     CALL_METHOD                     2
                674     STORE_FAST                      65: _var_var_95
                676     LOAD_GLOBAL                     1: np
                678     LOAD_METHOD                     6: clip
                680     LOAD_FAST                       21: _var_var_51
                682     LOAD_FAST                       16: _var_var_46
                684     LOAD_FAST                       61: _var_var_91
                686     BINARY_MULTIPLY                 
                688     BINARY_ADD                      
                690     LOAD_CONST                      44: 1
                692     LOAD_FAST                       17: _var_var_47
                694     LOAD_FAST                       59: _var_var_89
                696     BINARY_MULTIPLY                 
                698     BINARY_ADD                      
                700     BINARY_TRUE_DIVIDE              
                702     LOAD_CONST                      14: 0.5
                704     LOAD_CONST                      45: 90
                706     CALL_METHOD                     3
                708     STORE_FAST                      24: _var_var_54
                710     LOAD_GLOBAL                     1: np
                712     LOAD_METHOD                     6: clip
                714     LOAD_FAST                       15: _var_var_45
                716     LOAD_FAST                       64: _var_var_94
                718     BINARY_MULTIPLY                 
                720     LOAD_GLOBAL                     1: np
                722     LOAD_METHOD                     7: exp
                724     LOAD_FAST                       58: _var_var_88
                726     LOAD_CONST                      46: 10.7
                728     BINARY_TRUE_DIVIDE              
                730     CALL_METHOD                     1
                732     BINARY_MULTIPLY                 
                734     LOAD_CONST                      0: None
                736     LOAD_CONST                      47: 500
                738     CALL_METHOD                     3
                740     STORE_FAST                      66: _var_var_96
                742     LOAD_CONST                      48: 0.68
                744     LOAD_FAST                       66: _var_var_96
                746     BINARY_MULTIPLY                 
                748     STORE_FAST                      67: _var_var_97
                750     LOAD_CONST                      24: 1
                752     LOAD_FAST                       34: _var_var_64
                754     LOAD_FAST                       33: _var_var_63
                756     BINARY_MULTIPLY                 
                758     LOAD_FAST                       39: _var_var_69
                760     BINARY_MULTIPLY                 
                762     BINARY_TRUE_DIVIDE              
                764     STORE_FAST                      68: _var_var_98
                766     LOAD_FAST                       32: _var_var_62
                768     LOAD_FAST                       34: _var_var_64
                770     LOAD_FAST                       38: _var_var_68
                772     BINARY_MULTIPLY                 
                774     BINARY_TRUE_DIVIDE              
                776     STORE_FAST                      69: _var_var_99
                778     LOAD_GLOBAL                     0: findSaturatedVaporPressureTorr
                780     LOAD_FAST                       22: _var_var_52
                782     CALL_FUNCTION                   1
                784     LOAD_FAST                       8: _var_var_38
                786     BINARY_SUBTRACT                 
                788     LOAD_FAST                       68: _var_var_98
                790     LOAD_FAST                       69: _var_var_99
                792     BINARY_ADD                      
                794     BINARY_TRUE_DIVIDE              
                796     STORE_FAST                      70: _var_var_100
                798     LOAD_FAST                       67: _var_var_97
                800     LOAD_FAST                       70: _var_var_100
                802     BINARY_TRUE_DIVIDE              
                804     STORE_FAST                      71: _var_var_101
                806     LOAD_GLOBAL                     1: np
                808     LOAD_METHOD                     6: clip
                810     LOAD_CONST                      49: 0.06
                812     LOAD_CONST                      50: 0.94
                814     LOAD_FAST                       71: _var_var_101
                816     BINARY_MULTIPLY                 
                818     BINARY_ADD                      
                820     LOAD_CONST                      0: None
                822     LOAD_FAST                       37: _var_var_67
                824     CALL_METHOD                     3
                826     STORE_FAST                      72: _var_var_102
                828     LOAD_FAST                       72: _var_var_102
                830     LOAD_FAST                       70: _var_var_100
                832     BINARY_MULTIPLY                 
                834     LOAD_FAST                       67: _var_var_97
                836     BINARY_SUBTRACT                 
                838     STORE_FAST                      73: _var_var_103
                840     LOAD_GLOBAL                     1: np
                842     LOAD_METHOD                     6: clip
                844     LOAD_FAST                       67: _var_var_97
                846     LOAD_FAST                       73: _var_var_103
                848     BINARY_ADD                      
                850     LOAD_CONST                      0: None
                852     LOAD_FAST                       70: _var_var_100
                854     CALL_METHOD                     3
                856     STORE_FAST                      27: _var_var_57
                858     LOAD_CONST                      51: 19.4
                860     LOAD_FAST                       59: _var_var_89
                862     BINARY_MULTIPLY                 
                864     LOAD_FAST                       62: _var_var_92
                866     BINARY_MULTIPLY                 
                868     STORE_FAST                      25: _var_var_55
                870     LOAD_FAST                       35: _var_var_65
                872     LOAD_FAST                       25: _var_var_55
                874     BINARY_ADD                      
                876     STORE_FAST                      36: _var_var_66
                878     LOAD_CONST                      52: 0.0417737
                880     LOAD_CONST                      53: 0.745183
                882     LOAD_FAST                       24: _var_var_54
                884     LOAD_CONST                      54: 0.585417
                886     BINARY_ADD                      
                888     BINARY_TRUE_DIVIDE              
                890     BINARY_ADD                      
                892     STORE_FAST                      26: _var_var_56
                894     JUMP_ABSOLUTE                   372
                898     LOAD_FAST                       46: _var_var_76
                900     LOAD_FAST                       27: _var_var_57
                902     BINARY_ADD                      
                904     STORE_FAST                      74: _var_var_104
                906     LOAD_FAST                       36: _var_var_66
                908     LOAD_FAST                       6: wme
                910     BINARY_SUBTRACT                 
                912     STORE_FAST                      75: _var_var_105
                914     LOAD_GLOBAL                     1: np
                916     LOAD_METHOD                     2: maximum
                918     LOAD_CONST                      27: 0
                920     LOAD_CONST                      55: 0.42
                922     LOAD_FAST                       75: _var_var_105
                924     LOAD_CONST                      44: 1
                926     LOAD_FAST                       13: _var_var_43
                928     BINARY_MULTIPLY                 
                930     BINARY_SUBTRACT                 
                932     BINARY_MULTIPLY                 
                934     CALL_METHOD                     2
                936     STORE_FAST                      76: _var_var_106
                938     LOAD_FAST                       70: _var_var_100
                940     LOAD_FAST                       37: _var_var_67
                942     BINARY_MULTIPLY                 
                944     STORE_FAST                      70: _var_var_100
                946     LOAD_FAST                       72: _var_var_102
                948     STORE_FAST                      77: _var_var_107
                950     LOAD_GLOBAL                     0: findSaturatedVaporPressureTorr
                952     LOAD_FAST                       22: _var_var_52
                954     CALL_FUNCTION                   1
                956     STORE_FAST                      78: _var_var_108
                958     LOAD_FAST                       40: _var_var_70
                960     STORE_FAST                      79: _var_var_109
                962     LOAD_GLOBAL                     1: np
                964     LOAD_METHOD                     3: where
                966     LOAD_FAST                       4: met
                968     LOAD_CONST                      56: 0.85
                970     COMPARE_OP                      0 (<)
                972     LOAD_CONST                      33: 3
                974     LOAD_GLOBAL                     1: np
                976     LOAD_METHOD                     2: maximum
                978     LOAD_CONST                      33: 3
                980     LOAD_CONST                      57: 5.66
                982     LOAD_GLOBAL                     1: np
                984     LOAD_METHOD                     4: power
                986     LOAD_FAST                       4: met
                988     LOAD_CONST                      56: 0.85
                990     BINARY_SUBTRACT                 
                992     LOAD_CONST                      58: 0.39
                994     CALL_METHOD                     2
                996     BINARY_MULTIPLY                 
                998     CALL_METHOD                     2
                1000    CALL_METHOD                     3
                1002    STORE_FAST                      80: _var_var_110
                1004    LOAD_FAST                       80: _var_var_110
                1006    LOAD_FAST                       79: _var_var_109
                1008    BINARY_ADD                      
                1010    STORE_FAST                      80: _var_var_110
                1012    LOAD_CONST                      59: 1.52
                1014    LOAD_FAST                       4: met
                1016    LOAD_FAST                       6: wme
                1018    LOAD_FAST                       13: _var_var_43
                1020    BINARY_TRUE_DIVIDE              
                1022    BINARY_SUBTRACT                 
                1024    LOAD_CONST                      60: 0.6944
                1026    BINARY_ADD                      
                1028    BINARY_TRUE_DIVIDE              
                1030    LOAD_CONST                      61: 0.1835
                1032    BINARY_SUBTRACT                 
                1034    STORE_FAST                      81: _var_var_111
                1036    LOAD_CONST                      23: 0.155
                1038    LOAD_FAST                       81: _var_var_111
                1040    BINARY_MULTIPLY                 
                1042    STORE_FAST                      82: _var_var_112
                1044    LOAD_CONST                      24: 1
                1046    LOAD_FAST                       10: _var_var_40
                1048    LOAD_FAST                       81: _var_var_111
                1050    BINARY_MULTIPLY                 
                1052    BINARY_ADD                      
                1054    STORE_FAST                      83: _var_var_113
                1056    LOAD_CONST                      24: 1
                1058    LOAD_CONST                      24: 1
                1060    LOAD_CONST                      23: 0.155
                1062    LOAD_FAST                       83: _var_var_113
                1064    BINARY_MULTIPLY                 
                1066    LOAD_FAST                       80: _var_var_110
                1068    BINARY_MULTIPLY                 
                1070    LOAD_FAST                       81: _var_var_111
                1072    BINARY_MULTIPLY                 
                1074    BINARY_ADD                      
                1076    BINARY_TRUE_DIVIDE              
                1078    STORE_FAST                      84: _var_var_114
                1080    LOAD_CONST                      32: 0.45
                1082    STORE_FAST                      85: _var_var_115
                1084    LOAD_FAST                       85: _var_var_115
                1086    LOAD_FAST                       80: _var_var_110
                1088    BINARY_MULTIPLY                 
                1090    LOAD_FAST                       80: _var_var_110
                1092    BINARY_TRUE_DIVIDE              
                1094    LOAD_CONST                      44: 1
                1096    LOAD_FAST                       84: _var_var_114
                1098    BINARY_SUBTRACT                 
                1100    BINARY_MULTIPLY                 
                1102    LOAD_FAST                       80: _var_var_110
                1104    LOAD_FAST                       80: _var_var_110
                1106    BINARY_TRUE_DIVIDE              
                1108    LOAD_FAST                       84: _var_var_114
                1110    LOAD_FAST                       85: _var_var_115
                1112    BINARY_MULTIPLY                 
                1114    BINARY_SUBTRACT                 
                1116    BINARY_TRUE_DIVIDE              
                1118    STORE_FAST                      86: _var_var_116
                1120    LOAD_CONST                      24: 1
                1122    LOAD_FAST                       83: _var_var_113
                1124    LOAD_FAST                       80: _var_var_110
                1126    BINARY_MULTIPLY                 
                1128    BINARY_TRUE_DIVIDE              
                1130    STORE_FAST                      87: _var_var_117
                1132    LOAD_CONST                      24: 1
                1134    LOAD_FAST                       34: _var_var_64
                1136    LOAD_FAST                       83: _var_var_113
                1138    BINARY_MULTIPLY                 
                1140    LOAD_FAST                       80: _var_var_110
                1142    BINARY_MULTIPLY                 
                1144    BINARY_TRUE_DIVIDE              
                1146    STORE_FAST                      88: _var_var_118
                1148    LOAD_FAST                       82: _var_var_112
                1150    LOAD_FAST                       34: _var_var_64
                1152    LOAD_FAST                       86: _var_var_116
                1154    BINARY_MULTIPLY                 
                1156    BINARY_TRUE_DIVIDE              
                1158    STORE_FAST                      89: _var_var_119
                1160    LOAD_CONST                      24: 1
                1162    LOAD_FAST                       87: _var_var_117
                1164    LOAD_FAST                       82: _var_var_112
                1166    BINARY_ADD                      
                1168    BINARY_TRUE_DIVIDE              
                1170    STORE_FAST                      90: _var_var_120
                1172    LOAD_CONST                      24: 1
                1174    LOAD_FAST                       88: _var_var_118
                1176    LOAD_FAST                       89: _var_var_119
                1178    BINARY_ADD                      
                1180    BINARY_TRUE_DIVIDE              
                1182    STORE_FAST                      91: _var_var_121
                1184    LOAD_CONST                      62: 0.0001
                1186    STORE_FAST                      92: _var_var_122
                1188    LOAD_FAST                       22: _var_var_52
                1190    LOAD_FAST                       74: _var_var_104
                1192    LOAD_FAST                       90: _var_var_120
                1194    BINARY_TRUE_DIVIDE              
                1196    BINARY_SUBTRACT                 
                1198    STORE_FAST                      93: _var_var_123
                1200    LOAD_FAST                       93: _var_var_123
                1202    STORE_FAST                      94: _var_var_124
                1204    LOAD_GLOBAL                     5: range
                1206    LOAD_CONST                      5: 100
                1208    CALL_FUNCTION                   1
                1210    GET_ITER                        
                1212    FOR_ITER                        154 (to 1368)
                1214    STORE_FAST                      45: _var_var_75
                1216    LOAD_FAST                       74: _var_var_104
                1218    LOAD_FAST                       90: _var_var_120
                1220    LOAD_FAST                       22: _var_var_52
                1222    LOAD_FAST                       93: _var_var_123
                1224    BINARY_SUBTRACT                 
                1226    BINARY_MULTIPLY                 
                1228    BINARY_SUBTRACT                 
                1230    LOAD_FAST                       77: _var_var_107
                1232    LOAD_FAST                       91: _var_var_121
                1234    BINARY_MULTIPLY                 
                1236    LOAD_FAST                       78: _var_var_108
                1238    LOAD_CONST                      14: 0.5
                1240    LOAD_GLOBAL                     0: findSaturatedVaporPressureTorr
                1242    LOAD_FAST                       93: _var_var_123
                1244    CALL_FUNCTION                   1
                1246    BINARY_MULTIPLY                 
                1248    BINARY_SUBTRACT                 
                1250    BINARY_MULTIPLY                 
                1252    BINARY_SUBTRACT                 
                1254    STORE_FAST                      95: _var_var_125
                1256    LOAD_FAST                       74: _var_var_104
                1258    LOAD_FAST                       90: _var_var_120
                1260    LOAD_FAST                       22: _var_var_52
                1262    LOAD_FAST                       93: _var_var_123
                1264    LOAD_FAST                       92: _var_var_122
                1266    BINARY_ADD                      
                1268    BINARY_SUBTRACT                 
                1270    BINARY_MULTIPLY                 
                1272    BINARY_SUBTRACT                 
                1274    LOAD_FAST                       77: _var_var_107
                1276    LOAD_FAST                       91: _var_var_121
                1278    BINARY_MULTIPLY                 
                1280    LOAD_FAST                       78: _var_var_108
                1282    LOAD_CONST                      14: 0.5
                1284    LOAD_GLOBAL                     0: findSaturatedVaporPressureTorr
                1286    LOAD_FAST                       93: _var_var_123
                1288    LOAD_FAST                       92: _var_var_122
                1290    BINARY_ADD                      
                1292    CALL_FUNCTION                   1
                1294    BINARY_MULTIPLY                 
                1296    BINARY_SUBTRACT                 
                1298    BINARY_MULTIPLY                 
                1300    BINARY_SUBTRACT                 
                1302    STORE_FAST                      96: _var_var_126
                1304    LOAD_FAST                       93: _var_var_123
                1306    LOAD_FAST                       92: _var_var_122
                1308    LOAD_FAST                       95: _var_var_125
                1310    BINARY_MULTIPLY                 
                1312    LOAD_FAST                       96: _var_var_126
                1314    LOAD_FAST                       95: _var_var_125
                1316    BINARY_SUBTRACT                 
                1318    BINARY_TRUE_DIVIDE              
                1320    BINARY_SUBTRACT                 
                1322    STORE_FAST                      94: _var_var_124
                1324    LOAD_FAST                       94: _var_var_124
                1326    LOAD_FAST                       93: _var_var_123
                1328    BINARY_SUBTRACT                 
                1330    STORE_FAST                      97: _var_var_127
                1332    LOAD_FAST                       94: _var_var_124
                1334    STORE_FAST                      93: _var_var_123
                1336    LOAD_GLOBAL                     1: np
                1338    LOAD_METHOD                     8: all
                1340    LOAD_GLOBAL                     1: np
                1342    LOAD_METHOD                     9: abs
                1344    LOAD_FAST                       97: _var_var_127
                1346    CALL_METHOD                     1
                1348    LOAD_CONST                      63: 0.01
                1350    COMPARE_OP                      1 (<=)
                1352    CALL_METHOD                     1
                1354    POP_JUMP_IF_FALSE               1212
                1358    POP_TOP                         
                1360    JUMP_ABSOLUTE                   1368
                1364    JUMP_ABSOLUTE                   1212
                1368    LOAD_FAST                       94: _var_var_124
                1370    POP_BLOCK                       
                1372    LOAD_CONST                      64: '__pyarmor_exit_47486__'
                1374    NOP                             
                1376    NOP                             
                1378    LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14H\x05\x00\x00\x00\x00\x00\x00'
                1380    CALL_FUNCTION                   1
                1382    POP_TOP                         
                1384    RETURN_VALUE                    
                1386    LOAD_CONST                      64: '__pyarmor_exit_47486__'
                1388    NOP                             
                1390    NOP                             
                1392    LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14H\x05\x00\x00\x00\x00\x00\x00'
                1394    CALL_FUNCTION                   1
                1396    POP_TOP                         
                1398    RERAISE                         
                1400    LOAD_CONST                      0: None
                1402    RETURN_VALUE                    
        'comfPierceSET'
        [Code]
            File Name: <frozen comfort>
            Object Name: calcHumidRatio
            Arg Count: 3
            Pos Only Arg Count: 0
            KW Only Arg Count: 0
            Locals: 23
            Stack Size: 8
            Flags: 0x20000043 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NOFREE | CO_PYARMOR_OBFUSCATED)
            [Names]
                'np'
                'array'
                'where'
                'exp'
                'maximum'
            [Var Names]
                'airTemp'
                'relHumid'
                'barPress'
                '__assert_armored__'
                '_var_var_128'
                '_var_var_129'
                '_var_var_130'
                '_var_var_131'
                '_var_var_132'
                '_var_var_133'
                '_var_var_134'
                '_var_var_135'
                '_var_var_136'
                '_var_var_137'
                '_var_var_138'
                '_var_var_139'
                '_var_var_140'
                '_var_var_141'
                '_var_var_142'
                '_var_var_143'
                '_var_var_144'
                '_var_var_145'
                '_var_var_146'
            [Free Vars]
            [Cell Vars]
            [Constants]
                None
                '__pyarmor_assert_47487__'
                'calcHumidRatio.<locals>.<lambda>'
                '__pyarmor_enter_47488__'
                b'<COAddr>\x01\x00\x00\x14Z\x01\x00\x00\x00\x00\x00\x00'
                273
                1
                647.096
                0
                -7.85952
                1.5
                1.84408
                3
                -11.7866
                3.5
                22.6807
                4
                -15.9619
                7.5
                1.80123
                22064000
                273.16
                -1.5
                -13.9282
                -1.25
                34.7078
                611.657
                0.01
                0.621991
                1.01
                1.89
                2500
                '__pyarmor_exit_47489__'
            [Disassembly]
                0       NOP                             
                2       NOP                             
                4       NOP                             
                6       NOP                             
                8       LOAD_CONST                      3: '__pyarmor_enter_47488__'
                10      NOP                             
                12      NOP                             
                14      LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14Z\x01\x00\x00\x00\x00\x00\x00'
                16      CALL_FUNCTION                   1
                18      POP_TOP                         
                20      SETUP_FINALLY                   356 (to 380)
                24      LOAD_GLOBAL                     0: np
                26      LOAD_METHOD                     1: array
                28      LOAD_FAST                       0: airTemp
                30      CALL_METHOD                     1
                32      LOAD_CONST                      5: 273
                34      BINARY_ADD                      
                36      STORE_FAST                      4: _var_var_128
                38      LOAD_GLOBAL                     0: np
                40      LOAD_METHOD                     2: where
                42      LOAD_FAST                       4: _var_var_128
                44      LOAD_CONST                      5: 273
                46      COMPARE_OP                      5 (>=)
                48      LOAD_CONST                      6: 1
                50      LOAD_FAST                       4: _var_var_128
                52      LOAD_CONST                      7: 647.096
                54      BINARY_TRUE_DIVIDE              
                56      BINARY_SUBTRACT                 
                58      LOAD_CONST                      8: 0
                60      CALL_METHOD                     3
                62      STORE_FAST                      5: _var_var_129
                64      LOAD_FAST                       5: _var_var_129
                66      LOAD_CONST                      9: -7.85952
                68      BINARY_MULTIPLY                 
                70      LOAD_FAST                       5: _var_var_129
                72      LOAD_CONST                      10: 1.5
                74      BINARY_POWER                    
                76      LOAD_CONST                      11: 1.84408
                78      BINARY_MULTIPLY                 
                80      BINARY_ADD                      
                82      LOAD_FAST                       5: _var_var_129
                84      LOAD_CONST                      12: 3
                86      BINARY_POWER                    
                88      LOAD_CONST                      13: -11.7866
                90      BINARY_MULTIPLY                 
                92      BINARY_ADD                      
                94      LOAD_FAST                       5: _var_var_129
                96      LOAD_CONST                      14: 3.5
                98      BINARY_POWER                    
                100     LOAD_CONST                      15: 22.6807
                102     BINARY_MULTIPLY                 
                104     BINARY_ADD                      
                106     LOAD_FAST                       5: _var_var_129
                108     LOAD_CONST                      16: 4
                110     BINARY_POWER                    
                112     LOAD_CONST                      17: -15.9619
                114     BINARY_MULTIPLY                 
                116     BINARY_ADD                      
                118     LOAD_FAST                       5: _var_var_129
                120     LOAD_CONST                      18: 7.5
                122     BINARY_POWER                    
                124     LOAD_CONST                      19: 1.80123
                126     BINARY_MULTIPLY                 
                128     BINARY_ADD                      
                130     STORE_FAST                      6: _var_var_130
                132     LOAD_CONST                      7: 647.096
                134     LOAD_FAST                       4: _var_var_128
                136     BINARY_TRUE_DIVIDE              
                138     STORE_FAST                      7: _var_var_131
                140     LOAD_FAST                       7: _var_var_131
                142     LOAD_FAST                       6: _var_var_130
                144     BINARY_MULTIPLY                 
                146     STORE_FAST                      8: _var_var_132
                148     LOAD_GLOBAL                     0: np
                150     LOAD_METHOD                     3: exp
                152     LOAD_FAST                       8: _var_var_132
                154     CALL_METHOD                     1
                156     STORE_FAST                      9: _var_var_133
                158     LOAD_GLOBAL                     0: np
                160     LOAD_METHOD                     2: where
                162     LOAD_FAST                       9: _var_var_133
                164     LOAD_CONST                      6: 1
                166     COMPARE_OP                      3 (!=)
                168     LOAD_FAST                       9: _var_var_133
                170     LOAD_CONST                      20: 22064000
                172     BINARY_MULTIPLY                 
                174     LOAD_CONST                      8: 0
                176     CALL_METHOD                     3
                178     STORE_FAST                      10: _var_var_134
                180     LOAD_GLOBAL                     0: np
                182     LOAD_METHOD                     2: where
                184     LOAD_FAST                       4: _var_var_128
                186     LOAD_CONST                      5: 273
                188     COMPARE_OP                      0 (<)
                190     LOAD_FAST                       4: _var_var_128
                192     LOAD_CONST                      21: 273.16
                194     BINARY_TRUE_DIVIDE              
                196     LOAD_CONST                      6: 1
                198     CALL_METHOD                     3
                200     STORE_FAST                      11: _var_var_135
                202     LOAD_CONST                      6: 1
                204     LOAD_FAST                       11: _var_var_135
                206     LOAD_CONST                      22: -1.5
                208     BINARY_POWER                    
                210     BINARY_SUBTRACT                 
                212     LOAD_CONST                      23: -13.9282
                214     BINARY_MULTIPLY                 
                216     LOAD_CONST                      6: 1
                218     LOAD_FAST                       11: _var_var_135
                220     LOAD_CONST                      24: -1.25
                222     BINARY_POWER                    
                224     BINARY_SUBTRACT                 
                226     LOAD_CONST                      25: 34.7078
                228     BINARY_MULTIPLY                 
                230     BINARY_ADD                      
                232     STORE_FAST                      12: _var_var_136
                234     LOAD_GLOBAL                     0: np
                236     LOAD_METHOD                     3: exp
                238     LOAD_FAST                       12: _var_var_136
                240     CALL_METHOD                     1
                242     STORE_FAST                      9: _var_var_133
                244     LOAD_GLOBAL                     0: np
                246     LOAD_METHOD                     2: where
                248     LOAD_FAST                       9: _var_var_133
                250     LOAD_CONST                      6: 1
                252     COMPARE_OP                      3 (!=)
                254     LOAD_FAST                       9: _var_var_133
                256     LOAD_CONST                      26: 611.657
                258     BINARY_MULTIPLY                 
                260     LOAD_CONST                      8: 0
                262     CALL_METHOD                     3
                264     STORE_FAST                      13: _var_var_137
                266     LOAD_FAST                       10: _var_var_134
                268     LOAD_FAST                       13: _var_var_137
                270     BINARY_ADD                      
                272     STORE_FAST                      14: _var_var_138
                274     LOAD_FAST                       1: relHumid
                276     LOAD_CONST                      27: 0.01
                278     BINARY_MULTIPLY                 
                280     LOAD_FAST                       14: _var_var_138
                282     BINARY_MULTIPLY                 
                284     STORE_FAST                      15: _var_var_139
                286     LOAD_FAST                       2: barPress
                288     LOAD_FAST                       15: _var_var_139
                290     BINARY_SUBTRACT                 
                292     STORE_FAST                      16: _var_var_140
                294     LOAD_CONST                      28: 0.621991
                296     LOAD_FAST                       15: _var_var_139
                298     BINARY_MULTIPLY                 
                300     LOAD_FAST                       16: _var_var_140
                302     BINARY_TRUE_DIVIDE              
                304     STORE_FAST                      17: _var_var_141
                306     LOAD_CONST                      29: 1.01
                308     LOAD_CONST                      30: 1.89
                310     LOAD_FAST                       17: _var_var_141
                312     BINARY_MULTIPLY                 
                314     BINARY_ADD                      
                316     STORE_FAST                      18: _var_var_142
                318     LOAD_FAST                       18: _var_var_142
                320     LOAD_FAST                       0: airTemp
                322     BINARY_MULTIPLY                 
                324     STORE_FAST                      19: _var_var_143
                326     LOAD_CONST                      31: 2500
                328     LOAD_FAST                       17: _var_var_141
                330     BINARY_MULTIPLY                 
                332     STORE_FAST                      20: _var_var_144
                334     LOAD_FAST                       19: _var_var_143
                336     LOAD_FAST                       20: _var_var_144
                338     BINARY_ADD                      
                340     STORE_FAST                      21: _var_var_145
                342     LOAD_GLOBAL                     0: np
                344     LOAD_METHOD                     4: maximum
                346     LOAD_FAST                       21: _var_var_145
                348     LOAD_CONST                      8: 0
                350     CALL_METHOD                     2
                352     STORE_FAST                      22: _var_var_146
                354     LOAD_FAST                       17: _var_var_141
                356     LOAD_FAST                       22: _var_var_146
                358     LOAD_FAST                       15: _var_var_139
                360     LOAD_FAST                       14: _var_var_138
                362     BUILD_TUPLE                     4
                364     POP_BLOCK                       
                366     LOAD_CONST                      32: '__pyarmor_exit_47489__'
                368     NOP                             
                370     NOP                             
                372     LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14Z\x01\x00\x00\x00\x00\x00\x00'
                374     CALL_FUNCTION                   1
                376     POP_TOP                         
                378     RETURN_VALUE                    
                380     LOAD_CONST                      32: '__pyarmor_exit_47489__'
                382     NOP                             
                384     NOP                             
                386     LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14Z\x01\x00\x00\x00\x00\x00\x00'
                388     CALL_FUNCTION                   1
                390     POP_TOP                         
                392     RERAISE                         
                394     LOAD_CONST                      0: None
                396     RETURN_VALUE                    
        'calcHumidRatio'
        '__pyarmor_exit_47468__'
    [Disassembly]
        0       LOAD_CONST                      0: '\nOptimized version of the CBE Comfort tool comfort models.\n'
        2       STORE_NAME                      0: __doc__
        4       NOP                             
        6       NOP                             
        8       NOP                             
        10      NOP                             
        12      LOAD_CONST                      3: '__pyarmor_enter_47467__'
        14      NOP                             
        16      NOP                             
        18      LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x184\x00\x00\x00\x00\x00\x00\x00'
        20      CALL_FUNCTION                   1
        22      POP_TOP                         
        24      SETUP_FINALLY                   64 (to 90)
        26      LOAD_CONST                      5: 0
        28      LOAD_CONST                      6: None
        30      IMPORT_NAME                     2: numpy
        32      STORE_NAME                      3: np
        34      LOAD_CONST                      7: <CODE> findSaturatedVaporPressureTorr
        36      LOAD_CONST                      8: 'findSaturatedVaporPressureTorr'
        38      MAKE_FUNCTION                   0
        40      STORE_NAME                      4: findSaturatedVaporPressureTorr
        42      LOAD_CONST                      9: <CODE> comfPMVElevatedAirspeed
        44      LOAD_CONST                      10: 'comfPMVElevatedAirspeed'
        46      MAKE_FUNCTION                   0
        48      STORE_NAME                      5: comfPMVElevatedAirspeed
        50      LOAD_CONST                      11: <CODE> comfPMV
        52      LOAD_CONST                      12: 'comfPMV'
        54      MAKE_FUNCTION                   0
        56      STORE_NAME                      6: comfPMV
        58      LOAD_CONST                      13: <CODE> comfPierceSET
        60      LOAD_CONST                      14: 'comfPierceSET'
        62      MAKE_FUNCTION                   0
        64      STORE_NAME                      7: comfPierceSET
        66      LOAD_CONST                      15: <CODE> calcHumidRatio
        68      LOAD_CONST                      16: 'calcHumidRatio'
        70      MAKE_FUNCTION                   0
        72      STORE_NAME                      8: calcHumidRatio
        74      POP_BLOCK                       
        76      LOAD_CONST                      17: '__pyarmor_exit_47468__'
        78      NOP                             
        80      NOP                             
        82      LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x184\x00\x00\x00\x00\x00\x00\x00'
        84      CALL_FUNCTION                   1
        86      POP_TOP                         
        88      JUMP_FORWARD                    14 (to 104)
        90      LOAD_CONST                      17: '__pyarmor_exit_47468__'
        92      NOP                             
        94      NOP                             
        96      LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x184\x00\x00\x00\x00\x00\x00\x00'
        98      CALL_FUNCTION                   1
        100     POP_TOP                         
        102     RERAISE                         
        104     LOAD_CONST                      6: None
        106     RETURN_VALUE                    
