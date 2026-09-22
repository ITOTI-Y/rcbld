import collections
import csv
import os

import lib
import numpy as np

# from dateutil import parser, rrule
# import cPickle as pickle
import pandas as pd

# Constants
parent_folder = os.path.abspath(os.path.join(os.getcwd(), os.pardir)) + "\\"
sigma = 90  # tilt angle, deg: eg. Vertical wall: 90,
area = 1  # area of the surface, m2
esc = 1367  # Eb constant evaluated at the quinox, W/m2
r_g = 0.14  # ground reflectivity - assign the overcast sky


class Weather:
    def __init__(self, wea_file, **kwargs):
        """three calculated dictionaries will be included in this class: wea_dict,
        cal_dict, SRF_dict"""
        self.wea_file = wea_file  # full path of weather file
        self.cal_dict = {}  # dictionary of calculation results
        if kwargs is not None:
            for k, v in list(kwargs.items()):
                setattr(self, k.replace(" ", "_"), v)
        self.getWeather()

        # self.dumpResults()

    def getWeather(self):
        # return a lists of list of weather variables
        wea_dict = {}
        with open(self.wea_file) as fweather:
            csv_weather = csv.reader(fweather)
            csv_weather = list(csv_weather)
            loc_info = csv_weather[0]

        if loc_info[-1] == "":
            self.latitude = float(loc_info[0])
            self.longitude = float(loc_info[1])
            self.time_zone = float(loc_info[2])
            self.LSM = 15 * self.time_zone  # 15*TZ: East +, West -
            weather_data = pd.read_csv(self.wea_file, skiprows=1)
            wea_dict["DBT"] = weather_data["Temperature"].values
            wea_dict["RH"] = weather_data["Relative Humidity"].values
            wea_dict["Eb"] = weather_data["DNI"].values
            wea_dict["wind"] = weather_data["Wind Speed"].values
            wea_dict["Egh"] = weather_data["GHI"].values
            wea_dict["month"] = weather_data["Month"].values
            wea_dict["day"] = weather_data["Day"].values
            wea_dict["hour"] = weather_data["Hour"].values
            wea_dict["Ed"] = weather_data["DHI"].values
            wea_dict["pressure"] = weather_data["Pressure"].values
            wea_dict["HIR"] = weather_data["HIR"].values
            wea_dict["year"] = weather_data["Year"].values
        else:
            self.location = loc_info[1]
            self.latitude = float(loc_info[-4])
            self.longitude = float(loc_info[-3])
            self.time_zone = float(loc_info[-2])
            self.LSM = 15 * self.time_zone  # 15*TZ: East +, West -
            epw_data = pd.read_csv(self.wea_file, skiprows=8, header=None)
            wea_dict["DBT"] = epw_data.iloc[:, 6].values
            wea_dict["RH"] = epw_data.iloc[:, 8].values
            wea_dict["Eb"] = epw_data.iloc[:, 14].values
            wea_dict["wind"] = epw_data.iloc[:, 21].values
            wea_dict["Egh"] = epw_data.iloc[:, 13].values
            wea_dict["month"] = epw_data.iloc[:, 1].values
            wea_dict["day"] = epw_data.iloc[:, 2].values
            wea_dict["hour"] = epw_data.iloc[:, 3].values
            wea_dict["Ed"] = epw_data.iloc[:, 15].values
            wea_dict["pressure"] = epw_data.iloc[:, 9].values
            wea_dict["HIR"] = epw_data.iloc[:, 12].values
            wea_dict["year"] = epw_data.iloc[:, 0].values
        wea_dict["T_er"] = (wea_dict["HIR"] / (5.6697 * 10**-8)) ** 0.25 - 273.15
        self.wea_dict = wea_dict

    def cal_Ydate(self):
        """calculate date number of year"""
        Ydate = [1]
        month = self.wea_dict["month"]
        day = self.wea_dict["day"]
        for i in range(1, len(day)):
            if month[i] == month[i - 1]:
                Ydate.append(Ydate[i - 1] + day[i] - day[i - 1])
            else:
                Ydate.append(Ydate[i - 1] + 1)
        self.cal_dict["Ydate"] = np.array(Ydate)

    # -----------------------------------Direct, diffuse, and ground reflection radiation calculation
    def cal_tao(self):
        """calculate in minutes"""
        Ydate = self.cal_dict["Ydate"]
        self.cal_dict["tao"] = 2 * np.pi * (Ydate - 1) / 365
        # print len(self.cal_dict['tao'])

    def cal_ET(self):
        """calculate equation of time"""
        tao = self.cal_dict["tao"]
        self.cal_dict["ET"] = 2.2918 * (
            0.0075
            + 0.1868 * np.cos(tao)
            - 3.2077 * np.sin(tao)
            - 1.4615 * np.cos(2 * tao)
            - 4.089 * np.sin(2 * tao)
        )

    def cal_AST(self):
        """calculate apparent solar time"""
        ET = self.cal_dict["ET"]
        self.cal_dict["AST"] = (
            self.wea_dict["hour"] + ET / 60 + (self.longitude - self.LSM) / 15
        )

    def cal_solarDegree(self):
        """calculate solar deciliation degree and hour angle: angular displacement of the
        sun east or west of the local meridian due to the rotation of the earth,deg"""
        self.cal_dict["delta"] = 23.45 * np.sin(
            (self.cal_dict["Ydate"] + 284.0) / 365 * 2 * np.pi
        )
        self.cal_dict["theta_h"] = 15.0 * (self.cal_dict["AST"] - 12.0)

    def cal_azimuth(self):
        """calculate sin value of solar altitude, sin_beta; solar altitude in radians, beta_rad;
        solar altitude in degrees, beta_deg; sin value of solar azimuth angle, sin_fai;
        cos value of solar azimuth angle, cos_fai; fai1_deg; fai2_deg;
        solar azimuth angle in degree, fai_deg"""
        delta = self.cal_dict["delta"]
        theta_h = self.cal_dict["theta_h"]
        sin_beta = np.cos(self.latitude * np.pi / 180) * np.cos(
            delta * np.pi / 180
        ) * np.cos(theta_h * np.pi / 180) + np.sin(
            self.latitude * np.pi / 180
        ) * np.sin(delta * np.pi / 180)
        self.cal_dict["sin_beta"] = sin_beta
        beta_rad = np.arcsin(sin_beta)
        self.cal_dict["beta_rad"] = beta_rad
        beta_deg = np.rad2deg(beta_rad)
        self.cal_dict["beta_deg"] = beta_deg
        sin_fai = (
            np.sin(theta_h * np.pi / 180)
            * np.cos(delta * np.pi / 180)
            / np.cos(beta_rad)
        )
        self.cal_dict["sin_fai"] = sin_fai
        cos_fai = (
            np.cos(theta_h * np.pi / 180)
            * np.cos(delta * np.pi / 180)
            * np.sin(self.latitude * np.pi / 180)
            - np.sin(delta * np.pi / 180) * np.cos(self.latitude * np.pi / 180)
        ) / np.cos(beta_rad)
        self.cal_dict["cos_fai"] = cos_fai
        fai1_deg = np.arcsin(sin_fai) * 180 / np.pi
        self.cal_dict["fai1_deg"] = fai1_deg
        fai2_deg = np.arccos(cos_fai) * 180 / np.pi
        self.cal_dict["fai2_deg"] = fai2_deg
        fai_deg = np.where(
            sin_fai > 0, fai2_deg, np.where(cos_fai > 0, fai1_deg, -180 - fai1_deg)
        )
        self.cal_dict["fai_deg"] = fai_deg

    def cal_surface(self):
        """calculate surface solar azimuth, gamma; cos value of surface angle of incidence, cos_theta;
        surface angle of incidence, theta; direct irradiation beam component, Et_b;
        diffuse irradiation beam component, Et_d; ground reflected component, Et_r"""
        self.cal_dict["surf"] = {}
        beta_rad = self.cal_dict["beta_rad"]
        sin_fai = self.cal_dict["sin_fai"]
        cos_fai = self.cal_dict["cos_fai"]
        fai1_deg = self.cal_dict["fai1_deg"]
        fai2_deg = self.cal_dict["fai2_deg"]
        fai_deg = self.cal_dict["fai_deg"]
        theta_h = self.cal_dict["theta_h"]

        self.cal_dict["Et_r"] = (
            (self.wea_dict["Eb"] * np.sin(beta_rad) + self.wea_dict["Ed"])
            * r_g
            * (1 - np.cos(sigma * np.pi / 180))
            / 2
        )
        surface = lib.Surface()
        for attr, value in surface.iterAttributes():
            self.cal_dict["surf"][attr] = {}
            self.cal_dict["surf"][attr]["gamma"] = np.absolute(fai_deg - value)
            self.cal_dict["surf"][attr]["cos_theta"] = np.cos(beta_rad) * np.cos(
                self.cal_dict["surf"][attr]["gamma"] * np.pi / 180
            ) * np.sin(sigma * np.pi / 180) + np.sin(beta_rad) * np.cos(
                sigma * np.pi / 180
            )
            self.cal_dict["surf"][attr]["theta"] = (
                np.arccos(self.cal_dict["surf"][attr]["cos_theta"]) * 180 / np.pi
            )
            gamma = self.cal_dict["surf"][attr]["gamma"]
            cos_theta = self.cal_dict["surf"][attr]["cos_theta"]
            self.cal_dict["surf"][attr]["Et_b"] = np.where(
                (gamma > 90) & (gamma < 270),
                0,
                np.where(cos_theta < 0, 0, self.wea_dict["Eb"] * cos_theta),
            )
            self.cal_dict["surf"][attr]["Y"] = (
                0.55 + 0.437 * cos_theta + 0.313 * (cos_theta**2)
            )
            self.cal_dict["surf"][attr]["Y"] = np.where(
                self.cal_dict["surf"][attr]["Y"] < 0.45,
                0.45,
                self.cal_dict["surf"][attr]["Y"],
            )
            Y = self.cal_dict["surf"][attr]["Y"]
            self.cal_dict["surf"][attr]["Et_d"] = np.where(
                sigma <= 90,
                self.wea_dict["Ed"]
                * (Y * np.sin(sigma * np.pi / 180) + np.cos(sigma * np.pi / 180)),
                self.wea_dict["Ed"] * (Y * np.sin(sigma * np.pi / 180)),
            )
            self.cal_dict["surf"][attr]["GSR"] = (
                self.cal_dict["surf"][attr]["Et_b"]
                + self.cal_dict["surf"][attr]["Et_d"]
                + self.cal_dict["Et_r"]
            )
            # print attr, self.cal_dict['surf'][attr]['GSR'][:50]
        self.cal_dict["surf"]["R"] = {}
        self.cal_dict["surf"]["R"]["GSR"] = self.wea_dict["Egh"]

    # ----------------------------------------------------------------------specific humidity calculation
    def cal_mmv(self):
        """calculate specific humidity in g/kg, mmv"""
        water = [6.11e00, 4.44e-01, 1.43e-02, 2.65e-04, 3.03e-06, 2.03e-08, 6.14e-11]
        ice = [6.11e00, 5.03e-01, 1.89e-02, 4.18e-04, 5.82e-06, 4.84e-08, 1.84e-10]

        def recurse(lst, n):
            if n == 6:
                return 0
            else:
                return lst[n] + self.wea_dict["DBT"] * recurse(lst, n + 1)

        water_sat = recurse(water, 0)
        ice_sat = recurse(ice, 0)
        vapor_sat = np.minimum(water_sat, ice_sat)
        p_H2O = vapor_sat * self.wea_dict["RH"] * 0.01  # partial pressure of water
        X_H2O = p_H2O / (self.wea_dict["pressure"] / 100)
        humidity = (X_H2O * 18.02) / (X_H2O * 18.02 + (1 - X_H2O) * 28.96)
        mmv = 1000 * humidity / (1 - humidity)
        self.cal_dict["mmv"] = mmv

    # ----------------------------------------------------------------------solar reduction factor calculation

    def cal_SRF(self):
        self.cal_dict["overhang"] = {}
        self.cal_dict["fin"] = {}
        self.cal_dict["horizon"] = {}
        surface = lib.Surface()
        beta_deg = self.cal_dict["beta_deg"]
        fai_deg = self.cal_dict["fai_deg"]
        Et_r = self.cal_dict["Et_r"]

        for i in range(15, 61, 15):
            self.cal_dict["overhang"][i] = {}
            self.cal_dict["fin"][i] = {}
            for orient, psi in surface.iterAttributes():
                GSR = self.cal_dict["surf"][orient]["GSR"]
                Et_b = self.cal_dict["surf"][orient]["Et_b"]
                Et_d = self.cal_dict["surf"][orient]["Et_d"]

                self.cal_dict["overhang"][i][orient] = np.where(
                    GSR == 0,
                    0,
                    (
                        np.maximum(
                            0,
                            1
                            - (
                                0.5
                                * np.tan(np.deg2rad(i))
                                / np.tan(np.deg2rad(90.0 - np.maximum(beta_deg, 0)))
                            ),
                        )
                        * Et_b
                        + (1 - i / 90.0) * Et_d
                        + Et_r
                    )
                    / GSR,
                )
                if orient == "S" or orient == "SE" or orient == "E" or orient == "NE":
                    self.cal_dict["fin"][i][orient] = np.where(
                        GSR == 0,
                        0,
                        np.where(
                            (fai_deg - psi > 90) | (fai_deg - psi < 0),
                            1,
                            (
                                (
                                    np.maximum(
                                        0,
                                        1
                                        - 0.5
                                        * np.tan(np.deg2rad(i))
                                        / np.tan(
                                            np.deg2rad(
                                                90.0 - np.absolute(fai_deg - psi)
                                            )
                                        ),
                                    )
                                )
                                * Et_b
                                + Et_d
                                + Et_r
                            )
                            / GSR,
                        ),
                    )
                else:
                    self.cal_dict["fin"][i][orient] = np.where(
                        GSR == 0,
                        0,
                        np.where(
                            (fai_deg - psi < -90) | (fai_deg - psi > 0),
                            1,
                            (
                                (
                                    np.maximum(
                                        0,
                                        1
                                        - 0.5
                                        * np.tan(np.deg2rad(i))
                                        / np.tan(
                                            np.deg2rad(
                                                90.0 - np.absolute(fai_deg - psi)
                                            )
                                        ),
                                    )
                                )
                                * Et_b
                                + Et_d
                                + Et_r
                            )
                            / GSR,
                        ),
                    )

        for i in range(10, 81, 10):
            self.cal_dict["horizon"][i] = {}
            for orient, psi in surface.iterAttributes():
                GSR = self.cal_dict["surf"][orient]["GSR"]
                Et_b = self.cal_dict["surf"][orient]["Et_b"]
                Et_d = self.cal_dict["surf"][orient]["Et_d"]
                self.cal_dict["horizon"][i][orient] = np.where(
                    GSR == 0,
                    0,
                    np.where(np.maximum(beta_deg, 0) < i, 1 - Et_b / GSR, 1),
                )

    ##        for key in self.cal_dict['overhang']['30'].iterkeys():
    ##            print key, self.cal_dict['overhang']['30'][key][:50]

    # ----------------------------------------------------------------------solar irradiation on a tilted surface
    def cal_Esol(self):
        self.cal_dict["Esol"] = {}
        beta_rad = self.cal_dict["beta_rad"]
        Egh = self.wea_dict["Egh"]
        fai_deg = self.cal_dict["fai_deg"]
        surface = lib.Surface()
        for tilt in range(15, 91, 15):
            self.cal_dict["Esol"][tilt] = {}
            for orient, psi in surface.iterAttributes():
                incident = Egh / np.sin(beta_rad)
                self.cal_dict["Esol"][tilt][orient] = incident * (
                    np.cos(beta_rad)
                    * np.sin(np.deg2rad(tilt))
                    * np.cos(np.deg2rad(fai_deg - psi))
                    + np.sin(beta_rad) * np.cos(np.deg2rad(tilt))
                )
                self.cal_dict["Esol"][tilt][orient] = np.where(
                    (self.cal_dict["Esol"][tilt][orient] < 0)
                    | (self.cal_dict["Esol"][tilt][orient] >= 1500),
                    0,
                    self.cal_dict["Esol"][tilt][orient],
                )
        # print Egh[5100:5124], np.rad2deg(beta_rad)[5100:5124], min(np.absolute(np.rad2deg(beta_rad)))
        # print self.cal_dict['Esol'][90]['S'][5000:5012], max(self.cal_dict['Esol'][90]['S'])

    ##        for key in self.cal_dict['Eol'][30].iterkeys():
    ##            print key, self.cal_dict['Esol'][30][key][3950:4000]

    # -------------------------------------------------------------------------dump results into file
    def dumpResults(self):
        """update the wea_dict and cal_dict, and dump the needed weather and calculated results
        to wea_calculation.csv under Outputs folder"""

        output_dict = collections.OrderedDict()
        output_dict["month"] = self.wea_dict["month"]
        output_dict["day"] = self.wea_dict["day"]
        output_dict["hour"] = self.wea_dict["hour"]
        output_dict["dry bulb temperature"] = self.wea_dict["DBT"]
        output_dict["wind speed"] = self.wea_dict["wind"]
        for surf in list(self.cal_dict["surf"].keys()):
            output_dict[surf + " orientation global solar radiation"] = self.cal_dict[
                "surf"
            ][surf]["GSR"]
        output_dict["solar altitude degrees"] = self.cal_dict["beta_deg"]
        output_dict["specific humidity"] = self.cal_dict["mmv"]
        output_dict["atmospheric pressure"] = self.wea_dict["pressure"]
        output_dict["relative humidity"] = self.wea_dict["RH"]

        wea_df = pd.DataFrame.from_dict(output_dict)
        wea_df.to_csv(parent_folder + "Outputs\\weather_calculation.csv")

    def getWeaDict(self):
        return self.wea_dict

    def getCalDict(self):
        self.cal_Ydate()
        self.cal_tao()
        self.cal_ET()
        self.cal_AST()
        self.cal_solarDegree()
        self.cal_azimuth()
        self.cal_surface()
        self.cal_mmv()
        self.cal_SRF()
        self.cal_Esol()
        return self.cal_dict


# def main():
#     W = Weather(parent_folder+"Weather\\TMY\\Philadelphia_PA\\weather_2012.csv", weather = 'self')
#     W.dumpResults()


# if __name__ == '__main__':
#     main()
