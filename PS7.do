******************************************************************************
*Project:	ECON 608 PS7
*Created by: Zhixin Yu
*Created:	2019/11/23
******************************************************************************

* Set working environment
clear all
capture log close
set more off
set matsize 5000

* Set working directory
cd "C:\Users\Administrator\Desktop\Duke\19 Fall\ECON 608"
log using PS7log.log, replace
pwd

******************************************************************************
* Question 3 ---- Wald Tests
******************************************************************************
clear
* load ps6data1.dta
use "C:\Users\Administrator\Downloads\ps7data1.dta" 

*===============================================================================
*(1) Estimate the coefficients in model
gen lny = ln(y)
gen lnx1 = ln(x1)
gen lnx2 = ln(x2)

reg lny z1 z2 lnx1 lnx2

*      Source |       SS           df       MS      Number of obs   =     1,200
*-------------+----------------------------------   F(4, 1195)      =    951.44
*       Model |  3818.91955         4  954.729888   Prob > F        =    0.0000
*    Residual |  1199.12644     1,195  1.00345309   R-squared       =    0.7610
*-------------+----------------------------------   Adj R-squared   =    0.7602
*       Total |  5018.04599     1,199  4.18519265   Root MSE        =    1.0017

*------------------------------------------------------------------------------
*         lny |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
*-------------+----------------------------------------------------------------
*          z1 |   1.564073   .0290384    53.86   0.000     1.507101    1.621045
*          z2 |  -1.456148   .0578881   -25.15   0.000    -1.569722   -1.342575
*        lnx1 |    .318695   .0669849     4.76   0.000     .1872738    .4501162
*        lnx2 |   .6985129   .0379789    18.39   0.000     .6240001    .7730257
*       _cons |   1.017464   .0903252    11.26   0.000     .8402507    1.194678
*------------------------------------------------------------------------------

*===============================================================================
*(2) The P-value is 0.000 for H0: gamma = 0, we can reject H0 at significance level 5%,
*    test statistic is t =  4.76, and P-value closed to zero.

*===============================================================================
*(3) Test H0 = eta1 +eta2 = 0; h0 = gamma + beta = 1 separately
test z1 + z2 = 0

* ( 1)  z1 + z2 = 0

*       F(  1,  1195) =    2.81
*            Prob > F =    0.0940
test lnx1 + lnx2 = 1

* ( 1)  lnx1 + lnx2 = 1

*       F(  1,  1195) =    0.05
*            Prob > F =    0.8242
* The p-Value for the first test is 0.0940. So we would reject H0 at 10% significance level. 
* The p-Value for the second test is 0.8242. So we would fail to reject H0 at 10% significance level. 

*===============================================================================
*(4) Jointly test H0: eta1 +eta2 = 0 and gamma + beta = 1
test (z1 + z2 = 0) (lnx1 + lnx2 = 1)

* ( 1)  z1 + z2 = 0
* ( 2)  lnx1 + lnx2 = 1

*       F(  2,  1195) =    1.42
*            Prob > F =    0.2419
* The p-Value for the first test is 0.2419. So we would fail to reject H0 at 10% significance level. 
* Do not agree with the classmate, since we reject one of H0 separately, but we can not reject the jointly H0.

*===============================================================================
*(5) Test the overall significance of the model with H0: eta1 = eta2 = gamma = beta = 0
reg lny z1 z2 lnx1 lnx2

*      Source |       SS           df       MS      Number of obs   =     1,200
*-------------+----------------------------------   F(4, 1195)      =    951.44
*       Model |  3818.91955         4  954.729888   Prob > F        =    0.0000
*    Residual |  1199.12644     1,195  1.00345309   R-squared       =    0.7610
*-------------+----------------------------------   Adj R-squared   =    0.7602
*       Total |  5018.04599     1,199  4.18519265   Root MSE        =    1.0017

*------------------------------------------------------------------------------
*         lny |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
*-------------+----------------------------------------------------------------
*          z1 |   1.564073   .0290384    53.86   0.000     1.507101    1.621045
*          z2 |  -1.456148   .0578881   -25.15   0.000    -1.569722   -1.342575
*        lnx1 |    .318695   .0669849     4.76   0.000     .1872738    .4501162
*        lnx2 |   .6985129   .0379789    18.39   0.000     .6240001    .7730257
*       _cons |   1.017464   .0903252    11.26   0.000     .8402507    1.194678
*------------------------------------------------------------------------------
* Note that the F-statistics is 951.44 and the p-value is 0.0000.

*===============================================================================
*(6) Test H0: eta1/eta2 = -1 and H0: log(gamma + beta) = 0
testnl _b[z1] / _b[z2] = -1

*  (1)  _b[z1] / _b[z2] = -1

*               chi2(1) =        2.50
*           Prob > chi2 =        0.1138

testnl log(_b[lnx1] + _b[lnx2]) = 0

*  (1)  log(_b[lnx1] + _b[lnx2]) = 0

*               chi2(1) =        0.05
*           Prob > chi2 =        0.8226
* The two p-Values are 0.1138 and 0.8226. So we would fail to reject H0 at 10% significance level. 
* The result are different from (3), and I think Wald tests are variant to equivalent transformation.

*===============================================================================
*(7) Provide the 95% confidence interval of gamma + beta
lincom lnx1 + lnx2

*------------------------------------------------------------------------------
*         lny |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
*-------------+----------------------------------------------------------------
*         (1) |   1.017208    .077429    13.14   0.000      .865296     1.16912
*------------------------------------------------------------------------------
* The 95% confidence interval of gamma + beta is [0.865296, 1.16912]

*===============================================================================
*(8) Provide the 95% confidence interval of eta1/eta2
nlcom _b[z1] / _b[z2]
*       _nl_1:  _b[z1] / _b[z2]

*------------------------------------------------------------------------------
*         lny |      Coef.   Std. Err.      z    P>|z|     [95% Conf. Interval]
*-------------+----------------------------------------------------------------
*       _nl_1 |  -1.074116   .0468659   -22.92   0.000    -1.165972   -.9822608
*------------------------------------------------------------------------------
* The 95% confidence interval of eta1/eta2 is [-1.165972, -.9822608]



log close
******************************************************************************
* Thank you for reading! Feel free making comments! Have a good day!
******************************************************************************
* The End
