******************************************************************************
*Project:	ECON 608 PS5
*Created by: Zhixin Yu
*Created:	2019/10/23
******************************************************************************

* Set working environment
clear all
capture log close
set more off
set matsize 5000

* Set working directory
cd "C:\Users\Administrator\Desktop\Duke\19 Fall\ECON 608"
log using PS5log.log, replace
pwd

******************************************************************************
* Question 5 ---- Empirical Exercises: Some Isuues on Variable Selection
******************************************************************************

*========================(1)========================*
* load q5data.dta from sakai
use "C:\Users\Administrator\Downloads\ps5data1.dta" 

* estimate coefficients (beta0,beta1,beta2,beta3,gamma)
reg y x1 x2 x3 w

*      Source |       SS           df       MS      Number of obs   =       500
*-------------+----------------------------------   F(4, 495)       =   1077.77
*       Model |  8092.94796         4  2023.23699   Prob > F        =    0.0000
*    Residual |  929.235491       495  1.87724342   R-squared       =    0.8970
*-------------+----------------------------------   Adj R-squared   =    0.8962
*       Total |  9022.18345       499   18.080528   Root MSE        =    1.3701

*------------------------------------------------------------------------------
*           y |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
*-------------+----------------------------------------------------------------
*          x1 |   .9719941   .1232122     7.89   0.000     .7299108    1.214077
*          x2 |  -1.032179   .0233502   -44.20   0.000    -1.078057   -.9863015
*          x3 |   1.298477    .095721    13.57   0.000     1.110408    1.486547
*           w |    1.74014   .0993908    17.51   0.000      1.54486     1.93542
*       _cons |   1.187727   .1279458     9.28   0.000     .9363436    1.439111
*------------------------------------------------------------------------------


*========================(2) Inclusion of irrevelant variables========================*
**(a)**
* run a regression including an irrelevant regressor z
reg y x1 x2 x3 w z

*      Source |       SS           df       MS      Number of obs   =       500
*-------------+----------------------------------   F(5, 494)       =    863.16
*       Model |  8095.53988         5  1619.10798   Prob > F        =    0.0000
*    Residual |  926.643568       494   1.8757967   R-squared       =    0.8973
*-------------+----------------------------------   Adj R-squared   =    0.8963
*       Total |  9022.18345       499   18.080528   Root MSE        =    1.3696
*
*------------------------------------------------------------------------------
*           y |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
*-------------+----------------------------------------------------------------
*          x1 |    1.02602   .1314607     7.80   0.000     .7677292    1.284311
*          x2 |  -.9750344   .0539268   -18.08   0.000    -1.080989   -.8690803
*          x3 |   1.354946   .1070661    12.66   0.000     1.144585    1.565307
*           w |   1.787537   .1072228    16.67   0.000     1.576868    1.998206
*           z |  -.0617612   .0525409    -1.18   0.240    -.1649924      .04147
*       _cons |   1.217565    .130391     9.34   0.000     .9613753    1.473754
*------------------------------------------------------------------------------

** Answer:
* The estimates from (1) are: (beta0,beta1,beta2,beta3,gamma)           = (1.187727, 0.9719941, -1.032179, 1.298477, 1.74014)
* The estimates from (2) are: (beta0_h,beta1_h,beta2_h,beta3_h,gamma_h) = (1.217565, 1.02602, -0.9750344, 1.354946, 1.787537)
* The difference is not much between estimates from (1) and (2), about 0.03-0.06 difference in each coefficients.
* The SE's from (1) are SE(beta0,beta1,beta2,beta3,gamma) = (0.1279458, 0.1232122, 0.0233502, 0.095721, 0.0993908)
* The SE's from (2) are SE(beta0,beta1,beta2,beta3,gamma) = (0.130391, 0.1314607, 0.0539268, 0.1070661, 0.1072228)
* The comparison implied that including more variables will result in higher SE's.

**(b)**
* See Problem Set Sheets
**(c)**
* See Problem Set Sheets


*========================(3) Imperfect multicollinearity========================*
* run a regression including x4, a variable highly correlated with x3
reg y x1 x2 x3 w x4

*      Source |       SS           df       MS      Number of obs   =       500
*-------------+----------------------------------   F(5, 494)       =    865.69
*       Model |  8097.97219         5  1619.59444   Prob > F        =    0.0000
*    Residual |   924.21126       494    1.870873   R-squared       =    0.8976
*-------------+----------------------------------   Adj R-squared   =    0.8965
*       Total |  9022.18345       499   18.080528   Root MSE        =    1.3678
*
*------------------------------------------------------------------------------
*           y |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
*-------------+----------------------------------------------------------------
*          x1 |   .9573385   .1233276     7.76   0.000     .7150272     1.19965
*          x2 |  -1.034111   .0233403   -44.31   0.000     -1.07997   -.9882526
*          x3 |  -.7083663   1.228341    -0.58   0.564    -3.121784    1.705051
*           w |    1.74789   .0993346    17.60   0.000      1.55272    1.943061
*          x4 |   2.221648   1.355697     1.64   0.102    -.4419951    4.885291
*       _cons |   1.206937   .1282653     9.41   0.000     .9549244     1.45895
*------------------------------------------------------------------------------

* The estimates are:          (beta0,beta1,beta2,beta3,gamma,xi) = (1.206937, 0.9573385, -1.034111, -0.7083663, 1.74789, 2.221648)
* The estimates from (1) are: (beta0,beta1,beta2,beta3,gamma)    = (1.187727, 0.9719941, -1.032179, 1.298477, 1.74014)
* The estimated coeffcient of x3 is very different, after including a highly correlaed variable, the sign of coefficient turn from positive to negative.

* The SE of x3 in (1) is: 0.1070661, the SE's of x3 and x4 in (3) are: 1.228341, 1.355697
* The SE of x3 is much higher if including a highly correlated variable.


*========================(4) Omission of revelant variables========================*
* run a regression model:y = beta0 + beta1*x1 + beta2*x2 + beta3*x3 + epsilon
reg y x1 x2 x3

*      Source |       SS           df       MS      Number of obs   =       500
*-------------+----------------------------------   F(3, 496)       =    826.02
*       Model |  7517.51218         3  2505.83739   Prob > F        =    0.0000
*    Residual |  1504.67127       496  3.03361142   R-squared       =    0.8332
*-------------+----------------------------------   Adj R-squared   =    0.8322
*       Total |  9022.18345       499   18.080528   Root MSE        =    1.7417
*
*------------------------------------------------------------------------------
*           y |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
*-------------+----------------------------------------------------------------
*          x1 |   1.110211   .1563076     7.10   0.000     .8031045    1.417318
*          x2 |  -1.013734   .0296529   -34.19   0.000    -1.071995   -.9554735
*          x3 |   2.603723   .0763222    34.11   0.000     2.453769    2.753678
*       _cons |    1.09941   .1625204     6.76   0.000     .7800962    1.418723
*------------------------------------------------------------------------------

**(a)**
* The estimates from (1) are: (beta0,beta1,beta2,beta3,gamma) = (1.187727, 0.9719941, -1.032179, 1.298477, 1.74014)
* The estimates from (4) are: (beta0,beta1,beta2,beta3)       = (1.09941, 1.110211, -1.013734, 2.603723)

**(b)**
* See Problem Set Sheets
**(c)**
* See Problem Set Sheets


log close
******************************************************************************
* Thank you for reading! Feel free making comments! Have a good day!
******************************************************************************
* The End









