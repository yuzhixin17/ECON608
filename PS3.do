******************************************************************************
*Project:	ECON 608 PS3
*Created by: Zhixin Yu
*Created:	2019/09/23
******************************************************************************

* Set working environment
clear all
capture log close
set more off
set matsize 5000

* Set working directory
cd "C:\Users\Administrator\Desktop\Duke\19 Fall\ECON 608"
log using PS3log.log, replace
pwd

******************************************************************************
* Question 6 ---- Monte Carlo Exercise: Delta Method
******************************************************************************

*========================(1)========================*
 
* Data Creation
set seed 17
set obs 1000

* Run a loop for 1000 times, with theta = 2
forvalues i = 1(1)1000{
gen x`i' = rnormal(2,1)
collapse (mean) theta`i' = x`i'
gen phi`i' = theta`i'^2
display theta`i', phi`i'
}
*(2 variables, 1000 observations pasted into data editor)

* Plot the density of phi(xi_mean) using a histogram with kernel density estimate.
histogram phi1000, kdensity
* Save the graph
graph save Graph "C:\Users\Administrator\Desktop\Duke\19 Fall\ECON 608\Graph1.gph"

*========================(2)========================*
* provide a good estimation or not?

* Not that good, the distribution is not centered that much, because X is not being close enough to its mean.

*========================(3)========================* 
* Redo (1) and (2) with theta = 0.2
clear all
set seed 17
set obs 1000

forvalues i = 1(1)1000{
gen x`i' = rnormal(0.2,1)
collapse (mean) theta`i' = x`i'
gen phi`i' = theta`i'^2
display theta`i', phi`i'
}
. *(2 variables, 1000 observations pasted into data editor)

histogram phi1000, kdensity
graph save Graph "C:\Users\Administrator\Desktop\Duke\19 Fall\ECON 608\Graph2.gph"

** Comment: When theta is smaller, it provides a better estimation for phi.
** For delta method, this is a good approximation only if X has a high probability of being close enough to its mean (mu) so that the Taylor approximation is still good.


******************************************************************************
* Question 7 ---- Regression with Lagged Dependent Variable
******************************************************************************
clear all

*========================(1)========================*
* import data
use "C:\Users\Administrator\Downloads\ps3data.dta" 

* run regression model(7.3)
nl (y = exp({alpha} + {gamma}*D))
*
*      Source |      SS            df       MS
*-------------+----------------------------------    Number of obs =      2,000
*       Model |  660031.48          2  330015.742    R-squared     =     0.0324
*    Residual |   19726279       1998  9873.01259    Adj R-squared =     0.0314
*-------------+----------------------------------    Root MSE      =   99.36303
*       Total |   20386311       2000  10193.1553    Res. dev.     =   24068.87
*
*------------------------------------------------------------------------------
*           y |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
*-------------+----------------------------------------------------------------
*      /alpha |   2.893096   .1423797    20.32   0.000     2.613868    3.172325
*      /gamma |   .0251615   .2781005     0.09   0.928    -.5202359    .5705589
*------------------------------------------------------------------------------
** The OLS estimator is biased, because it does not rule out the effect of X,
** the condition expectation is not equal to zero in this case.

*========================(2)========================*
* generate variables
gen lny = ln(y)
gen lnperiod = ln(period)

* run new regression model(7.4)
nl (lny = {alpha} + {gamma}*D + {beta}*lnperiod)
*
*      Source |      SS            df       MS
*-------------+----------------------------------    Number of obs =      2,000
*       Model |  1384.3185          2  692.159242    R-squared     =     0.1847
*    Residual |  6111.7695       1997  3.06047549    Adj R-squared =     0.1839
*-------------+----------------------------------    Root MSE      =   1.749421
*       Total |   7496.088       1999  3.74991897    Res. dev.     =   7909.892
*
*------------------------------------------------------------------------------
*         lny |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
*-------------+----------------------------------------------------------------
*      /alpha |   1.031925   .0553216    18.65   0.000      .923431    1.140419
*      /gamma |   2.246723   .1106487    20.31   0.000     2.029724    2.463722
*       /beta |  -2.350983   .1387034   -16.95   0.000    -2.623001   -2.078964
*------------------------------------------------------------------------------
*  Parameter alpha taken as constant term in model & ANOVA table

** Comment: The coefficients are all significant after adjustment.

*========================(3)========================*
** Question: Do you think the OLS estimator of model (7.4) is unbiased? why?

** Answer: I think it is unbiased, because it rules out the effect of x, using beta coefficient estimator.


log close
******************************************************************************
* Thank you for reading! Feel free making comments! Have a good day!
******************************************************************************
* The End









