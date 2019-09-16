******************************************************************************
*Project:	ECON 608 PS2
*Created by: Zhixin Yu
*Created:	2019/09/15
******************************************************************************
* Set working environment
clear all
capture log close
set more off
set matsize 5000

* Set working directory
cd "C:\Users\Administrator\Desktop\Duke\19 Fall\ECON 608"
pwd

******************************* Question (a) *******************************

* import data
use "C:\Users\Administrator\Desktop\Duke\19 Fall\ECON 608\ps2data1.dta",clear

* show the missing values of data
mdesc

* run the regression to obtain OLS estimates
reg ltotexp suppin phylim actlim totchr age female income

*      Source |       SS           df       MS      Number of obs   =     2,955
*-------------+----------------------------------   F(7, 2947)      =    124.98
*       Model |  1264.72124         7  180.674463   Prob > F        =    0.0000
*    Residual |  4260.16814     2,947  1.44559489   R-squared       =    0.2289
*-------------+----------------------------------   Adj R-squared   =    0.2271
*       Total |  5524.88938     2,954  1.87030785   Root MSE        =    1.2023
*------------------------------------------------------------------------------
*     ltotexp |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
*-------------+----------------------------------------------------------------
*     suppins |   .2556428   .0462264     5.53   0.000     .1650034    .3462821
*      phylim |   .3020598   .0569709     5.30   0.000      .190353    .4137666
*      actlim |   .3560054   .0621118     5.73   0.000     .2342185    .4777923
*      totchr |   .3758201   .0184227    20.40   0.000     .3396974    .4119429
*         age |   .0038016   .0036561     1.04   0.299    -.0033672    .0109705
*      female |  -.0843275   .0455442    -1.85   0.064    -.1736292    .0049741
*      income |   .0025498   .0010194     2.50   0.012      .000551    .0045486
*       _cons |   6.703737     .27676    24.22   0.000     6.161075      7.2464
*------------------------------------------------------------------------------

******************************* Question (f) *******************************

*(i) Calculate predicted logyi, predicted yi and residual ei for each individual

* calculate predicted logyi
predict ltotexp_hat

* calculate predicted yi
gen yi_hat = e^ltotexp_hat

* calculate residual ei
gen ei = ltotexp - ltotexp_hat

*(ii) Find the sum of residual
total(ei)

*Total estimation                  Number of obs   =      2,955
*
*--------------------------------------------------------------
*             |      Total   Std. Err.     [95% Conf. Interval]
*-------------+------------------------------------------------
*          ei |   .0000117   65.28101     -128.0009    128.0009
*--------------------------------------------------------------

*(iii) Does the sum of predicted yi equals to the sum of yi

* calculate the sum of predicted yi
total(yi_hat)
* 2.35e+13

* calculate the sum of yi
total(totexp)
* 2.15e+07

*(iv) Does the sum of predicted logyi equals to the sum of logyi

* calculate the sum of predicted logyi
total(ltotexp_hat)
* 24608.63

* calculate the sum of logyi
total(ltotexp)
* 23816.91

******************************* Question (g) *******************************

* generate one additional regressor age2 = age^2
gen age2 = age^2

* run the new regression model
reg ltotexp suppin phylim actlim totchr female income age age2

*      Source |       SS           df       MS      Number of obs   =     2,955
*-------------+----------------------------------   F(8, 2946)      =    110.94
*       Model |  1279.09585         8  159.886982   Prob > F        =    0.0000
*    Residual |  4245.79353     2,946  1.44120622   R-squared       =    0.2315
*-------------+----------------------------------   Adj R-squared   =    0.2294
*       Total |  5524.88938     2,954  1.87030785   Root MSE        =    1.2005
*------------------------------------------------------------------------------
*     ltotexp |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
*-------------+----------------------------------------------------------------
*     suppins |   .2637491   .0462275     5.71   0.000     .1731076    .3543906
*      phylim |   .3045206   .0568897     5.35   0.000      .192973    .4160682
*      actlim |   .3716271   .0622144     5.97   0.000     .2496391    .4936152
*      totchr |    .372237   .0184297    20.20   0.000     .3361006    .4083734
*      female |  -.0785666   .0455116    -1.73   0.084    -.1678043    .0106711
*      income |   .0027262   .0010194     2.67   0.008     .0007274    .0047249
*         age |   .2827834    .088412     3.20   0.001     .1094278     .456139
*        age2 |  -.0018573   .0005881    -3.16   0.002    -.0030105   -.0007042
*       _cons |  -3.706789   3.307946    -1.12   0.263    -10.19291     2.77933
*------------------------------------------------------------------------------

* For the answer to each questions, please refer to my answer sheets

* save the modified data and close log-file, stop recording
save ECON608_PS2_data1_ZY, replace

******************************************************************************
* Thank you for reading! Feel free making comments! Have a good day!
******************************************************************************
* The End
