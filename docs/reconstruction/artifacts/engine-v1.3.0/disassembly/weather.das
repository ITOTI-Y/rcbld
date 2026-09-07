[Code]
    File Name: <frozen weather>
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
        'csv'
        'collections'
        'lib'
        'numpy'
        'np'
        'pandas'
        'pd'
        'sigma'
        'area'
        'esc'
        'r_g'
        'Weather'
    [Var Names]
    [Free Vars]
    [Cell Vars]
    [Constants]
        '__pyarmor_assert_47490__'
        '<lambda>'
        '__pyarmor_enter_47491__'
        b'<COAddr>\x01\x00\x00\x14R\x00\x00\x00\x00\x00\x00\x00'
        0
        None
        90
        1
        1367
        0.14
        [Code]
            File Name: <frozen weather>
            Object Name: Weather
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
                'getWeather'
                'cal_Ydate'
                'cal_tao'
                'cal_ET'
                'cal_AST'
                'cal_solarDegree'
                'cal_azimuth'
                'cal_surface'
                'cal_mmv'
                'cal_SRF'
                'cal_Esol'
                'getCalDict'
                'getWeaDict'
            [Var Names]
            [Free Vars]
            [Cell Vars]
            [Constants]
                'Weather'
                '__pyarmor_assert_47493__'
                'Weather.<lambda>'
                '__pyarmor_enter_47494__'
                b'<COAddr>\x03\x00\x00\x1ct\x00\x00\x00\x00\x00\x00\x00'
                [Code]
                    File Name: <frozen weather>
                    Object Name: __init__
                    Arg Count: 2
                    Pos Only Arg Count: 0
                    KW Only Arg Count: 0
                    Locals: 6
                    Stack Size: 8
                    Flags: 0x2000004B (CO_OPTIMIZED | CO_NEWLOCALS | CO_VARKEYWORDS | CO_NOFREE | CO_PYARMOR_OBFUSCATED)
                    [Names]
                        'wea_file'
                        'cal_dict'
                        'items'
                        'setattr'
                        'replace'
                        'getWeather'
                    [Var Names]
                        'self'
                        'wea_file'
                        'kwargs'
                        '__assert_armored__'
                        '_var_var_0'
                        '_var_var_1'
                    [Free Vars]
                    [Cell Vars]
                    [Constants]
                        None
                        '__pyarmor_assert_47496__'
                        'Weather.__init__.<locals>.<lambda>'
                        '__pyarmor_enter_47497__'
                        b'<COAddr>\x03\x00\x00\x14>\x00\x00\x00\x00\x00\x00\x00'
                        ' '
                        '_'
                        '__pyarmor_exit_47498__'
                    [Disassembly]
                        0       NOP                             
                        2       NOP                             
                        4       NOP                             
                        6       NOP                             
                        8       LOAD_CONST                      3: '__pyarmor_enter_47497__'
                        10      NOP                             
                        12      NOP                             
                        14      LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x14>\x00\x00\x00\x00\x00\x00\x00'
                        16      CALL_FUNCTION                   1
                        18      POP_TOP                         
                        20      SETUP_FINALLY                   74 (to 96)
                        22      LOAD_FAST                       1: wea_file
                        24      LOAD_FAST                       0: self
                        26      STORE_ATTR                      0: wea_file
                        28      BUILD_MAP                       0
                        30      LOAD_FAST                       0: self
                        32      STORE_ATTR                      1: cal_dict
                        34      LOAD_FAST                       2: kwargs
                        36      LOAD_METHOD                     2: items
                        38      CALL_METHOD                     0
                        40      GET_ITER                        
                        42      FOR_ITER                        28 (to 72)
                        44      UNPACK_SEQUENCE                 2
                        46      STORE_FAST                      4: _var_var_0
                        48      STORE_FAST                      5: _var_var_1
                        50      LOAD_GLOBAL                     3: setattr
                        52      LOAD_FAST                       0: self
                        54      LOAD_FAST                       4: _var_var_0
                        56      LOAD_METHOD                     4: replace
                        58      LOAD_CONST                      5: ' '
                        60      LOAD_CONST                      6: '_'
                        62      CALL_METHOD                     2
                        64      LOAD_FAST                       5: _var_var_1
                        66      CALL_FUNCTION                   3
                        68      POP_TOP                         
                        70      JUMP_ABSOLUTE                   42
                        72      LOAD_FAST                       0: self
                        74      LOAD_METHOD                     5: getWeather
                        76      CALL_METHOD                     0
                        78      POP_TOP                         
                        80      POP_BLOCK                       
                        82      LOAD_CONST                      7: '__pyarmor_exit_47498__'
                        84      NOP                             
                        86      NOP                             
                        88      LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x14>\x00\x00\x00\x00\x00\x00\x00'
                        90      CALL_FUNCTION                   1
                        92      POP_TOP                         
                        94      JUMP_FORWARD                    14 (to 110)
                        96      LOAD_CONST                      7: '__pyarmor_exit_47498__'
                        98      NOP                             
                        100     NOP                             
                        102     LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x14>\x00\x00\x00\x00\x00\x00\x00'
                        104     CALL_FUNCTION                   1
                        106     POP_TOP                         
                        108     RERAISE                         
                        110     LOAD_CONST                      0: None
                        112     RETURN_VALUE                    
                'Weather.__init__'
                [Code]
                    File Name: <frozen weather>
                    Object Name: getWeather
                    Arg Count: 1
                    Pos Only Arg Count: 0
                    KW Only Arg Count: 0
                    Locals: 8
                    Stack Size: 8
                    Flags: 0x20000043 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NOFREE | CO_PYARMOR_OBFUSCATED)
                    [Names]
                        'open'
                        'wea_file'
                        'csv'
                        'reader'
                        'list'
                        'float'
                        'latitude'
                        'longitude'
                        'time_zone'
                        'LSM'
                        'pd'
                        'read_csv'
                        'values'
                        'location'
                        'iloc'
                        'wea_dict'
                    [Var Names]
                        'self'
                        '__assert_armored__'
                        '_var_var_2'
                        '_var_var_3'
                        '_var_var_4'
                        '_var_var_5'
                        '_var_var_6'
                        '_var_var_7'
                    [Free Vars]
                    [Cell Vars]
                    [Constants]
                        None
                        '__pyarmor_assert_47499__'
                        'Weather.getWeather.<locals>.<lambda>'
                        '__pyarmor_enter_47500__'
                        b'<COAddr>\x01\x00\x00\x14\xe0\x02\x00\x00\x00\x00\x00\x00'
                        'r'
                        0
                        -1
                        ''
                        1
                        2
                        15
                        (
                            'skiprows'
                        )
                        'Temperature'
                        'DBT'
                        'Relative Humidity'
                        'RH'
                        'DNI'
                        'Eb'
                        'Wind Speed'
                        'wind'
                        'GHI'
                        'Egh'
                        'Month'
                        'month'
                        'Day'
                        'day'
                        'Hour'
                        'hour'
                        'DHI'
                        'Ed'
                        'Pressure'
                        'pressure'
                        'HIR'
                        'Year'
                        'year'
                        -4
                        -3
                        -2
                        8
                        (
                            'skiprows'
                            'header'
                        )
                        6
                        14
                        21
                        13
                        3
                        9
                        12
                        5.6697e-08
                        0.25
                        273.15
                        'T_er'
                        '__pyarmor_exit_47501__'
                    [Disassembly]
                        0       NOP                             
                        2       NOP                             
                        4       NOP                             
                        6       NOP                             
                        8       LOAD_CONST                      3: '__pyarmor_enter_47500__'
                        10      NOP                             
                        12      NOP                             
                        14      LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14\xe0\x02\x00\x00\x00\x00\x00\x00'
                        16      CALL_FUNCTION                   1
                        18      POP_TOP                         
                        20      SETUP_FINALLY                   746 (to 770)
                        24      BUILD_MAP                       0
                        26      STORE_FAST                      2: _var_var_2
                        28      LOAD_GLOBAL                     0: open
                        30      LOAD_FAST                       0: self
                        32      LOAD_ATTR                       1: wea_file
                        34      LOAD_CONST                      5: 'r'
                        36      CALL_FUNCTION                   2
                        38      SETUP_WITH                      42 (to 82)
                        40      STORE_FAST                      3: _var_var_3
                        42      LOAD_GLOBAL                     2: csv
                        44      LOAD_METHOD                     3: reader
                        46      LOAD_FAST                       3: _var_var_3
                        48      CALL_METHOD                     1
                        50      STORE_FAST                      4: _var_var_4
                        52      LOAD_GLOBAL                     4: list
                        54      LOAD_FAST                       4: _var_var_4
                        56      CALL_FUNCTION                   1
                        58      STORE_FAST                      4: _var_var_4
                        60      LOAD_FAST                       4: _var_var_4
                        62      LOAD_CONST                      6: 0
                        64      BINARY_SUBSCR                   
                        66      STORE_FAST                      5: _var_var_5
                        68      POP_BLOCK                       
                        70      LOAD_CONST                      0: None
                        72      DUP_TOP                         
                        74      DUP_TOP                         
                        76      CALL_FUNCTION                   3
                        78      POP_TOP                         
                        80      JUMP_FORWARD                    16 (to 98)
                        82      WITH_EXCEPT_START               
                        84      POP_JUMP_IF_TRUE                88
                        86      RERAISE                         
                        88      POP_TOP                         
                        90      POP_TOP                         
                        92      POP_TOP                         
                        94      POP_EXCEPT                      
                        96      POP_TOP                         
                        98      LOAD_FAST                       5: _var_var_5
                        100     LOAD_CONST                      7: -1
                        102     BINARY_SUBSCR                   
                        104     LOAD_CONST                      8: ''
                        106     COMPARE_OP                      2 (==)
                        108     POP_JUMP_IF_FALSE               354
                        112     LOAD_GLOBAL                     5: float
                        114     LOAD_FAST                       5: _var_var_5
                        116     LOAD_CONST                      6: 0
                        118     BINARY_SUBSCR                   
                        120     CALL_FUNCTION                   1
                        122     LOAD_FAST                       0: self
                        124     STORE_ATTR                      6: latitude
                        126     LOAD_GLOBAL                     5: float
                        128     LOAD_FAST                       5: _var_var_5
                        130     LOAD_CONST                      9: 1
                        132     BINARY_SUBSCR                   
                        134     CALL_FUNCTION                   1
                        136     LOAD_FAST                       0: self
                        138     STORE_ATTR                      7: longitude
                        140     LOAD_GLOBAL                     5: float
                        142     LOAD_FAST                       5: _var_var_5
                        144     LOAD_CONST                      10: 2
                        146     BINARY_SUBSCR                   
                        148     CALL_FUNCTION                   1
                        150     LOAD_FAST                       0: self
                        152     STORE_ATTR                      8: time_zone
                        154     LOAD_CONST                      11: 15
                        156     LOAD_FAST                       0: self
                        158     LOAD_ATTR                       8: time_zone
                        160     BINARY_MULTIPLY                 
                        162     LOAD_FAST                       0: self
                        164     STORE_ATTR                      9: LSM
                        166     LOAD_GLOBAL                     10: pd
                        168     LOAD_ATTR                       11: read_csv
                        170     LOAD_FAST                       0: self
                        172     LOAD_ATTR                       1: wea_file
                        174     LOAD_CONST                      9: 1
                        176     LOAD_CONST                      12: ('skiprows',)
                        178     CALL_FUNCTION_KW                2
                        180     STORE_FAST                      6: _var_var_6
                        182     LOAD_FAST                       6: _var_var_6
                        184     LOAD_CONST                      13: 'Temperature'
                        186     BINARY_SUBSCR                   
                        188     LOAD_ATTR                       12: values
                        190     LOAD_FAST                       2: _var_var_2
                        192     LOAD_CONST                      14: 'DBT'
                        194     STORE_SUBSCR                    
                        196     LOAD_FAST                       6: _var_var_6
                        198     LOAD_CONST                      15: 'Relative Humidity'
                        200     BINARY_SUBSCR                   
                        202     LOAD_ATTR                       12: values
                        204     LOAD_FAST                       2: _var_var_2
                        206     LOAD_CONST                      16: 'RH'
                        208     STORE_SUBSCR                    
                        210     LOAD_FAST                       6: _var_var_6
                        212     LOAD_CONST                      17: 'DNI'
                        214     BINARY_SUBSCR                   
                        216     LOAD_ATTR                       12: values
                        218     LOAD_FAST                       2: _var_var_2
                        220     LOAD_CONST                      18: 'Eb'
                        222     STORE_SUBSCR                    
                        224     LOAD_FAST                       6: _var_var_6
                        226     LOAD_CONST                      19: 'Wind Speed'
                        228     BINARY_SUBSCR                   
                        230     LOAD_ATTR                       12: values
                        232     LOAD_FAST                       2: _var_var_2
                        234     LOAD_CONST                      20: 'wind'
                        236     STORE_SUBSCR                    
                        238     LOAD_FAST                       6: _var_var_6
                        240     LOAD_CONST                      21: 'GHI'
                        242     BINARY_SUBSCR                   
                        244     LOAD_ATTR                       12: values
                        246     LOAD_FAST                       2: _var_var_2
                        248     LOAD_CONST                      22: 'Egh'
                        250     STORE_SUBSCR                    
                        252     LOAD_FAST                       6: _var_var_6
                        254     LOAD_CONST                      23: 'Month'
                        256     BINARY_SUBSCR                   
                        258     LOAD_ATTR                       12: values
                        260     LOAD_FAST                       2: _var_var_2
                        262     LOAD_CONST                      24: 'month'
                        264     STORE_SUBSCR                    
                        266     LOAD_FAST                       6: _var_var_6
                        268     LOAD_CONST                      25: 'Day'
                        270     BINARY_SUBSCR                   
                        272     LOAD_ATTR                       12: values
                        274     LOAD_FAST                       2: _var_var_2
                        276     LOAD_CONST                      26: 'day'
                        278     STORE_SUBSCR                    
                        280     LOAD_FAST                       6: _var_var_6
                        282     LOAD_CONST                      27: 'Hour'
                        284     BINARY_SUBSCR                   
                        286     LOAD_ATTR                       12: values
                        288     LOAD_FAST                       2: _var_var_2
                        290     LOAD_CONST                      28: 'hour'
                        292     STORE_SUBSCR                    
                        294     LOAD_FAST                       6: _var_var_6
                        296     LOAD_CONST                      29: 'DHI'
                        298     BINARY_SUBSCR                   
                        300     LOAD_ATTR                       12: values
                        302     LOAD_FAST                       2: _var_var_2
                        304     LOAD_CONST                      30: 'Ed'
                        306     STORE_SUBSCR                    
                        308     LOAD_FAST                       6: _var_var_6
                        310     LOAD_CONST                      31: 'Pressure'
                        312     BINARY_SUBSCR                   
                        314     LOAD_ATTR                       12: values
                        316     LOAD_FAST                       2: _var_var_2
                        318     LOAD_CONST                      32: 'pressure'
                        320     STORE_SUBSCR                    
                        322     LOAD_FAST                       6: _var_var_6
                        324     LOAD_CONST                      33: 'HIR'
                        326     BINARY_SUBSCR                   
                        328     LOAD_ATTR                       12: values
                        330     LOAD_FAST                       2: _var_var_2
                        332     LOAD_CONST                      33: 'HIR'
                        334     STORE_SUBSCR                    
                        336     LOAD_FAST                       6: _var_var_6
                        338     LOAD_CONST                      34: 'Year'
                        340     BINARY_SUBSCR                   
                        342     LOAD_ATTR                       12: values
                        344     LOAD_FAST                       2: _var_var_2
                        346     LOAD_CONST                      35: 'year'
                        348     STORE_SUBSCR                    
                        350     JUMP_FORWARD                    370 (to 724)
                        354     LOAD_FAST                       5: _var_var_5
                        356     LOAD_CONST                      9: 1
                        358     BINARY_SUBSCR                   
                        360     LOAD_FAST                       0: self
                        362     STORE_ATTR                      13: location
                        364     LOAD_GLOBAL                     5: float
                        366     LOAD_FAST                       5: _var_var_5
                        368     LOAD_CONST                      36: -4
                        370     BINARY_SUBSCR                   
                        372     CALL_FUNCTION                   1
                        374     LOAD_FAST                       0: self
                        376     STORE_ATTR                      6: latitude
                        378     LOAD_GLOBAL                     5: float
                        380     LOAD_FAST                       5: _var_var_5
                        382     LOAD_CONST                      37: -3
                        384     BINARY_SUBSCR                   
                        386     CALL_FUNCTION                   1
                        388     LOAD_FAST                       0: self
                        390     STORE_ATTR                      7: longitude
                        392     LOAD_GLOBAL                     5: float
                        394     LOAD_FAST                       5: _var_var_5
                        396     LOAD_CONST                      38: -2
                        398     BINARY_SUBSCR                   
                        400     CALL_FUNCTION                   1
                        402     LOAD_FAST                       0: self
                        404     STORE_ATTR                      8: time_zone
                        406     LOAD_CONST                      11: 15
                        408     LOAD_FAST                       0: self
                        410     LOAD_ATTR                       8: time_zone
                        412     BINARY_MULTIPLY                 
                        414     LOAD_FAST                       0: self
                        416     STORE_ATTR                      9: LSM
                        418     LOAD_GLOBAL                     10: pd
                        420     LOAD_ATTR                       11: read_csv
                        422     LOAD_FAST                       0: self
                        424     LOAD_ATTR                       1: wea_file
                        426     LOAD_CONST                      39: 8
                        428     LOAD_CONST                      0: None
                        430     LOAD_CONST                      40: ('skiprows', 'header')
                        432     CALL_FUNCTION_KW                3
                        434     STORE_FAST                      7: _var_var_7
                        436     LOAD_FAST                       7: _var_var_7
                        438     LOAD_ATTR                       14: iloc
                        440     LOAD_CONST                      0: None
                        442     LOAD_CONST                      0: None
                        444     BUILD_SLICE                     2
                        446     LOAD_CONST                      41: 6
                        448     BUILD_TUPLE                     2
                        450     BINARY_SUBSCR                   
                        452     LOAD_ATTR                       12: values
                        454     LOAD_FAST                       2: _var_var_2
                        456     LOAD_CONST                      14: 'DBT'
                        458     STORE_SUBSCR                    
                        460     LOAD_FAST                       7: _var_var_7
                        462     LOAD_ATTR                       14: iloc
                        464     LOAD_CONST                      0: None
                        466     LOAD_CONST                      0: None
                        468     BUILD_SLICE                     2
                        470     LOAD_CONST                      39: 8
                        472     BUILD_TUPLE                     2
                        474     BINARY_SUBSCR                   
                        476     LOAD_ATTR                       12: values
                        478     LOAD_FAST                       2: _var_var_2
                        480     LOAD_CONST                      16: 'RH'
                        482     STORE_SUBSCR                    
                        484     LOAD_FAST                       7: _var_var_7
                        486     LOAD_ATTR                       14: iloc
                        488     LOAD_CONST                      0: None
                        490     LOAD_CONST                      0: None
                        492     BUILD_SLICE                     2
                        494     LOAD_CONST                      42: 14
                        496     BUILD_TUPLE                     2
                        498     BINARY_SUBSCR                   
                        500     LOAD_ATTR                       12: values
                        502     LOAD_FAST                       2: _var_var_2
                        504     LOAD_CONST                      18: 'Eb'
                        506     STORE_SUBSCR                    
                        508     LOAD_FAST                       7: _var_var_7
                        510     LOAD_ATTR                       14: iloc
                        512     LOAD_CONST                      0: None
                        514     LOAD_CONST                      0: None
                        516     BUILD_SLICE                     2
                        518     LOAD_CONST                      43: 21
                        520     BUILD_TUPLE                     2
                        522     BINARY_SUBSCR                   
                        524     LOAD_ATTR                       12: values
                        526     LOAD_FAST                       2: _var_var_2
                        528     LOAD_CONST                      20: 'wind'
                        530     STORE_SUBSCR                    
                        532     LOAD_FAST                       7: _var_var_7
                        534     LOAD_ATTR                       14: iloc
                        536     LOAD_CONST                      0: None
                        538     LOAD_CONST                      0: None
                        540     BUILD_SLICE                     2
                        542     LOAD_CONST                      44: 13
                        544     BUILD_TUPLE                     2
                        546     BINARY_SUBSCR                   
                        548     LOAD_ATTR                       12: values
                        550     LOAD_FAST                       2: _var_var_2
                        552     LOAD_CONST                      22: 'Egh'
                        554     STORE_SUBSCR                    
                        556     LOAD_FAST                       7: _var_var_7
                        558     LOAD_ATTR                       14: iloc
                        560     LOAD_CONST                      0: None
                        562     LOAD_CONST                      0: None
                        564     BUILD_SLICE                     2
                        566     LOAD_CONST                      9: 1
                        568     BUILD_TUPLE                     2
                        570     BINARY_SUBSCR                   
                        572     LOAD_ATTR                       12: values
                        574     LOAD_FAST                       2: _var_var_2
                        576     LOAD_CONST                      24: 'month'
                        578     STORE_SUBSCR                    
                        580     LOAD_FAST                       7: _var_var_7
                        582     LOAD_ATTR                       14: iloc
                        584     LOAD_CONST                      0: None
                        586     LOAD_CONST                      0: None
                        588     BUILD_SLICE                     2
                        590     LOAD_CONST                      10: 2
                        592     BUILD_TUPLE                     2
                        594     BINARY_SUBSCR                   
                        596     LOAD_ATTR                       12: values
                        598     LOAD_FAST                       2: _var_var_2
                        600     LOAD_CONST                      26: 'day'
                        602     STORE_SUBSCR                    
                        604     LOAD_FAST                       7: _var_var_7
                        606     LOAD_ATTR                       14: iloc
                        608     LOAD_CONST                      0: None
                        610     LOAD_CONST                      0: None
                        612     BUILD_SLICE                     2
                        614     LOAD_CONST                      45: 3
                        616     BUILD_TUPLE                     2
                        618     BINARY_SUBSCR                   
                        620     LOAD_ATTR                       12: values
                        622     LOAD_FAST                       2: _var_var_2
                        624     LOAD_CONST                      28: 'hour'
                        626     STORE_SUBSCR                    
                        628     LOAD_FAST                       7: _var_var_7
                        630     LOAD_ATTR                       14: iloc
                        632     LOAD_CONST                      0: None
                        634     LOAD_CONST                      0: None
                        636     BUILD_SLICE                     2
                        638     LOAD_CONST                      11: 15
                        640     BUILD_TUPLE                     2
                        642     BINARY_SUBSCR                   
                        644     LOAD_ATTR                       12: values
                        646     LOAD_FAST                       2: _var_var_2
                        648     LOAD_CONST                      30: 'Ed'
                        650     STORE_SUBSCR                    
                        652     LOAD_FAST                       7: _var_var_7
                        654     LOAD_ATTR                       14: iloc
                        656     LOAD_CONST                      0: None
                        658     LOAD_CONST                      0: None
                        660     BUILD_SLICE                     2
                        662     LOAD_CONST                      46: 9
                        664     BUILD_TUPLE                     2
                        666     BINARY_SUBSCR                   
                        668     LOAD_ATTR                       12: values
                        670     LOAD_FAST                       2: _var_var_2
                        672     LOAD_CONST                      32: 'pressure'
                        674     STORE_SUBSCR                    
                        676     LOAD_FAST                       7: _var_var_7
                        678     LOAD_ATTR                       14: iloc
                        680     LOAD_CONST                      0: None
                        682     LOAD_CONST                      0: None
                        684     BUILD_SLICE                     2
                        686     LOAD_CONST                      47: 12
                        688     BUILD_TUPLE                     2
                        690     BINARY_SUBSCR                   
                        692     LOAD_ATTR                       12: values
                        694     LOAD_FAST                       2: _var_var_2
                        696     LOAD_CONST                      33: 'HIR'
                        698     STORE_SUBSCR                    
                        700     LOAD_FAST                       7: _var_var_7
                        702     LOAD_ATTR                       14: iloc
                        704     LOAD_CONST                      0: None
                        706     LOAD_CONST                      0: None
                        708     BUILD_SLICE                     2
                        710     LOAD_CONST                      6: 0
                        712     BUILD_TUPLE                     2
                        714     BINARY_SUBSCR                   
                        716     LOAD_ATTR                       12: values
                        718     LOAD_FAST                       2: _var_var_2
                        720     LOAD_CONST                      35: 'year'
                        722     STORE_SUBSCR                    
                        724     LOAD_FAST                       2: _var_var_2
                        726     LOAD_CONST                      33: 'HIR'
                        728     BINARY_SUBSCR                   
                        730     LOAD_CONST                      48: 5.6697e-08
                        732     BINARY_TRUE_DIVIDE              
                        734     LOAD_CONST                      49: 0.25
                        736     BINARY_POWER                    
                        738     LOAD_CONST                      50: 273.15
                        740     BINARY_SUBTRACT                 
                        742     LOAD_FAST                       2: _var_var_2
                        744     LOAD_CONST                      51: 'T_er'
                        746     STORE_SUBSCR                    
                        748     LOAD_FAST                       2: _var_var_2
                        750     LOAD_FAST                       0: self
                        752     STORE_ATTR                      15: wea_dict
                        754     POP_BLOCK                       
                        756     LOAD_CONST                      52: '__pyarmor_exit_47501__'
                        758     NOP                             
                        760     NOP                             
                        762     LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14\xe0\x02\x00\x00\x00\x00\x00\x00'
                        764     CALL_FUNCTION                   1
                        766     POP_TOP                         
                        768     JUMP_FORWARD                    14 (to 784)
                        770     LOAD_CONST                      52: '__pyarmor_exit_47501__'
                        772     NOP                             
                        774     NOP                             
                        776     LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14\xe0\x02\x00\x00\x00\x00\x00\x00'
                        778     CALL_FUNCTION                   1
                        780     POP_TOP                         
                        782     RERAISE                         
                        784     LOAD_CONST                      0: None
                        786     RETURN_VALUE                    
                'Weather.getWeather'
                [Code]
                    File Name: <frozen weather>
                    Object Name: cal_Ydate
                    Arg Count: 1
                    Pos Only Arg Count: 0
                    KW Only Arg Count: 0
                    Locals: 6
                    Stack Size: 8
                    Flags: 0x20000043 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NOFREE | CO_PYARMOR_OBFUSCATED)
                    [Names]
                        'wea_dict'
                        'range'
                        'len'
                        'append'
                        'np'
                        'array'
                        'cal_dict'
                    [Var Names]
                        'self'
                        '__assert_armored__'
                        '_var_var_8'
                        '_var_var_9'
                        '_var_var_10'
                        '_var_var_11'
                    [Free Vars]
                    [Cell Vars]
                    [Constants]
                        None
                        '__pyarmor_assert_47502__'
                        'Weather.cal_Ydate.<locals>.<lambda>'
                        '__pyarmor_enter_47503__'
                        b'<COAddr>\x03\x00\x00\x14\x94\x00\x00\x00\x00\x00\x00\x00'
                        'month'
                        'day'
                        1
                        'Ydate'
                        '__pyarmor_exit_47504__'
                    [Disassembly]
                        0       NOP                             
                        2       NOP                             
                        4       NOP                             
                        6       NOP                             
                        8       LOAD_CONST                      3: '__pyarmor_enter_47503__'
                        10      NOP                             
                        12      NOP                             
                        14      LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x14\x94\x00\x00\x00\x00\x00\x00\x00'
                        16      CALL_FUNCTION                   1
                        18      POP_TOP                         
                        20      SETUP_FINALLY                   160 (to 182)
                        22      LOAD_FAST                       0: self
                        24      LOAD_ATTR                       0: wea_dict
                        26      LOAD_CONST                      5: 'month'
                        28      BINARY_SUBSCR                   
                        30      STORE_FAST                      2: _var_var_8
                        32      LOAD_FAST                       0: self
                        34      LOAD_ATTR                       0: wea_dict
                        36      LOAD_CONST                      6: 'day'
                        38      BINARY_SUBSCR                   
                        40      STORE_FAST                      3: _var_var_9
                        42      LOAD_CONST                      7: 1
                        44      BUILD_LIST                      1
                        46      STORE_FAST                      4: _var_var_10
                        48      LOAD_GLOBAL                     1: range
                        50      LOAD_CONST                      7: 1
                        52      LOAD_GLOBAL                     2: len
                        54      LOAD_FAST                       3: _var_var_9
                        56      CALL_FUNCTION                   1
                        58      CALL_FUNCTION                   2
                        60      GET_ITER                        
                        62      FOR_ITER                        86 (to 150)
                        64      STORE_FAST                      5: _var_var_11
                        66      LOAD_FAST                       2: _var_var_8
                        68      LOAD_FAST                       5: _var_var_11
                        70      BINARY_SUBSCR                   
                        72      LOAD_FAST                       2: _var_var_8
                        74      LOAD_FAST                       5: _var_var_11
                        76      LOAD_CONST                      7: 1
                        78      BINARY_SUBTRACT                 
                        80      BINARY_SUBSCR                   
                        82      COMPARE_OP                      2 (==)
                        84      POP_JUMP_IF_FALSE               126
                        86      LOAD_FAST                       4: _var_var_10
                        88      LOAD_METHOD                     3: append
                        90      LOAD_FAST                       4: _var_var_10
                        92      LOAD_FAST                       5: _var_var_11
                        94      LOAD_CONST                      7: 1
                        96      BINARY_SUBTRACT                 
                        98      BINARY_SUBSCR                   
                        100     LOAD_FAST                       3: _var_var_9
                        102     LOAD_FAST                       5: _var_var_11
                        104     BINARY_SUBSCR                   
                        106     BINARY_ADD                      
                        108     LOAD_FAST                       3: _var_var_9
                        110     LOAD_FAST                       5: _var_var_11
                        112     LOAD_CONST                      7: 1
                        114     BINARY_SUBTRACT                 
                        116     BINARY_SUBSCR                   
                        118     BINARY_SUBTRACT                 
                        120     CALL_METHOD                     1
                        122     POP_TOP                         
                        124     JUMP_ABSOLUTE                   62
                        126     LOAD_FAST                       4: _var_var_10
                        128     LOAD_METHOD                     3: append
                        130     LOAD_FAST                       4: _var_var_10
                        132     LOAD_FAST                       5: _var_var_11
                        134     LOAD_CONST                      7: 1
                        136     BINARY_SUBTRACT                 
                        138     BINARY_SUBSCR                   
                        140     LOAD_CONST                      7: 1
                        142     BINARY_ADD                      
                        144     CALL_METHOD                     1
                        146     POP_TOP                         
                        148     JUMP_ABSOLUTE                   62
                        150     LOAD_GLOBAL                     4: np
                        152     LOAD_METHOD                     5: array
                        154     LOAD_FAST                       4: _var_var_10
                        156     CALL_METHOD                     1
                        158     LOAD_FAST                       0: self
                        160     LOAD_ATTR                       6: cal_dict
                        162     LOAD_CONST                      8: 'Ydate'
                        164     STORE_SUBSCR                    
                        166     POP_BLOCK                       
                        168     LOAD_CONST                      9: '__pyarmor_exit_47504__'
                        170     NOP                             
                        172     NOP                             
                        174     LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x14\x94\x00\x00\x00\x00\x00\x00\x00'
                        176     CALL_FUNCTION                   1
                        178     POP_TOP                         
                        180     JUMP_FORWARD                    14 (to 196)
                        182     LOAD_CONST                      9: '__pyarmor_exit_47504__'
                        184     NOP                             
                        186     NOP                             
                        188     LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x14\x94\x00\x00\x00\x00\x00\x00\x00'
                        190     CALL_FUNCTION                   1
                        192     POP_TOP                         
                        194     RERAISE                         
                        196     LOAD_CONST                      0: None
                        198     RETURN_VALUE                    
                'Weather.cal_Ydate'
                [Code]
                    File Name: <frozen weather>
                    Object Name: cal_tao
                    Arg Count: 1
                    Pos Only Arg Count: 0
                    KW Only Arg Count: 0
                    Locals: 3
                    Stack Size: 8
                    Flags: 0x20000043 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NOFREE | CO_PYARMOR_OBFUSCATED)
                    [Names]
                        'cal_dict'
                        'np'
                        'pi'
                    [Var Names]
                        'self'
                        '__assert_armored__'
                        '_var_var_10'
                    [Free Vars]
                    [Cell Vars]
                    [Constants]
                        None
                        '__pyarmor_assert_47505__'
                        'Weather.cal_tao.<locals>.<lambda>'
                        '__pyarmor_enter_47506__'
                        b'<COAddr>\x01\x00\x00\x14*\x00\x00\x00\x00\x00\x00\x00'
                        'Ydate'
                        2
                        1
                        365
                        'tao'
                        '__pyarmor_exit_47507__'
                    [Disassembly]
                        0       NOP                             
                        2       NOP                             
                        4       NOP                             
                        6       NOP                             
                        8       LOAD_CONST                      3: '__pyarmor_enter_47506__'
                        10      NOP                             
                        12      NOP                             
                        14      LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14*\x00\x00\x00\x00\x00\x00\x00'
                        16      CALL_FUNCTION                   1
                        18      POP_TOP                         
                        20      SETUP_FINALLY                   54 (to 76)
                        22      LOAD_FAST                       0: self
                        24      LOAD_ATTR                       0: cal_dict
                        26      LOAD_CONST                      5: 'Ydate'
                        28      BINARY_SUBSCR                   
                        30      STORE_FAST                      2: _var_var_10
                        32      LOAD_CONST                      6: 2
                        34      LOAD_GLOBAL                     1: np
                        36      LOAD_ATTR                       2: pi
                        38      BINARY_MULTIPLY                 
                        40      LOAD_FAST                       2: _var_var_10
                        42      LOAD_CONST                      7: 1
                        44      BINARY_SUBTRACT                 
                        46      BINARY_MULTIPLY                 
                        48      LOAD_CONST                      8: 365
                        50      BINARY_TRUE_DIVIDE              
                        52      LOAD_FAST                       0: self
                        54      LOAD_ATTR                       0: cal_dict
                        56      LOAD_CONST                      9: 'tao'
                        58      STORE_SUBSCR                    
                        60      POP_BLOCK                       
                        62      LOAD_CONST                      10: '__pyarmor_exit_47507__'
                        64      NOP                             
                        66      NOP                             
                        68      LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14*\x00\x00\x00\x00\x00\x00\x00'
                        70      CALL_FUNCTION                   1
                        72      POP_TOP                         
                        74      JUMP_FORWARD                    14 (to 90)
                        76      LOAD_CONST                      10: '__pyarmor_exit_47507__'
                        78      NOP                             
                        80      NOP                             
                        82      LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14*\x00\x00\x00\x00\x00\x00\x00'
                        84      CALL_FUNCTION                   1
                        86      POP_TOP                         
                        88      RERAISE                         
                        90      LOAD_CONST                      0: None
                        92      RETURN_VALUE                    
                'Weather.cal_tao'
                [Code]
                    File Name: <frozen weather>
                    Object Name: cal_ET
                    Arg Count: 1
                    Pos Only Arg Count: 0
                    KW Only Arg Count: 0
                    Locals: 3
                    Stack Size: 8
                    Flags: 0x20000043 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NOFREE | CO_PYARMOR_OBFUSCATED)
                    [Names]
                        'cal_dict'
                        'np'
                        'cos'
                        'sin'
                    [Var Names]
                        'self'
                        '__assert_armored__'
                        '_var_var_12'
                    [Free Vars]
                    [Cell Vars]
                    [Constants]
                        None
                        '__pyarmor_assert_47508__'
                        'Weather.cal_ET.<locals>.<lambda>'
                        '__pyarmor_enter_47509__'
                        b'<COAddr>\x03\x00\x00\x14\\\x00\x00\x00\x00\x00\x00\x00'
                        'tao'
                        2.2918
                        0.0075
                        0.1868
                        3.2077
                        1.4615
                        2
                        4.089
                        'ET'
                        '__pyarmor_exit_47510__'
                    [Disassembly]
                        0       NOP                             
                        2       NOP                             
                        4       NOP                             
                        6       NOP                             
                        8       LOAD_CONST                      3: '__pyarmor_enter_47509__'
                        10      NOP                             
                        12      NOP                             
                        14      LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x14\\\x00\x00\x00\x00\x00\x00\x00'
                        16      CALL_FUNCTION                   1
                        18      POP_TOP                         
                        20      SETUP_FINALLY                   104 (to 126)
                        22      LOAD_FAST                       0: self
                        24      LOAD_ATTR                       0: cal_dict
                        26      LOAD_CONST                      5: 'tao'
                        28      BINARY_SUBSCR                   
                        30      STORE_FAST                      2: _var_var_12
                        32      LOAD_CONST                      6: 2.2918
                        34      LOAD_CONST                      7: 0.0075
                        36      LOAD_CONST                      8: 0.1868
                        38      LOAD_GLOBAL                     1: np
                        40      LOAD_METHOD                     2: cos
                        42      LOAD_FAST                       2: _var_var_12
                        44      CALL_METHOD                     1
                        46      BINARY_MULTIPLY                 
                        48      BINARY_ADD                      
                        50      LOAD_CONST                      9: 3.2077
                        52      LOAD_GLOBAL                     1: np
                        54      LOAD_METHOD                     3: sin
                        56      LOAD_FAST                       2: _var_var_12
                        58      CALL_METHOD                     1
                        60      BINARY_MULTIPLY                 
                        62      BINARY_SUBTRACT                 
                        64      LOAD_CONST                      10: 1.4615
                        66      LOAD_GLOBAL                     1: np
                        68      LOAD_METHOD                     2: cos
                        70      LOAD_CONST                      11: 2
                        72      LOAD_FAST                       2: _var_var_12
                        74      BINARY_MULTIPLY                 
                        76      CALL_METHOD                     1
                        78      BINARY_MULTIPLY                 
                        80      BINARY_SUBTRACT                 
                        82      LOAD_CONST                      12: 4.089
                        84      LOAD_GLOBAL                     1: np
                        86      LOAD_METHOD                     3: sin
                        88      LOAD_CONST                      11: 2
                        90      LOAD_FAST                       2: _var_var_12
                        92      BINARY_MULTIPLY                 
                        94      CALL_METHOD                     1
                        96      BINARY_MULTIPLY                 
                        98      BINARY_SUBTRACT                 
                        100     BINARY_MULTIPLY                 
                        102     LOAD_FAST                       0: self
                        104     LOAD_ATTR                       0: cal_dict
                        106     LOAD_CONST                      13: 'ET'
                        108     STORE_SUBSCR                    
                        110     POP_BLOCK                       
                        112     LOAD_CONST                      14: '__pyarmor_exit_47510__'
                        114     NOP                             
                        116     NOP                             
                        118     LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x14\\\x00\x00\x00\x00\x00\x00\x00'
                        120     CALL_FUNCTION                   1
                        122     POP_TOP                         
                        124     JUMP_FORWARD                    14 (to 140)
                        126     LOAD_CONST                      14: '__pyarmor_exit_47510__'
                        128     NOP                             
                        130     NOP                             
                        132     LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x14\\\x00\x00\x00\x00\x00\x00\x00'
                        134     CALL_FUNCTION                   1
                        136     POP_TOP                         
                        138     RERAISE                         
                        140     LOAD_CONST                      0: None
                        142     RETURN_VALUE                    
                'Weather.cal_ET'
                [Code]
                    File Name: <frozen weather>
                    Object Name: cal_AST
                    Arg Count: 1
                    Pos Only Arg Count: 0
                    KW Only Arg Count: 0
                    Locals: 3
                    Stack Size: 8
                    Flags: 0x20000043 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NOFREE | CO_PYARMOR_OBFUSCATED)
                    [Names]
                        'cal_dict'
                        'wea_dict'
                        'longitude'
                        'LSM'
                    [Var Names]
                        'self'
                        '__assert_armored__'
                        '_var_var_13'
                    [Free Vars]
                    [Cell Vars]
                    [Constants]
                        None
                        '__pyarmor_assert_47511__'
                        'Weather.cal_AST.<locals>.<lambda>'
                        '__pyarmor_enter_47512__'
                        b'<COAddr>\x03\x00\x00\x146\x00\x00\x00\x00\x00\x00\x00'
                        'ET'
                        'hour'
                        60
                        15
                        'AST'
                        '__pyarmor_exit_47513__'
                    [Disassembly]
                        0       NOP                             
                        2       NOP                             
                        4       NOP                             
                        6       NOP                             
                        8       LOAD_CONST                      3: '__pyarmor_enter_47512__'
                        10      NOP                             
                        12      NOP                             
                        14      LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x146\x00\x00\x00\x00\x00\x00\x00'
                        16      CALL_FUNCTION                   1
                        18      POP_TOP                         
                        20      SETUP_FINALLY                   66 (to 88)
                        22      LOAD_FAST                       0: self
                        24      LOAD_ATTR                       0: cal_dict
                        26      LOAD_CONST                      5: 'ET'
                        28      BINARY_SUBSCR                   
                        30      STORE_FAST                      2: _var_var_13
                        32      LOAD_FAST                       0: self
                        34      LOAD_ATTR                       1: wea_dict
                        36      LOAD_CONST                      6: 'hour'
                        38      BINARY_SUBSCR                   
                        40      LOAD_FAST                       2: _var_var_13
                        42      LOAD_CONST                      7: 60
                        44      BINARY_TRUE_DIVIDE              
                        46      BINARY_ADD                      
                        48      LOAD_FAST                       0: self
                        50      LOAD_ATTR                       2: longitude
                        52      LOAD_FAST                       0: self
                        54      LOAD_ATTR                       3: LSM
                        56      BINARY_SUBTRACT                 
                        58      LOAD_CONST                      8: 15
                        60      BINARY_TRUE_DIVIDE              
                        62      BINARY_ADD                      
                        64      LOAD_FAST                       0: self
                        66      LOAD_ATTR                       0: cal_dict
                        68      LOAD_CONST                      9: 'AST'
                        70      STORE_SUBSCR                    
                        72      POP_BLOCK                       
                        74      LOAD_CONST                      10: '__pyarmor_exit_47513__'
                        76      NOP                             
                        78      NOP                             
                        80      LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x146\x00\x00\x00\x00\x00\x00\x00'
                        82      CALL_FUNCTION                   1
                        84      POP_TOP                         
                        86      JUMP_FORWARD                    14 (to 102)
                        88      LOAD_CONST                      10: '__pyarmor_exit_47513__'
                        90      NOP                             
                        92      NOP                             
                        94      LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x146\x00\x00\x00\x00\x00\x00\x00'
                        96      CALL_FUNCTION                   1
                        98      POP_TOP                         
                        100     RERAISE                         
                        102     LOAD_CONST                      0: None
                        104     RETURN_VALUE                    
                'Weather.cal_AST'
                [Code]
                    File Name: <frozen weather>
                    Object Name: cal_solarDegree
                    Arg Count: 1
                    Pos Only Arg Count: 0
                    KW Only Arg Count: 0
                    Locals: 3
                    Stack Size: 8
                    Flags: 0x20000043 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NOFREE | CO_PYARMOR_OBFUSCATED)
                    [Names]
                        'cal_dict'
                        'np'
                        'sin'
                        'pi'
                    [Var Names]
                        'self'
                        '__assert_armored__'
                        '_var_var_10'
                    [Free Vars]
                    [Cell Vars]
                    [Constants]
                        None
                        '__pyarmor_assert_47514__'
                        'Weather.cal_solarDegree.<locals>.<lambda>'
                        '__pyarmor_enter_47515__'
                        b'<COAddr>\x03\x00\x00\x14L\x00\x00\x00\x00\x00\x00\x00'
                        'Ydate'
                        23.45
                        284
                        365
                        2
                        'delta'
                        15
                        'AST'
                        12
                        'theta_h'
                        '__pyarmor_exit_47516__'
                    [Disassembly]
                        0       NOP                             
                        2       NOP                             
                        4       NOP                             
                        6       NOP                             
                        8       LOAD_CONST                      3: '__pyarmor_enter_47515__'
                        10      NOP                             
                        12      NOP                             
                        14      LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x14L\x00\x00\x00\x00\x00\x00\x00'
                        16      CALL_FUNCTION                   1
                        18      POP_TOP                         
                        20      SETUP_FINALLY                   88 (to 110)
                        22      LOAD_FAST                       0: self
                        24      LOAD_ATTR                       0: cal_dict
                        26      LOAD_CONST                      5: 'Ydate'
                        28      BINARY_SUBSCR                   
                        30      STORE_FAST                      2: _var_var_10
                        32      LOAD_CONST                      6: 23.45
                        34      LOAD_GLOBAL                     1: np
                        36      LOAD_METHOD                     2: sin
                        38      LOAD_FAST                       2: _var_var_10
                        40      LOAD_CONST                      7: 284
                        42      BINARY_ADD                      
                        44      LOAD_CONST                      8: 365
                        46      BINARY_TRUE_DIVIDE              
                        48      LOAD_CONST                      9: 2
                        50      BINARY_MULTIPLY                 
                        52      LOAD_GLOBAL                     1: np
                        54      LOAD_ATTR                       3: pi
                        56      BINARY_MULTIPLY                 
                        58      CALL_METHOD                     1
                        60      BINARY_MULTIPLY                 
                        62      LOAD_FAST                       0: self
                        64      LOAD_ATTR                       0: cal_dict
                        66      LOAD_CONST                      10: 'delta'
                        68      STORE_SUBSCR                    
                        70      LOAD_CONST                      11: 15
                        72      LOAD_FAST                       0: self
                        74      LOAD_ATTR                       0: cal_dict
                        76      LOAD_CONST                      12: 'AST'
                        78      BINARY_SUBSCR                   
                        80      LOAD_CONST                      13: 12
                        82      BINARY_SUBTRACT                 
                        84      BINARY_MULTIPLY                 
                        86      LOAD_FAST                       0: self
                        88      LOAD_ATTR                       0: cal_dict
                        90      LOAD_CONST                      14: 'theta_h'
                        92      STORE_SUBSCR                    
                        94      POP_BLOCK                       
                        96      LOAD_CONST                      15: '__pyarmor_exit_47516__'
                        98      NOP                             
                        100     NOP                             
                        102     LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x14L\x00\x00\x00\x00\x00\x00\x00'
                        104     CALL_FUNCTION                   1
                        106     POP_TOP                         
                        108     JUMP_FORWARD                    14 (to 124)
                        110     LOAD_CONST                      15: '__pyarmor_exit_47516__'
                        112     NOP                             
                        114     NOP                             
                        116     LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x14L\x00\x00\x00\x00\x00\x00\x00'
                        118     CALL_FUNCTION                   1
                        120     POP_TOP                         
                        122     RERAISE                         
                        124     LOAD_CONST                      0: None
                        126     RETURN_VALUE                    
                'Weather.cal_solarDegree'
                [Code]
                    File Name: <frozen weather>
                    Object Name: cal_azimuth
                    Arg Count: 1
                    Pos Only Arg Count: 0
                    KW Only Arg Count: 0
                    Locals: 13
                    Stack Size: 11
                    Flags: 0x20000043 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NOFREE | CO_PYARMOR_OBFUSCATED)
                    [Names]
                        'np'
                        'radians'
                        'cal_dict'
                        'latitude'
                        'cos'
                        'sin'
                        'arcsin'
                        'degrees'
                        'arccos'
                        'where'
                        'update'
                    [Var Names]
                        'self'
                        '__assert_armored__'
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
                    [Free Vars]
                    [Cell Vars]
                    [Constants]
                        None
                        '__pyarmor_assert_47517__'
                        'Weather.cal_azimuth.<locals>.<lambda>'
                        '__pyarmor_enter_47518__'
                        b'<COAddr>\x01\x00\x00\x144\x01\x00\x00\x00\x00\x00\x00'
                        'delta'
                        'theta_h'
                        0
                        -180
                        (
                            'sin_beta'
                            'beta_rad'
                            'beta_deg'
                            'sin_fai'
                            'cos_fai'
                            'fai1_deg'
                            'fai2_deg'
                            'fai_deg'
                        )
                        '__pyarmor_exit_47519__'
                    [Disassembly]
                        0       NOP                             
                        2       NOP                             
                        4       NOP                             
                        6       NOP                             
                        8       LOAD_CONST                      3: '__pyarmor_enter_47518__'
                        10      NOP                             
                        12      NOP                             
                        14      LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x144\x01\x00\x00\x00\x00\x00\x00'
                        16      CALL_FUNCTION                   1
                        18      POP_TOP                         
                        20      SETUP_FINALLY                   318 (to 342)
                        24      LOAD_GLOBAL                     0: np
                        26      LOAD_METHOD                     1: radians
                        28      LOAD_FAST                       0: self
                        30      LOAD_ATTR                       2: cal_dict
                        32      LOAD_CONST                      5: 'delta'
                        34      BINARY_SUBSCR                   
                        36      CALL_METHOD                     1
                        38      STORE_FAST                      2: _var_var_14
                        40      LOAD_GLOBAL                     0: np
                        42      LOAD_METHOD                     1: radians
                        44      LOAD_FAST                       0: self
                        46      LOAD_ATTR                       2: cal_dict
                        48      LOAD_CONST                      6: 'theta_h'
                        50      BINARY_SUBSCR                   
                        52      CALL_METHOD                     1
                        54      STORE_FAST                      3: _var_var_15
                        56      LOAD_GLOBAL                     0: np
                        58      LOAD_METHOD                     1: radians
                        60      LOAD_FAST                       0: self
                        62      LOAD_ATTR                       3: latitude
                        64      CALL_METHOD                     1
                        66      STORE_FAST                      4: _var_var_16
                        68      LOAD_GLOBAL                     0: np
                        70      LOAD_METHOD                     4: cos
                        72      LOAD_FAST                       4: _var_var_16
                        74      CALL_METHOD                     1
                        76      LOAD_GLOBAL                     0: np
                        78      LOAD_METHOD                     4: cos
                        80      LOAD_FAST                       2: _var_var_14
                        82      CALL_METHOD                     1
                        84      BINARY_MULTIPLY                 
                        86      LOAD_GLOBAL                     0: np
                        88      LOAD_METHOD                     4: cos
                        90      LOAD_FAST                       3: _var_var_15
                        92      CALL_METHOD                     1
                        94      BINARY_MULTIPLY                 
                        96      LOAD_GLOBAL                     0: np
                        98      LOAD_METHOD                     5: sin
                        100     LOAD_FAST                       4: _var_var_16
                        102     CALL_METHOD                     1
                        104     LOAD_GLOBAL                     0: np
                        106     LOAD_METHOD                     5: sin
                        108     LOAD_FAST                       2: _var_var_14
                        110     CALL_METHOD                     1
                        112     BINARY_MULTIPLY                 
                        114     BINARY_ADD                      
                        116     STORE_FAST                      5: _var_var_17
                        118     LOAD_GLOBAL                     0: np
                        120     LOAD_METHOD                     6: arcsin
                        122     LOAD_FAST                       5: _var_var_17
                        124     CALL_METHOD                     1
                        126     STORE_FAST                      6: _var_var_18
                        128     LOAD_GLOBAL                     0: np
                        130     LOAD_METHOD                     7: degrees
                        132     LOAD_FAST                       6: _var_var_18
                        134     CALL_METHOD                     1
                        136     STORE_FAST                      7: _var_var_19
                        138     LOAD_GLOBAL                     0: np
                        140     LOAD_METHOD                     5: sin
                        142     LOAD_FAST                       3: _var_var_15
                        144     CALL_METHOD                     1
                        146     LOAD_GLOBAL                     0: np
                        148     LOAD_METHOD                     4: cos
                        150     LOAD_FAST                       2: _var_var_14
                        152     CALL_METHOD                     1
                        154     BINARY_MULTIPLY                 
                        156     LOAD_GLOBAL                     0: np
                        158     LOAD_METHOD                     4: cos
                        160     LOAD_FAST                       6: _var_var_18
                        162     CALL_METHOD                     1
                        164     BINARY_TRUE_DIVIDE              
                        166     STORE_FAST                      8: _var_var_20
                        168     LOAD_GLOBAL                     0: np
                        170     LOAD_METHOD                     4: cos
                        172     LOAD_FAST                       3: _var_var_15
                        174     CALL_METHOD                     1
                        176     LOAD_GLOBAL                     0: np
                        178     LOAD_METHOD                     4: cos
                        180     LOAD_FAST                       2: _var_var_14
                        182     CALL_METHOD                     1
                        184     BINARY_MULTIPLY                 
                        186     LOAD_GLOBAL                     0: np
                        188     LOAD_METHOD                     5: sin
                        190     LOAD_FAST                       4: _var_var_16
                        192     CALL_METHOD                     1
                        194     BINARY_MULTIPLY                 
                        196     LOAD_GLOBAL                     0: np
                        198     LOAD_METHOD                     5: sin
                        200     LOAD_FAST                       2: _var_var_14
                        202     CALL_METHOD                     1
                        204     LOAD_GLOBAL                     0: np
                        206     LOAD_METHOD                     4: cos
                        208     LOAD_FAST                       4: _var_var_16
                        210     CALL_METHOD                     1
                        212     BINARY_MULTIPLY                 
                        214     BINARY_SUBTRACT                 
                        216     LOAD_GLOBAL                     0: np
                        218     LOAD_METHOD                     4: cos
                        220     LOAD_FAST                       6: _var_var_18
                        222     CALL_METHOD                     1
                        224     BINARY_TRUE_DIVIDE              
                        226     STORE_FAST                      9: _var_var_21
                        228     LOAD_GLOBAL                     0: np
                        230     LOAD_METHOD                     7: degrees
                        232     LOAD_GLOBAL                     0: np
                        234     LOAD_METHOD                     6: arcsin
                        236     LOAD_FAST                       8: _var_var_20
                        238     CALL_METHOD                     1
                        240     CALL_METHOD                     1
                        242     STORE_FAST                      10: _var_var_22
                        244     LOAD_GLOBAL                     0: np
                        246     LOAD_METHOD                     7: degrees
                        248     LOAD_GLOBAL                     0: np
                        250     LOAD_METHOD                     8: arccos
                        252     LOAD_FAST                       9: _var_var_21
                        254     CALL_METHOD                     1
                        256     CALL_METHOD                     1
                        258     STORE_FAST                      11: _var_var_23
                        260     LOAD_GLOBAL                     0: np
                        262     LOAD_METHOD                     9: where
                        264     LOAD_FAST                       8: _var_var_20
                        266     LOAD_CONST                      7: 0
                        268     COMPARE_OP                      4 (>)
                        270     LOAD_FAST                       11: _var_var_23
                        272     LOAD_GLOBAL                     0: np
                        274     LOAD_METHOD                     9: where
                        276     LOAD_FAST                       9: _var_var_21
                        278     LOAD_CONST                      7: 0
                        280     COMPARE_OP                      4 (>)
                        282     LOAD_FAST                       10: _var_var_22
                        284     LOAD_CONST                      8: -180
                        286     LOAD_FAST                       10: _var_var_22
                        288     BINARY_SUBTRACT                 
                        290     CALL_METHOD                     3
                        292     CALL_METHOD                     3
                        294     STORE_FAST                      12: _var_var_24
                        296     LOAD_FAST                       0: self
                        298     LOAD_ATTR                       2: cal_dict
                        300     LOAD_METHOD                     10: update
                        302     LOAD_FAST                       5: _var_var_17
                        304     LOAD_FAST                       6: _var_var_18
                        306     LOAD_FAST                       7: _var_var_19
                        308     LOAD_FAST                       8: _var_var_20
                        310     LOAD_FAST                       9: _var_var_21
                        312     LOAD_FAST                       10: _var_var_22
                        314     LOAD_FAST                       11: _var_var_23
                        316     LOAD_FAST                       12: _var_var_24
                        318     LOAD_CONST                      9: ('sin_beta', 'beta_rad', 'beta_deg', 'sin_fai', 'cos_fai', 'fai1_deg', 'fai2_deg', 'fai_deg')
                        320     BUILD_CONST_KEY_MAP             8
                        322     CALL_METHOD                     1
                        324     POP_TOP                         
                        326     POP_BLOCK                       
                        328     LOAD_CONST                      10: '__pyarmor_exit_47519__'
                        330     NOP                             
                        332     NOP                             
                        334     LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x144\x01\x00\x00\x00\x00\x00\x00'
                        336     CALL_FUNCTION                   1
                        338     POP_TOP                         
                        340     JUMP_FORWARD                    14 (to 356)
                        342     LOAD_CONST                      10: '__pyarmor_exit_47519__'
                        344     NOP                             
                        346     NOP                             
                        348     LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x144\x01\x00\x00\x00\x00\x00\x00'
                        350     CALL_FUNCTION                   1
                        352     POP_TOP                         
                        354     RERAISE                         
                        356     LOAD_CONST                      0: None
                        358     RETURN_VALUE                    
                'Weather.cal_azimuth'
                [Code]
                    File Name: <frozen weather>
                    Object Name: cal_surface
                    Arg Count: 1
                    Pos Only Arg Count: 0
                    KW Only Arg Count: 0
                    Locals: 16
                    Stack Size: 12
                    Flags: 0x20000043 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NOFREE | CO_PYARMOR_OBFUSCATED)
                    [Names]
                        'cal_dict'
                        'wea_dict'
                        'np'
                        'sin'
                        'r_g'
                        'cos'
                        'radians'
                        'sigma'
                        'lib'
                        'Surface'
                        'iterAttributes'
                        'abs'
                        'degrees'
                        'arccos'
                        'where'
                    [Var Names]
                        'self'
                        '__assert_armored__'
                        '_var_var_18'
                        '_var_var_20'
                        '_var_var_21'
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
                    [Free Vars]
                    [Cell Vars]
                    [Constants]
                        None
                        '__pyarmor_assert_47520__'
                        'Weather.cal_surface.<locals>.<lambda>'
                        '__pyarmor_enter_47521__'
                        b'<COAddr>\x03\x00\x00\x14\xea\x01\x00\x00\x00\x00\x00\x00'
                        'surf'
                        'beta_rad'
                        'sin_fai'
                        'cos_fai'
                        'fai_deg'
                        'Eb'
                        'Ed'
                        1
                        2
                        'Et_r'
                        90
                        270
                        0
                        0.55
                        0.437
                        0.313
                        0.45
                        (
                            'gamma'
                            'cos_theta'
                            'theta'
                            'Et_b'
                            'Y'
                            'Et_d'
                            'GSR'
                        )
                        'GSR'
                        'Egh'
                        'R'
                        '__pyarmor_exit_47522__'
                    [Disassembly]
                        0       NOP                             
                        2       NOP                             
                        4       NOP                             
                        6       NOP                             
                        8       LOAD_CONST                      3: '__pyarmor_enter_47521__'
                        10      NOP                             
                        12      NOP                             
                        14      LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x14\xea\x01\x00\x00\x00\x00\x00\x00'
                        16      CALL_FUNCTION                   1
                        18      POP_TOP                         
                        20      SETUP_FINALLY                   500 (to 524)
                        24      BUILD_MAP                       0
                        26      LOAD_FAST                       0: self
                        28      LOAD_ATTR                       0: cal_dict
                        30      LOAD_CONST                      5: 'surf'
                        32      STORE_SUBSCR                    
                        34      LOAD_FAST                       0: self
                        36      LOAD_ATTR                       0: cal_dict
                        38      LOAD_CONST                      6: 'beta_rad'
                        40      BINARY_SUBSCR                   
                        42      STORE_FAST                      2: _var_var_18
                        44      LOAD_FAST                       0: self
                        46      LOAD_ATTR                       0: cal_dict
                        48      LOAD_CONST                      7: 'sin_fai'
                        50      BINARY_SUBSCR                   
                        52      STORE_FAST                      3: _var_var_20
                        54      LOAD_FAST                       0: self
                        56      LOAD_ATTR                       0: cal_dict
                        58      LOAD_CONST                      8: 'cos_fai'
                        60      BINARY_SUBSCR                   
                        62      STORE_FAST                      4: _var_var_21
                        64      LOAD_FAST                       0: self
                        66      LOAD_ATTR                       0: cal_dict
                        68      LOAD_CONST                      9: 'fai_deg'
                        70      BINARY_SUBSCR                   
                        72      STORE_FAST                      5: _var_var_24
                        74      LOAD_FAST                       0: self
                        76      LOAD_ATTR                       1: wea_dict
                        78      LOAD_CONST                      10: 'Eb'
                        80      BINARY_SUBSCR                   
                        82      LOAD_GLOBAL                     2: np
                        84      LOAD_METHOD                     3: sin
                        86      LOAD_FAST                       2: _var_var_18
                        88      CALL_METHOD                     1
                        90      BINARY_MULTIPLY                 
                        92      LOAD_FAST                       0: self
                        94      LOAD_ATTR                       1: wea_dict
                        96      LOAD_CONST                      11: 'Ed'
                        98      BINARY_SUBSCR                   
                        100     BINARY_ADD                      
                        102     LOAD_GLOBAL                     4: r_g
                        104     BINARY_MULTIPLY                 
                        106     LOAD_CONST                      12: 1
                        108     LOAD_GLOBAL                     2: np
                        110     LOAD_METHOD                     5: cos
                        112     LOAD_GLOBAL                     2: np
                        114     LOAD_METHOD                     6: radians
                        116     LOAD_GLOBAL                     7: sigma
                        118     CALL_METHOD                     1
                        120     CALL_METHOD                     1
                        122     BINARY_SUBTRACT                 
                        124     BINARY_MULTIPLY                 
                        126     LOAD_CONST                      13: 2
                        128     BINARY_TRUE_DIVIDE              
                        130     STORE_FAST                      6: _var_var_25
                        132     LOAD_FAST                       6: _var_var_25
                        134     LOAD_FAST                       0: self
                        136     LOAD_ATTR                       0: cal_dict
                        138     LOAD_CONST                      14: 'Et_r'
                        140     STORE_SUBSCR                    
                        142     LOAD_GLOBAL                     8: lib
                        144     LOAD_METHOD                     9: Surface
                        146     CALL_METHOD                     0
                        148     STORE_FAST                      7: _var_var_26
                        150     LOAD_FAST                       7: _var_var_26
                        152     LOAD_METHOD                     10: iterAttributes
                        154     CALL_METHOD                     0
                        156     GET_ITER                        
                        158     FOR_ITER                        322 (to 484)
                        162     UNPACK_SEQUENCE                 2
                        164     STORE_FAST                      8: _var_var_27
                        166     STORE_FAST                      9: _var_var_28
                        168     LOAD_GLOBAL                     2: np
                        170     LOAD_METHOD                     11: abs
                        172     LOAD_FAST                       5: _var_var_24
                        174     LOAD_FAST                       9: _var_var_28
                        176     BINARY_SUBTRACT                 
                        178     CALL_METHOD                     1
                        180     STORE_FAST                      10: _var_var_29
                        182     LOAD_GLOBAL                     2: np
                        184     LOAD_METHOD                     5: cos
                        186     LOAD_FAST                       2: _var_var_18
                        188     CALL_METHOD                     1
                        190     LOAD_GLOBAL                     2: np
                        192     LOAD_METHOD                     5: cos
                        194     LOAD_GLOBAL                     2: np
                        196     LOAD_METHOD                     6: radians
                        198     LOAD_FAST                       10: _var_var_29
                        200     CALL_METHOD                     1
                        202     CALL_METHOD                     1
                        204     BINARY_MULTIPLY                 
                        206     LOAD_GLOBAL                     2: np
                        208     LOAD_METHOD                     3: sin
                        210     LOAD_GLOBAL                     2: np
                        212     LOAD_METHOD                     6: radians
                        214     LOAD_GLOBAL                     7: sigma
                        216     CALL_METHOD                     1
                        218     CALL_METHOD                     1
                        220     BINARY_MULTIPLY                 
                        222     LOAD_GLOBAL                     2: np
                        224     LOAD_METHOD                     3: sin
                        226     LOAD_FAST                       2: _var_var_18
                        228     CALL_METHOD                     1
                        230     LOAD_GLOBAL                     2: np
                        232     LOAD_METHOD                     5: cos
                        234     LOAD_GLOBAL                     2: np
                        236     LOAD_METHOD                     6: radians
                        238     LOAD_GLOBAL                     7: sigma
                        240     CALL_METHOD                     1
                        242     CALL_METHOD                     1
                        244     BINARY_MULTIPLY                 
                        246     BINARY_ADD                      
                        248     STORE_FAST                      11: _var_var_30
                        250     LOAD_GLOBAL                     2: np
                        252     LOAD_METHOD                     12: degrees
                        254     LOAD_GLOBAL                     2: np
                        256     LOAD_METHOD                     13: arccos
                        258     LOAD_FAST                       11: _var_var_30
                        260     CALL_METHOD                     1
                        262     CALL_METHOD                     1
                        264     STORE_FAST                      12: _var_var_31
                        266     LOAD_GLOBAL                     2: np
                        268     LOAD_METHOD                     14: where
                        270     LOAD_FAST                       10: _var_var_29
                        272     LOAD_CONST                      15: 90
                        274     COMPARE_OP                      4 (>)
                        276     LOAD_FAST                       10: _var_var_29
                        278     LOAD_CONST                      16: 270
                        280     COMPARE_OP                      0 (<)
                        282     BINARY_AND                      
                        284     LOAD_CONST                      17: 0
                        286     LOAD_GLOBAL                     2: np
                        288     LOAD_METHOD                     14: where
                        290     LOAD_FAST                       11: _var_var_30
                        292     LOAD_CONST                      17: 0
                        294     COMPARE_OP                      0 (<)
                        296     LOAD_CONST                      17: 0
                        298     LOAD_FAST                       0: self
                        300     LOAD_ATTR                       1: wea_dict
                        302     LOAD_CONST                      10: 'Eb'
                        304     BINARY_SUBSCR                   
                        306     LOAD_FAST                       11: _var_var_30
                        308     BINARY_MULTIPLY                 
                        310     CALL_METHOD                     3
                        312     CALL_METHOD                     3
                        314     STORE_FAST                      13: _var_var_32
                        316     LOAD_CONST                      18: 0.55
                        318     LOAD_CONST                      19: 0.437
                        320     LOAD_FAST                       11: _var_var_30
                        322     BINARY_MULTIPLY                 
                        324     BINARY_ADD                      
                        326     LOAD_CONST                      20: 0.313
                        328     LOAD_FAST                       11: _var_var_30
                        330     LOAD_CONST                      13: 2
                        332     BINARY_POWER                    
                        334     BINARY_MULTIPLY                 
                        336     BINARY_ADD                      
                        338     STORE_FAST                      14: _var_var_33
                        340     LOAD_GLOBAL                     2: np
                        342     LOAD_METHOD                     14: where
                        344     LOAD_FAST                       14: _var_var_33
                        346     LOAD_CONST                      21: 0.45
                        348     COMPARE_OP                      0 (<)
                        350     LOAD_CONST                      21: 0.45
                        352     LOAD_FAST                       14: _var_var_33
                        354     CALL_METHOD                     3
                        356     STORE_FAST                      14: _var_var_33
                        358     LOAD_GLOBAL                     2: np
                        360     LOAD_METHOD                     14: where
                        362     LOAD_GLOBAL                     7: sigma
                        364     LOAD_CONST                      15: 90
                        366     COMPARE_OP                      1 (<=)
                        368     LOAD_FAST                       0: self
                        370     LOAD_ATTR                       1: wea_dict
                        372     LOAD_CONST                      11: 'Ed'
                        374     BINARY_SUBSCR                   
                        376     LOAD_FAST                       14: _var_var_33
                        378     LOAD_GLOBAL                     2: np
                        380     LOAD_METHOD                     3: sin
                        382     LOAD_GLOBAL                     2: np
                        384     LOAD_METHOD                     6: radians
                        386     LOAD_GLOBAL                     7: sigma
                        388     CALL_METHOD                     1
                        390     CALL_METHOD                     1
                        392     BINARY_MULTIPLY                 
                        394     LOAD_GLOBAL                     2: np
                        396     LOAD_METHOD                     5: cos
                        398     LOAD_GLOBAL                     2: np
                        400     LOAD_METHOD                     6: radians
                        402     LOAD_GLOBAL                     7: sigma
                        404     CALL_METHOD                     1
                        406     CALL_METHOD                     1
                        408     BINARY_ADD                      
                        410     BINARY_MULTIPLY                 
                        412     LOAD_FAST                       0: self
                        414     LOAD_ATTR                       1: wea_dict
                        416     LOAD_CONST                      11: 'Ed'
                        418     BINARY_SUBSCR                   
                        420     LOAD_FAST                       14: _var_var_33
                        422     LOAD_GLOBAL                     2: np
                        424     LOAD_METHOD                     3: sin
                        426     LOAD_GLOBAL                     2: np
                        428     LOAD_METHOD                     6: radians
                        430     LOAD_GLOBAL                     7: sigma
                        432     CALL_METHOD                     1
                        434     CALL_METHOD                     1
                        436     BINARY_MULTIPLY                 
                        438     BINARY_MULTIPLY                 
                        440     CALL_METHOD                     3
                        442     STORE_FAST                      15: _var_var_34
                        444     LOAD_FAST                       10: _var_var_29
                        446     LOAD_FAST                       11: _var_var_30
                        448     LOAD_FAST                       12: _var_var_31
                        450     LOAD_FAST                       13: _var_var_32
                        452     LOAD_FAST                       14: _var_var_33
                        454     LOAD_FAST                       15: _var_var_34
                        456     LOAD_FAST                       13: _var_var_32
                        458     LOAD_FAST                       15: _var_var_34
                        460     BINARY_ADD                      
                        462     LOAD_FAST                       6: _var_var_25
                        464     BINARY_ADD                      
                        466     LOAD_CONST                      22: ('gamma', 'cos_theta', 'theta', 'Et_b', 'Y', 'Et_d', 'GSR')
                        468     BUILD_CONST_KEY_MAP             7
                        470     LOAD_FAST                       0: self
                        472     LOAD_ATTR                       0: cal_dict
                        474     LOAD_CONST                      5: 'surf'
                        476     BINARY_SUBSCR                   
                        478     LOAD_FAST                       8: _var_var_27
                        480     STORE_SUBSCR                    
                        482     JUMP_ABSOLUTE                   158
                        484     LOAD_CONST                      23: 'GSR'
                        486     LOAD_FAST                       0: self
                        488     LOAD_ATTR                       1: wea_dict
                        490     LOAD_CONST                      24: 'Egh'
                        492     BINARY_SUBSCR                   
                        494     BUILD_MAP                       1
                        496     LOAD_FAST                       0: self
                        498     LOAD_ATTR                       0: cal_dict
                        500     LOAD_CONST                      5: 'surf'
                        502     BINARY_SUBSCR                   
                        504     LOAD_CONST                      25: 'R'
                        506     STORE_SUBSCR                    
                        508     POP_BLOCK                       
                        510     LOAD_CONST                      26: '__pyarmor_exit_47522__'
                        512     NOP                             
                        514     NOP                             
                        516     LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x14\xea\x01\x00\x00\x00\x00\x00\x00'
                        518     CALL_FUNCTION                   1
                        520     POP_TOP                         
                        522     JUMP_FORWARD                    14 (to 538)
                        524     LOAD_CONST                      26: '__pyarmor_exit_47522__'
                        526     NOP                             
                        528     NOP                             
                        530     LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x14\xea\x01\x00\x00\x00\x00\x00\x00'
                        532     CALL_FUNCTION                   1
                        534     POP_TOP                         
                        536     RERAISE                         
                        538     LOAD_CONST                      0: None
                        540     RETURN_VALUE                    
                'Weather.cal_surface'
                [Code]
                    File Name: <frozen weather>
                    Object Name: cal_mmv
                    Arg Count: 1
                    Pos Only Arg Count: 0
                    KW Only Arg Count: 0
                    Locals: 10
                    Stack Size: 8
                    Flags: 0x20000003 (CO_OPTIMIZED | CO_NEWLOCALS | CO_PYARMOR_OBFUSCATED)
                    [Names]
                        'wea_dict'
                        'np'
                        'array'
                        'minimum'
                        'cal_dict'
                    [Var Names]
                        'self'
                        '__assert_armored__'
                        '_var_var_38'
                        '_var_var_39'
                        '_var_var_40'
                        '_var_var_41'
                        '_var_var_42'
                        '_var_var_43'
                        '_var_var_44'
                        '_var_var_45'
                    [Free Vars]
                    [Cell Vars]
                        '_var_var_35'
                        '_var_var_36'
                        '_var_var_37'
                    [Constants]
                        None
                        '__pyarmor_assert_47523__'
                        'Weather.cal_mmv.<locals>.<lambda>'
                        '__pyarmor_enter_47524__'
                        b'<COAddr>\x03\x00\x00\x14\xc4\x00\x00\x00\x00\x00\x00\x00'
                        (
                            6.11
                            0.444
                            0.0143
                            0.000265
                            3.03e-06
                            2.03e-08
                            6.14e-11
                        )
                        (
                            6.11
                            0.503
                            0.0189
                            0.000418
                            5.82e-06
                            4.84e-08
                            1.84e-10
                        )
                        [Code]
                            File Name: <frozen weather>
                            Object Name: recurse
                            Arg Count: 3
                            Pos Only Arg Count: 0
                            KW Only Arg Count: 0
                            Locals: 4
                            Stack Size: 8
                            Flags: 0x20000013 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NESTED | CO_PYARMOR_OBFUSCATED)
                            [Names]
                            [Var Names]
                                'lst'
                                'n'
                                'T'
                                '__assert_armored__'
                            [Free Vars]
                                'recurse'
                            [Cell Vars]
                            [Constants]
                                None
                                '__pyarmor_assert_47526__'
                                'Weather.cal_mmv.<locals>.recurse.<locals>.<lambda>'
                                '__pyarmor_enter_47527__'
                                b'<COAddr>\x01\x00\x00\x14H\x00\x00\x00\x00\x00\x00\x00'
                                6
                                '__pyarmor_exit_47528__'
                                0
                                1
                            [Disassembly]
                                0       NOP                             
                                2       NOP                             
                                4       NOP                             
                                6       NOP                             
                                8       LOAD_CONST                      3: '__pyarmor_enter_47527__'
                                10      NOP                             
                                12      NOP                             
                                14      LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14H\x00\x00\x00\x00\x00\x00\x00'
                                16      CALL_FUNCTION                   1
                                18      POP_TOP                         
                                20      SETUP_FINALLY                   84 (to 106)
                                22      LOAD_FAST                       1: n
                                24      LOAD_CONST                      5: 6
                                26      COMPARE_OP                      2 (==)
                                28      POP_JUMP_IF_FALSE               48
                                30      POP_BLOCK                       
                                32      NOP                             
                                34      NOP                             
                                36      NOP                             
                                38      NOP                             
                                40      NOP                             
                                42      NOP                             
                                44      LOAD_CONST                      7: 0
                                46      RETURN_VALUE                    
                                48      LOAD_FAST                       0: lst
                                50      LOAD_FAST                       1: n
                                52      BINARY_SUBSCR                   
                                54      LOAD_FAST                       2: T
                                56      LOAD_DEREF                      0: recurse
                                58      LOAD_FAST                       0: lst
                                60      LOAD_FAST                       1: n
                                62      LOAD_CONST                      8: 1
                                64      BINARY_ADD                      
                                66      LOAD_FAST                       2: T
                                68      CALL_FUNCTION                   3
                                70      BINARY_MULTIPLY                 
                                72      BINARY_ADD                      
                                74      POP_BLOCK                       
                                76      NOP                             
                                78      NOP                             
                                80      NOP                             
                                82      NOP                             
                                84      NOP                             
                                86      NOP                             
                                88      RETURN_VALUE                    
                                90      POP_BLOCK                       
                                92      LOAD_CONST                      6: '__pyarmor_exit_47528__'
                                94      NOP                             
                                96      NOP                             
                                98      LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14H\x00\x00\x00\x00\x00\x00\x00'
                                100     CALL_FUNCTION                   1
                                102     POP_TOP                         
                                104     JUMP_FORWARD                    14 (to 120)
                                106     LOAD_CONST                      6: '__pyarmor_exit_47528__'
                                108     NOP                             
                                110     NOP                             
                                112     LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14H\x00\x00\x00\x00\x00\x00\x00'
                                114     CALL_FUNCTION                   1
                                116     POP_TOP                         
                                118     RERAISE                         
                                120     LOAD_CONST                      0: None
                                122     RETURN_VALUE                    
                        'Weather.cal_mmv.<locals>.recurse'
                        'DBT'
                        [Code]
                            File Name: <frozen weather>
                            Object Name: <listcomp>
                            Arg Count: 1
                            Pos Only Arg Count: 0
                            KW Only Arg Count: 0
                            Locals: 2
                            Stack Size: 6
                            Flags: 0x00000013 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NESTED)
                            [Names]
                            [Var Names]
                                '.0'
                                '_var_var_46'
                            [Free Vars]
                                'recurse'
                                'water'
                            [Cell Vars]
                            [Constants]
                                0
                            [Disassembly]
                                0       BUILD_LIST                      0
                                2       LOAD_FAST                       0: .0
                                4       FOR_ITER                        16 (to 22)
                                6       STORE_FAST                      1: _var_var_46
                                8       LOAD_DEREF                      0: recurse
                                10      LOAD_DEREF                      1: water
                                12      LOAD_CONST                      0: 0
                                14      LOAD_FAST                       1: _var_var_46
                                16      CALL_FUNCTION                   3
                                18      LIST_APPEND                     2
                                20      JUMP_ABSOLUTE                   4
                                22      RETURN_VALUE                    
                        'Weather.cal_mmv.<locals>.<listcomp>'
                        [Code]
                            File Name: <frozen weather>
                            Object Name: <listcomp>
                            Arg Count: 1
                            Pos Only Arg Count: 0
                            KW Only Arg Count: 0
                            Locals: 2
                            Stack Size: 6
                            Flags: 0x00000013 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NESTED)
                            [Names]
                            [Var Names]
                                '.0'
                                '_var_var_46'
                            [Free Vars]
                                'ice'
                                'recurse'
                            [Cell Vars]
                            [Constants]
                                0
                            [Disassembly]
                                0       BUILD_LIST                      0
                                2       LOAD_FAST                       0: .0
                                4       FOR_ITER                        16 (to 22)
                                6       STORE_FAST                      1: _var_var_46
                                8       LOAD_DEREF                      1: recurse
                                10      LOAD_DEREF                      0: ice
                                12      LOAD_CONST                      0: 0
                                14      LOAD_FAST                       1: _var_var_46
                                16      CALL_FUNCTION                   3
                                18      LIST_APPEND                     2
                                20      JUMP_ABSOLUTE                   4
                                22      RETURN_VALUE                    
                        'RH'
                        0.01
                        'pressure'
                        100
                        18.02
                        1
                        28.96
                        1000
                        'mmv'
                        '__pyarmor_exit_47525__'
                    [Disassembly]
                        0       NOP                             
                        2       NOP                             
                        4       NOP                             
                        6       NOP                             
                        8       LOAD_CONST                      3: '__pyarmor_enter_47524__'
                        10      NOP                             
                        12      NOP                             
                        14      LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x14\xc4\x00\x00\x00\x00\x00\x00\x00'
                        16      CALL_FUNCTION                   1
                        18      POP_TOP                         
                        20      SETUP_FINALLY                   208 (to 230)
                        22      BUILD_LIST                      0
                        24      LOAD_CONST                      5: (6.11, 0.444, 0.0143, 0.000265, 3.03e-06, 2.03e-08, 6.14e-11)
                        26      LIST_EXTEND                     1
                        28      STORE_DEREF                     2: _var_var_37
                        30      BUILD_LIST                      0
                        32      LOAD_CONST                      6: (6.11, 0.503, 0.0189, 0.000418, 5.82e-06, 4.84e-08, 1.84e-10)
                        34      LIST_EXTEND                     1
                        36      STORE_DEREF                     0: _var_var_35
                        38      LOAD_CLOSURE                    1: _var_var_36
                        40      BUILD_TUPLE                     1
                        42      LOAD_CONST                      7: <CODE> recurse
                        44      LOAD_CONST                      8: 'Weather.cal_mmv.<locals>.recurse'
                        46      MAKE_FUNCTION                   8
                        48      STORE_DEREF                     1: _var_var_36
                        50      LOAD_FAST                       0: self
                        52      LOAD_ATTR                       0: wea_dict
                        54      LOAD_CONST                      9: 'DBT'
                        56      BINARY_SUBSCR                   
                        58      STORE_FAST                      2: _var_var_38
                        60      LOAD_GLOBAL                     1: np
                        62      LOAD_METHOD                     2: array
                        64      LOAD_CLOSURE                    1: _var_var_36
                        66      LOAD_CLOSURE                    2: _var_var_37
                        68      BUILD_TUPLE                     2
                        70      LOAD_CONST                      10: <CODE> <listcomp>
                        72      LOAD_CONST                      11: 'Weather.cal_mmv.<locals>.<listcomp>'
                        74      MAKE_FUNCTION                   8
                        76      LOAD_FAST                       2: _var_var_38
                        78      GET_ITER                        
                        80      CALL_FUNCTION                   1
                        82      CALL_METHOD                     1
                        84      STORE_FAST                      3: _var_var_39
                        86      LOAD_GLOBAL                     1: np
                        88      LOAD_METHOD                     2: array
                        90      LOAD_CLOSURE                    0: _var_var_35
                        92      LOAD_CLOSURE                    1: _var_var_36
                        94      BUILD_TUPLE                     2
                        96      LOAD_CONST                      12: <CODE> <listcomp>
                        98      LOAD_CONST                      11: 'Weather.cal_mmv.<locals>.<listcomp>'
                        100     MAKE_FUNCTION                   8
                        102     LOAD_FAST                       2: _var_var_38
                        104     GET_ITER                        
                        106     CALL_FUNCTION                   1
                        108     CALL_METHOD                     1
                        110     STORE_FAST                      4: _var_var_40
                        112     LOAD_GLOBAL                     1: np
                        114     LOAD_METHOD                     3: minimum
                        116     LOAD_FAST                       3: _var_var_39
                        118     LOAD_FAST                       4: _var_var_40
                        120     CALL_METHOD                     2
                        122     STORE_FAST                      5: _var_var_41
                        124     LOAD_FAST                       5: _var_var_41
                        126     LOAD_FAST                       0: self
                        128     LOAD_ATTR                       0: wea_dict
                        130     LOAD_CONST                      13: 'RH'
                        132     BINARY_SUBSCR                   
                        134     BINARY_MULTIPLY                 
                        136     LOAD_CONST                      14: 0.01
                        138     BINARY_MULTIPLY                 
                        140     STORE_FAST                      6: _var_var_42
                        142     LOAD_FAST                       6: _var_var_42
                        144     LOAD_FAST                       0: self
                        146     LOAD_ATTR                       0: wea_dict
                        148     LOAD_CONST                      15: 'pressure'
                        150     BINARY_SUBSCR                   
                        152     LOAD_CONST                      16: 100
                        154     BINARY_TRUE_DIVIDE              
                        156     BINARY_TRUE_DIVIDE              
                        158     STORE_FAST                      7: _var_var_43
                        160     LOAD_FAST                       7: _var_var_43
                        162     LOAD_CONST                      17: 18.02
                        164     BINARY_MULTIPLY                 
                        166     LOAD_FAST                       7: _var_var_43
                        168     LOAD_CONST                      17: 18.02
                        170     BINARY_MULTIPLY                 
                        172     LOAD_CONST                      18: 1
                        174     LOAD_FAST                       7: _var_var_43
                        176     BINARY_SUBTRACT                 
                        178     LOAD_CONST                      19: 28.96
                        180     BINARY_MULTIPLY                 
                        182     BINARY_ADD                      
                        184     BINARY_TRUE_DIVIDE              
                        186     STORE_FAST                      8: _var_var_44
                        188     LOAD_CONST                      20: 1000
                        190     LOAD_FAST                       8: _var_var_44
                        192     BINARY_MULTIPLY                 
                        194     LOAD_CONST                      18: 1
                        196     LOAD_FAST                       8: _var_var_44
                        198     BINARY_SUBTRACT                 
                        200     BINARY_TRUE_DIVIDE              
                        202     STORE_FAST                      9: _var_var_45
                        204     LOAD_FAST                       9: _var_var_45
                        206     LOAD_FAST                       0: self
                        208     LOAD_ATTR                       4: cal_dict
                        210     LOAD_CONST                      21: 'mmv'
                        212     STORE_SUBSCR                    
                        214     POP_BLOCK                       
                        216     LOAD_CONST                      22: '__pyarmor_exit_47525__'
                        218     NOP                             
                        220     NOP                             
                        222     LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x14\xc4\x00\x00\x00\x00\x00\x00\x00'
                        224     CALL_FUNCTION                   1
                        226     POP_TOP                         
                        228     JUMP_FORWARD                    14 (to 244)
                        230     LOAD_CONST                      22: '__pyarmor_exit_47525__'
                        232     NOP                             
                        234     NOP                             
                        236     LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x14\xc4\x00\x00\x00\x00\x00\x00\x00'
                        238     CALL_FUNCTION                   1
                        240     POP_TOP                         
                        242     RERAISE                         
                        244     LOAD_CONST                      0: None
                        246     RETURN_VALUE                    
                'Weather.cal_mmv'
                [Code]
                    File Name: <frozen weather>
                    Object Name: cal_SRF
                    Arg Count: 1
                    Pos Only Arg Count: 0
                    KW Only Arg Count: 0
                    Locals: 15
                    Stack Size: 16
                    Flags: 0x20000043 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NOFREE | CO_PYARMOR_OBFUSCATED)
                    [Names]
                        'cal_dict'
                        'lib'
                        'Surface'
                        'range'
                        'iterAttributes'
                        'np'
                        'maximum'
                        'tan'
                        'radians'
                        'where'
                        'abs'
                    [Var Names]
                        'self'
                        '__assert_armored__'
                        '_var_var_26'
                        '_var_var_19'
                        '_var_var_24'
                        '_var_var_25'
                        '_var_var_11'
                        '_var_var_47'
                        '_var_var_48'
                        '_var_var_49'
                        '_var_var_32'
                        '_var_var_34'
                        '_var_var_50'
                        '_var_var_51'
                        '_var_var_52'
                    [Free Vars]
                    [Cell Vars]
                    [Constants]
                        None
                        '__pyarmor_assert_47529__'
                        'Weather.cal_SRF.<locals>.<lambda>'
                        '__pyarmor_enter_47530__'
                        b'<COAddr>\x03\x00\x00\x14\x88\x02\x00\x00\x00\x00\x00\x00'
                        'overhang'
                        'fin'
                        'horizon'
                        'beta_deg'
                        'fai_deg'
                        'Et_r'
                        15
                        61
                        'surf'
                        'GSR'
                        'Et_b'
                        'Et_d'
                        0
                        1
                        0.5
                        90
                        (
                            'S'
                            'SE'
                            'E'
                            'NE'
                        )
                        90
                        -90
                        10
                        81
                        '__pyarmor_exit_47531__'
                    [Disassembly]
                        0       NOP                             
                        2       NOP                             
                        4       NOP                             
                        6       NOP                             
                        8       LOAD_CONST                      3: '__pyarmor_enter_47530__'
                        10      NOP                             
                        12      NOP                             
                        14      LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x14\x88\x02\x00\x00\x00\x00\x00\x00'
                        16      CALL_FUNCTION                   1
                        18      POP_TOP                         
                        20      SETUP_FINALLY                   658 (to 682)
                        24      BUILD_MAP                       0
                        26      LOAD_FAST                       0: self
                        28      LOAD_ATTR                       0: cal_dict
                        30      LOAD_CONST                      5: 'overhang'
                        32      STORE_SUBSCR                    
                        34      BUILD_MAP                       0
                        36      LOAD_FAST                       0: self
                        38      LOAD_ATTR                       0: cal_dict
                        40      LOAD_CONST                      6: 'fin'
                        42      STORE_SUBSCR                    
                        44      BUILD_MAP                       0
                        46      LOAD_FAST                       0: self
                        48      LOAD_ATTR                       0: cal_dict
                        50      LOAD_CONST                      7: 'horizon'
                        52      STORE_SUBSCR                    
                        54      LOAD_GLOBAL                     1: lib
                        56      LOAD_METHOD                     2: Surface
                        58      CALL_METHOD                     0
                        60      STORE_FAST                      2: _var_var_26
                        62      LOAD_FAST                       0: self
                        64      LOAD_ATTR                       0: cal_dict
                        66      LOAD_CONST                      8: 'beta_deg'
                        68      BINARY_SUBSCR                   
                        70      STORE_FAST                      3: _var_var_19
                        72      LOAD_FAST                       0: self
                        74      LOAD_ATTR                       0: cal_dict
                        76      LOAD_CONST                      9: 'fai_deg'
                        78      BINARY_SUBSCR                   
                        80      STORE_FAST                      4: _var_var_24
                        82      LOAD_FAST                       0: self
                        84      LOAD_ATTR                       0: cal_dict
                        86      LOAD_CONST                      10: 'Et_r'
                        88      BINARY_SUBSCR                   
                        90      STORE_FAST                      5: _var_var_25
                        92      LOAD_GLOBAL                     3: range
                        94      LOAD_CONST                      11: 15
                        96      LOAD_CONST                      12: 61
                        98      LOAD_CONST                      11: 15
                        100     CALL_FUNCTION                   3
                        102     GET_ITER                        
                        104     FOR_ITER                        406 (to 514)
                        108     STORE_FAST                      6: _var_var_11
                        110     BUILD_MAP                       0
                        112     LOAD_FAST                       0: self
                        114     LOAD_ATTR                       0: cal_dict
                        116     LOAD_CONST                      5: 'overhang'
                        118     BINARY_SUBSCR                   
                        120     LOAD_FAST                       6: _var_var_11
                        122     STORE_SUBSCR                    
                        124     BUILD_MAP                       0
                        126     LOAD_FAST                       0: self
                        128     LOAD_ATTR                       0: cal_dict
                        130     LOAD_CONST                      6: 'fin'
                        132     BINARY_SUBSCR                   
                        134     LOAD_FAST                       6: _var_var_11
                        136     STORE_SUBSCR                    
                        138     LOAD_FAST                       2: _var_var_26
                        140     LOAD_METHOD                     4: iterAttributes
                        142     CALL_METHOD                     0
                        144     GET_ITER                        
                        146     FOR_ITER                        362 (to 512)
                        150     UNPACK_SEQUENCE                 2
                        152     STORE_FAST                      7: _var_var_47
                        154     STORE_FAST                      8: _var_var_48
                        156     LOAD_FAST                       0: self
                        158     LOAD_ATTR                       0: cal_dict
                        160     LOAD_CONST                      13: 'surf'
                        162     BINARY_SUBSCR                   
                        164     LOAD_FAST                       7: _var_var_47
                        166     BINARY_SUBSCR                   
                        168     LOAD_CONST                      14: 'GSR'
                        170     BINARY_SUBSCR                   
                        172     STORE_FAST                      9: _var_var_49
                        174     LOAD_FAST                       0: self
                        176     LOAD_ATTR                       0: cal_dict
                        178     LOAD_CONST                      13: 'surf'
                        180     BINARY_SUBSCR                   
                        182     LOAD_FAST                       7: _var_var_47
                        184     BINARY_SUBSCR                   
                        186     LOAD_CONST                      15: 'Et_b'
                        188     BINARY_SUBSCR                   
                        190     STORE_FAST                      10: _var_var_32
                        192     LOAD_FAST                       0: self
                        194     LOAD_ATTR                       0: cal_dict
                        196     LOAD_CONST                      13: 'surf'
                        198     BINARY_SUBSCR                   
                        200     LOAD_FAST                       7: _var_var_47
                        202     BINARY_SUBSCR                   
                        204     LOAD_CONST                      16: 'Et_d'
                        206     BINARY_SUBSCR                   
                        208     STORE_FAST                      11: _var_var_34
                        210     LOAD_GLOBAL                     5: np
                        212     LOAD_METHOD                     6: maximum
                        214     LOAD_CONST                      17: 0
                        216     LOAD_CONST                      18: 1
                        218     LOAD_CONST                      19: 0.5
                        220     LOAD_GLOBAL                     5: np
                        222     LOAD_METHOD                     7: tan
                        224     LOAD_GLOBAL                     5: np
                        226     LOAD_METHOD                     8: radians
                        228     LOAD_FAST                       6: _var_var_11
                        230     CALL_METHOD                     1
                        232     CALL_METHOD                     1
                        234     BINARY_MULTIPLY                 
                        236     LOAD_GLOBAL                     5: np
                        238     LOAD_METHOD                     7: tan
                        240     LOAD_GLOBAL                     5: np
                        242     LOAD_METHOD                     8: radians
                        244     LOAD_CONST                      20: 90
                        246     LOAD_GLOBAL                     5: np
                        248     LOAD_METHOD                     6: maximum
                        250     LOAD_FAST                       3: _var_var_19
                        252     LOAD_CONST                      17: 0
                        254     CALL_METHOD                     2
                        256     BINARY_SUBTRACT                 
                        258     CALL_METHOD                     1
                        260     CALL_METHOD                     1
                        262     BINARY_TRUE_DIVIDE              
                        264     BINARY_SUBTRACT                 
                        266     CALL_METHOD                     2
                        268     STORE_FAST                      12: _var_var_50
                        270     LOAD_GLOBAL                     5: np
                        272     LOAD_METHOD                     9: where
                        274     LOAD_FAST                       9: _var_var_49
                        276     LOAD_CONST                      17: 0
                        278     COMPARE_OP                      2 (==)
                        280     LOAD_CONST                      17: 0
                        282     LOAD_FAST                       12: _var_var_50
                        284     LOAD_FAST                       10: _var_var_32
                        286     BINARY_MULTIPLY                 
                        288     LOAD_CONST                      18: 1
                        290     LOAD_FAST                       6: _var_var_11
                        292     LOAD_CONST                      20: 90
                        294     BINARY_TRUE_DIVIDE              
                        296     BINARY_SUBTRACT                 
                        298     LOAD_FAST                       11: _var_var_34
                        300     BINARY_MULTIPLY                 
                        302     BINARY_ADD                      
                        304     LOAD_FAST                       5: _var_var_25
                        306     BINARY_ADD                      
                        308     LOAD_FAST                       9: _var_var_49
                        310     BINARY_TRUE_DIVIDE              
                        312     CALL_METHOD                     3
                        314     LOAD_FAST                       0: self
                        316     LOAD_ATTR                       0: cal_dict
                        318     LOAD_CONST                      5: 'overhang'
                        320     BINARY_SUBSCR                   
                        322     LOAD_FAST                       6: _var_var_11
                        324     BINARY_SUBSCR                   
                        326     LOAD_FAST                       7: _var_var_47
                        328     STORE_SUBSCR                    
                        330     LOAD_FAST                       7: _var_var_47
                        332     LOAD_CONST                      21: ('S', 'SE', 'E', 'NE')
                        334     CONTAINS_OP                     0 (in)
                        336     POP_JUMP_IF_FALSE               366
                        340     LOAD_FAST                       4: _var_var_24
                        342     LOAD_FAST                       8: _var_var_48
                        344     BINARY_SUBTRACT                 
                        346     LOAD_CONST                      22: 90
                        348     COMPARE_OP                      4 (>)
                        350     LOAD_FAST                       4: _var_var_24
                        352     LOAD_FAST                       8: _var_var_48
                        354     BINARY_SUBTRACT                 
                        356     LOAD_CONST                      17: 0
                        358     COMPARE_OP                      0 (<)
                        360     BINARY_OR                       
                        362     STORE_FAST                      13: _var_var_51
                        364     JUMP_FORWARD                    24 (to 390)
                        366     LOAD_FAST                       4: _var_var_24
                        368     LOAD_FAST                       8: _var_var_48
                        370     BINARY_SUBTRACT                 
                        372     LOAD_CONST                      23: -90
                        374     COMPARE_OP                      0 (<)
                        376     LOAD_FAST                       4: _var_var_24
                        378     LOAD_FAST                       8: _var_var_48
                        380     BINARY_SUBTRACT                 
                        382     LOAD_CONST                      17: 0
                        384     COMPARE_OP                      4 (>)
                        386     BINARY_OR                       
                        388     STORE_FAST                      13: _var_var_51
                        390     LOAD_GLOBAL                     5: np
                        392     LOAD_METHOD                     6: maximum
                        394     LOAD_CONST                      17: 0
                        396     LOAD_CONST                      18: 1
                        398     LOAD_CONST                      19: 0.5
                        400     LOAD_GLOBAL                     5: np
                        402     LOAD_METHOD                     7: tan
                        404     LOAD_GLOBAL                     5: np
                        406     LOAD_METHOD                     8: radians
                        408     LOAD_FAST                       6: _var_var_11
                        410     CALL_METHOD                     1
                        412     CALL_METHOD                     1
                        414     BINARY_MULTIPLY                 
                        416     LOAD_GLOBAL                     5: np
                        418     LOAD_METHOD                     7: tan
                        420     LOAD_GLOBAL                     5: np
                        422     LOAD_METHOD                     8: radians
                        424     LOAD_CONST                      20: 90
                        426     LOAD_GLOBAL                     5: np
                        428     LOAD_METHOD                     10: abs
                        430     LOAD_FAST                       4: _var_var_24
                        432     LOAD_FAST                       8: _var_var_48
                        434     BINARY_SUBTRACT                 
                        436     CALL_METHOD                     1
                        438     BINARY_SUBTRACT                 
                        440     CALL_METHOD                     1
                        442     CALL_METHOD                     1
                        444     BINARY_TRUE_DIVIDE              
                        446     BINARY_SUBTRACT                 
                        448     CALL_METHOD                     2
                        450     STORE_FAST                      14: _var_var_52
                        452     LOAD_GLOBAL                     5: np
                        454     LOAD_METHOD                     9: where
                        456     LOAD_FAST                       9: _var_var_49
                        458     LOAD_CONST                      17: 0
                        460     COMPARE_OP                      2 (==)
                        462     LOAD_CONST                      17: 0
                        464     LOAD_GLOBAL                     5: np
                        466     LOAD_METHOD                     9: where
                        468     LOAD_FAST                       13: _var_var_51
                        470     LOAD_CONST                      18: 1
                        472     LOAD_FAST                       14: _var_var_52
                        474     LOAD_FAST                       10: _var_var_32
                        476     BINARY_MULTIPLY                 
                        478     LOAD_FAST                       11: _var_var_34
                        480     BINARY_ADD                      
                        482     LOAD_FAST                       5: _var_var_25
                        484     BINARY_ADD                      
                        486     LOAD_FAST                       9: _var_var_49
                        488     BINARY_TRUE_DIVIDE              
                        490     CALL_METHOD                     3
                        492     CALL_METHOD                     3
                        494     LOAD_FAST                       0: self
                        496     LOAD_ATTR                       0: cal_dict
                        498     LOAD_CONST                      6: 'fin'
                        500     BINARY_SUBSCR                   
                        502     LOAD_FAST                       6: _var_var_11
                        504     BINARY_SUBSCR                   
                        506     LOAD_FAST                       7: _var_var_47
                        508     STORE_SUBSCR                    
                        510     JUMP_ABSOLUTE                   146
                        512     JUMP_ABSOLUTE                   104
                        514     LOAD_GLOBAL                     3: range
                        516     LOAD_CONST                      24: 10
                        518     LOAD_CONST                      25: 81
                        520     LOAD_CONST                      24: 10
                        522     CALL_FUNCTION                   3
                        524     GET_ITER                        
                        526     FOR_ITER                        138 (to 666)
                        528     STORE_FAST                      6: _var_var_11
                        530     BUILD_MAP                       0
                        532     LOAD_FAST                       0: self
                        534     LOAD_ATTR                       0: cal_dict
                        536     LOAD_CONST                      7: 'horizon'
                        538     BINARY_SUBSCR                   
                        540     LOAD_FAST                       6: _var_var_11
                        542     STORE_SUBSCR                    
                        544     LOAD_FAST                       2: _var_var_26
                        546     LOAD_METHOD                     4: iterAttributes
                        548     CALL_METHOD                     0
                        550     GET_ITER                        
                        552     FOR_ITER                        108 (to 662)
                        554     UNPACK_SEQUENCE                 2
                        556     STORE_FAST                      7: _var_var_47
                        558     STORE_FAST                      8: _var_var_48
                        560     LOAD_FAST                       0: self
                        562     LOAD_ATTR                       0: cal_dict
                        564     LOAD_CONST                      13: 'surf'
                        566     BINARY_SUBSCR                   
                        568     LOAD_FAST                       7: _var_var_47
                        570     BINARY_SUBSCR                   
                        572     LOAD_CONST                      14: 'GSR'
                        574     BINARY_SUBSCR                   
                        576     STORE_FAST                      9: _var_var_49
                        578     LOAD_FAST                       0: self
                        580     LOAD_ATTR                       0: cal_dict
                        582     LOAD_CONST                      13: 'surf'
                        584     BINARY_SUBSCR                   
                        586     LOAD_FAST                       7: _var_var_47
                        588     BINARY_SUBSCR                   
                        590     LOAD_CONST                      15: 'Et_b'
                        592     BINARY_SUBSCR                   
                        594     STORE_FAST                      10: _var_var_32
                        596     LOAD_GLOBAL                     5: np
                        598     LOAD_METHOD                     9: where
                        600     LOAD_FAST                       9: _var_var_49
                        602     LOAD_CONST                      17: 0
                        604     COMPARE_OP                      2 (==)
                        606     LOAD_CONST                      17: 0
                        608     LOAD_GLOBAL                     5: np
                        610     LOAD_METHOD                     9: where
                        612     LOAD_GLOBAL                     5: np
                        614     LOAD_METHOD                     6: maximum
                        616     LOAD_FAST                       3: _var_var_19
                        618     LOAD_CONST                      17: 0
                        620     CALL_METHOD                     2
                        622     LOAD_FAST                       6: _var_var_11
                        624     COMPARE_OP                      0 (<)
                        626     LOAD_CONST                      18: 1
                        628     LOAD_FAST                       10: _var_var_32
                        630     LOAD_FAST                       9: _var_var_49
                        632     BINARY_TRUE_DIVIDE              
                        634     BINARY_SUBTRACT                 
                        636     LOAD_CONST                      18: 1
                        638     CALL_METHOD                     3
                        640     CALL_METHOD                     3
                        642     LOAD_FAST                       0: self
                        644     LOAD_ATTR                       0: cal_dict
                        646     LOAD_CONST                      7: 'horizon'
                        648     BINARY_SUBSCR                   
                        650     LOAD_FAST                       6: _var_var_11
                        652     BINARY_SUBSCR                   
                        654     LOAD_FAST                       7: _var_var_47
                        656     STORE_SUBSCR                    
                        658     JUMP_ABSOLUTE                   552
                        662     JUMP_ABSOLUTE                   526
                        666     POP_BLOCK                       
                        668     LOAD_CONST                      26: '__pyarmor_exit_47531__'
                        670     NOP                             
                        672     NOP                             
                        674     LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x14\x88\x02\x00\x00\x00\x00\x00\x00'
                        676     CALL_FUNCTION                   1
                        678     POP_TOP                         
                        680     JUMP_FORWARD                    14 (to 696)
                        682     LOAD_CONST                      26: '__pyarmor_exit_47531__'
                        684     NOP                             
                        686     NOP                             
                        688     LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x14\x88\x02\x00\x00\x00\x00\x00\x00'
                        690     CALL_FUNCTION                   1
                        692     POP_TOP                         
                        694     RERAISE                         
                        696     LOAD_CONST                      0: None
                        698     RETURN_VALUE                    
                'Weather.cal_SRF'
                [Code]
                    File Name: <frozen weather>
                    Object Name: cal_Esol
                    Arg Count: 1
                    Pos Only Arg Count: 0
                    KW Only Arg Count: 0
                    Locals: 13
                    Stack Size: 9
                    Flags: 0x20000043 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NOFREE | CO_PYARMOR_OBFUSCATED)
                    [Names]
                        'cal_dict'
                        'wea_dict'
                        'lib'
                        'Surface'
                        'np'
                        'sin'
                        'range'
                        'radians'
                        'iterAttributes'
                        'cos'
                        'clip'
                    [Var Names]
                        'self'
                        '__assert_armored__'
                        '_var_var_18'
                        '_var_var_53'
                        '_var_var_24'
                        '_var_var_26'
                        '_var_var_54'
                        '_var_var_55'
                        '_var_var_56'
                        '_var_var_47'
                        '_var_var_48'
                        '_var_var_57'
                        '_var_var_58'
                    [Free Vars]
                    [Cell Vars]
                    [Constants]
                        None
                        '__pyarmor_assert_47532__'
                        'Weather.cal_Esol.<locals>.<lambda>'
                        '__pyarmor_enter_47533__'
                        b'<COAddr>\x01\x00\x00\x14\xe4\x00\x00\x00\x00\x00\x00\x00'
                        'Esol'
                        'beta_rad'
                        'Egh'
                        'fai_deg'
                        15
                        91
                        0
                        1500
                        '__pyarmor_exit_47534__'
                    [Disassembly]
                        0       NOP                             
                        2       NOP                             
                        4       NOP                             
                        6       NOP                             
                        8       LOAD_CONST                      3: '__pyarmor_enter_47533__'
                        10      NOP                             
                        12      NOP                             
                        14      LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14\xe4\x00\x00\x00\x00\x00\x00\x00'
                        16      CALL_FUNCTION                   1
                        18      POP_TOP                         
                        20      SETUP_FINALLY                   240 (to 262)
                        22      BUILD_MAP                       0
                        24      LOAD_FAST                       0: self
                        26      LOAD_ATTR                       0: cal_dict
                        28      LOAD_CONST                      5: 'Esol'
                        30      STORE_SUBSCR                    
                        32      LOAD_FAST                       0: self
                        34      LOAD_ATTR                       0: cal_dict
                        36      LOAD_CONST                      6: 'beta_rad'
                        38      BINARY_SUBSCR                   
                        40      STORE_FAST                      2: _var_var_18
                        42      LOAD_FAST                       0: self
                        44      LOAD_ATTR                       1: wea_dict
                        46      LOAD_CONST                      7: 'Egh'
                        48      BINARY_SUBSCR                   
                        50      STORE_FAST                      3: _var_var_53
                        52      LOAD_FAST                       0: self
                        54      LOAD_ATTR                       0: cal_dict
                        56      LOAD_CONST                      8: 'fai_deg'
                        58      BINARY_SUBSCR                   
                        60      STORE_FAST                      4: _var_var_24
                        62      LOAD_GLOBAL                     2: lib
                        64      LOAD_METHOD                     3: Surface
                        66      CALL_METHOD                     0
                        68      STORE_FAST                      5: _var_var_26
                        70      LOAD_FAST                       3: _var_var_53
                        72      LOAD_GLOBAL                     4: np
                        74      LOAD_METHOD                     5: sin
                        76      LOAD_FAST                       2: _var_var_18
                        78      CALL_METHOD                     1
                        80      BINARY_TRUE_DIVIDE              
                        82      STORE_FAST                      6: _var_var_54
                        84      LOAD_GLOBAL                     6: range
                        86      LOAD_CONST                      9: 15
                        88      LOAD_CONST                      10: 91
                        90      LOAD_CONST                      9: 15
                        92      CALL_FUNCTION                   3
                        94      GET_ITER                        
                        96      FOR_ITER                        148 (to 246)
                        98      STORE_FAST                      7: _var_var_55
                        100     LOAD_GLOBAL                     4: np
                        102     LOAD_METHOD                     7: radians
                        104     LOAD_FAST                       7: _var_var_55
                        106     CALL_METHOD                     1
                        108     STORE_FAST                      8: _var_var_56
                        110     BUILD_MAP                       0
                        112     LOAD_FAST                       0: self
                        114     LOAD_ATTR                       0: cal_dict
                        116     LOAD_CONST                      5: 'Esol'
                        118     BINARY_SUBSCR                   
                        120     LOAD_FAST                       7: _var_var_55
                        122     STORE_SUBSCR                    
                        124     LOAD_FAST                       5: _var_var_26
                        126     LOAD_METHOD                     8: iterAttributes
                        128     CALL_METHOD                     0
                        130     GET_ITER                        
                        132     FOR_ITER                        110 (to 244)
                        134     UNPACK_SEQUENCE                 2
                        136     STORE_FAST                      9: _var_var_47
                        138     STORE_FAST                      10: _var_var_48
                        140     LOAD_GLOBAL                     4: np
                        142     LOAD_METHOD                     7: radians
                        144     LOAD_FAST                       10: _var_var_48
                        146     CALL_METHOD                     1
                        148     STORE_FAST                      11: _var_var_57
                        150     LOAD_FAST                       6: _var_var_54
                        152     LOAD_GLOBAL                     4: np
                        154     LOAD_METHOD                     9: cos
                        156     LOAD_FAST                       2: _var_var_18
                        158     CALL_METHOD                     1
                        160     LOAD_GLOBAL                     4: np
                        162     LOAD_METHOD                     5: sin
                        164     LOAD_FAST                       8: _var_var_56
                        166     CALL_METHOD                     1
                        168     BINARY_MULTIPLY                 
                        170     LOAD_GLOBAL                     4: np
                        172     LOAD_METHOD                     9: cos
                        174     LOAD_GLOBAL                     4: np
                        176     LOAD_METHOD                     7: radians
                        178     LOAD_FAST                       4: _var_var_24
                        180     CALL_METHOD                     1
                        182     LOAD_FAST                       11: _var_var_57
                        184     BINARY_SUBTRACT                 
                        186     CALL_METHOD                     1
                        188     BINARY_MULTIPLY                 
                        190     LOAD_GLOBAL                     4: np
                        192     LOAD_METHOD                     5: sin
                        194     LOAD_FAST                       2: _var_var_18
                        196     CALL_METHOD                     1
                        198     LOAD_GLOBAL                     4: np
                        200     LOAD_METHOD                     9: cos
                        202     LOAD_FAST                       8: _var_var_56
                        204     CALL_METHOD                     1
                        206     BINARY_MULTIPLY                 
                        208     BINARY_ADD                      
                        210     BINARY_MULTIPLY                 
                        212     STORE_FAST                      12: _var_var_58
                        214     LOAD_GLOBAL                     4: np
                        216     LOAD_METHOD                     10: clip
                        218     LOAD_FAST                       12: _var_var_58
                        220     LOAD_CONST                      11: 0
                        222     LOAD_CONST                      12: 1500
                        224     CALL_METHOD                     3
                        226     LOAD_FAST                       0: self
                        228     LOAD_ATTR                       0: cal_dict
                        230     LOAD_CONST                      5: 'Esol'
                        232     BINARY_SUBSCR                   
                        234     LOAD_FAST                       7: _var_var_55
                        236     BINARY_SUBSCR                   
                        238     LOAD_FAST                       9: _var_var_47
                        240     STORE_SUBSCR                    
                        242     JUMP_ABSOLUTE                   132
                        244     JUMP_ABSOLUTE                   96
                        246     POP_BLOCK                       
                        248     LOAD_CONST                      13: '__pyarmor_exit_47534__'
                        250     NOP                             
                        252     NOP                             
                        254     LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14\xe4\x00\x00\x00\x00\x00\x00\x00'
                        256     CALL_FUNCTION                   1
                        258     POP_TOP                         
                        260     JUMP_FORWARD                    14 (to 276)
                        262     LOAD_CONST                      13: '__pyarmor_exit_47534__'
                        264     NOP                             
                        266     NOP                             
                        268     LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14\xe4\x00\x00\x00\x00\x00\x00\x00'
                        270     CALL_FUNCTION                   1
                        272     POP_TOP                         
                        274     RERAISE                         
                        276     LOAD_CONST                      0: None
                        278     RETURN_VALUE                    
                'Weather.cal_Esol'
                [Code]
                    File Name: <frozen weather>
                    Object Name: getCalDict
                    Arg Count: 1
                    Pos Only Arg Count: 0
                    KW Only Arg Count: 0
                    Locals: 2
                    Stack Size: 8
                    Flags: 0x20000043 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NOFREE | CO_PYARMOR_OBFUSCATED)
                    [Names]
                        'cal_Ydate'
                        'cal_tao'
                        'cal_ET'
                        'cal_AST'
                        'cal_solarDegree'
                        'cal_azimuth'
                        'cal_surface'
                        'cal_mmv'
                        'cal_SRF'
                        'cal_Esol'
                        'cal_dict'
                    [Var Names]
                        'self'
                        '__assert_armored__'
                    [Free Vars]
                    [Cell Vars]
                    [Constants]
                        None
                        '__pyarmor_assert_47535__'
                        'Weather.getCalDict.<locals>.<lambda>'
                        '__pyarmor_enter_47536__'
                        b'<COAddr>\x03\x00\x00\x14X\x00\x00\x00\x00\x00\x00\x00'
                        '__pyarmor_exit_47537__'
                    [Disassembly]
                        0       NOP                             
                        2       NOP                             
                        4       NOP                             
                        6       NOP                             
                        8       LOAD_CONST                      3: '__pyarmor_enter_47536__'
                        10      NOP                             
                        12      NOP                             
                        14      LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x14X\x00\x00\x00\x00\x00\x00\x00'
                        16      CALL_FUNCTION                   1
                        18      POP_TOP                         
                        20      SETUP_FINALLY                   100 (to 122)
                        22      LOAD_FAST                       0: self
                        24      LOAD_METHOD                     0: cal_Ydate
                        26      CALL_METHOD                     0
                        28      POP_TOP                         
                        30      LOAD_FAST                       0: self
                        32      LOAD_METHOD                     1: cal_tao
                        34      CALL_METHOD                     0
                        36      POP_TOP                         
                        38      LOAD_FAST                       0: self
                        40      LOAD_METHOD                     2: cal_ET
                        42      CALL_METHOD                     0
                        44      POP_TOP                         
                        46      LOAD_FAST                       0: self
                        48      LOAD_METHOD                     3: cal_AST
                        50      CALL_METHOD                     0
                        52      POP_TOP                         
                        54      LOAD_FAST                       0: self
                        56      LOAD_METHOD                     4: cal_solarDegree
                        58      CALL_METHOD                     0
                        60      POP_TOP                         
                        62      LOAD_FAST                       0: self
                        64      LOAD_METHOD                     5: cal_azimuth
                        66      CALL_METHOD                     0
                        68      POP_TOP                         
                        70      LOAD_FAST                       0: self
                        72      LOAD_METHOD                     6: cal_surface
                        74      CALL_METHOD                     0
                        76      POP_TOP                         
                        78      LOAD_FAST                       0: self
                        80      LOAD_METHOD                     7: cal_mmv
                        82      CALL_METHOD                     0
                        84      POP_TOP                         
                        86      LOAD_FAST                       0: self
                        88      LOAD_METHOD                     8: cal_SRF
                        90      CALL_METHOD                     0
                        92      POP_TOP                         
                        94      LOAD_FAST                       0: self
                        96      LOAD_METHOD                     9: cal_Esol
                        98      CALL_METHOD                     0
                        100     POP_TOP                         
                        102     LOAD_FAST                       0: self
                        104     LOAD_ATTR                       10: cal_dict
                        106     POP_BLOCK                       
                        108     LOAD_CONST                      5: '__pyarmor_exit_47537__'
                        110     NOP                             
                        112     NOP                             
                        114     LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x14X\x00\x00\x00\x00\x00\x00\x00'
                        116     CALL_FUNCTION                   1
                        118     POP_TOP                         
                        120     RETURN_VALUE                    
                        122     LOAD_CONST                      5: '__pyarmor_exit_47537__'
                        124     NOP                             
                        126     NOP                             
                        128     LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x14X\x00\x00\x00\x00\x00\x00\x00'
                        130     CALL_FUNCTION                   1
                        132     POP_TOP                         
                        134     RERAISE                         
                        136     LOAD_CONST                      0: None
                        138     RETURN_VALUE                    
                'Weather.getCalDict'
                [Code]
                    File Name: <frozen weather>
                    Object Name: getWeaDict
                    Arg Count: 1
                    Pos Only Arg Count: 0
                    KW Only Arg Count: 0
                    Locals: 2
                    Stack Size: 8
                    Flags: 0x20000043 (CO_OPTIMIZED | CO_NEWLOCALS | CO_NOFREE | CO_PYARMOR_OBFUSCATED)
                    [Names]
                        'wea_dict'
                    [Var Names]
                        'self'
                        '__assert_armored__'
                    [Free Vars]
                    [Cell Vars]
                    [Constants]
                        None
                        '__pyarmor_assert_47538__'
                        'Weather.getWeaDict.<locals>.<lambda>'
                        '__pyarmor_enter_47539__'
                        b'<COAddr>\x01\x00\x00\x14\x08\x00\x00\x00\x00\x00\x00\x00'
                        '__pyarmor_exit_47540__'
                    [Disassembly]
                        0       NOP                             
                        2       NOP                             
                        4       NOP                             
                        6       NOP                             
                        8       LOAD_CONST                      3: '__pyarmor_enter_47539__'
                        10      NOP                             
                        12      NOP                             
                        14      LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14\x08\x00\x00\x00\x00\x00\x00\x00'
                        16      CALL_FUNCTION                   1
                        18      POP_TOP                         
                        20      SETUP_FINALLY                   20 (to 42)
                        22      LOAD_FAST                       0: self
                        24      LOAD_ATTR                       0: wea_dict
                        26      POP_BLOCK                       
                        28      LOAD_CONST                      5: '__pyarmor_exit_47540__'
                        30      NOP                             
                        32      NOP                             
                        34      LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14\x08\x00\x00\x00\x00\x00\x00\x00'
                        36      CALL_FUNCTION                   1
                        38      POP_TOP                         
                        40      RETURN_VALUE                    
                        42      LOAD_CONST                      5: '__pyarmor_exit_47540__'
                        44      NOP                             
                        46      NOP                             
                        48      LOAD_CONST                      4: b'<COAddr>\x01\x00\x00\x14\x08\x00\x00\x00\x00\x00\x00\x00'
                        50      CALL_FUNCTION                   1
                        52      POP_TOP                         
                        54      RERAISE                         
                        56      LOAD_CONST                      0: None
                        58      RETURN_VALUE                    
                'Weather.getWeaDict'
                '__pyarmor_exit_47495__'
                None
            [Disassembly]
                0       LOAD_NAME                       0: __name__
                2       STORE_NAME                      1: __module__
                4       LOAD_CONST                      0: 'Weather'
                6       STORE_NAME                      2: __qualname__
                8       NOP                             
                10      NOP                             
                12      NOP                             
                14      NOP                             
                16      LOAD_CONST                      3: '__pyarmor_enter_47494__'
                18      NOP                             
                20      NOP                             
                22      LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x1ct\x00\x00\x00\x00\x00\x00\x00'
                24      CALL_FUNCTION                   1
                26      POP_TOP                         
                28      SETUP_FINALLY                   128 (to 158)
                30      LOAD_CONST                      5: <CODE> __init__
                32      LOAD_CONST                      6: 'Weather.__init__'
                34      MAKE_FUNCTION                   0
                36      STORE_NAME                      4: __init__
                38      LOAD_CONST                      7: <CODE> getWeather
                40      LOAD_CONST                      8: 'Weather.getWeather'
                42      MAKE_FUNCTION                   0
                44      STORE_NAME                      5: getWeather
                46      LOAD_CONST                      9: <CODE> cal_Ydate
                48      LOAD_CONST                      10: 'Weather.cal_Ydate'
                50      MAKE_FUNCTION                   0
                52      STORE_NAME                      6: cal_Ydate
                54      LOAD_CONST                      11: <CODE> cal_tao
                56      LOAD_CONST                      12: 'Weather.cal_tao'
                58      MAKE_FUNCTION                   0
                60      STORE_NAME                      7: cal_tao
                62      LOAD_CONST                      13: <CODE> cal_ET
                64      LOAD_CONST                      14: 'Weather.cal_ET'
                66      MAKE_FUNCTION                   0
                68      STORE_NAME                      8: cal_ET
                70      LOAD_CONST                      15: <CODE> cal_AST
                72      LOAD_CONST                      16: 'Weather.cal_AST'
                74      MAKE_FUNCTION                   0
                76      STORE_NAME                      9: cal_AST
                78      LOAD_CONST                      17: <CODE> cal_solarDegree
                80      LOAD_CONST                      18: 'Weather.cal_solarDegree'
                82      MAKE_FUNCTION                   0
                84      STORE_NAME                      10: cal_solarDegree
                86      LOAD_CONST                      19: <CODE> cal_azimuth
                88      LOAD_CONST                      20: 'Weather.cal_azimuth'
                90      MAKE_FUNCTION                   0
                92      STORE_NAME                      11: cal_azimuth
                94      LOAD_CONST                      21: <CODE> cal_surface
                96      LOAD_CONST                      22: 'Weather.cal_surface'
                98      MAKE_FUNCTION                   0
                100     STORE_NAME                      12: cal_surface
                102     LOAD_CONST                      23: <CODE> cal_mmv
                104     LOAD_CONST                      24: 'Weather.cal_mmv'
                106     MAKE_FUNCTION                   0
                108     STORE_NAME                      13: cal_mmv
                110     LOAD_CONST                      25: <CODE> cal_SRF
                112     LOAD_CONST                      26: 'Weather.cal_SRF'
                114     MAKE_FUNCTION                   0
                116     STORE_NAME                      14: cal_SRF
                118     LOAD_CONST                      27: <CODE> cal_Esol
                120     LOAD_CONST                      28: 'Weather.cal_Esol'
                122     MAKE_FUNCTION                   0
                124     STORE_NAME                      15: cal_Esol
                126     LOAD_CONST                      29: <CODE> getCalDict
                128     LOAD_CONST                      30: 'Weather.getCalDict'
                130     MAKE_FUNCTION                   0
                132     STORE_NAME                      16: getCalDict
                134     LOAD_CONST                      31: <CODE> getWeaDict
                136     LOAD_CONST                      32: 'Weather.getWeaDict'
                138     MAKE_FUNCTION                   0
                140     STORE_NAME                      17: getWeaDict
                142     POP_BLOCK                       
                144     LOAD_CONST                      33: '__pyarmor_exit_47495__'
                146     NOP                             
                148     NOP                             
                150     LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x1ct\x00\x00\x00\x00\x00\x00\x00'
                152     CALL_FUNCTION                   1
                154     POP_TOP                         
                156     JUMP_FORWARD                    14 (to 172)
                158     LOAD_CONST                      33: '__pyarmor_exit_47495__'
                160     NOP                             
                162     NOP                             
                164     LOAD_CONST                      4: b'<COAddr>\x03\x00\x00\x1ct\x00\x00\x00\x00\x00\x00\x00'
                166     CALL_FUNCTION                   1
                168     POP_TOP                         
                170     RERAISE                         
                172     LOAD_CONST                      34: None
                174     RETURN_VALUE                    
        'Weather'
        '__pyarmor_exit_47492__'
    [Disassembly]
        0       NOP                             
        2       NOP                             
        4       NOP                             
        6       NOP                             
        8       LOAD_CONST                      2: '__pyarmor_enter_47491__'
        10      NOP                             
        12      NOP                             
        14      LOAD_CONST                      3: b'<COAddr>\x01\x00\x00\x14R\x00\x00\x00\x00\x00\x00\x00'
        16      CALL_FUNCTION                   1
        18      POP_TOP                         
        20      SETUP_FINALLY                   94 (to 116)
        22      LOAD_CONST                      4: 0
        24      LOAD_CONST                      5: None
        26      IMPORT_NAME                     1: os
        28      STORE_NAME                      1: os
        30      LOAD_CONST                      4: 0
        32      LOAD_CONST                      5: None
        34      IMPORT_NAME                     2: csv
        36      STORE_NAME                      2: csv
        38      LOAD_CONST                      4: 0
        40      LOAD_CONST                      5: None
        42      IMPORT_NAME                     3: collections
        44      STORE_NAME                      3: collections
        46      LOAD_CONST                      4: 0
        48      LOAD_CONST                      5: None
        50      IMPORT_NAME                     4: lib
        52      STORE_NAME                      4: lib
        54      LOAD_CONST                      4: 0
        56      LOAD_CONST                      5: None
        58      IMPORT_NAME                     5: numpy
        60      STORE_NAME                      6: np
        62      LOAD_CONST                      4: 0
        64      LOAD_CONST                      5: None
        66      IMPORT_NAME                     7: pandas
        68      STORE_NAME                      8: pd
        70      LOAD_CONST                      6: 90
        72      STORE_NAME                      9: sigma
        74      LOAD_CONST                      7: 1
        76      STORE_NAME                      10: area
        78      LOAD_CONST                      8: 1367
        80      STORE_NAME                      11: esc
        82      LOAD_CONST                      9: 0.14
        84      STORE_NAME                      12: r_g
        86      LOAD_BUILD_CLASS                
        88      LOAD_CONST                      10: <CODE> Weather
        90      LOAD_CONST                      11: 'Weather'
        92      MAKE_FUNCTION                   0
        94      LOAD_CONST                      11: 'Weather'
        96      CALL_FUNCTION                   2
        98      STORE_NAME                      13: Weather
        100     POP_BLOCK                       
        102     LOAD_CONST                      12: '__pyarmor_exit_47492__'
        104     NOP                             
        106     NOP                             
        108     LOAD_CONST                      3: b'<COAddr>\x01\x00\x00\x14R\x00\x00\x00\x00\x00\x00\x00'
        110     CALL_FUNCTION                   1
        112     POP_TOP                         
        114     JUMP_FORWARD                    14 (to 130)
        116     LOAD_CONST                      12: '__pyarmor_exit_47492__'
        118     NOP                             
        120     NOP                             
        122     LOAD_CONST                      3: b'<COAddr>\x01\x00\x00\x14R\x00\x00\x00\x00\x00\x00\x00'
        124     CALL_FUNCTION                   1
        126     POP_TOP                         
        128     RERAISE                         
        130     LOAD_CONST                      5: None
        132     RETURN_VALUE                    
