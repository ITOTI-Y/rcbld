import os, lib, sys
import simulation
import warnings
import numpy as np
import time

def strtobool(val):
    val = val.lower()
    if val in ('y', 'yes', 't', 'true', 'on', '1'):
        return True
    elif val in ('n', 'no', 'f', 'false', 'off', '0'):
        return False
    else:
        raise ValueError("invalid truth value %r" % (val,))

def baseCEN(building, first_day, runcode, **kwargs):
    start_time = time.time()
    parent_folder = os.path.abspath(os.path.join(os.getcwd(), os.pardir))+"\\"
    project_folder = parent_folder+"Projects\\"+building+'\\'
    run_folder = project_folder + runcode + '\\'
    read = lib.Read_Inputs(run_folder+building+'_'+runcode+'.sim')  
    input_dict = read.getInputDict()
    
    if_pmv = strtobool(kwargs.get('if_pmv', 'False'))
    if_print = strtobool(kwargs.get('if_print', 'True'))
    solver = kwargs.get('solver', 'crank-nicholson')
    infl_style = kwargs.get('infl_style', 'constant')
    DHW_style = kwargs.get('DHW_style', 'real')
    weather_mode = kwargs.get('weather_mode', 'default')
    
     ##  
    file_path=run_folder+building+'_'+runcode+'.sol'
    if os.path.isfile(file_path):
        with open(file_path, 'r',encoding='utf-8') as file:
            first_char = file.read(1)
        if not first_char:
            print("No RCBldGH radiance")
        else:  
            with open(run_folder+building+'_'+runcode+'.sol', 'r', encoding='utf-8') as f_solar:
                content=f_solar.readlines()
            for i in range(len(content)):
                if ':' in content[i]:
                    #setattr(input_dict["Zones"][content[i].split(':')[0]], 'Solar', np.array(content[i].split(':')[1].split(',')).astype(float))
                    input_dict["Zones"][content[i].split(':')[0]]['Solar_OP']=np.array(content[i].split(':')[1].split(';')[1].split(',')).astype(float)
                    input_dict["Zones"][content[i].split(':')[0]]['Solar_W']= np.array(content[i].split(':')[1].split(';')[0].split(',')).astype(float)  
    ##

    sim = simulation.Simulation(input_dict, weather_mode, first_day=first_day, 
                              solver=solver, order=1, if_pmv=if_pmv, 
                              DHW_style=DHW_style, infl_style=infl_style, 
                              if_print=if_print)
    
    if not os.path.exists(run_folder):
        os.makedirs(run_folder)
        
    sim.run()
    sim.dumpResults(run_folder+building+'_'+runcode)
    
    end_time = time.time()
    print(f"Simulation completed in {end_time - start_time:.2f} seconds")

def main(argv, **kwargs):    
    baseCEN(argv[1], argv[2], argv[4], **kwargs)

if __name__ == '__main__': 
    warnings.filterwarnings("ignore")
    kwargs = dict(arg.split('=', 1) for arg in sys.argv[5:] if '=' in arg)
    main(sys.argv[:5], **kwargs)