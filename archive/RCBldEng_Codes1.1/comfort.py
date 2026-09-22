"""
Optimized version of the CBE Comfort tool comfort models.
"""

import numpy as np
# from numba import njit

#@njit
def findSaturatedVaporPressureTorr(T):
    return np.exp(18.6686 - 4030.183 / (T + 235.0))

#@njit
def comfPMVElevatedAirspeed(ta, tr, vel, rh, met, clo, wme):
    set = comfPierceSET(ta, tr, vel, rh, met, clo, wme)
    stillAirThreshold = 0.1

    def utilSecant(a, b, epsilon):
        def fn(t):
            return set - comfPierceSET(ta - t, tr - t, stillAirThreshold, rh, met, clo, wme)
        
        f1 = fn(a)
        return np.where(np.abs(f1) <= epsilon, a,
                        np.where(np.abs(fn(b)) <= epsilon, b,
                                 b - fn(b) / ((fn(b) - f1) / (b - a))))

    if np.all(vel <= stillAirThreshold):
        pmv, ppd = comfPMV(ta, tr, vel, rh, met, clo, wme)
        ta_adj = ta
        ce = np.zeros_like(ta)
    else:
        ce = utilSecant(np.zeros_like(ta), np.full_like(ta, 40), 0.001)
        pmv, ppd = comfPMV(ta - ce, tr - ce, stillAirThreshold, rh, met, clo, wme)
        ta_adj = ta - ce

    return pmv

#@njit
def comfPMV(ta, tr, vel, rh, met, clo, wme):
    pa = rh * 10 * np.exp(16.6536 - 4030.183 / (ta + 235))

    icl = 0.155 * clo
    m = met * 58.15
    w = wme * 58.15
    mw = m - w
    fcl = np.where(icl <= 0.078, 1 + (1.29 * icl), 1.05 + (0.645 * icl))

    hcf = 12.1 * np.sqrt(vel)
    taa = ta + 273
    tra = tr + 273
    tcla = taa + (35.5 - ta) / (3.5 * icl + 0.1)

    p1 = icl * fcl
    p2 = p1 * 3.96
    p3 = p1 * 100
    p4 = p1 * taa
    p5 = (308.7 - 0.028 * mw) + (p2 * np.power(tra / 100, 4))
    xn = tcla / 100
    xf = tcla / 50

    n = 0
    eps = 0.00015
    while np.any(np.abs(xn - xf) > eps) and n < 150:
        xf = (xf + xn) / 2
        hcn = 2.38 * np.power(np.abs(100.0 * xf - taa), 0.25)
        hc = np.where(hcf > hcn, hcf, hcn)
        xn = (p5 + p4 * hc - p2 * np.power(xf, 4)) / (100 + p3 * hc)
        n += 1

    tcl = 100 * xn - 273

    hl1 = 3.05 * 0.001 * (5733 - (6.99 * mw) - pa)
    hl2 = np.where(mw > 58.15, 0.42 * (mw - 58.15), 0)
    hl3 = 1.7 * 0.00001 * m * (5867 - pa)
    hl4 = 0.0014 * m * (34 - ta)
    hl5 = 3.96 * fcl * (np.power(xn, 4) - np.power(tra / 100, 4))
    hl6 = fcl * hc * (tcl - ta)

    ts = 0.303 * np.exp(-0.036 * m) + 0.028
    pmv = ts * (mw - hl1 - hl2 - hl3 - hl4 - hl5 - hl6)
    ppd = 100.0 - 95.0 * np.exp(-0.03353 * np.power(pmv, 4.0) - 0.2179 * np.power(pmv, 2.0))

    return pmv, ppd

#@njit
def comfPierceSET(ta, tr, vel, rh, met, clo, wme):
    VaporPressure = (rh * findSaturatedVaporPressureTorr(ta)) / 100
    AirVelocity = np.maximum(vel, 0.1)
    KCLO = 0.25
    BODYWEIGHT = 69.9
    BODYSURFACEAREA = 1.8258
    METFACTOR = 58.2
    SBC = 0.000000056697
    CSW = 170
    CDIL = 120
    CSTR = 0.5

    TempSkinNeutral = 33.7
    TempCoreNeutral = 36.49
    TempBodyNeutral = 36.49
    SkinBloodFlowNeutral = 6.3

    TempSkin = TempSkinNeutral
    TempCore = TempCoreNeutral
    SkinBloodFlow = SkinBloodFlowNeutral
    MSHIV = 0.0
    ALFA = 0.1
    ESK = 0.1 * met

    p = 101325.0 / 1000
    PressureInAtmospheres = p * 0.009869
    LTIME = 60
    TIMEH = LTIME / 60.0
    RCL = 0.155 * clo
    FACL = 1.0 + 0.15 * clo
    LR = 2.2 / PressureInAtmospheres
    RM = met * METFACTOR
    M = met * METFACTOR

    WCRIT = np.where(clo <= 0, 0.38 * np.power(AirVelocity, -0.29), 0.59 * np.power(AirVelocity, -0.08))
    ICL = np.where(clo <= 0, 1.0, 0.45)

    CHC = np.maximum(3.0 * np.power(PressureInAtmospheres, 0.53), 8.600001 * np.power((AirVelocity * PressureInAtmospheres), 0.53))
    CHR = 4.7
    CTC = CHR + CHC
    RA = 1.0 / (FACL * CTC)
    TOP = (CHR * tr + CHC * ta) / CTC
    TCL = TOP + (TempSkin - TOP) / (CTC * (RA + RCL))

    # Main calculation loop
    for _ in range(LTIME):
        DRY = (TempSkin - TOP) / (RA + RCL)
        HFCS = (TempCore - TempSkin) * (5.28 + 1.163 * SkinBloodFlow)
        ERES = 0.0023 * M * (44.0 - VaporPressure)
        CRES = 0.0014 * M * (34.0 - ta)
        SCR = M - HFCS - ERES - CRES - wme
        SSK = HFCS - DRY - ESK
        TCSK = 0.97 * ALFA * BODYWEIGHT
        TCCR = 0.97 * (1 - ALFA) * BODYWEIGHT
        DTSK = (SSK * BODYSURFACEAREA) / (TCSK * 60.0)
        DTCR = SCR * BODYSURFACEAREA / (TCCR * 60.0)
        TempSkin = TempSkin + DTSK
        TempCore = TempCore + DTCR
        TB = ALFA * TempSkin + (1 - ALFA) * TempCore
        SKSIG = TempSkin - TempSkinNeutral
        WARMS = np.maximum(0, SKSIG)
        COLDS = np.maximum(0, -SKSIG)
        CRSIG = (TempCore - TempCoreNeutral)
        WARMC = np.maximum(0, CRSIG)
        COLDC = np.maximum(0, -CRSIG)
        BDSIG = TB - TempBodyNeutral
        WARMB = np.maximum(0, BDSIG)
        COLDB = np.maximum(0, -BDSIG)
        SkinBloodFlow = np.clip((SkinBloodFlowNeutral + CDIL * WARMC) / (1 + CSTR * COLDS), 0.5, 90.0)
        REGSW = np.clip(CSW * WARMB * np.exp(WARMS / 10.7), None, 500.0)
        ERSW = 0.68 * REGSW
        REA = 1.0 / (LR * FACL * CHC)
        RECL = RCL / (LR * ICL)
        EMAX = ((findSaturatedVaporPressureTorr(TempSkin) - VaporPressure) / (REA + RECL))
        PRSW = ERSW / EMAX
        PWET = np.clip(0.06 + 0.94 * PRSW, None, WCRIT)
        EDIF = PWET * EMAX - ERSW
        ESK = np.clip(ERSW + EDIF, None, EMAX)
        MSHIV = 19.4 * COLDS * COLDC
        M = RM + MSHIV
        ALFA = 0.0417737 + 0.7451833 / (SkinBloodFlow + .585417)

    # Compute heat storage and wet skin
    HSK = DRY + ESK
    RN = M - wme
    ECOMF = np.maximum(0, 0.42 * (RN - (1 * METFACTOR)))
    EMAX = EMAX * WCRIT
    W = PWET
    PSSK = findSaturatedVaporPressureTorr(TempSkin)

    # Define new heat flow terms, coeffs, and abbreviations
    CHRS = CHR
    CTCS = np.where(met < 0.85, 3.0, np.maximum(3.0, 5.66 * np.power((met - 0.85), 0.39)))
    CTCS = CTCS + CHRS  # Corrected this line
    RCLOS = 1.52 / ((met - wme / METFACTOR) + 0.6944) - 0.1835
    RCLS = 0.155 * RCLOS
    FACLS = 1.0 + KCLO * RCLOS
    FCLS = 1.0 / (1.0 + 0.155 * FACLS * CTCS * RCLOS)
    IMS = 0.45
    ICLS = IMS * CTCS / CTCS * (1 - FCLS) / (CTCS / CTCS - FCLS * IMS)
    RAS = 1.0 / (FACLS * CTCS)
    REAS = 1.0 / (LR * FACLS * CTCS)
    RECLS = RCLS / (LR * ICLS)
    HD_S = 1.0 / (RAS + RCLS)
    HE_S = 1.0 / (REAS + RECLS)

    # SET* (standardized humidity, clo, Pb, and CHC)
    DELTA = .0001
    X_OLD = TempSkin - HSK / HD_S
    X = X_OLD
    for _ in range(100):  # Set a maximum number of iterations
        ERR1 = (HSK - HD_S * (TempSkin - X_OLD) - W * HE_S * (PSSK - 0.5 * findSaturatedVaporPressureTorr(X_OLD)))
        ERR2 = (HSK - HD_S * (TempSkin - (X_OLD + DELTA)) - W * HE_S * (PSSK - 0.5 * findSaturatedVaporPressureTorr((X_OLD + DELTA))))
        X = X_OLD - DELTA * ERR1 / (ERR2 - ERR1)
        dx = X - X_OLD
        X_OLD = X
        if np.all(np.abs(dx) <= .01):
            break

    return X

#@njit
def calcHumidRatio(airTemp, relHumid, barPress):
    TKelvin = np.array(airTemp) + 273
    Sigma = np.where(TKelvin >= 273, 1 - (TKelvin / 647.096), 0)
    
    ExpressResult = (Sigma * -7.85951783 +
                     Sigma**1.5 * 1.84408259 +
                     Sigma**3 * -11.7866487 +
                     Sigma**3.5 * 22.6807411 +
                     Sigma**4 * -15.9618719 +
                     Sigma**7.5 * 1.80122502)
    
    CritTemp = 647.096 / TKelvin
    Exponent = CritTemp * ExpressResult
    Power = np.exp(Exponent)
    SatPress1 = np.where(Power != 1, Power * 22064000, 0)
    
    Theta = np.where(TKelvin < 273, TKelvin / 273.16, 1)
    Exponent2 = ((1 - (Theta**(-1.5))) * (-13.928169) +
                 (1 - (Theta**(-1.25))) * 34.707823)
    Power = np.exp(Exponent2)
    SatPress2 = np.where(Power != 1, Power * 611.657, 0)
    
    saturationPressure = SatPress1 + SatPress2
    
    partialPressure = relHumid * 0.01 * saturationPressure
    
    PressDiffer = barPress - partialPressure
    humidityRatio = 0.621991 * partialPressure / PressDiffer
    
    EnVariable1 = 1.01 + (1.89 * humidityRatio)
    EnVariable2 = EnVariable1 * airTemp
    EnVariable3 = 2500 * humidityRatio
    EnVariable4 = EnVariable2 + EnVariable3
    
    enthalpy = np.maximum(EnVariable4, 0)
    return humidityRatio, enthalpy, partialPressure, saturationPressure

