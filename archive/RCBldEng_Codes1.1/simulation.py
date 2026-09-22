import os,collections, copy, comfort, weather, time
import numpy as np
import lib
import pandas as pd

#Constants
# parent_folder = '\\'.join(os.getcwd().split('\\')[0: os.getcwd().split('\\').index('Codes')])+'\\'
parent_folder = os.path.abspath(os.path.join(os.getcwd(), os.pardir))+"\\"

def print_progress_bar(iteration, total, prefix='Progress:', suffix='Complete', length=50):
    """
    Call in a loop to create terminal progress bar
    """
    percent = 100 * (iteration / float(total))
    filled_length = int(length * iteration // total)
    bar = '█' * filled_length + '-' * (length - filled_length)
    
    # Calculate time estimation
    elapsed_time = time.time() - print_progress_bar.start_time
    if iteration > 0:
        estimated_total_time = elapsed_time * total / iteration
        remaining_time = estimated_total_time - elapsed_time
        time_suffix = f" | Time remaining: {remaining_time:.1f}s"
    else:
        time_suffix = ""
    
    # Print progress bar
    print(f'\r{prefix} |{bar}| {percent:.1f}% {suffix}{time_suffix}', end='')
    
    # Print new line on complete
    if iteration == total:
        print()

class Simulation():
    def __init__(self, input_dict, wea_file, **kwargs):
        if kwargs is not None:
            for k, v in list(kwargs.items()):
                setattr(self, k.replace(' ', '_'), v) 
        self.input_dict = input_dict    
        if wea_file == 'default':
            self.W = weather.Weather(self.input_dict['Basics']['Weather File']) 
        else:
            self.W = weather.Weather(wea_file)       
        self.wea_dict = self.W.getWeaDict()        
        self.getInputClass()

    def getInputClass(self):
        # print self.input_dict
        if hasattr(self, 'if_print') and self.if_print == True:
            print('Reading model parameters from the input file...')
        if hasattr(self, 'first_day'):
            pre = lib.Pre_Calculation(self.wea_dict, self.input_dict, self.first_day)
        else:
            pre = lib.Pre_Calculation(self.wea_dict, self.input_dict, 'sun')
        if not hasattr(self, 'order'):
            self.order = 1; self.solver = 'crank-nicholson'
        if not hasattr(self, 'if_pmv'):
            self.if_pmv = True
        # pre.printDict()
        # print(self.if_pmv, self.solver, self.order, self.DHW_style, self.infl_style, self.if_print)
        pre_dict=pre.getDict(); self.pre_dict = pre_dict

        self.PV = lib.SubSystem(pre_dict['PV'])
        self.General = lib.SubSystem(pre_dict['General'])
        self.DHW = lib.SubSystem(pre_dict['DHW'])
        self.Pumps = lib.SubSystem(pre_dict['Pumps'])
        self.BEM = lib.SubSystem(pre_dict['BEM'])
        self.Wind_Turbines = lib.SubSystem(pre_dict['Wind_Turbines']) 
        self.At = self.General.At   #default: 4.5
        self.Am = self.General.Am
        self.T_er = self.wea_dict['T_er']; self.Te = self.wea_dict['DBT']; self.ws = self.wea_dict['wind']; self.rh = self.wea_dict['RH']
        self.rse = np.where(self.ws<=1.5, 0.08, np.where(self.ws<=2.5, 0.06, np.where(self.ws<=3.5, 0.05, np.where(self.ws<=6, 0.04, np.where(self.ws<=8.5, 0.03, 0.02)))))
        # self.beta_deg = self.SCal_dict['beta_deg']
        self.P_shading_threshold = 26 if self.General.building_type == 1 else 23    #threshold for shading control based on outdoor temperature
        if self.order == 2:
            self.Cm = self.General.Cm/3600
            self.Ct = 0.35*self.General.Cm/3600
        elif self.order == 1:
            self.Cm = self.General.Cm/3600
        return pre_dict
    
    def solarGain(self):
        if hasattr(self, 'if_print') and self.if_print == True:
            print('Calculating solar heat gain by default simplified solar radiation calculation method...')
        
        #原本的辐照计算方法 2025.1.14
        zname, zone = next(iter(self.pre_dict['Zones'].items()))        
        if hasattr(self.pre_dict['Zones'][zname],'Solar_OP')==False:
            print("no extra solar")
            self.SCal_dict = self.W.getCalDict()
            for zname, zone in list(self.pre_dict['Zones'].items()):
                zone.qi_env_dict_w = {} 
                zone.qi_env_dict_op = {} 
                # print zone.Envelopes.__dict__
                for mat, orient_dct in list(zone.Envelopes.__dict__.items()):
                    # print zname, mat, orient_dct
                    if np.array(list(orient_dct.values())).shape[1] == 12:    #window
                        zone.qi_env_dict_w[mat] = {}
                        zone.qi_env_dict_w[mat]['gain']={}; zone.qi_env_dict_w[mat]['reflection']={}; zone.qi_env_dict_w[mat]['shading_SRF']={}
                        for orient, lst in list(orient_dct.items()):                        
                            if orient != 'G':
                                SRF_overhang = 1 if lst[1] == 0 or orient == 'R' else self.SCal_dict['overhang'][lst[1]][orient]
                                SRF_fin = 1 if lst[2] == 0 or orient == 'R' else self.SCal_dict['fin'][lst[2]][orient]
                                SRF_horizon = 1 if lst[3] == 0 or orient == 'R' else self.SCal_dict['horizon'][lst[3]][orient]
                                zone.qi_env_dict_w[mat]['shading_SRF'][orient] = lst[4]
                                # zone.qi_env_dict_w[mat]['gain'][orient] = SRF_overhang*SRF_fin*SRF_horizon*self.SCal_dict['surf'][orient]['GSR']*lst[0]*(1-lst[-5])*Tsol    #SRFs*GSR*area*|shading_SRF|*(1-frame_factor)*transmission_factor
                                zone.qi_env_dict_w[mat]['gain'][orient] = SRF_overhang*SRF_fin*SRF_horizon*self.SCal_dict['surf'][orient]['GSR']*lst[0]*(1-lst[-5])*lst[-1] #SRFs*GSR*area*|shading_SRF|*(1-frame_factor)*transmission_factor
                                zone.qi_env_dict_w[mat]['reflection'][orient] = lst[5]*self.rse*lst[6]*lst[0]*lst[-4]*(self.Te - self.T_er)      # - form_factor*rse*U-value*area*5emissivity*delta_T               
                                #zone.qi_env_dict_w[mat]['reflection'][orient] = lst[5] * lst[-4] * 5.67e-8 * lst[0] * ((self.Te + 273.15)**4 - (self.T_er + 273.15)**4)    
                        zone.qi_env_dict_w[mat]['shading_SRF'] =  np.array(list(zone.qi_env_dict_w[mat]['shading_SRF'].values()))
                        zone.qi_env_dict_w[mat]['gain'] = np.array(list(zone.qi_env_dict_w[mat]['gain'].values())).transpose()
                        if np.count_nonzero(zone.qi_env_dict_w[mat]['gain']) == 0:
                            del zone.qi_env_dict_w[mat]

                    if np.array(list(orient_dct.values())).shape[1] == 5:     #wall and roof  ##面积、视角系数、U、吸收、发射
                        zone.qi_env_dict_op[mat] = {}
                        for orient, lst in list(orient_dct.items()):                            
                            if orient != 'G':
                                zone.qi_env_dict_op[mat][orient] = self.SCal_dict['surf'][orient]['GSR']*lst[0]*lst[2]*lst[3]*self.rse-lst[1]*self.rse*lst[2]*lst[0]*lst[-1]*(self.Te - self.T_er)  
                                  #   GSR*Area*U-value*absorption*rse - form_factor*rse*U-value*area*5emissivity*delta_T
                        if np.count_nonzero(np.array(list(zone.qi_env_dict_op[mat].values()))) == 0:
                            del zone.qi_env_dict_op[mat]   
                #solar heat gain calculation through opaque materials    
                zone.q_sol_op = np.sum(np.array([np.sum(np.array(list(orient_dict.values())), axis = 0) for mat, orient_dict in list(zone.qi_env_dict_op.items()) if np.array(list(zone.Envelopes.__dict__[mat].values())).shape[1] == 5]), axis = 0)/zone.Af #np.array(list(zone.Envelopes.__dict__[mat].values())).shape[1] == 5])  ##面积、视角系数、U、吸收、发射
                
                #solar heat gain calculation through windows            
                zone.q_sol_w_rfl = np.sum(np.array([np.sum(np.array(list(orient_dict['reflection'].values())), axis = 0) for mat, orient_dict in list(zone.qi_env_dict_w.items()) if np.array(list(zone.Envelopes.__dict__[mat].values())).shape[1] == 12]), axis = 0)/zone.Af
                zone.q_sol_w = np.where(self.Te > self.P_shading_threshold, np.sum(np.array([np.matmul(dct['gain'],dct['shading_SRF']) for mat, dct in list(zone.qi_env_dict_w.items())]), axis = 0)/zone.Af - zone.q_sol_w_rfl, np.sum(np.array([np.sum(dct['gain'], axis = 1) for mat, dct in list(zone.qi_env_dict_w.items())]), axis = 0)/zone.Af - zone.q_sol_w_rfl)
                
                #total solar heat gain                
                zone.q_sol = zone.q_sol_w+zone.q_sol_op  
        #接入外部的辐照数据                       
        else:  
            print("has extra solar")              
            self.SCal_dict = self.W.getCalDict()            
            for zname, zone in list(self.pre_dict['Zones'].items()):
                zone.qi_env_dict_w = {}; zone.qi_env_dict_op = {}  
                # print zone.Envelopes.__dict__
                for mat, orient_dct in list(zone.Envelopes.__dict__.items()):
                    # print zname, mat, orient_dct
                    if np.array(list(orient_dct.values())).shape[1] == 12:    #window
                        zone.qi_env_dict_w[mat] = {}
                        zone.qi_env_dict_w[mat]['gain']={}; zone.qi_env_dict_w[mat]['reflection']={}; zone.qi_env_dict_w[mat]['shading_SRF']={}
                        for orient, lst in list(orient_dct.items()):                        
                            if orient != 'G':
                                SRF_overhang = 1 if lst[1] == 0 or orient == 'R' else self.SCal_dict['overhang'][lst[1]][orient]
                                SRF_fin = 1 if lst[2] == 0 or orient == 'R' else self.SCal_dict['fin'][lst[2]][orient]
                                SRF_horizon = 1 if lst[3] == 0 or orient == 'R' else self.SCal_dict['horizon'][lst[3]][orient]
                                zone.qi_env_dict_w[mat]['shading_SRF'][orient] = lst[4]
                                # zone.qi_env_dict_w[mat]['gain'][orient] = SRF_overhang*SRF_fin*SRF_horizon*self.SCal_dict['surf'][orient]['GSR']*lst[0]*(1-lst[-5])*Tsol    #SRFs*GSR*area*|shading_SRF|*(1-frame_factor)*transmission_factor
                                zone.qi_env_dict_w[mat]['gain'][orient] = SRF_overhang*SRF_fin*SRF_horizon*self.SCal_dict['surf'][orient]['GSR']*lst[0]*(1-lst[-5])*lst[-1] #SRFs*GSR*area*|shading_SRF|*(1-frame_factor)*transmission_factor
                                zone.qi_env_dict_w[mat]['reflection'][orient] = lst[5]*self.rse*lst[6]*lst[0]*lst[-4]*(self.Te - self.T_er)      # - form_factor*rse*U-value*area*5emissivity*delta_T               
                        zone.qi_env_dict_w[mat]['shading_SRF'] =  np.array(list(zone.qi_env_dict_w[mat]['shading_SRF'].values()))
                        zone.qi_env_dict_w[mat]['gain'] = np.array(list(zone.qi_env_dict_w[mat]['gain'].values())).transpose()
                        if np.count_nonzero(zone.qi_env_dict_w[mat]['gain']) == 0:
                            del zone.qi_env_dict_w[mat]
                    if np.array(list(orient_dct.values())).shape[1] == 5:     #wall and roof
                        zone.qi_env_dict_op[mat] = {}
                        for orient, lst in list(orient_dct.items()):
                            if orient != 'G':
                                zone.qi_env_dict_op[mat][orient] = self.SCal_dict['surf'][orient]['GSR']*lst[0]*lst[2]*lst[3]*self.rse-lst[1]*self.rse*lst[2]*lst[0]*lst[-1]*(self.Te - self.T_er)    #   GSR*Area*U-value*absorption*rse - form_factor*rse*U-value*area*5emissivity*delta_T
                        if np.count_nonzero(np.array(list(zone.qi_env_dict_op[mat].values()))) == 0:
                            del zone.qi_env_dict_op[mat]   

                #solar heat gain calculation through opaque materials    
                zone.q_sol_op = np.sum(np.array([np.sum(np.array(list(orient_dict.values())), axis = 0) for mat, orient_dict in list(zone.qi_env_dict_op.items()) if np.array(list(zone.Envelopes.__dict__[mat].values())).shape[1] == 5]), axis = 0)/zone.Af

                #solar heat gain calculation through windows            
                zone.q_sol_w_rfl = np.sum(np.array([np.sum(np.array(list(orient_dict['reflection'].values())), axis = 0) for mat, orient_dict in list(zone.qi_env_dict_w.items()) if np.array(list(zone.Envelopes.__dict__[mat].values())).shape[1] == 12]), axis = 0)/zone.Af
                zone.q_sol_w = np.where(self.Te > self.P_shading_threshold, np.sum(np.array([np.matmul(dct['gain'],dct['shading_SRF']) for mat, dct in list(zone.qi_env_dict_w.items())]), axis = 0)/zone.Af - zone.q_sol_w_rfl, np.sum(np.array([np.sum(dct['gain'], axis = 1) for mat, dct in list(zone.qi_env_dict_w.items())]), axis = 0)/zone.Af - zone.q_sol_w_rfl)
                
                #total solar heat gain
                zone.q_sol = zone.q_sol_w+zone.q_sol_op              

            for zname, zone in list(self.pre_dict['Zones'].items()):            
                if hasattr(self.pre_dict['Zones'][zname],'Solar_OP'):
                    zone.q_sol_op==self.pre_dict['Zones'][zname].Solar_OP 
                    zone.q_sol_w=self.pre_dict['Zones'][zname].Solar_W
                    zone.q_sol= zone.q_sol_op + zone.q_sol_w
        #end  

    def otherHeatGain(self):
        ground_U = 0
        for zname, zone in list(self.pre_dict['Zones'].items()):
            zone.Htr_is = 3.2*self.At      #default: 3.45, transmission heat transfer coeff between internal air in the building (or zone) and all internal surfaces surrounding the building
            zone.Htr_w = sum([np.sum(np.array(list(value.values()))[:, 0]*np.array(list(value.values()))[:, 6]) for key, value in list(zone.Envelopes.__dict__.items()) if len(np.transpose(np.array(list(value.values()))))==12])      #transmission heat transfer coeff of window
            zone.Htr_op = sum([np.sum(np.array(list(value.values()))[:, 0]*np.array(list(value.values()))[:, 2]) for key, value in list(zone.Envelopes.__dict__.items()) if len(np.transpose(np.array(list(value.values()))))==5])      #transmission heat transfer coeff of opaque surface
            zone.Htr_ms = 9.0*self.Am       #transmission heat transfer coeff of internal structure
            zone.Htr_em = 1/(1/(zone.Htr_op/zone.Af)-1/zone.Htr_ms)
            # zone.Htr_em = 1/(1/(zone.Htr_op/zone.Af)-1/zone.Htr_ms) if 1/(1/(zone.Htr_op/zone.Af)-1/zone.Htr_ms)>0 else 0   #transmission heat transfer coeff of external structure    
            # zone.Htr_em = np.absolute(1/(1/(zone.Htr_op/zone.Af)-1/zone.Htr_ms))   #transmission heat transfer coeff of external structure    
            zone.prs = 1-self.Am/self.At-(zone.Htr_w/zone.Af)/(9.1*self.At) 
            # zone.prs = 1-self.Am/self.At-(zone.Htr_w/zone.Af + zone.Htr_iw)/(9.1*self.At) 
            zone.prm = self.Am/self.At
            ground_U += sum([sum(np.array(list(value.values()))[:,1])*sum(np.array(list(value.values()))[:,0]) for key, value in list(zone.Envelopes.__dict__.items()) if len(np.transpose(np.array(list(value.values()))))==2])
            zone.ground_U = sum([sum(np.array(list(value.values()))[:,1])*sum(np.array(list(value.values()))[:,0]) for key, value in list(zone.Envelopes.__dict__.items()) if len(np.transpose(np.array(list(value.values()))))==2])/zone.Af

            zone.qi_occ = zone.occupancy_frac*zone.occupant_load
            zone.qi_app = zone.equipment_frac*zone.appliance_load
            zone.qi_li = zone.light_frac*zone.lighting_load+zone.Lightings.P_pc
            zone.q_int = zone.qi_occ+zone.qi_app+zone.qi_li           
            zone.qv_supp_fctrl = zone.Ventilation.supply*zone.Ventilation.MV_sched
            zone.qv_exh = zone.qv_supp_fctrl
            zone.qv_diff = zone.qv_supp_fctrl - zone.qv_exh 
            zone.qv_supp = zone.qv_supp_fctrl*(1-zone.Ventilation.HR_eff)
            zone.q_ia = 0.5*zone.q_int      #heat flow to the internal air node
            zone.deltaT_water_H = zone.HVAC.T_Swater_H-zone.HVAC.T_Rwater_H if zone.HVAC.T_Swater_H != 0 and zone.HVAC.T_Rwater_H != 0 else 11
            zone.deltaT_water_C = zone.HVAC.T_Rwater_C-zone.HVAC.T_Swater_C if zone.HVAC.T_Swater_C != 0 and zone.HVAC.T_Rwater_C != 0 else 5
            zone.q_m = zone.prm*(0.5*zone.q_int+zone.q_sol)         #heat flow to the internal mass node
            zone.q_st = zone.prs*(0.5*zone.q_int+zone.q_sol)        #heat flow to the central node
            # print zone.Ventilation.Aow

        ground_U = ground_U/self.General.building_area
        self.Htr_gr = ground_U
        #adjacent zone process                
        for zname, zone in list(self.pre_dict['Zones'].items()): 
            zone.Htr_iw = sum([zone.U_iw*area for name, area in list(zone.adj_wall_zone.items())])/zone.Af + sum([zone.U_if*area for name, area in list(zone.adj_ceiling_zone.items())])/zone.Af 
            zone.Htr_if = 0
            for name, area in list(zone.adj_floor_zone.items()):
                if name == 'ground':
                    zone.Htr_if += self.Htr_gr * area
                else:
                    zone.Htr_if += zone.U_if * area
            zone.Htr_if = zone.Htr_if/zone.Af
            
        month = copy.deepcopy(self.wea_dict['month']).astype(np.float64)
        for i in range(len(month)):
            month[i] = self.General.ground_temperature[int(month[i])-1]
        self.T_gr = np.array(month)
        # print (ground_U)      

    def beforeIterate(self):
        for zname, zone in list(self.pre_dict['Zones'].items()): 
            zone.T_m_t_1_hc = zone.T_m_t_hc    #temperature of thermal mass
            zone.T_m_t_1_un = zone.T_m_t_hc
            zone.T_m_t_1_0 = zone.T_m_t_hc   

    def initiate(self):
        #T_air_hc = T_air_set
        if hasattr(self, 'if_print') and self.if_print == True:
            print('Initiating simulation...')
        for zname, zone in list(self.pre_dict['Zones'].items()):
            zone.T_m_t_hc = np.zeros(len(self.Te)+1); zone.T_m_t_hc[0]=zone.T_set_H[0]; zone.T_m_t_1_hc = np.zeros(len(self.Te))
            zone.T_m_t_0 = np.zeros(len(self.Te)+1); zone.T_m_t_0[0] = zone.T_set_H[0]; zone.T_m_t_1_0 = np.zeros(len(self.Te)) 
            zone.T_m_t_un = np.zeros(len(self.Te)+1); zone.T_m_t_un[0] = zone.T_set_H[0]; zone.T_m_t_1_un = np.zeros(len(self.Te))

            zone.q_m_tot_0 = np.zeros(len(self.Te)); zone.q_m_tot_un = np.zeros(len(self.Te)); zone.q_m_tot_hc = np.zeros(len(self.Te))
            # zone.q_s_tot_0 = np.zeros(len(self.Te)); zone.q_s_tot_un = np.zeros(len(self.Te)); zone.q_s_tot_hc = np.zeros(len(self.Te))
            zone.q_a_tot_0 = np.zeros(len(self.Te)); zone.q_a_tot_un = np.zeros(len(self.Te)); zone.q_a_tot_hc = np.zeros(len(self.Te))
            zone.T_op_0 = np.zeros(len(self.Te)); zone.T_op_un = np.zeros(len(self.Te)); zone.T_op_hc = np.zeros(len(self.Te))
            zone.T_m_hc = np.zeros(len(self.Te)+1); zone.T_m_0 = np.zeros(len(self.Te)+1); zone.T_m_un = np.zeros(len(self.Te)+1)
            zone.T_s_hc = np.zeros(len(self.Te)+1); zone.T_s_0 = np.zeros(len(self.Te)+1); zone.T_s_un = np.zeros(len(self.Te)+1)

            zone.T_air_hc = np.zeros(len(self.Te)+1); zone.T_air_hc[0]=zone.T_set_H[0]
            zone.T_air_set = np.zeros(len(self.Te)+1); zone.T_air_set[0]=zone.T_set_H[0]
            zone.T_air_un = np.zeros(len(self.Te)+1); zone.T_air_un[0]=zone.T_set_H[0]
            zone.free_float_T = np.zeros(len(self.Te)+1); zone.free_float_T[0]=zone.T_set_H[0]

            zone.Hve = np.zeros(len(self.Te)); zone.H1=np.zeros(len(self.Te)); zone.H2=np.zeros(len(self.Te)); zone.H3=np.zeros(len(self.Te))
            zone.qv_stack = np.zeros(len(self.Te)); zone.qv_infred = np.zeros(len(self.Te)); zone.qv_inf = np.zeros(len(self.Te)); zone.qv_wind = np.zeros(len(self.Te)); zone.qv_sw = np.zeros(len(self.Te))
            zone.V = np.zeros(len(self.Te)); zone.Ywind = np.zeros(len(self.Te)); zone.Ytemp = np.zeros(len(self.Te)); zone.Ropw = np.zeros(len(self.Te)); zone.qv_airing = np.zeros(len(self.Te)); zone.NV_hrs = np.zeros(len(self.Te))
            zone.qv_NV = np.zeros(len(self.Te)); zone.qv_NV_calc = np.zeros(len(self.Te))
            zone.qv_tot = np.zeros(len(self.Te))
            zone.inf_ACH = np.zeros(len(self.Te)); zone.mech_ACH = np.zeros(len(self.Te)); zone.NV_ACH = np.zeros(len(self.Te))

            zone.q_es = np.zeros(len(self.Te)); zone.q_em = np.zeros(len(self.Te)); zone.T_es = np.zeros(len(self.Te)); zone.T_em = np.zeros(len(self.Te))
            zone.q_hc = np.zeros(len(self.Te)); zone.q_C_nd = np.zeros(len(self.Te)+1); zone.q_C_nd[0] = 0; zone.q_H_nd = np.zeros(len(self.Te)); zone.q_NV_ac = np.zeros(len(self.Te))
            zone.T_supp = np.zeros(len(self.Te))
            zone.q_inf = np.zeros(len(self.Te)); zone.q_NV = np.zeros(len(self.Te))
            # zone.q_az_f = np.zeros(len(self.Te))            
            # zone.q_sol_op = np.zeros(len(self.Te)) if not zone.qi_env_dict_op else zone.q_sol_op; zone.q_sol_w = np.zeros(len(self.Te)); zone.q_sol = np.zeros(len(self.Te)); zone.q_m = np.zeros(len(self.Te)); zone.q_st = np.zeros(len(self.Te))

    def iterate(self):
        total_steps = len(self.Te)
        print_progress_bar.start_time = time.time()  # Store start time
        solver = self.solver.lower()
        for i in range(len(self.Te)):
            if hasattr(self, 'if_print') and self.if_print == True:
                if i % 1000 == 0:  # Update every 1000 steps
                    print_progress_bar(i, total_steps)
                if i == len(self.Te)-1:  # Show 100% completion
                    print_progress_bar(total_steps, total_steps)

            hvac_cap_dct = {}
            for hvac_name in self.General.HVAC_dct:
                hvac_cap_dct[hvac_name] = [0, 0]        #first one is heating load, second one is cooling load

            for zname, zone in list(self.pre_dict['Zones'].items()): 
                #air infiltration calculation
                if zone.Q4Pa != 0:
                    if hasattr(self, 'infl_style'):
                        if self.infl_style == 'real':
                            # if zone.q_C_nd[i] > 0:
                            zone.qv_stack[i] = max(0.0146*zone.Ventilation.flow_rate*zone.infiltration_frac[i]*(0.7*zone.height*np.absolute(self.Te[i]-zone.T_air_set[i]))**0.667, 0.001)
                            zone.qv_wind[i] = 0.0769*zone.Ventilation.flow_rate*zone.infiltration_frac[i]*(zone.Ventilation.dCP*zone.Ventilation.vsite*self.ws[i]**2)**0.667
                            zone.qv_sw[i] = max(zone.qv_stack[i], zone.qv_wind[i])+0.14*zone.qv_stack[i]*zone.qv_wind[i]/(zone.Ventilation.flow_rate*zone.infiltration_frac[i])
                            zone.qv_infred[i] = max(zone.qv_sw[i], (zone.qv_stack[i]*np.absolute(zone.qv_diff[i])/2.0+zone.qv_wind[i]*np.absolute(zone.qv_diff[i])*2/3)/(zone.qv_stack[i]+zone.qv_wind[i]))
                            zone.qv_inf[i] = max(0, -zone.qv_diff[i])+zone.qv_sw[i]
                            # zone.qv_inf[i] = zone.Ventilation.flow_rate*zone.infiltration_frac[i]
                        elif self.infl_style == 'constant':
                            zone.qv_inf[i] = zone.Ventilation.flow_rate*zone.infiltration_frac[i]
                        else:
                            raise ValueError
                    else:
                        zone.qv_inf[i] = zone.Ventilation.flow_rate*zone.infiltration_frac[i]

                #natural ventilation calculation
                if zone.vent_type != 1:
                    zone.V[i] = 0.01+0.001*self.ws[i]**2+0.0035*zone.Ventilation.height*np.absolute(zone.T_air_set[i]-self.Te[i])
                    zone.Ywind[i] = np.where((1-0.1*self.ws[i])>1, 1, np.where(1-0.1*self.ws[i]<0,0,1-0.1*self.ws[i]))
                    zone.Ytemp[i] = np.where(self.Te[i]/25.0+0.2>1,1,np.where(self.Te[i]/25.0+0.2<0,0,self.Te[i]/25.0+0.2))
                    zone.Ropw[i] = zone.Ywind[i]*zone.Ytemp[i]
                    zone.qv_airing[i] = zone.Ropw[i]*(3.6*500*zone.Ventilation.Aow*zone.V[i]**0.5)/zone.Af
                    if zone.vent_type == 3:
                        zone.NV_hrs[i] = 1; zone.qv_NV[i] = zone.qv_airing[i]
                    elif zone.vent_type == 2:
                        zone.NV_hrs[i] = 1 if (zone.q_C_nd[i] > 0 and self.Te[i] < zone.T_air_set[i] and self.Te[i] > 16) else 0  
                    else:
                        zone.NV_hrs[i] = 0
                    zone.qv_NV_calc[i] = zone.qv_airing[i] if zone.NV_hrs[i] == 1 else 0

                zone.qv_tot[i] = zone.qv_supp[i]+zone.qv_inf[i]+zone.qv_NV_calc[i]
                zone.Hve[i] = (1.2/3.6)*zone.qv_tot[i]; zone.H1[i] = 1/(1/zone.Htr_is + 1/zone.Hve[i]); zone.H2[i] = zone.H1[i]+zone.Htr_w/zone.Af+zone.Htr_iw; zone.H3[i] = 1/(1/zone.H2[i]+1/zone.Htr_ms)
               
                #adjacent zone heat flow calculation:
                if zone.Htr_w+zone.Htr_iw*zone.Af == 0:
                    zone.q_es[i] = 0
                else:
                    zone.q_es[i] = zone.Htr_w/zone.Af*self.Te[i]+ sum([self.pre_dict['Zones'][name].T_air_hc[i] * zone.U_iw * area/zone.Af for name, area in list(zone.adj_wall_zone.items())]) + \
                        sum([self.pre_dict['Zones'][name].T_air_hc[i] * zone.U_if * area/zone.Af for name, area in list(zone.adj_ceiling_zone.items())]) 
                        
                q_az_f = []
                for name, area in list(zone.adj_floor_zone.items()):
                    if name == 'ground':
                        q_az_f += [self.T_gr[i] * self.Htr_gr * area/zone.Af]
                    else:
                        q_az_f += [self.pre_dict['Zones'][name].T_air_hc[i] * zone.U_if * area/zone.Af]     
                zone.q_em[i] = zone.Htr_em*self.Te[i] + sum(q_az_f)

                #if there is no heating and cooling need:
                zone.q_m_tot_0[i] = zone.q_m[i] + zone.q_em[i] + zone.H3[i]*(zone.q_st[i]+zone.q_es[i]+zone.H1[i]*(zone.q_ia[i]/zone.Hve[i]+self.Te[i]))/zone.H2[i] 
                A = self.Cm; B = zone.H3[i]+zone.Htr_em+zone.Htr_if; C = zone.q_m_tot_0[i]
                if solver == 'crank-nicholson':
                    zone.T_m_t_0[i+1] = (zone.T_m_t_1_0[i]*(A - 0.5*B)+C)/(A+0.5*B)
                elif solver == 'euler':
                    zone.T_m_t_0[i+1] = zone.T_m_t_1_0[i] + (C-B*zone.T_m_t_1_0[i])/A
                elif solver == 'runge-kutta':                    
                    zone.T_m_t_0[i+1] = zone.T_m_t_1_0[i] + (C - B*(zone.T_m_t_1_0[i] + ((C - B*zone.T_m_t_1_0[i])/A)/2))/A
                else:
                    zone.T_m_t_0[i+1] = (zone.T_m_t_1_0[i]*(A - 0.5*B)+C)/(A+0.5*B)
                zone.T_m_0[i] = (zone.T_m_t_1_0[i] + zone.T_m_t_0[i+1])/2.0
                # mean instantaneous temperature of all internal surfaces of partitions that have direct contact with the internal air in the building:
                zone.T_s_0[i] = (zone.Htr_ms*zone.T_m_0[i] + zone.q_st[i]+zone.q_es[i]+zone.H1[i]*(self.Te[i]+zone.q_ia[i]/zone.Hve[i]))/(zone.Htr_ms+zone.Htr_w/zone.Af+zone.H1[i]+zone.Htr_iw)
                if self.order == 2:
                    zone.q_a_tot_0[i] = zone.Htr_is*zone.T_s_0[i]+zone.Hve[i]*self.Te[i]+zone.q_ia[i]
                    A = self.Ct; B = zone.Htr_is+zone.Hve[i]; C = zone.q_a_tot_0[i]
                    if solver == 'crank-nicholson':
                        zone.free_float_T[i+1] = (zone.free_float_T[i]*(A - 0.5*B)+C)/(A+0.5*B)
                    elif solver == 'euler':
                        zone.free_float_T[i+1] = zone.free_float_T[i] + (C-B*zone.free_float_T[i])/A
                    elif solver == 'runge-kutta':                    
                        zone.free_float_T[i+1] = zone.free_float_T[i] + (C - B*(zone.free_float_T[i] + ((C - B*zone.free_float_T[i])/A)/2))/A
                    else:
                        zone.free_float_T[i+1] = zone.free_float_T[i] + (C-B*zone.free_float_T[i])/A
                else:
                    zone.free_float_T[i+1] = (zone.Htr_is*zone.T_s_0[i]+zone.Hve[i]*self.Te[i]+zone.q_ia[i])/(zone.Htr_is+zone.Hve[i])
                zone.T_op_0[i] = 0.3*zone.free_float_T[i]+0.7*zone.T_s_0[i]
                zone.T_air_set[i+1] = np.where(zone.free_float_T[i+1]<zone.T_set_H[i], zone.T_set_H[i], np.where(zone.free_float_T[i+1]>zone.T_set_C[i], zone.T_set_C[i], zone.free_float_T[i+1]))        

                #if heating and cooling need is only 10W/m2
                zone.q_m_tot_un[i] = zone.q_m[i] + zone.q_em[i] + zone.H3[i]*(zone.q_st[i]+zone.q_es[i]+zone.H1[i]*((zone.q_ia[i]+10.0)/zone.Hve[i]+self.Te[i]))/zone.H2[i]
                A = self.Cm; B = zone.H3[i]+zone.Htr_em+zone.Htr_if; C = zone.q_m_tot_un[i]
                if solver == 'crank-nicholson':
                    zone.T_m_t_un[i+1] = (zone.T_m_t_1_un[i]*(A - 0.5*B)+C)/(A+0.5*B)
                elif solver == 'euler':
                    zone.T_m_t_un[i+1] = zone.T_m_t_1_un[i] + (C-B*zone.T_m_t_1_un[i])/A
                elif solver == 'runge-kutta':                    
                    zone.T_m_t_un[i+1] = zone.T_m_t_1_un[i] + (C - B*(zone.T_m_t_1_un[i] + ((C - B*zone.T_m_t_1_un[i])/A)/2))/A
                else:
                    zone.T_m_t_un[i+1] = (zone.T_m_t_1_un[i]*(A - 0.5*B)+C)/(A+0.5*B)
                zone.T_m_un[i] = (zone.T_m_t_1_un[i] + zone.T_m_t_un[i+1])/2.0
                zone.T_s_un[i] = (zone.Htr_ms*zone.T_m_un[i] + zone.q_st[i]+zone.q_es[i]+zone.H1[i]*(self.Te[i]+(zone.q_ia[i]+10.0)/zone.Hve[i]))/(zone.Htr_ms+zone.Htr_w/zone.Af+zone.H1[i]+zone.Htr_iw)
                # mean instantaneous temperature of all internal surfaces of partitions that have direct contact with the internal air in the building:
                if self.order == 2:
                    zone.q_a_tot_un[i] = zone.Htr_is*zone.T_s_un[i]+zone.Hve[i]*self.Te[i]+zone.q_ia[i]+10.0
                    A = self.Ct; B = zone.Htr_is+zone.Hve[i]; C = zone.q_a_tot_un[i]
                    if solver == 'crank-nicholson':
                        zone.T_air_un[i+1] = (zone.T_air_un[i]*(A - 0.5*B)+C)/(A+0.5*B)
                    elif solver == 'euler':
                        zone.T_air_un[i+1] = zone.T_air_un[i] + (C-B*zone.T_air_un[i])/A
                    elif solver == 'runge-kutta':                    
                        zone.T_air_un[i+1] = zone.T_air_un[i] + (C - B*(zone.T_air_un[i] + ((C - B*zone.T_air_un[i])/A)/2))/A
                    else:
                        zone.T_air_un[i+1] = zone.T_air_un[i] + (C-B*zone.T_air_un[i])/A
                else:
                    zone.T_air_un[i+1] = (zone.Htr_is*zone.T_s_un[i]+zone.Hve[i]*self.Te[i]+zone.q_ia[i]+10.0)/(zone.Htr_is+zone.Hve[i])
                zone.T_op_un[i] = 0.3*zone.T_air_un[i]+0.7*zone.T_s_un[i]
                # if zname == 'floor_2' or zname == 'floor_1_perimeter':
                #     print(zone.T_air_un[i])

                #calculate how much actual heating and cooling energy is needed
                zone.q_hc[i] = 0 if (zone.free_float_T[i+1]>=zone.T_set_H[i] and zone.free_float_T[i+1]<=zone.T_set_C[i]) or zone.HVAC_frac[i] == 0 else zone.HVAC_frac[i] * 10.0*(zone.T_air_set[i+1]-zone.free_float_T[i+1])/(zone.T_air_un[i+1]-zone.free_float_T[i+1])
                zone.q_m_tot_hc[i] = zone.q_m[i] + zone.q_em[i] + zone.H3[i]*(zone.q_st[i]+zone.q_es[i]+zone.H1[i]*((zone.q_ia[i]+zone.q_hc[i])/zone.Hve[i]+self.Te[i]))/zone.H2[i]
                A = self.Cm; B = zone.H3[i]+zone.Htr_em+zone.Htr_if; C = zone.q_m_tot_hc[i]
                if solver == 'crank-nicholson':    
                    zone.T_m_t_hc[i+1] = (zone.T_m_t_1_hc[i]*(A - 0.5*B)+C)/(A+0.5*B)
                elif solver == 'euler':
                    zone.T_m_t_hc[i+1] = zone.T_m_t_1_hc[i] + (C-B*zone.T_m_t_1_hc[i])/A
                elif solver == 'runge-kutta':                    
                    zone.T_m_t_hc[i+1] = zone.T_m_t_1_hc[i] + (C - B*(zone.T_m_t_1_hc[i] + ((C - B*zone.T_m_t_1_hc[i])/A)/2))/A
                else:
                    zone.T_m_t_hc[i+1] = (zone.T_m_t_1_hc[i]*(A - 0.5*B)+C)/(A+0.5*B)
                zone.T_m_hc[i] = (zone.T_m_t_1_hc[i] + zone.T_m_t_hc[i+1])/2.0
                zone.T_s_hc[i] = (zone.Htr_ms*zone.T_m_hc[i] + zone.q_st[i]+zone.q_es[i]+zone.H1[i]*(self.Te[i]+(zone.q_ia[i]+zone.q_hc[i])/zone.Hve[i]))/(zone.Htr_ms+zone.Htr_w/zone.Af+zone.H1[i]+zone.Htr_iw)
                # mean instantaneous temperature of all internal surfaces of partitions that have direct contact with the internal air in the building:
                if self.order == 2:                    
                    zone.q_a_tot_hc[i] = zone.Htr_is*zone.T_s_hc[i]+zone.Hve[i]*self.Te[i]+zone.q_ia[i]+zone.q_hc[i]
                    A = self.Ct; B = zone.Htr_is+zone.Hve[i]; C = zone.q_a_tot_hc[i]
                    if solver == 'crank-nicholson':
                        zone.T_air_hc[i+1] = (zone.T_air_hc[i]*(A - 0.5*B)+C)/(A+0.5*B)
                    elif solver == 'euler':
                        zone.T_air_hc[i+1] = zone.T_air_hc[i] + (C-B*zone.T_air_hc[i])/A
                    elif solver == 'runge-kutta':                    
                        zone.T_air_hc[i+1] = zone.T_air_hc[i] + (C - B*(zone.T_air_hc[i] + ((C - B*zone.T_air_hc[i])/A)/2))/A
                    else:
                        zone.T_air_hc[i+1] = zone.T_air_hc[i] + (C-B*zone.T_air_hc[i])/A
                else:
                    zone.T_air_hc[i+1] = (zone.Htr_is*zone.T_s_hc[i]+zone.Hve[i]*self.Te[i]+zone.q_ia[i]+zone.q_hc[i])/(zone.Htr_is+zone.Hve[i])
                zone.T_op_hc[i] = 0.3*zone.T_air_hc[i+1]+0.7*zone.T_s_hc[i]    
                # if zname == 'floor_2' or zname == 'floor_1_perimeter':
                #     print(zone.q_hc[i])       

                if zone.q_hc[i]>0:
                    zone.q_H_nd[i] = zone.q_hc[i]
                    hvac_cap_dct[zone.HVAC.hvac_name][0] += (zone.q_H_nd[i] * zone.Af)/1000
                else:
                    zone.q_C_nd[i+1] = -zone.q_hc[i]
                    hvac_cap_dct[zone.HVAC.hvac_name][1] += (zone.q_C_nd[i] * zone.Af)/1000 
            
            for hvac_name, hc_cap in list(hvac_cap_dct.items()):                
                if hc_cap[0] > self.pre_dict['Zones'][self.General.HVAC_dct[hvac_name][0]].HVAC.heat_cap:
                    # print ("enter overloaded heating calculation!")
                    for zname in self.General.HVAC_dct[hvac_name]:
                        zone = self.pre_dict['Zones'][zname]
                        if zone.q_hc[i]>0:
                            zone.q_hc[i] = (zone.q_hc[i]/hc_cap[0]) * zone.HVAC.heat_cap
                            zone.q_m_tot_hc[i] = zone.q_m[i] + zone.q_em[i] + zone.H3[i]*\
                            (zone.q_st[i]+zone.q_es[i]+zone.H1[i]*((zone.q_ia[i]+zone.q_hc[i])/zone.Hve[i]+self.Te[i]))/zone.H2[i]
                            A = self.Cm; B = zone.H3[i]+zone.Htr_em+zone.Htr_if; C = zone.q_m_tot_hc[i]
                            if solver == 'crank-nicholson':    
                                zone.T_m_t_hc[i+1] = (zone.T_m_t_1_hc[i]*(A - 0.5*B)+C)/(A+0.5*B)
                            elif solver == 'euler':
                                zone.T_m_t_hc[i+1] = zone.T_m_t_1_hc[i] + (C-B*zone.T_m_t_1_hc[i])/A
                            elif solver == 'runge-kutta':                    
                                zone.T_m_t_hc[i+1] = zone.T_m_t_1_hc[i] + (C - B*(zone.T_m_t_1_hc[i] + ((C - B*zone.T_m_t_1_hc[i])/A)/2))/A
                            else:
                                zone.T_m_t_hc[i+1] = (zone.T_m_t_1_hc[i]*(A - 0.5*B)+C)/(A+0.5*B)
                            zone.T_m_hc[i] = (zone.T_m_t_1_hc[i] + zone.T_m_t_hc[i+1])/2.0
                            zone.T_s_hc[i] = (zone.Htr_ms*zone.T_m_hc[i] + zone.q_st[i]+zone.q_es[i]+zone.H1[i]*(self.Te[i]+(zone.q_ia[i]+zone.q_hc[i])/zone.Hve[i]))/(zone.Htr_ms+zone.Htr_w/zone.Af+zone.H1[i]+zone.Htr_iw)
                            # mean instantaneous temperature of all internal surfaces of partitions that have direct contact with the internal air in the building:
                            if self.order == 2:
                                zone.q_a_tot_hc[i] = zone.Htr_is*zone.T_s_hc[i]+zone.Hve[i]*self.Te[i]+zone.q_ia[i]+zone.q_hc[i]
                                A = self.Ct; B = zone.Htr_is+zone.Hve[i]; C = zone.q_a_tot_hc[i]
                                if solver == 'crank-nicholson':
                                    zone.T_air_hc[i+1] = (zone.T_air_hc[i]*(A - 0.5*B)+C)/(A+0.5*B)
                                elif solver == 'euler':
                                    zone.T_air_hc[i+1] = zone.T_air_hc[i] + (C-B*zone.T_air_hc[i])/A
                                elif solver == 'runge-kutta':                    
                                    zone.T_air_hc[i+1] = zone.T_air_hc[i] + (C - B*(zone.T_air_hc[i] + ((C - B*zone.T_air_hc[i])/A)/2))/A
                                else:
                                    zone.T_air_hc[i+1] = zone.T_air_hc[i] + (C-B*zone.T_air_hc[i])/A
                            else:
                                zone.T_air_hc[i+1] = (zone.Htr_is*zone.T_s_hc[i]+zone.Hve[i]*self.Te[i]+zone.q_ia[i]+zone.q_hc[i])/(zone.Htr_is+zone.Hve[i])
                            zone.T_op_hc[i] = 0.3*zone.T_air_hc[i+1]+0.7*zone.T_s_hc[i] 

                if hc_cap[1] > self.pre_dict['Zones'][self.General.HVAC_dct[hvac_name][0]].HVAC.cool_cap:
                    # print "enter overloaded cooling calculation!"
                    for zname in self.General.HVAC_dct[hvac_name]:
                        zone = self.pre_dict['Zones'][zname]
                        if zone.q_hc[i]<0:
                            zone.q_hc[i] = (zone.q_hc[i]/hc_cap[1]) * zone.HVAC.cool_cap     #take the share of maximum cooling capacity as of the needed total cooling load
                            zone.q_m_tot_hc[i] = zone.q_m[i] + zone.q_em[i] + zone.H3[i]*\
                            (zone.q_st[i]+zone.q_es[i]+zone.H1[i]*((zone.q_ia[i]+zone.q_hc[i])/zone.Hve[i]+self.Te[i]))/zone.H2[i]
                            A = self.Cm; B = zone.H3[i]+zone.Htr_em+zone.Htr_if; C = zone.q_m_tot_hc[i]
                            if solver == 'crank-nicholson':    
                                zone.T_m_t_hc[i+1] = (zone.T_m_t_1_hc[i]*(A - 0.5*B)+C)/(A+0.5*B)
                            elif solver == 'euler':
                                zone.T_m_t_hc[i+1] = zone.T_m_t_1_hc[i] + (C-B*zone.T_m_t_1_hc[i])/A
                            elif solver == 'runge-kutta':                    
                                zone.T_m_t_hc[i+1] = zone.T_m_t_1_hc[i] + (C - B*(zone.T_m_t_1_hc[i] + ((C - B*zone.T_m_t_1_hc[i])/A)/2))/A
                            else:
                                zone.T_m_t_hc[i+1] = (zone.T_m_t_1_hc[i]*(A - 0.5*B)+C)/(A+0.5*B)
                            zone.T_m_hc[i] = (zone.T_m_t_1_hc[i] + zone.T_m_t_hc[i+1])/2.0
                            zone.T_s_hc[i] = (zone.Htr_ms*zone.T_m_hc[i] + zone.q_st[i]+zone.q_es[i]+zone.H1[i]*(self.Te[i]+(zone.q_ia[i]+zone.q_hc[i])/zone.Hve[i]))/(zone.Htr_ms+zone.Htr_w/zone.Af+zone.H1[i]+zone.Htr_iw)
                            # mean instantaneous temperature of all internal surfaces of partitions that have direct contact with the internal air in the building:
                            if self.order == 2:
                                zone.q_a_tot_hc[i] = zone.Htr_is*zone.T_s_hc[i]+zone.Hve[i]*self.Te[i]+zone.q_ia[i]+zone.q_hc[i]
                                A = self.Ct; B = zone.Htr_is+zone.Hve[i]; C = zone.q_a_tot_hc[i]
                                if solver == 'crank-nicholson':
                                    zone.T_air_hc[i+1] = (zone.T_air_hc[i]*(A - 0.5*B)+C)/(A+0.5*B)
                                elif solver == 'euler':
                                    zone.T_air_hc[i+1] = zone.T_air_hc[i] + (C-B*zone.T_air_hc[i])/A
                                elif solver == 'runge-kutta':                    
                                    zone.T_air_hc[i+1] = zone.T_air_hc[i] + (C - B*(zone.T_air_hc[i] + ((C - B*zone.T_air_hc[i])/A)/2))/A
                                else:
                                    zone.T_air_hc[i+1] = zone.T_air_hc[i] + (C-B*zone.T_air_hc[i])/A
                            else:                                
                                zone.T_air_hc[i+1] = (zone.Htr_is*zone.T_s_hc[i]+zone.Hve[i]*self.Te[i]+zone.q_ia[i]+zone.q_hc[i])/(zone.Htr_is+zone.Hve[i])
                            zone.T_op_hc[i] = 0.3*zone.T_air_hc[i+1]+0.7*zone.T_s_hc[i]
                        
    def hourlyAggregate(self):
        for zname, zone in list(self.pre_dict['Zones'].items()):
            zone.q_hc *= zone.Af*3600; zone.q_H_nd*= zone.Af*3600; zone.q_C_nd = zone.q_C_nd[1:]* zone.Af*3600;
            zone.q_NV_ac = np.where(zone.NV_hrs == 0, 0, zone.q_C_nd)
            zone.T_air_hc = zone.T_air_hc[1:]
            zone.T_s_hc = zone.T_s_hc[1:]
            zone.qi_li *= zone.Af*3600; zone.qi_app *= zone.Af*3600
            zone.q_sol_w *= zone.Af*3600; zone.q_sol *= zone.Af*3600; zone.q_sol_op *= zone.Af*3600
            zone.q_inf = (1.2/3.6)*zone.qv_inf*zone.Af*3600; zone.q_NV = (1.2/3.6)*zone.qv_NV*zone.Af*3600
            
    def energy(self):  
        self.Af = 0
        for zname, zone in list(self.pre_dict['Zones'].items()):
            zone.heat_supply_air = (zone.q_H_nd/(zone.Af*3600)/1000*3.6)/(zone.Fans.T_supply_H - zone.T_air_hc)/zone.Fans.rho
            zone.cool_supply_air = (zone.q_C_nd/(zone.Af*3600)/1000*3.6)/(zone.T_air_hc - (zone.Fans.T_supply_C+zone.HVAC.reheat_deltaT))/zone.Fans.rho

            if zone.HVAC.reheat_summer == 1: 
                zone.rh_threshold_summer = 25 if zone.HVAC.reheat_summer == 1 else 100
                zone.q_C_nd_HVAC = np.where(self.rh > zone.rh_threshold_summer, ((zone.T_air_hc - zone.Fans.T_supply_C)*(zone.cool_supply_air)*zone.Fans.rho)*1000/3.6*(zone.Af*3600), zone.q_C_nd)
                zone.q_H_nd_HVAC = np.where(zone.q_hc>0, zone.q_H_nd, np.where(self.rh > zone.rh_threshold_summer, (zone.HVAC.reheat_deltaT*(zone.cool_supply_air)*zone.Fans.rho)*1000/3.6*(zone.Af*3600), zone.q_H_nd)) 
                
            else:
                zone.q_C_nd_HVAC = zone.q_C_nd
                zone.q_H_nd_HVAC = zone.q_H_nd

            zone.fresh_air = zone.qv_tot
            zone.fan_volume = np.maximum(zone.heat_supply_air, zone.cool_supply_air)+zone.qv_exh      # unit in m3/h/m2
            zone.fan_volume *= 1.2 * zone.Af/3600    # unit: m3/s
            zone.fan_energy = np.where(zone.fan_volume>0,np.array([max(zone.fan_volume)]*len(self.Te))*zone.Fans.fan_power*zone.Fans.fan_flow_control_factor*self.BEM.f_BAC_e*3600, 0)
            
            zone.heat_supply_water = (zone.q_H_nd_HVAC/1000000)/(zone.deltaT_water_H)/self.Pumps.rho if self.Pumps.pump_power_H != 0 else np.zeros(len(self.Te))
            zone.cool_supply_water = (zone.q_C_nd_HVAC/1000000)/(zone.deltaT_water_C)/self.Pumps.rho if self.Pumps.pump_power_C != 0 else np.zeros(len(self.Te))
            if self.Pumps.fcntrl == 0.5:
                zone.pump_volume_H = zone.heat_supply_water/3600; zone.pump_volume_C = zone.cool_supply_water/3600
            elif self.Pumps.fcntrl == 1:
                zone.pump_volume_H = 0.8*max(zone.heat_supply_water)/3600; zone.pump_volume_C = 0.8*max(zone.cool_supply_water)/3600 #0.8: oefficient for constant speed pump
            else:
                zone.pump_volume_H = 0; zone.pump_volume_C = 0

            zone.f_dem_heat = max(0.1, sum(zone.q_H_nd_HVAC)/(sum(zone.q_H_nd_HVAC)+sum(zone.q_C_nd_HVAC)))
            zone.f_dem_cool = max(1-zone.f_dem_heat, 0.1)
            zone.dist_cool = 1/(1+zone.HVAC.a_cool+zone.HVAC.f_waste/zone.f_dem_cool)
            zone.dist_heat = 1/(1+zone.HVAC.a_heat+zone.HVAC.f_waste/zone.f_dem_heat)
            zone.heating_efficiency = np.interp(zone.q_H_nd_HVAC/max(zone.q_H_nd_HVAC), zone.HVAC.PLV_x, zone.HVAC.heating_PLV*zone.HVAC.heating_efficiency) if max(zone.q_H_nd_HVAC) != 0 else 0
            zone.cooling_COP = np.interp(zone.q_C_nd_HVAC/max(zone.q_C_nd_HVAC), zone.HVAC.PLV_x, zone.HVAC.cooling_PLV*zone.HVAC.cooling_COP) if max(zone.q_C_nd_HVAC) != 0 else 0
            zone.heat_loss = zone.q_H_nd_HVAC*(1-zone.dist_heat)/zone.dist_heat
            zone.heat_energy = np.where(zone.heating_efficiency == 0, np.zeros(len(self.Te)), (zone.q_H_nd_HVAC+zone.heat_loss)*self.BEM.f_BAC_hc/zone.heating_efficiency)
            zone.cool_loss = zone.q_C_nd_HVAC*(1-zone.dist_cool)/zone.dist_cool
            zone.cool_energy = np.where(zone.cooling_COP == 0, np.zeros(len(self.Te)), (zone.q_C_nd_HVAC+zone.cool_loss)*self.BEM.f_BAC_hc/zone.cooling_COP)
            zone.qi_equip = zone.qi_app           
            zone.DHW_q = 12*(zone.DHW*4.18*1000*45)*zone.Af     
            if hasattr(self, 'DHW_style'):           
                if self.DHW_style == 'avg':
                    zone.DHW_dem = np.array([zone.DHW_q/len(self.Te)]*len(self.Te))
                elif self.DHW_style == 'occ':
                    zone.DHW_dem = zone.DHW_q*zone.occupancy_frac/sum(zone.occupancy_frac) if sum(zone.occupancy_frac) != 0 else np.zeros(len(self.Te))
                else: 
                    zone.DHW_dem = zone.DHW_q*zone.occupancy_frac/sum(zone.occupancy_frac) if sum(zone.occupancy_frac) != 0 else np.zeros(len(self.Te))
            else:
                zone.DHW_dem = zone.DHW_q*zone.occupancy_frac/sum(zone.occupancy_frac) if sum(zone.occupancy_frac) != 0 else np.zeros(len(self.Te))
            self.Af+=(zone.Af if np.count_nonzero(zone.q_hc)>0 else 0)
        rho = self.wea_dict['pressure']/self.Wind_Turbines.R_air/(273.0+self.Te)
        self.Egen_wind = 0.5*rho*self.Wind_Turbines.Multiplier*self.Wind_Turbines.Swept_Area*self.Wind_Turbines.Efficiency*self.ws**3*3600
    
    def renewables(self):
        try:
            int(self.PV.PV_Area)
        except ValueError:
            self.Esol_PV = np.zeros(len(self.Te))
        else:
            if int(self.PV.PV_Area) != 0:
                try:
                    int(self.PV.PV_Angle)
                except ValueError:
                    self.Esol_PV = np.zeros(len(self.Te))
                else:
                    if int(self.PV.PV_Angle) == 0:
                        self.Esol_PV = self.wea_dict['Egh']/1000.0
                    else:
                        self.Esol_PV = self.SCal_dict['Esol'][int(self.PV.PV_Angle)][self.PV.Orientation]/1000.0
                        # print np.mean(self.SCal_dict['Esol'][int(self.PV.PV_Angle)][self.PV.Orientation]), np.max(self.SCal_dict['Esol'][int(self.PV.PV_Angle)][self.PV.Orientation])
            else:
                self.Esol_PV = np.zeros(len(self.Te))
        self.Egen_PV = self.Esol_PV*self.PV.Ppk*self.PV.fperf*3600000

        try:
            int(self.DHW.SWH_Area)
        except ValueError:
            self.Esol_SWH = np.zeros(len(self.Te))
        else:
            if int(self.DHW.SWH_Area) != 0:
                try:
                    int(self.DHW.SWH_Angle)
                except ValueError:
                    self.Esol_PV = np.zeros(len(self.Te))
                else:
                    if int(self.DHW.SWH_Angle) == 0:
                        self.Esol_SWH = self.wea_dict['Egh']/1000.0
                    else:
                        self.Esol_SWH = self.SCal_dict['Esol'][int(self.DHW.SWH_Angle)][self.DHW.SWH_Orientation]/1000.0
            else:
                self.Esol_SWH = np.zeros(len(self.Te))
        self.Esol_SWH *= 3600000

    def aggregate(self):
        print("Processing simulation results...") if hasattr(self, 'if_print') and self.if_print == True else None
        agg_dict = collections.OrderedDict()

        agg_dict['indoor_temperature'] = {}
        for zname, zone in list(self.pre_dict['Zones'].items()):
            agg_dict['indoor_temperature'][zname] = zone.T_air_hc
        agg_dict['indoor_temperature'] = pd.DataFrame.from_dict(agg_dict['indoor_temperature'])

        agg_dict['q_sol_w'] = {}
        for zname, zone in list(self.pre_dict['Zones'].items()):
            agg_dict['q_sol_w'][zname] = zone.q_sol_w
        agg_dict['q_sol_w'] = pd.DataFrame.from_dict(agg_dict['q_sol_w'])

        agg_dict['q_sol_op'] = {}
        for zname, zone in list(self.pre_dict['Zones'].items()):
            agg_dict['q_sol_op'][zname] = zone.q_sol_op
        agg_dict['q_sol_op'] = pd.DataFrame.from_dict(agg_dict['q_sol_op'])

        agg_dict['q_inf'] = {}
        for zname, zone in list(self.pre_dict['Zones'].items()):
            agg_dict['q_inf'][zname] = zone.q_inf
        agg_dict['q_inf'] = pd.DataFrame.from_dict(agg_dict['q_inf'])

        agg_dict['q_NV'] = {}
        for zname, zone in list(self.pre_dict['Zones'].items()):
            agg_dict['q_NV'][zname] = zone.q_NV
        agg_dict['q_NV'] = pd.DataFrame.from_dict(agg_dict['q_NV'])

        agg_dict['q_H_nd'] = {}
        for zname, zone in list(self.pre_dict['Zones'].items()):
            agg_dict['q_H_nd'][zname] = zone.q_H_nd
        agg_dict['q_H_nd'] = pd.DataFrame.from_dict(agg_dict['q_H_nd'])

        agg_dict['q_C_nd'] = {}
        for zname, zone in list(self.pre_dict['Zones'].items()):
            agg_dict['q_C_nd'][zname] = zone.q_C_nd
        agg_dict['q_C_nd'] = pd.DataFrame.from_dict(agg_dict['q_C_nd'])

        agg_dict['heat_energy'] = {}
        for zname, zone in list(self.pre_dict['Zones'].items()):
            agg_dict['heat_energy'][zname] = zone.heat_energy
        agg_dict['heat_energy'] = pd.DataFrame.from_dict(agg_dict['heat_energy'])

        agg_dict['cool_energy'] = {}
        for zname, zone in list(self.pre_dict['Zones'].items()):
            agg_dict['cool_energy'][zname] = zone.cool_energy
        agg_dict['cool_energy'] = pd.DataFrame.from_dict(agg_dict['cool_energy'])

        agg_dict['lighting_energy'] = {}
        for zname, zone in list(self.pre_dict['Zones'].items()):
            agg_dict['lighting_energy'][zname] = zone.qi_li
        agg_dict['lighting_energy'] = pd.DataFrame.from_dict(agg_dict['lighting_energy'])

        agg_dict['equipment_energy'] = {}
        for zname, zone in list(self.pre_dict['Zones'].items()):
            agg_dict['equipment_energy'][zname] = zone.qi_app
        agg_dict['equipment_energy'] = pd.DataFrame.from_dict(agg_dict['equipment_energy'])

        agg_dict['DHW_dem'] = {}
        for zname, zone in list(self.pre_dict['Zones'].items()):
            agg_dict['DHW_dem'][zname] = zone.DHW_dem
        agg_dict['DHW_dem'] = pd.DataFrame.from_dict(agg_dict['DHW_dem'])

        agg_dict['fan_energy'] = {}
        for zname, zone in list(self.pre_dict['Zones'].items()):
            agg_dict['fan_energy'][zname] = zone.fan_energy
        agg_dict['fan_energy'] = pd.DataFrame.from_dict(agg_dict['fan_energy'])   

        agg_dict['fan_energy'] = {}
        for zname, zone in list(self.pre_dict['Zones'].items()):
            agg_dict['fan_energy'][zname] = zone.fan_energy
        agg_dict['fan_energy'] = pd.DataFrame.from_dict(agg_dict['fan_energy'])  

        agg_dict['occupants'] = {}
        for zname, zone in list(self.pre_dict['Zones'].items()):
            agg_dict['occupants'][zname] = zone.occupants * zone.occupancy_frac
        agg_dict['occupants'] = pd.DataFrame.from_dict(agg_dict['occupants']) 

        self.pump_volume_H = 0
        for zname, zone in list(self.pre_dict['Zones'].items()):
           self.pump_volume_H += zone.pump_volume_H 

        self.pump_volume_C = 0
        for zname, zone in list(self.pre_dict['Zones'].items()):
           self.pump_volume_C += zone.pump_volume_C  

        self.q_sol_w = agg_dict['q_sol_w'].sum(axis = 1)
        self.q_sol_op = agg_dict['q_sol_op'].sum(axis = 1)
        self.q_inf = agg_dict['q_inf'].sum(axis = 1)
        self.q_NV = agg_dict['q_NV'].sum(axis = 1)
        self.lighting_energy = agg_dict['lighting_energy'].sum(axis = 1)
        self.equipment_energy = agg_dict['equipment_energy'].sum(axis = 1)
        self.q_H_nd = agg_dict['q_H_nd'].sum(axis = 1)
        self.q_C_nd = agg_dict['q_C_nd'].sum(axis = 1)
        self.heat_energy = agg_dict['heat_energy'].sum(axis = 1)
        self.cool_energy = agg_dict['cool_energy'].sum(axis = 1)
        self.DHW_dem = agg_dict['DHW_dem'].sum(axis = 1)
        self.fan_energy = agg_dict['fan_energy'].sum(axis = 1)
        self.occupants = agg_dict['occupants'].sum(axis = 1)

        self.pump_energy_H = self.Pumps.pump_power_H*self.pump_volume_H*np.where(self.heat_energy>0, 1, 0)*3600
        self.pump_energy_C = self.Pumps.pump_power_C*self.pump_volume_C*np.where(self.cool_energy>0, 1, 0)*3600
        self.pump_energy_HVAC = self.pump_energy_C+self.pump_energy_H        

        self.DHW_dem_1 = copy.deepcopy(self.DHW_dem)
        self.DHW_dem -= self.Esol_SWH*self.DHW.SWH_Area*0.5
        self.DHW_dem = np.where(self.DHW_dem>0, self.DHW_dem, 0)
        self.DHW_energy = self.DHW_dem / (self.DHW.dstr_eff*self.DHW.gen_eff)
        self.Egen_SWH = np.where(self.DHW_energy>0, self.Esol_SWH*self.DHW.SWH_Area*0.5, self.DHW_dem_1)   
        self.DHW_supply_water = np.where(self.DHW_dem!=0, self.Pumps.DHW_flow, 0)
        if self.Pumps.fcntrl == 0.5:
            self.pump_volume_D = self.DHW_supply_water
        elif self.Pumps.fcntrl == 1:
            self.pump_volume_D = 0.8*max(self.DHW_supply_water) #0.8: oefficient for constant speed pump
        else:
            self.pump_volume_D = 0
        self.pump_energy_DHW = self.Pumps.pump_power_D*self.pump_volume_D*3600  
        self.pump_energy = self.pump_energy_HVAC+self.pump_energy_DHW  

        self.agg_dict = agg_dict

    def comfAnalysis(self):
        Ta_df = pd.DataFrame(columns=[zname for zname, zone in list(self.pre_dict['Zones'].items())], index = list(range(len(self.Te))))
        Ts_df = pd.DataFrame(columns=[zname for zname, zone in list(self.pre_dict['Zones'].items())], index = list(range(len(self.Te))))    
        occ_df = pd.DataFrame(columns=[zname for zname, zone in list(self.pre_dict['Zones'].items())], index = list(range(len(self.Te)))) 
        for zname, zone in list(self.pre_dict['Zones'].items()):
            Ta_df[zname]=zone.T_air_hc
            Ts_df[zname]=zone.T_s_hc
            occ_df[zname] = zone.occupancy_frac
        pmv_arr = comfort.comfPMVElevatedAirspeed(Ta_df.values, Ts_df.values, 0.1, 55, 1.1, 0.5, 0)
        pmv_df = pd.DataFrame(data = pmv_arr, columns=[zname for zname, zone in list(self.pre_dict['Zones'].items())], index = list(range(len(self.Te))))
        pmv_df = occ_df.where(occ_df==0, pmv_df)
        # print pmv_df
        return pmv_df

    def postProcess(self):
        """update the wea_dict and cal_dict, and dump the needed weather and calculated results
        to wea_calculation.csv under Outputs folder"""
        output_dict = collections.OrderedDict()
        output_dict['year'] = self.wea_dict['year']
        output_dict['month'] = self.wea_dict['month']
        output_dict['day'] = self.wea_dict['day']
        output_dict['hour'] = self.wea_dict['hour']
        output_dict['outdoor_temperature'] = self.Te
        output_dict['heat_transfer_window '] = self.q_sol_w
        output_dict['heat_transfer_wall'] = self.q_sol_op
        output_dict['heat_transfer_infiltration'] = self.q_inf
        output_dict['heat_transfer_natural_vent'] = self.q_NV
        output_dict['heating_load'] = self.q_H_nd
        output_dict['cooling_load'] = self.q_C_nd
        output_dict['lighting_energy'] = self.lighting_energy
        output_dict['equipment_energy'] = self.equipment_energy
        output_dict['heat_energy'] = self.heat_energy
        output_dict['cool_energy'] = self.cool_energy
        output_dict['DHW_energy'] = self.DHW_energy
        output_dict['pump_energy'] = self.pump_energy
        output_dict['fan_energy'] = self.fan_energy
        self.elec_dem = self.lighting_energy+self.equipment_energy+(self.cool_energy if self.General.cool_source.cls==1 else 0)+\
        self.pump_energy+self.fan_energy+(self.heat_energy if self.General.heat_source.cls==1 else 0)+(self.DHW_energy if self.General.DHW_source.cls==1 else 0)
        output_dict['total_electricity'] = np.where(self.elec_dem-self.Egen_PV-self.Egen_wind>0, self.elec_dem-self.Egen_PV-self.Egen_wind, 0)
        source_dict = {}; source_ref = collections.OrderedDict({1: 'electricity', 2: 'gas', 3: 'district_cooling', 4: 'district_heating', 5: 'steam' , 6: 'gasoline', 7: 'diesel', 8: 'coal', 
            9: 'fuel oil', 10: 'propane', 11: 'kerosene', 12: 'traditional bio', 13: 'others'})
        for i in range(1,7):
            if int(self.input_dict['Energy Sources']['Cooling Energy Source']) == i:
                source_dict[i] = copy.deepcopy(self.cool_energy)

            if int(self.input_dict['Energy Sources']['Heating Energy Source']) == i:
                if i not in list(source_dict.keys()):
                    source_dict[i] = copy.deepcopy(self.heat_energy)
                else:
                    source_dict[i] += copy.deepcopy(self.heat_energy)

            if int(self.input_dict['Energy Sources']['DHW Energy Source']) == i:
                if i not in list(source_dict.keys()):
                    source_dict[i] = copy.deepcopy(self.DHW_energy)
                else:
                    source_dict[i] += copy.deepcopy(self.DHW_energy)
        for k,v in list(source_dict.items()):
            if k != 1:
                output_dict['total_'+source_ref[k]] = v
        # output_dict['total_gas'] = (self.cool_energy if self.General.cool_source.cls==2 else np.zeros(len(self.Te)))+(self.heat_energy if self.General.heat_source.cls==2 else np.zeros(len(self.Te)))+(self.DHW_energy if self.General.DHW_source.cls==2 else np.zeros(len(self.Te)))
        output_dict['SWH_production'] = self.Egen_SWH
        output_dict['PV_production'] = np.where(output_dict['total_electricity']>0, self.Egen_PV, self.Egen_PV**2/(self.Egen_PV+self.Egen_wind))
        output_dict['wind_production'] = np.where(output_dict['total_electricity']>0, self.Egen_wind, self.Egen_wind**2/(self.Egen_PV+self.Egen_wind))
        if self.if_pmv == True:
            output_dict['PMV'] = self.comfAnalysis().abs().mean(axis = 1)
        output_dict['occupants'] = self.occupants
        self.output_dict = output_dict

    def dumpResults(self, results_file):
        results_df = pd.DataFrame.from_dict(self.output_dict)
        results_df.to_csv(results_file+"_hourly.csv")
        monthly_df = pd.DataFrame()
        Tia_df = pd.DataFrame.from_dict(self.agg_dict['indoor_temperature'])
        for column in results_df:
            if column != 'year' and column != 'month' and column != 'day' and column != 'hour' and column != 'outdoor_temperature':
                monthly_df[column] = results_df.groupby(['month'])[column].sum()*10**-6
            elif column == 'outdoor_temperature':
                monthly_df[column] = results_df.groupby(['month'])[column].mean()
        monthly_df.drop('occupants', axis = 1, inplace=True)
        monthly_df.to_csv(results_file+"_monthly.csv")
        Tia_df.to_csv(results_file+'_indoor_temperature.csv')
        folder = os.path.dirname(results_file)
        print("Simulation complete! Results are successfully dumped to "+folder) if hasattr(self, 'if_print') and self.if_print == True else None

    def run(self):
        self.solarGain()
        self.otherHeatGain()
        self.initiate()
        self.beforeIterate()
        self.iterate()
        self.hourlyAggregate()
        self.energy()
        self.renewables()
        self.aggregate()
        self.postProcess()


