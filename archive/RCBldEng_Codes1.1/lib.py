import collections
import copy
import os

import numpy as np

# import weather

# Constants
# parent_folder = '\\'.join(os.getcwd().split('\\')[0: os.getcwd().split('\\').index('Codes')])+'\\'
parent_folder = os.path.abspath(os.path.join(os.getcwd(), os.pardir)) + "\\"


class Surface:
    def __init__(self):
        self.S = 0
        self.SE = -45
        self.E = -90
        self.NE = -135
        self.N = 180
        self.NW = 135
        self.W = 90
        self.SW = 45

    def iterAttributes(self):
        for key, value in self.__dict__.items():
            if not key.startswith("__"):
                yield key, value


class Ground:
    def __init__(self, cls):
        self.k = 0
        self.C = 0
        self.rou = 0
        self.diffusivity = 0
        self.name = 0
        self.cls = cls
        self.string = 0
        self.getParameters()

    def getParameters(self):
        if self.cls == 1:
            self.k = 1.5
            self.rou = 1600
            self.C = 3000000 / self.rou
            self.name = "clay or silt"
        elif self.cls == 2:
            self.k = 2.0
            self.rou = 1900
            self.C = 2000000 / self.rou
            self.name = "sand or gravel"
        elif self.cls == 3:
            self.k = 3.5
            self.rou = 2500
            self.C = 2000000 / self.rou
            self.name = "homogeneous rock"
        else:
            raise ValueError("class input not listed!")
        self.diffusivity = self.k / (self.rou * self.C)
        self.string = self.name

    def __str__(self):
        return self.string


class Envelope_Heat_Capacity_Class:
    def __init__(self, cls):
        self.Am = 0
        self.Cm = 0
        self.cls = cls
        self.string = 0
        self.getParameters()

    def getParameters(self):
        if self.cls == 1:
            self.Am = 1.2
            self.Cm = 8000
        elif self.cls == 2:
            self.Am = 1.5
            self.Cm = 15000
        elif self.cls == 3:
            self.Am = 1.8
            self.Cm = 25000
        elif self.cls == 4:
            self.Am = 2.0
            self.Cm = 40000
        elif self.cls == 5:
            self.Am = 2.2
            self.Cm = 60000
        elif self.cls == 6:
            self.Am = 2.5
            self.Cm = 80000
        elif self.cls == 7:
            self.Am = 2.5
            self.Cm = 115000
        elif self.cls == 8:
            self.Am = 2.5
            self.Cm = 165000
        elif self.cls == 9:
            self.Am = 3.0
            self.Cm = 260000
        elif self.cls == 10:
            self.Am = 3.2
            self.Cm = 300000
        elif self.cls == 11:
            self.Am = 3.5
            self.Cm = 370000
        else:
            raise ValueError("class input not listed!")
        self.string = "heat capacity per floor area: " + str(self.Cm) + " * Af"

    def __str__(self):
        return self.string


class Wall:
    def __init__(self, lst):
        self.lst = lst.split(",")
        self.type = "wall"
        self.U_value = None
        self.abs = None
        self.emissivity = None
        self.string = 0
        self.getParameters()

    def getParameters(self):
        if "-" not in self.lst[0]:
            self.U_value = float(self.lst[0])
        else:
            self.U_value = "-"
        if "-" not in self.lst[1]:
            self.abs = float(self.lst[1])
        else:
            self.abs = "-"
        if "-" not in self.lst[2]:
            self.emissivity = float(self.lst[2])
        else:
            self.emissivity = "-"
        self.string = (
            self.type
            + "\nU-Value:"
            + str(self.U_value)
            + "\nabsorption coefficienct:"
            + str(self.abs)
            + "\nemissivity:"
            + str(self.emissivity)
        )

    def __str__(self):
        return self.string


class Windows:
    def __init__(self, mat_lst):
        self.mat_lst = mat_lst.split(",")
        self.type = "windows"
        self.U_value = None
        self.emissivity = None
        self.SHGC = None
        self.Tsol = None
        self.string = 0
        self.getParameters()

    def getParameters(self):
        if "-" not in self.mat_lst[0]:
            self.U_value = float(self.mat_lst[0])
        else:
            self.U_value = "-"
        if "-" not in self.mat_lst[1]:
            self.emissivity = float(self.mat_lst[1])
        else:
            self.emissivity = "-"
        if "-" not in self.mat_lst[2]:
            self.SHGC = float(self.mat_lst[2])
        else:
            self.SHGC = "-"

        if self.SHGC != "-" and self.U_value != "-":
            if self.U_value > 4.5 and self.SHGC < 0.7206:
                self.Tsol = 0.939998 * self.SHGC**2 + 0.20332 * self.SHGC
            elif self.U_value > 4.5 and self.SHGC >= 0.7206:
                self.Tsol = 1.30415 * self.SHGC - 0.30515
            elif self.U_value < 3.4 and self.SHGC <= 0.15:
                self.Tsol = 0.41040 * self.SHGC
            elif self.U_value < 3.4 and self.SHGC > 0.15:
                self.Tsol = 0.085775 * self.SHGC**2 + 0.963954 * self.SHGC - 0.084958
            else:
                if self.SHGC < 0.7206:
                    Tsol_1 = 0.939998 * self.SHGC**2 + 0.20332 * self.SHGC
                else:
                    Tsol_1 = 1.30415 * self.SHGC - 0.30515
                if self.SHGC <= 0.15:
                    Tsol_2 = 0.41040 * self.SHGC
                else:
                    Tsol_2 = 0.085775 * self.SHGC**2 + 0.963954 * self.SHGC - 0.084958
                # print Tsol_1, Tsol_2
                self.Tsol = np.interp(self.U_value, [3.4, 4.5], [Tsol_1, Tsol_2])
            # self.Tsol = self.SHGC
        else:
            self.Tsol = "-"

        # print self.Tsol
        self.string = (
            self.type
            + "\nU-Value:"
            + str(self.U_value)
            + "\nemissivity:"
            + str(self.emissivity)
            + "\nSHGC:"
            + str(self.SHGC)
            + "\nsolar transmittance:"
            + str(self.Tsol)
        )

    def __str__(self):
        return self.string


class Basement:
    def __init__(self, walls):
        self.walls = walls
        self.string = []

    ##        self.printByComponent()

    def printByComponent(self):
        for wall in self.walls:
            print(wall)


class Schedule:
    def __init__(self, dct, dim):
        self.dct = dct
        self.dim = dim
        self.parseOrigDict()

    def sched2Array(self, dct):
        sched = np.zeros((int(list(dct.keys())[-1].split(" ")[-1]), self.dim))
        try:
            np.array(list(dct.values())[0].split(",")).astype(float)
        except ValueError:
            sched = sched.astype(str)
        for key, value in list(dct.items()):
            split = key.split(" ")
            start_row = int(split[1])
            end_row = int(split[-1])
            if self.dim != 1:
                sched[start_row:end_row] = np.array(value.split(",")).astype(float)
            else:
                try:
                    sched[start_row:end_row] = float(value)
                except ValueError:
                    sched[start_row:end_row] = value
        return sched

    def parseOrigDict(self):
        self.sched = self.sched2Array(self.dct)

    def getSchedule(self):
        return self.sched


class Shading:
    def __init__(self, cls, in_or_out, control):
        """1': white blinds; 2: white curtains; 3: colored texture;
        4: alumnimium-coated texture
        0: in, 1: out"""
        self.cls = cls
        self.in_or_out = in_or_out
        self.control = control
        self.mat_name = 0
        self.side_name = 0
        self.SRF = 0
        self.string = 0
        self.getParameters()

    def getParameters(self):
        if self.cls == "-":
            self.SRF = 1
            self.string = "no shading"
            return

        self.cls = int(self.cls)
        self.in_or_out = int(self.in_or_out)
        self.control = int(self.control)
        if self.in_or_out == 1:
            self.side_name = "inside"
            if self.cls == 1:
                self.SRF = 0.7
                self.mat_name = "white blinds"
            elif self.cls == 2:
                self.SRF = 0.8
                self.mat_name = "white curtains"
            elif self.cls == 3:
                self.SRF = 0.57
                self.mat_name = "colored texture"
            elif self.cls == 4:
                self.SRF = 0.2
                self.mat_name = "alumnimium-coated texture"
            else:
                raise ValueError("class input not listed!")
        elif self.in_or_out == 2:
            self.side_name = "outside"
            if self.cls == 1:
                self.SRF = 0.3
                self.mat_name = "white blinds"
            elif self.cls == 2:
                self.SRF = 0.75
                self.mat_name = "white curtains"
            elif self.cls == 3:
                self.SRF = 0.37
                self.mat_name = "colored texture"
            elif self.cls == 4:
                self.SRF = 0.08
                self.mat_name = "alumnimium-coated texture"
            else:
                raise ValueError("class input not listed!")
        else:
            raise ValueError("class input not listed!")

        # if self.control == 1:
        #     self.SRF = self.SRF*0.75; self.mat_name+= ' controlled by user'
        # elif self.control == 2:
        #     self.SRF = self.SRF*0.5; self.mat_name+= ' controlled automatically'
        # elif self.control == 3:
        #     self.SRF = self.SRF*1; self.mat_name+= ' not well controlled'
        # else:
        #     raise ValueError('class input not listed!')
        # print self.SRF, self.cls, self.in_or_out, self.control

        self.string = "shading with %s %s" % (self.mat_name, self.side_name)

    def __str__(self):
        return self.string


class Infiltration_Leak_Level:
    def __init__(self, bldg_type, level):
        self.bldg_type = bldg_type
        self.level = level
        self.rate = 0
        self.dCP = 0.75
        self.string = 0
        self.getParameters()

    def getParameters(self):
        if self.bldg_type == 1:
            if self.level == 1:
                self.rate = 0.5
                self.string = "air leakage level low: 1/h at Q4Pa"
            elif self.level == 2:
                self.rate = 1
                self.string = "air leakage level medium: 1/h at Q4Pa"
            elif self.level == 3:
                self.rate = 3
                self.string = "air leakage level high: 3/h at Q4Pa"
            else:
                raise ValueError("class input not listed!")
        elif self.bldg_type == 2:
            if self.level == 1:
                self.rate = 0.5
                self.string = "air leakage level low: 0.5h at Q4Pa"
            elif self.level == 2:
                self.rate = 1
                self.string = "air leakage level medium: 1/h at Q4Pa"
            elif self.level == 3:
                self.rate = 3
                self.string = "air leakage level high: 3/h at Q4Pa"
            else:
                raise ValueError("class input not listed!")
        elif self.bldg_type == 3:
            if self.level == "low":
                self.rate = 2
                self.string = "air leakage level low: 2/h at Q4Pa"
            elif self.level == "medium":
                self.rate = 4
                self.string = "air leakage level medium: 4/h at Q4Pa"
            elif self.level == "high":
                self.rate = 6
                self.string = "air leakage level high: 6/h at Q4Pa"
            else:
                raise ValueError("class input not listed!")
        else:
            raise ValueError("class input not listed!")

    def __str__(self):
        return self.string


class Natural_Ventilation:
    def __init__(self, cls_type, open_angle, night_flush, occ_sched):
        self.cls_type = cls_type
        self.ca = 1.2  # heat capacity of air: 1.2 J/liter*k
        self.occ_sched = occ_sched
        self.NV_sched = None
        self.string = 0
        self.Ck = 0
        self.open_angle = open_angle
        self.night_flush = night_flush
        self.getParameters()

    def getParameters(self):
        if self.open_angle == 0:
            self.Ck = 0
        elif self.open_angle == 10:
            self.Ck = 0.17
        elif self.open_angle == 15:
            self.Ck = 0.25
        elif self.open_angle == 20:
            self.Ck = 0.33
        elif self.open_angle == 25:
            self.Ck = 0.39
        elif self.open_angle == 30:
            self.Ck = 0.46
        elif self.open_angle == 45:
            self.Ck = 0.62
        elif self.open_angle == 60:
            self.Ck = 0.74
        elif self.open_angle == 90:
            self.Ck = 0.9
        elif self.open_angle == 180:
            self.Ck = 1
        else:
            raise ValueError("class input not listed!")

        if self.cls_type != 1:
            self.NV_sched = np.where(self.occ_sched > 0, 1, 0)
        else:
            self.NV_sched = np.zeros(self.occ_sched.shape)

        if self.night_flush == 1:
            self.string = (
                "natural ventilation with window open at an angle of: "
                + str(self.open_angle)
                + " w/night flush"
            )
            self.NV_sched = np.where(self.NV_sched == 0, 1, self.NV_sched)
            return self.string
        elif self.night_flush == 2:
            self.string = (
                "natural ventilation with window open at an angle of: "
                + str(self.open_angle)
                + " w/o night flush"
            )
            return self.string

    def __str__(self):
        return self.string


class Heat_Recovery_Sys:
    def __init__(self, cls_type):
        self.name = 0
        self.HR_eff = 0
        self.cls_type = cls_type
        self.string = 0
        self.getParameters()

    def getParameters(self):
        if self.cls_type == 1:
            self.name = "no heat recovery"
            self.HR_eff = 0
        elif self.cls_type == 2:
            self.name = "heat change plates or pipes"
            self.HR_eff = 0.65
        elif self.cls_type == 3:
            self.name = "two-elements-system"
            self.HR_eff = 0.6
        elif self.cls_type == 4:
            self.name = "loading cold with air-conditioning"
            self.HR_eff = 0.4
        elif self.cls_type == 5:
            self.name = "heat pipes"
            self.HR_eff = 0.6
        elif self.cls_type == 6:
            self.name = "slow rotating or intermittent heat exchanger"
            self.HR_eff = 0.7
        else:
            raise ValueError("class input not listed!")
        self.string = (
            "heat recovery system w/"
            + self.name
            + " (efficiency: "
            + str(self.HR_eff)
            + " )"
        )

    def __str__(self):
        return self.string


class Terrain_Class:
    def __init__(self, cls):
        self.cls = cls
        self.vsite = 0
        self.name = 0
        self.string = 0
        self.getParameters()

    def getParameters(self):
        if self.cls == 1:
            self.vsite = 1
            self.name = "open terrain"
        elif self.cls == 2:
            self.vsite = 0.9
            self.name = "country"
        elif self.cls == 3:
            self.vsite = 0.8
            self.name = "urban"
        else:
            raise ValueError("class input not listed!")
        self.string = self.name + ": " + str(self.vsite)

    def __str__(self):
        return self.string


class Exhaust_Air_Recirculation:
    def __init__(self, cls):
        self.cls = cls
        self.factor = 0
        self.name = 0
        self.string = 0
        self.getParameters()

    def getParameters(self):
        if self.cls == 1:
            self.factor = 1
            self.name = "no exhaust air recirculation"
        elif self.cls == 2:
            self.factor = 0.8
            self.name = "exhaust air recirculation 20%"
        elif self.cls == 3:
            self.factor = 0.6
            self.name = "exhaust air recirculation 40%"
        elif self.cls == 4:
            self.factor = 0.4
            self.name = "exhaust air recirculation 60%"
        else:
            raise ValueError("class input not listed!")
        self.string = self.name

    def __str__(self):
        return self.string


class HVAC_Sys:
    def __init__(self, cls):
        self.cls = cls
        self.f_waste = 0
        self.a_heat = 0
        self.a_cool = 0
        self.string = 0
        self.name = 0
        self.getParameters()

    def getParameters(self):
        # HVAC System type (Heat distribution/ Cold distribution/ Room temperature control)
        if self.cls == 1:
            self.f_waste = 0
            self.a_heat = 0.08
            self.a_cool = 0
            self.name = "No airco system / Water or Water&Air / NA / Yes "
        elif self.cls == 2:
            self.f_waste = 0
            self.a_heat = 0.25
            self.a_cool = 0
            self.name = "No airco system / Water or Water&Air / NA / No"
        elif self.cls == 3:
            self.f_waste = 0
            self.a_heat = 0
            self.a_cool = 0
            self.name = "No airco system / Air / NA /  Yes"
        elif self.cls == 4:
            self.f_waste = 0
            self.a_heat = 0.36
            self.a_cool = 0
            self.name = "No airco system / Air / NA /  No"
        elif self.cls == 5:
            self.f_waste = 0.03
            self.a_heat = 0.08
            self.a_cool = 0.01
            self.name = "Single duct system / Water or Water&Air / Water / Yes"
        elif self.cls == 6:
            self.f_waste = 0
            self.a_heat = 0.08
            self.a_cool = 0
            self.name = "Single duct system / Water or Water&Air / Air / Yes"
        elif self.cls == 7:
            self.f_waste = 0
            self.a_heat = 0.25
            self.a_cool = 0
            self.name = "No airco system / Air / NA /  No"
        elif self.cls == 8:
            self.f_waste = 0.04
            self.a_heat = 0
            self.a_cool = 0
            self.name = "Single duct system / Air  / Air / Yes"
        elif self.cls == 9:
            self.f_waste = 0
            self.a_heat = 0.36
            self.a_cool = 0
            self.name = "Single duct system / Air / Air / No"
        elif self.cls == 10:
            self.f_waste = 0.03
            self.a_heat = 0.08
            self.a_cool = 0.01
            self.name = "Dual duct system / Water or Water&Air / Water / Yes"
        elif self.cls == 11:
            self.f_waste = 0
            self.a_heat = 0.08
            self.a_cool = 0
            self.name = "Dual duct system / Water or Water&Air / Air / Yes"
        elif self.cls == 12:
            self.f_waste = 0
            self.a_heat = 0.25
            self.a_cool = 0
            self.name = "Dual duct system  / Water or Water&Air / Air / No"
        elif self.cls == 13:
            self.f_waste = 0.08
            self.a_heat = 0
            self.a_cool = 0.01
            self.name = "Dual duct system / Air / Water / Yes"
        elif self.cls == 14:
            self.f_waste = 0.03
            self.a_heat = 0.08
            self.a_cool = 0.01
            self.name = (
                "Single duct , Terminal reheat / Water or Water&Air / Water / Yes"
            )
        elif self.cls == 15:
            self.f_waste = 0
            self.a_heat = 0.08
            self.a_cool = 0
            self.name = (
                "Single duct , Terminal reheat  / Water or Water&Air / Air / Yes"
            )
        elif self.cls == 16:
            self.f_waste = 0
            self.a_heat = 0.25
            self.a_cool = 0
            self.name = "Single duct , Terminal reheat / Water or Water&Air / Air / No"
        elif self.cls == 17:
            self.f_waste = 0.03
            self.a_heat = 0.08
            self.a_cool = 0.01
            self.name = "Constant volume / Water or Water&Air / Water / Yes"
        elif self.cls == 18:
            self.f_waste = 0
            self.a_heat = 0.08
            self.a_cool = 0
            self.name = "Constant volume / Water or Water&Air / Air / Yes"
        elif self.cls == 19:
            self.f_waste = 0
            self.a_heat = 0.25
            self.a_cool = 0
            self.name = "Constant volume / Water or Water&Air / Air / No"
        elif self.cls == 20:
            self.f_waste = 0.04
            self.a_heat = 0
            self.a_cool = 0
            self.name = "Constant volume / Air  / Air / Yes"
        elif self.cls == 21:
            self.f_waste = 0
            self.a_heat = 0.36
            self.a_cool = 0
            self.name = "Constant volume / Air / Air / No"
        elif self.cls == 22:
            self.f_waste = 0.03
            self.a_heat = 0.03
            self.a_cool = 0.01
            self.name = "Variable air volume / Water or Water&Air / Water / Yes"
        elif self.cls == 23:
            self.f_waste = 0
            self.a_heat = 0.08
            self.a_cool = 0
            self.name = "Variable air volume / Water or Water&Air / Air / Yes"
        elif self.cls == 24:
            self.f_waste = 0
            self.a_heat = 0.25
            self.a_cool = 0
            self.name = "Variable air volume / Water or Water&Air / Air / No"
        elif self.cls == 25:
            self.f_waste = 0.04
            self.a_heat = 0.08
            self.a_cool = 0.01
            self.name = "Fan coil system, 2-pipe"
        elif self.cls == 26:
            self.f_waste = 0.04
            self.a_heat = 0.08
            self.a_cool = 0.01
            self.name = "Fan coil system, 3-pipe"
        elif self.cls == 27:
            self.f_waste = 0.04
            self.a_heat = 0.08
            self.a_cool = 0.01
            self.name = "Fan coil system, 4-pipe"
        elif self.cls == 28:
            self.f_waste = 0.08
            self.a_heat = 0
            self.a_cool = 0.01
            self.name = "Induction system, 2-pipe non change over"
        elif self.cls == 29:
            self.f_waste = 0.04
            self.a_heat = 0.08
            self.a_cool = 0.01
            self.name = "Induction system, 2-pipe change over"
        elif self.cls == 30:
            self.f_waste = 0.04
            self.a_heat = 0.08
            self.a_cool = 0.01
            self.name = "Induction system, 3-pipe"
        elif self.cls == 31:
            self.f_waste = 0.04
            self.a_heat = 0.08
            self.a_cool = 0.01
            self.name = "Induction system, 4-pipe"
        elif self.cls == 32:
            self.f_waste = 0.04
            self.a_heat = 0.08
            self.a_cool = 0.01
            self.name = "2-pipe radiant cooling panels (chilled ceilings & passive chilled beams)"
        elif self.cls == 33:
            self.f_waste = 0.04
            self.a_heat = 0.08
            self.a_cool = 0.01
            self.name = "4-pipe radiant cooling panels (chilled ceilings & passive chilled beams)"
        elif self.cls == 34:
            self.f_waste = 0.04
            self.a_heat = 0.08
            self.a_cool = 0.01
            self.name = "Embedded cooling system floors, walls or ceilings"
        elif self.cls == 35:
            self.f_waste = 0
            self.a_heat = 0.08
            self.a_cool = 0.01
            self.name = "Room units including single duct units"
        elif self.cls == 36:
            self.f_waste = 0
            self.a_heat = 0
            self.a_cool = 0
            self.name = "Direct expansion single split system"
        elif self.cls == 37:
            self.f_waste = 0
            self.a_heat = 0
            self.a_cool = 0
            self.name = "Direct expansion single split system including variable refrigerant flow systems"
        else:
            raise ValueError("class input not listed!")
        self.string = (
            self.name
            + ": f_waste = "
            + str(self.f_waste)
            + ", a_heat = "
            + str(self.a_heat)
            + ", a_cool = "
            + str(self.a_cool)
        )

    def __str__(self):
        return self.string


class BEM_Sys:
    def __init__(self, cls):
        self.cls = cls
        self.name = 0
        self.f_BAC_hc = 0
        self.f_BAC_e = 0
        self.string = 0
        self.getParameters()

    def getParameters(self):
        if self.cls == 1:
            self.name = "Class D"
            self.f_BAC_hc = 1.51
            self.f_BAC_e = 1.1
        elif self.cls == 2:
            self.name = "Class C"
            self.f_BAC_hc = 1
            self.f_BAC_e = 1
        elif self.cls == 3:
            self.name = "Class B"
            self.f_BAC_hc = 0.8
            self.f_BAC_e = 0.93
        elif self.cls == 4:
            self.name = "Class A"
            self.f_BAC_hc = 0.7
            self.f_BAC_e = 0.87
        else:
            raise ValueError("class input not listed!")
        self.string = (
            "BEM system: "
            + self.name
            + " with f_BAC_hc: "
            + str(self.f_BAC_hc)
            + " and f_BAC_e: "
            + str(self.f_BAC_e)
        )

    def __str__(self):
        return self.string


class Fan:
    def __init__(self):
        self.rho = 1.22521 * 0.001012
        self.string = "Fan"

    def __str__(self):
        return self.string


class Pump_Sys:
    def __init__(self, cls):
        self.cls = cls
        self.name = 0
        self.rho = 4.184
        self.string = 0
        self.factor = 0
        self.getParameters()

    def getParameters(self):
        if self.cls == 1:
            self.name = "no pump used"
            self.factor = 0
        elif self.cls == 2:
            self.name = "automatic control more than 50%"
            self.factor = 0.5
        elif self.cls == 3:
            self.name = "all other case"
            self.factor = 1
        else:
            raise ValueError("class input not listed!")
        self.string = self.name

    def __str__(self):
        return self.string


class DHW_Sys:
    def __init__(self, distr_cls, sys_cls):
        self.distr_cls = distr_cls
        self.sys_cls = sys_cls
        self.string = ""
        self.distr_eff = 0
        self.sys_eff = 0
        self.getParameters()

    def getParameters(self):
        if self.sys_cls == 1:
            self.sys_eff = 0.75
            self.string += "electric generation"
        elif self.sys_cls == 2:
            self.sys_eff = 0.61
            self.string += "VR-boiler"
        elif self.sys_cls == 3:
            self.sys_eff = 0.75
            self.string += "gas_boiler or HR-boiler"
        elif self.sys_cls == 4:
            self.sys_eff = 0.9
            self.string += "co-generation"
        elif self.sys_cls == 5:
            self.sys_eff = 0.9
            self.string += "district heating"
        elif self.sys_cls == 6:
            self.sys_eff = 1.4
            self.string += "heat pump"
        elif self.sys_cls == 7:
            self.sys_eff = 0.61
            self.string += "steam"
        else:
            raise ValueError("class input not listed!")

        if self.distr_cls == 1:
            self.distr_eff = 1
            self.string += " that all taps within 3m from heat generation"
        elif self.distr_cls == 2:
            self.distr_eff = 0.8
            self.string += " that taps more than 3m from heat generation"
        elif self.distr_cls == 3:
            self.distr_eff = 0.6
            self.string += " of circulation system or unknown"
        else:
            raise ValueError("class input not listed!")

    def __str__(self):
        return self.string


class PV_Sys:
    def __init__(self, cls, vent_type):
        self.cls = cls
        self.vent_type = vent_type
        self.Kpk = 0
        self.fperf = 0
        self.name = 0
        self.string = 0
        self.getParameters()

    def getParameters(self):
        if self.cls == 1:
            self.Kpk = 0.15
            self.name = "Mono crystalline silicona of Kpk = 0.15kW/m2"
        elif self.cls == 2:
            self.Kpk = 0.13
            self.name = "Multi crystalline silicona of Kpk = 0.13kW/m2"
        elif self.cls == 3:
            self.Kpk = 0.06
            self.name = "Thin film amorphous silicon of Kpk = 0.06kW/m2"
        elif self.cls == 4:
            self.Kpk = 0.035
            self.name = "Other thin film layers of Kpk = 0.035kW/m2"
        elif self.cls == 5:
            self.Kpk = 0.105
            self.name = "Thin film copper-indium-gallium-diselenide of Kpk = 0.105kW/m2"
        elif self.cls == 6:
            self.Kpk = 0.095
            self.name = "Thin film cadmium-telloride of Kpk = 0.095kW/m2"
        else:
            raise ValueError("class input not listed!")

        if self.vent_type == 1:
            self.fperf = 0.7
            self.string = self.name + " w/fperf = 0.7"
        elif self.vent_type == 2:
            self.fperf = 0.75
            self.string = self.name + " w/fperf = 0.75"
        elif self.vent_type == 3:
            self.fperf = 0.78
            self.string = self.name + " w/fperf = 0.8"
        else:
            raise ValueError("class input not listed!")

    def __str__(self):
        return self.string


class Primary_Energy_Factor:
    def __init__(self, cls):
        self.cls = cls
        self.name = 0
        self.string = 0
        self.factor = 0
        self.getParameters()

    def getParameters(self):
        if self.cls == 1:
            self.factor = 3.167
            self.name = "electricity"
        elif self.cls == 2:
            self.factor = 1.084
            self.name = "natural gas"
        elif self.cls == 3:
            self.factor = 1.056
            self.name = "district cooling"
        elif self.cls == 4:
            self.factor = 3.613
            self.name = "district heating"
        elif self.cls == 5:
            self.factor = 0.3
            self.name = "steam"
        elif self.cls == 6:
            self.factor = 1.05
            self.name = "gasoline"
        elif self.cls == 7:
            self.factor = 1.05
            self.name = "diesel"
        elif self.cls == 8:
            self.factor = 1.05
            self.name = "coal"
        elif self.cls == 9:
            self.factor = 1.05
            self.name = "fuel oil"
        elif self.cls == 10:
            self.factor = 1.05
            self.name = "propane"
        elif self.cls == 11:
            self.factor = 1.05
            self.name = "kerosene"
        elif self.cls == 12:
            self.factor = 1.05
            self.name = "traditional bio"
        elif self.cls == 13:
            self.factor = 1.05
            self.name = "others"
        else:
            raise ValueError("class input not listed!")
        self.string = self.name + "w/conversion factor = " + str(self.factor)

    def __str__(self):
        return self.string


class Building_Type:
    def __init__(self, cls):
        self.cls = cls
        self.name = 0
        self.week_sched = 0
        self.string = 0
        self.getParameters()


class Read_Inputs:
    def __init__(self, input_file):
        self.input_file = input_file
        self.input_dict = {}
        self.finish = False
        self.content = self.readFile()
        self.readIntoMainDict()

    def readFile(self):
        with open(self.input_file, encoding="utf-8") as f:
            content = f.readlines()
        return content

    def line2Dict(self, line, dct):
        if "!!!" in line:
            pair = line.split("!!!")[0].split(":")
            key = pair[0].lstrip(" ").rstrip(" ")
            if len(pair) > 2:
                value = [":".join(s for s in pair[1:])][0].lstrip(" ").rstrip("\t")
                # print 'Weather file: ', value
            else:
                value = pair[1].lstrip(" ").rstrip(" \n\t")
            dct[key] = value
        else:
            pair = line.split(":")
            key = pair[0].lstrip(" ").rstrip(" ")
            value = pair[1].replace("\n", "").lstrip(" ").rstrip(" \n\t")
            dct[key] = value

    def parseLines2SubDict(self, lines, dct):
        for line in lines:
            if (
                "zone name:" in line.lower()
                or "surface name:" in line.lower()
                or "hvac name:" in line.lower()
                or "lighting name:" in line.lower()
            ):
                name = line.split("!!!")[0].split(":")[1].lstrip(" ").rstrip(" \n\t")
                dct[name] = collections.OrderedDict()
            else:
                try:
                    self.line2Dict(line, dct[name])
                except UnboundLocalError:
                    self.line2Dict(line, dct)

    def readSubDicts(self):
        content = self.content
        for i in range(len(content)):
            if content[i].startswith("$") and "Schedules:" in content[i]:
                key = content[i].split("!!!")[0].split(":")[0].lstrip(" $")
                self.input_dict[key] = collections.OrderedDict()
                for j in range(i + 1, len(content) - 1):
                    if content[j].startswith("Schedule Name:"):
                        lines = []
                        subkey = (
                            content[j]
                            .split("!!!")[0]
                            .split(":")[1]
                            .lstrip(" ")
                            .rstrip(" \n\t")
                        )
                        self.input_dict[key][subkey] = collections.OrderedDict()
                        while (
                            "Schedule Name:" not in content[j + 1]
                            and "$" not in content[j + 1]
                        ):
                            if ":" in content[j + 1]:
                                lines.append(content[j + 1])
                            j += 1
                        self.parseLines2SubDict(lines, self.input_dict[key][subkey])
                    elif content[j].startswith("$"):
                        break
                # print self.input_dict[key]
            elif content[i].startswith("$"):
                sub_name = content[i].split(":")[0].strip("$")
                self.input_dict[sub_name] = collections.OrderedDict()
                lines = []
                try:
                    while "$" not in content[i + 1]:
                        if ":" in content[i + 1]:
                            lines.append(content[i + 1])
                        i += 1
                    self.parseLines2SubDict(lines, self.input_dict[sub_name])
                except IndexError:
                    self.parseLines2SubDict(lines, self.input_dict[sub_name])
        # for k, v in self.input_dict.items():
        #     print k, v, '\n'
        for name, sched in list(self.input_dict["Building Use Schedules"].items()):
            self.input_dict["Building Use Schedules"][name] = Schedule(sched, 10)
            # print self.input_dict['Building Use Schedules'][name].getSchedule()
        for name, sched in list(
            self.input_dict["Indoor Temperature Setpoint Schedules"].items()
        ):
            self.input_dict["Indoor Temperature Setpoint Schedules"][name] = Schedule(
                sched, 4
            )
            # print self.input_dict['Indoor Temperature Setpoint Schedules'][name].getSchedule()
        for name, sched in list(self.input_dict["Monthly Schedules"].items()):
            self.input_dict["Monthly Schedules"][name] = Schedule(sched, 1)
            # print name, self.input_dict['Monthly Schedules'][name].getSchedule()

    def readIntoMainDict(self):
        self.readSubDicts()
        self.finish = True

    def getInputDict(self):
        return self.input_dict

    def printDict(self):
        if self.finish:
            for key, value in list(self.input_dict.items()):
                print((key, value, "\n"))
        else:
            print("Reading input file is not successfule!")


class Pre_Calculation:
    def __init__(self, wea_dict, input_dict, first_day):
        self.input_dict = input_dict
        # self.SCal_dict = SCal_dict
        self.wea_dict = wea_dict
        self.first_day = first_day
        self.dct = {}
        self.getGeneralInfo()
        self.getZoneInfo()
        self.getDHW()
        self.getPumps()
        self.getPV()
        self.getWindSys()

    def getGeneralInfo(self):
        subDict = {}
        if self.input_dict["Basics"]["Envelope Heat Capacity Type"] != "-":
            heat_capacity = Envelope_Heat_Capacity_Class(
                int(self.input_dict["Basics"]["Envelope Heat Capacity Type"])
            )
            subDict["Cm"] = heat_capacity.Cm
            subDict["Am"] = heat_capacity.Am
        else:
            subDict["Cm"] = float(self.input_dict["Basics"]["Envelope Heat Capacity"])
            subDict["Am"] = float(self.input_dict["Basics"]["Effective Mass Area"])
        if (
            "Internal Air Heat Transfer Coefficient"
            not in self.input_dict["Basics"].keys()
        ):
            subDict["At"] = 4.5
        else:
            if (
                self.input_dict["Basics"]["Internal Air Heat Transfer Coefficient"]
                != "-"
            ):
                subDict["At"] = float(
                    self.input_dict["Basics"]["Internal Air Heat Transfer Coefficient"]
                )
            else:
                subDict["At"] = 4.5
        subDict["building length"] = float(self.input_dict["Basics"]["Building Length"])
        subDict["building width"] = float(self.input_dict["Basics"]["Building Width"])
        subDict["building area"] = float(self.input_dict["Basics"]["Ground Floor Area"])
        subDict["building type"] = int(self.input_dict["Basics"]["Building Type"])
        subDict["ground temperature"] = np.array(
            self.input_dict["Basics"]["Monthly Ground Surface Temperature"].split(",")
        ).astype(float)
        ground = Ground(float(self.input_dict["Basics"]["Ground Type"]))
        subDict["ground conductivity"] = ground.k
        subDict["ground heat capacity"] = ground.C
        subDict["ground diffusivity"] = ground.diffusivity
        subDict["ground density"] = ground.rou
        subDict["cummulative hour"] = np.array(
            list(range(1, len(self.wea_dict["DBT"]) + 1))
        )
        subDict["date"] = np.where(
            np.mod(subDict["cummulative hour"], 24) == 0,
            subDict["cummulative hour"] // 24,
            (subDict["cummulative hour"] // 24) + 1,
        )
        subDict["day"] = np.where(
            np.mod(subDict["date"], 7) == 0, 7, np.mod(subDict["date"], 7)
        )
        subDict["hour"] = np.where(
            np.mod(subDict["cummulative hour"], 24) == 0,
            24,
            np.mod(subDict["cummulative hour"], 24),
        )
        week_day = collections.OrderedDict(
            [
                ("mon", 1),
                ("tue", 1),
                ("wed", 1),
                ("thr", 1),
                ("fri", 1),
                ("sat", 0),
                ("sun", 0),
            ]
        )
        week_day_list = list(week_day)
        if self.first_day not in week_day_list:
            raise ValueError(
                "Please choose one weekday to start with the simulation: mon, tue, wed, thr, fri, sat, sun"
            )
        week_day_list = (
            week_day_list[week_day_list.index(self.first_day) :]
            + week_day_list[: week_day_list.index(self.first_day)]
        )
        one_week = [week_day[d] for d in week_day_list]
        subDict["day type"] = np.array(
            [np.array(one_week)[x - 1] for x in subDict["day"]]
        )
        subDict["cool_source"] = Primary_Energy_Factor(
            int(self.input_dict["Energy Sources"]["Cooling Energy Source"])
        )
        subDict["heat_source"] = Primary_Energy_Factor(
            int(self.input_dict["Energy Sources"]["Heating Energy Source"])
        )
        subDict["DHW_source"] = Primary_Energy_Factor(
            int(self.input_dict["Energy Sources"]["DHW Energy Source"])
        )
        subDict["HVAC_dct"] = {}
        self.dct["General"] = subDict

    def ifEmptyEnvelope(self, env_name):
        if env_name == "-":
            return "-"
        else:
            return self.input_dict["Envelope Setting"][env_name]

    def getZoneInfo(self):
        self.dct["Zones"] = {}
        subDict = {}
        for zone, info_dict in list(self.input_dict["Zones"].items()):
            subDict[zone] = {}

            # zone basic information
            subDict[zone]["multiplier"] = int(info_dict["Multiplier"])
            m = int(info_dict["Multiplier"])
            subDict[zone]["lenght"] = (
                float(info_dict["Length"])
                if isinstance(info_dict["Length"], float)
                else "-"
            )
            subDict[zone]["width"] = (
                float(info_dict["Width"])
                if isinstance(info_dict["Width"], float)
                else "-"
            )
            subDict[zone]["height"] = float(info_dict["Height"]) * m
            subDict[zone]["Af"] = m * float(info_dict["Area"])
            area = subDict[zone]["Af"]
            subDict[zone]["occupancy"] = float(info_dict["Occupancy"])
            if float(info_dict["Occupancy"]) == 0:
                subDict[zone]["occupants"] = 0
                subDict[zone]["occupant load"] = 0
            else:
                subDict[zone]["occupants"] = area / float(info_dict["Occupancy"])
                subDict[zone]["occupant load"] = (
                    float(info_dict["Metabolic Rate"]) / subDict[zone]["occupancy"]
                )
            subDict[zone]["STOA"] = float(info_dict["Outdoor Air"]) * (
                area / float(info_dict["Occupancy"])
            )
            subDict[zone]["appliance load"] = float(info_dict["Appliance"])
            subDict[zone]["DHW"] = float(info_dict["DHW"])
            # subDict[zone]['At'] = 2*(float(info_dict['Height'])*float(info_dict['Length'])/area+float(info_dict['Height'])*float(info_dict['Width'])/area)+2

            # Zone Envelope
            subDict[zone]["Envelopes"] = {}
            if "South Facing External Facade Setting" in list(info_dict.keys()):
                subDict[zone]["Envelopes"]["S"] = self.ifEmptyEnvelope(
                    info_dict["South Facing External Facade Setting"]
                )
            if "North Facing External Facade Setting" in list(info_dict.keys()):
                subDict[zone]["Envelopes"]["N"] = self.ifEmptyEnvelope(
                    info_dict["North Facing External Facade Setting"]
                )
            if "West Facing External Facade Setting" in list(info_dict.keys()):
                subDict[zone]["Envelopes"]["W"] = self.ifEmptyEnvelope(
                    info_dict["West Facing External Facade Setting"]
                )
            if "East Facing External Facade Setting" in list(info_dict.keys()):
                subDict[zone]["Envelopes"]["E"] = self.ifEmptyEnvelope(
                    info_dict["East Facing External Facade Setting"]
                )
            if "Southeast Facing External Facade Setting" in list(info_dict.keys()):
                subDict[zone]["Envelopes"]["SE"] = self.ifEmptyEnvelope(
                    info_dict["Southeast Facing External Facade Setting"]
                )
            if "Northwest Facing External Facade Setting" in list(info_dict.keys()):
                subDict[zone]["Envelopes"]["NW"] = self.ifEmptyEnvelope(
                    info_dict["Northwest Facing External Facade Setting"]
                )
            if "Southwest Facing External Facade Setting" in list(info_dict.keys()):
                subDict[zone]["Envelopes"]["SW"] = self.ifEmptyEnvelope(
                    info_dict["Southwest Facing External Facade Setting"]
                )
            if "Northeast Facing External Facade Setting" in list(info_dict.keys()):
                subDict[zone]["Envelopes"]["NE"] = self.ifEmptyEnvelope(
                    info_dict["Northeast Facing External Facade Setting"]
                )
            subDict[zone]["Envelopes"]["R"] = self.ifEmptyEnvelope(
                info_dict["Roof Setting"]
            )
            subDict[zone]["Envelopes"]["G"] = self.ifEmptyEnvelope(
                info_dict["Ground Slab Setting"]
            )
            subDict[zone]["Envelopes"] = self.getEnvelopes(
                subDict[zone]["Envelopes"], m
            )
            # print subDict[zone]['Envelopes']

            # zone schedule
            infl = np.zeros(8760)
            infl_sched = (
                self.input_dict["Monthly Schedules"][
                    info_dict["Air Infiltration Schedule"]
                ].getSchedule()
                if info_dict["Air Infiltration Schedule"] != "-"
                else "-"
            )
            if not isinstance(infl_sched, str):
                for i in range(len(self.wea_dict["month"])):
                    infl[i] = float(infl_sched[int(self.wea_dict["month"][i] - 1), 0])
                subDict[zone]["infiltration_sched"] = np.array(infl)
            else:
                subDict[zone]["infiltration_sched"] = np.ones(len(self.wea_dict["DBT"]))
            infl_sched = subDict[zone]["infiltration_sched"]

            month = copy.deepcopy(self.wea_dict["month"])
            month[np.sort(np.unique(month, return_index=True)[1])]
            occ_sched_month = self.input_dict["Monthly Schedules"][
                info_dict["Building Use Schedule"]
            ].getSchedule()
            temp_sched_month = self.input_dict["Monthly Schedules"][
                info_dict["Indoor Temperature Setpoint Schedule"]
            ].getSchedule()
            occupancy_frac = []
            equipment_frac = []
            light_frac = []
            HVAC_frac = []
            T_set_H = []
            T_set_C = []
            infl_frac = []
            for i in month[np.sort(np.unique(month, return_index=True)[1])].astype(int):
                indices = np.where(month == i)
                occ_sched = self.input_dict["Building Use Schedules"][
                    occ_sched_month[i - 1][0]
                ].getSchedule()
                temp_sched = self.input_dict["Indoor Temperature Setpoint Schedules"][
                    temp_sched_month[i - 1][0]
                ].getSchedule()
                occupancy_frac += [
                    occ_sched[np.mod(j, 24)][0]
                    if self.dct["General"]["day type"][j] == 1
                    else occ_sched[np.mod(j, 24)][1]
                    for j in range(indices[0][0], indices[0][-1] + 1)
                ]
                equipment_frac += [
                    occ_sched[np.mod(j, 24)][2]
                    if self.dct["General"]["day type"][j] == 1
                    else occ_sched[np.mod(j, 24)][3]
                    for j in range(indices[0][0], indices[0][-1] + 1)
                ]
                light_frac += [
                    occ_sched[np.mod(j, 24)][4]
                    if self.dct["General"]["day type"][j] == 1
                    else occ_sched[np.mod(j, 24)][5]
                    for j in range(indices[0][0], indices[0][-1] + 1)
                ]
                HVAC_frac += [
                    occ_sched[np.mod(j, 24)][6]
                    if self.dct["General"]["day type"][j] == 1
                    else occ_sched[np.mod(j, 24)][7]
                    for j in range(indices[0][0], indices[0][-1] + 1)
                ]
                infl_frac += [
                    occ_sched[np.mod(j, 24)][8]
                    if self.dct["General"]["day type"][j] == 1
                    else occ_sched[np.mod(j, 24)][9]
                    for j in range(indices[0][0], indices[0][-1] + 1)
                ]
                T_set_H += [
                    temp_sched[np.mod(j, 24)][0]
                    if self.dct["General"]["day type"][j] == 1
                    else temp_sched[np.mod(j, 24)][1]
                    for j in range(indices[0][0], indices[0][-1] + 1)
                ]
                T_set_C += [
                    temp_sched[np.mod(j, 24)][2]
                    if self.dct["General"]["day type"][j] == 1
                    else temp_sched[np.mod(j, 24)][3]
                    for j in range(indices[0][0], indices[0][-1] + 1)
                ]

            subDict[zone]["occupancy_frac"] = np.array(occupancy_frac)
            subDict[zone]["equipment_frac"] = np.array(equipment_frac)
            subDict[zone]["light_frac"] = np.array(light_frac)
            subDict[zone]["HVAC_frac"] = np.array(HVAC_frac)
            subDict[zone]["T_set_H"] = np.array(T_set_H)
            subDict[zone]["T_set_C"] = np.array(T_set_C)
            subDict[zone]["infiltration_frac"] = np.array(infl_frac) * infl_sched
            subDict[zone]["fraction"] = (
                np.sum(occ_sched, 0)[0] * 5 + np.sum(occ_sched, 0)[1] * 2
            ) / 168.0

            # zone internal floor and wall
            if self.input_dict["Zones"][zone]["Interior Wall Material"] == "-":
                subDict[zone]["U_iw"] = 4.0
            else:
                subDict[zone]["U_iw"] = Wall(
                    self.input_dict["Internal Wall Materials"][
                        self.input_dict["Zones"][zone]["Interior Wall Material"]
                    ]
                ).U_value
            if self.input_dict["Zones"][zone]["Interior Floor Material"] == "-":
                subDict[zone]["U_if"] = 4.0
            else:
                subDict[zone]["U_if"] = float(
                    self.input_dict["Internal Floor Materials"][
                        self.input_dict["Zones"][zone]["Interior Floor Material"]
                    ]
                )
            # print subDict[zone]['U_if'], subDict[zone]['U_iw']

            # zone HVAC
            subDict[zone]["HVAC template"] = info_dict["HVAC Template"]
            if info_dict["HVAC Template"] not in list(
                self.dct["General"]["HVAC_dct"].keys()
            ):
                self.dct["General"]["HVAC_dct"][info_dict["HVAC Template"]] = [zone]
            else:
                self.dct["General"]["HVAC_dct"][info_dict["HVAC Template"]].append(zone)
            subDict[zone]["HVAC"] = self.getHVAC(
                self.input_dict["HVAC"][subDict[zone]["HVAC template"]], subDict[zone]
            )

            # zone ventilation
            if info_dict["Air Infiltration Level"] != "-":
                subDict[zone]["Q4Pa"] = Infiltration_Leak_Level(
                    self.dct["General"]["building type"],
                    int(info_dict["Air Infiltration Level"]),
                ).rate  # int(info_dict['HVAC']['Air Infiltration Level']
            else:
                subDict[zone]["Q4Pa"] = float(info_dict["Air Infiltration Rate"])
            subDict[zone]["vent type"] = int(info_dict["Ventilation Type"])
            subDict[zone]["window open angle"] = float(info_dict["Angle of Opening"])
            subDict[zone]["night flush"] = int(info_dict["Night Flushing"])
            subDict[zone]["window area open percent"] = float(
                info_dict["Window Area Open Percentage"]
            )
            subDict[zone]["Ventilation"] = self.getVent(subDict[zone])

            # lighting
            subDict[zone]["lighting template"] = info_dict["Lighting Template"]
            subDict[zone]["Lightings"] = self.getLightings(
                self.input_dict["Lighting Setting"][subDict[zone]["lighting template"]]
            )
            subDict[zone]["lighting load"] = subDict[zone]["Lightings"]["lighting load"]

            # Fans
            subDict[zone]["Fans"] = self.getFans(subDict[zone])

            # adjacent zone
            subDict[zone]["adj wall zone"] = {}
            subDict[zone]["adj floor zone"] = {}
            subDict[zone]["adj ceiling zone"] = {}
            if info_dict["Adjacent Wall Zone Name and Contact Area"] != "-":
                for z in info_dict["Adjacent Wall Zone Name and Contact Area"].split(
                    ";"
                ):
                    zname = z.split(",")[0].lstrip(" ").rstrip(" ")
                    a = float(z.split(",")[1].lstrip(" ").rstrip(" ")) * m
                    subDict[zone]["adj wall zone"][zname] = a
            if info_dict["Adjacent Floor Zone Name and Contact Area"] != "-":
                for z in info_dict["Adjacent Floor Zone Name and Contact Area"].split(
                    ";"
                ):
                    zname = z.split(",")[0].lstrip(" ").rstrip(" ")
                    a = float(z.split(",")[1].lstrip(" ").rstrip(" "))
                    subDict[zone]["adj floor zone"][zname] = a
            else:
                print(
                    "Warning: the floor of Zone %s is neither adjacent to any zone nor the ground, please review your model!!!"
                    % zone
                )
            if info_dict["Adjacent Ceiling Zone Name and Contact Area"] != "-":
                for z in info_dict["Adjacent Ceiling Zone Name and Contact Area"].split(
                    ";"
                ):
                    zname = z.split(",")[0].lstrip(" ").rstrip(" ")
                    a = float(z.split(",")[1].lstrip(" ").rstrip(" "))
                    subDict[zone]["adj ceiling zone"][zname] = a

            # external radiation data 2025.1.14
            if "Solar_OP" in info_dict:
                subDict[zone]["Solar_OP"] = info_dict["Solar_OP"]
            if "Solar_W" in info_dict:
                subDict[zone]["Solar_W"] = info_dict["Solar_W"]
            # end

            self.dct["Zones"][zone] = SubSystem(subDict[zone])
            self.dct["Zones"][zone].HVAC = SubSystem(self.dct["Zones"][zone].HVAC)
            self.dct["Zones"][zone].Ventilation = SubSystem(
                self.dct["Zones"][zone].Ventilation
            )
            self.dct["Zones"][zone].Lightings = SubSystem(
                self.dct["Zones"][zone].Lightings
            )
            self.dct["Zones"][zone].Fans = SubSystem(self.dct["Zones"][zone].Fans)
            self.dct["Zones"][zone].Envelopes = SubSystem(
                self.dct["Zones"][zone].Envelopes
            )
            # print subDict[zone]
            # print self.dct['Zones'][zone].adj_floor_zone

    def getEnvelopes(self, dct, m):
        new_dict = {}
        for mat, prop in list(self.input_dict["Window Materials"].items()):
            window = Windows(prop)
            new_dict[mat] = {}
            for orient, para_dict in list(dct.items()):
                if orient != "G" and para_dict != "-":
                    counter = 0
                    for inputs in list(para_dict.keys()):
                        if mat in inputs:
                            counter += 1
                    if counter != 0:
                        shading = Shading(
                            para_dict[mat + " Shading Type"],
                            para_dict[mat + " Shading Where"],
                            para_dict[mat + " Shading Control"],
                        )
                        lst = [
                            para_dict[mat + " Area"],
                            para_dict[mat + " Overhang Angle"],
                            para_dict[mat + " Fin Angle"],
                            para_dict[mat + " Horizon Angle"],
                            shading.SRF,
                        ]
                        if orient == "R":
                            lst.append(1)
                        else:
                            lst.append(0.5)

                        lst += [
                            window.U_value,
                            0.2,
                            window.emissivity,
                            window.Tsol,
                            11,
                            window.SHGC,
                        ]
                        lst = np.array(lst)
                        lst = np.where(lst == "-", "0", lst).astype(float)
                        lst[0] *= m
                        lst[-4] *= 5.0
                        new_dict[mat][orient] = lst
                    else:
                        new_dict[mat][orient] = np.zeros(12)
                elif para_dict == "-":
                    new_dict[mat][orient] = np.zeros(12)

        for mat, prop in list(self.input_dict["External Wall Materials"].items()):
            wall = Wall(prop)
            new_dict[mat] = {}
            for orient, para_dict in list(dct.items()):
                if orient != "R" and para_dict != "-":
                    counter = 0
                    for inputs in list(para_dict.keys()):
                        if mat in inputs:
                            counter += 1
                    if counter != 0:
                        lst = [para_dict[mat + " Area"]]
                        lst += [0.5, wall.U_value, wall.abs, wall.emissivity]
                        lst = np.array(lst)
                        lst = np.where(lst == "-", "0", lst).astype(float)
                        lst[0] *= m
                        lst[-1] *= 5.0
                        new_dict[mat][orient] = lst
                    else:
                        new_dict[mat][orient] = np.zeros(5)
                elif para_dict == "-":
                    new_dict[mat][orient] = np.zeros(5)

        for mat, prop in list(self.input_dict["Roof Materials"].items()):
            wall = Wall(prop)
            new_dict[mat] = {}
            if dct["R"] != "-":
                counter = 0
                for inputs in list(dct["R"].keys()):
                    if mat in inputs:
                        counter += 1
                if counter != 0:
                    lst = np.array(
                        [
                            dct["R"][mat + " Area"],
                            1,
                            wall.U_value,
                            wall.abs,
                            wall.emissivity,
                        ]
                    )
                    lst = np.where(lst == "-", "0", lst).astype(float)
                    lst[-1] *= 5.0
                    new_dict[mat]["R"] = lst
                else:
                    new_dict[mat]["R"] = np.zeros(5)
            elif dct["R"] == "-":
                new_dict[mat]["R"] = np.zeros(5)

        for mat, prop in list(self.input_dict["External Floor Materials"].items()):
            new_dict[mat] = {}
            if dct["G"] != "-":
                counter = 0
                for inputs in list(dct["G"].keys()):
                    if mat in inputs:
                        counter += 1
                if counter != 0:
                    lst = np.array([dct["G"][mat + " Area"], prop])
                    lst = np.where(lst == "-", "0", lst).astype(float)
                    new_dict[mat]["G"] = lst
                else:
                    new_dict[mat]["G"] = np.zeros(2)
            elif dct["G"] == "-":
                new_dict[mat]["G"] = np.zeros(2)
        return new_dict

    def getHVAC(self, dct, zone_dict):
        subDict = {}
        subDict["hvac_name"] = zone_dict["HVAC template"]
        subDict["reheat_summer"] = int(dct["Reheat Used in Summer"])
        # subDict['reheat_winter'] = int(dct['Reheat Used in Winter'])
        if subDict["reheat_summer"] == 2:
            subDict["reheat_deltaT"] = 0
        else:
            subDict["reheat_deltaT"] = float(dct["Reheat Temperature Delta"])
        subDict["heating efficiency"] = float(dct["Heating Nominal Efficiency"])
        subDict["cooling COP"] = float(dct["Cooling Nominal COP"])
        subDict["PLV_x"] = np.array([0.0, 0.2, 0.4, 0.6, 0.8, 1.0])
        subDict["heating_PLV"] = np.array(
            [
                float(dct["Heating COP0"]),
                float(dct["Heating COP20"]),
                float(dct["Heating COP40"]),
                float(dct["Heating COP60"]),
                float(dct["Heating COP80"]),
                float(dct["Heating COP100"]),
            ]
        )
        subDict["cooling_PLV"] = np.array(
            [
                float(dct["Cooling COP0"]),
                float(dct["Cooling COP20"]),
                float(dct["Cooling COP40"]),
                float(dct["Cooling COP60"]),
                float(dct["Cooling COP80"]),
                float(dct["Cooling COP100"]),
            ]
        )
        HVAC = HVAC_Sys(int(dct["HVAC System Type"]))
        subDict["f_waste"] = HVAC.f_waste
        subDict["a_heat"] = HVAC.a_heat
        subDict["a_cool"] = HVAC.a_cool

        subDict["T_set_H"] = np.amax(zone_dict["T_set_H"])
        subDict["T_set_C"] = np.amin(zone_dict["T_set_C"])

        if dct["Heating Capacity"] == "-":
            subDict["heat_cap"] = float("inf")
        else:
            try:
                subDict["heat_cap"] = float(dct["Heating Capacity"])
            except ValueError:
                print("Please input valid value for heating capacity!")

        if dct["Cooling Capacity"] == "-":
            subDict["cool_cap"] = float("inf")
        else:
            try:
                subDict["cool_cap"] = float(dct["Cooling Capacity"])
            except ValueError:
                print("Please input valid value for cooling capacity!")

        if dct["Design Heating Supply Air Temperature"] == "-":
            subDict["T_supply_H"] = subDict["T_set_H"] + 7.0
        else:
            try:
                subDict["T_supply_H"] = float(
                    dct["Design Heating Supply Air Temperature"]
                )
            except ValueError:
                print("Please input valid value for heating supply air temperature!")

        if dct["Design Cooling Supply Air Temperature"] == "-":
            subDict["T_supply_C"] = subDict["T_set_C"] - 7.0
        else:
            try:
                subDict["T_supply_C"] = float(
                    dct["Design Cooling Supply Air Temperature"]
                )
            except ValueError:
                print("Please input valid value for heating supply air temperature!")

        HR = Heat_Recovery_Sys(int(dct["Heat Recovery Type"]))
        subDict["HR_eff"] = HR.HR_eff
        recirculation = Exhaust_Air_Recirculation(
            int(dct["Exhaust Air Recirculation Type"])
        )
        subDict["fcntrl"] = recirculation.factor
        subDict["fan_power"] = float(dct["Specific Fan Power"])
        subDict["fan_flow_control_factor"] = float(dct["Fan Flow Control Factor"])
        try:
            subDict["T_Swater_H"] = float(
                dct["Design Heating Hot Water Supply Temperature"]
            )
        except ValueError:
            subDict["T_Swater_H"] = 0
        try:
            subDict["T_Swater_C"] = float(
                dct["Design Cooling Chilled Water Supply Temperature"]
            )
        except ValueError:
            subDict["T_Swater_C"] = 0
        try:
            subDict["T_Rwater_H"] = float(
                dct["Design Heating Hot Water Return Temperature"]
            )
        except ValueError:
            subDict["T_Rwater_H"] = 0
        try:
            subDict["T_Rwater_C"] = float(
                dct["Design Cooling Chilled Water Return Temperature"]
            )
        except ValueError:
            subDict["T_Rwater_C"] = 0
        return subDict

    def getVent(self, zone_dict):
        subDict = {}
        subDict["height"] = zone_dict["height"]
        subDict["volume"] = zone_dict["Af"] * zone_dict["height"]
        subDict["vent type"] = int(zone_dict["vent type"])
        # occupancy_sched = zone_dict['occupancy schedule'][:, :2]

        # --------Mechanical Ventilation
        if subDict["vent type"] == 3:
            subDict["MV_sched"] = np.zeros(zone_dict["occupancy_frac"].shape)
        else:
            # subDict['MV_sched'] = np.where(occupancy_sched>0, occupancy_sched, 0.2)
            subDict["MV_sched"] = np.where(zone_dict["occupancy_frac"] > 0, 1, 0.001)
        subDict["qv_min"] = 30 * zone_dict["occupants"] / zone_dict["Af"]

        if self.input_dict["Basics"]["Building Type"] == "1":
            subDict["min_ACH"] = 0.3
        elif (
            self.input_dict["Basics"]["Building Type"] == "2"
            or self.input_dict["Basics"]["Building Type"] == "3"
        ):
            subDict["min_ACH"] = subDict["qv_min"] / subDict["volume"] * zone_dict["Af"]
        else:
            raise ValueError(
                "Please have the right input for the specification of building type."
            )

        subDict["supply"] = zone_dict["STOA"] * 3.6 / zone_dict["Af"]
        subDict["exhaust"] = zone_dict["STOA"] * 3.6 / zone_dict["Af"]

        subDict["fraction"] = zone_dict["fraction"]
        subDict["HR_eff"] = zone_dict["HVAC"]["HR_eff"]
        subDict["fcntrl"] = zone_dict["HVAC"]["fcntrl"]

        # ---------Infiltration
        subDict["vsite"] = Terrain_Class(
            int(self.input_dict["Basics"]["Terrain Class"])
        ).vsite
        # subDict['leak_ACH'] = zone_dict['Q4Pa']/subDict['volume']*zone_dict['Af']
        subDict["flow_rate"] = zone_dict["Q4Pa"] / zone_dict["Af"] * subDict["volume"]
        subDict["dCP"] = 0.75

        # ---------Natural Ventilation
        NV = Natural_Ventilation(
            subDict["vent type"],
            zone_dict["window open angle"],
            zone_dict["night flush"],
            zone_dict["occupancy_frac"],
        )
        total_window_area = sum(
            [
                np.sum(np.array(list(dct.values())), axis=0)[0]
                for key, dct in list(zone_dict["Envelopes"].items())
                if len(np.transpose(np.array(list(dct.values())))) == 12
            ]
        )
        subDict["Aw"] = total_window_area * zone_dict["window area open percent"] / 100
        subDict["ca"] = NV.ca
        subDict["Ck"] = NV.Ck
        subDict["Aow"] = NV.Ck * subDict["Aw"]
        subDict["total_window_area"] = total_window_area
        subDict["NV_sched"] = NV.NV_sched
        subDict["NV_type"] = NV.cls_type
        return subDict

    def getLightings(self, dct):
        subDict = {}
        subDict["lighting load"] = float(dct["Lighting Load"])
        if dct["Parasitic Lighting Energy"] == "-":
            subDict["W_pc"] = 6
        else:
            subDict["W_pc"] = float(dct["Parasitic Lighting Energy"])
        subDict["P_pc"] = subDict["W_pc"] * 1000.0 / 8760
        subDict["F_D"] = float(dct["Daylighting Factor"])
        subDict["F_O"] = float(dct["Lighting Occupancy Factor"])
        subDict["F_c"] = float(dct["Lighting Illumination Control Factor"])
        subDict["lighting load"] *= subDict["F_D"] * subDict["F_O"] * subDict["F_c"]
        return subDict

    def getFans(self, zone_dict):
        subDict = {}
        subDict["T_supply_H"] = zone_dict["HVAC"]["T_supply_H"]
        subDict["T_supply_C"] = zone_dict["HVAC"]["T_supply_C"]
        subDict["rho"] = Fan().rho
        subDict["fraction"] = zone_dict["fraction"]
        subDict["supply_air_flow"] = zone_dict["STOA"]
        subDict["exhaust_air_flow"] = zone_dict["STOA"]

        subDict["fan_power"] = float(zone_dict["HVAC"]["fan_power"])
        subDict["fan_flow_control_factor"] = float(
            zone_dict["HVAC"]["fan_flow_control_factor"]
        )
        self.BEM = BEM_Sys(int(self.input_dict["BEM"]["BEM Type"]))
        self.dct["BEM"] = {}
        self.dct["BEM"]["f_BAC_e"] = self.BEM.f_BAC_e
        self.dct["BEM"]["f_BAC_hc"] = self.BEM.f_BAC_hc
        return subDict

    def getPumps(self):
        subDict = {}
        try:
            subDict["pump_power_H"] = float(
                self.input_dict["Pumps"]["Heating Use Pump Power Per Water Flow Rate"]
            )
        except ValueError:
            subDict["pump_power_H"] = 0
        try:
            subDict["pump_power_C"] = float(
                self.input_dict["Pumps"]["Cooling Use Pump Power Per Water Flow Rate"]
            )
        except ValueError:
            subDict["pump_power_C"] = 0
        try:
            subDict["pump_power_D"] = float(
                self.input_dict["Pumps"]["DHW Use Pump Power Per Water Flow Rate"]
            )
        except ValueError:
            subDict["pump_power_D"] = 0
        subDict["DHW_flow"] = float(self.input_dict["Pumps"]["DHW Use Peak Flow Rate"])

        pump = Pump_Sys(int(self.input_dict["Pumps"]["Pump Control Type"]))
        subDict["fcntrl"] = pump.factor
        subDict["rho"] = pump.rho
        self.dct["Pumps"] = subDict

    # zone independent systems
    def getDHW(self):
        subDict = {}
        DHW = DHW_Sys(
            int(self.input_dict["DHW"]["DHW Distribution System"]),
            int(self.input_dict["DHW"]["DHW Generation System"]),
        )
        subDict["dstr_eff"] = DHW.distr_eff
        subDict["gen_eff"] = DHW.sys_eff
        subDict["SWH Area"] = float(self.input_dict["SWH"]["SWH Area"])
        subDict["SWH Orientation"] = self.input_dict["SWH"]["SWH Orientation"]
        subDict["SWH Angle"] = float(self.input_dict["SWH"]["SWH Angle"])
        self.dct["DHW"] = subDict

    def getPV(self):
        subDict = {}
        subDict["PV Area"] = float(self.input_dict["PV"]["PV Surface Area"])
        PV = PV_Sys(
            int(self.input_dict["PV"]["PV Type"]),
            int(self.input_dict["PV"]["PV Ventilation Type"]),
        )
        subDict["Kpk"] = PV.Kpk
        subDict["fperf"] = PV.fperf
        subDict["Ppk"] = subDict["Kpk"] * subDict["PV Area"]
        subDict["Orientation"] = self.input_dict["PV"]["PV Orientation"]
        subDict["PV Angle"] = self.input_dict["PV"]["PV Angle"]
        self.dct["PV"] = subDict

    def getWindSys(self):
        subDict = {}
        subDict["Multiplier"] = int(
            self.input_dict["Wind Turbines"]["Wind Turbine Number"]
        )
        subDict["Diameter"] = float(
            self.input_dict["Wind Turbines"]["Wind Turbine Diameter"]
        )
        subDict["Swept Area"] = 0.25 * subDict["Diameter"] ** 2 * np.pi
        subDict["Efficiency"] = float(
            self.input_dict["Wind Turbines"]["Wind Turbine Efficiency"]
        )
        subDict["R_air"] = 287
        self.dct["Wind_Turbines"] = subDict

    def getDict(self):
        return self.dct

    def printDict(self):
        for key, value in list(self.dct.items()):
            print((key, value, "\n"))


class SubSystem:
    def __init__(self, dictionary):
        for k, v in list(dictionary.items()):
            setattr(self, k.replace(" ", "_"), v)


# def main():
#     R = Read_Inputs(parent_folder+'Inputs\\'+'ASHRAE90.1_OfficeMedium_STD2004_Philadelphia.cen')
#     input_dict = R.getInputDict()
#     W = weather.Weather(parent_folder+"Weather_Files\\"+input_dict['Basics']['Weather File'])
#     wea_dict = W.getWeaDict()
#     SCal_dict = W.getCalDict()
#     pre = Pre_Calculation(wea_dict, SCal_dict, input_dict)


# if __name__ == '__main__':
#     main()
