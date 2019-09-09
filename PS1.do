******************************************************************************
*Project:	ECON 608 PS1
*Created by: Zhixin Yu
*Created:	2019/09/05
******************************************************************************

* Set working environment
clear all
capture log close
set more off
set matsize 5000

* Set working directory
cd "C:\Users\Administrator\Desktop\Duke\19 Fall\ECON 608"
pwd

******************************* Question 1 *******************************

* import data
use "C:\Users\Administrator\Desktop\Duke\19 Fall\ECON 608\ps1data1.dta",clear

* browsing data
list

* search mdesc function and install the package
search mdesc

* show the missing values of data
mdesc
*    Variable    |     Missing          Total     Percent Missing
*----------------+-----------------------------------------------
*              y |           0          1,000           0.00
*              x |          96          1,000           9.60
*----------------+-----------------------------------------------

* Answer of Q(1): there are 96 missing values in x variable.
*If X variable is missing completely at random, then throwing out missing data does not bias inferences.
* However, there might be two issues we need to consider:
*1. If the units with missing values differ systematically from the completely observed cases, this could bias the complete-case analysis.
*2. If many variables are included in a model, there may be very few complete cases, so that most of the data would be discarded for the sake of a simple analysis.
* In this case, it seems that missing values are randomly distributed and there's no actual meaning provided, the number of missing value is not over 1%, then it might be fine.


******************************* Question 2 *******************************

* using OLS to estimate
reg y x

*      Source |       SS           df       MS      Number of obs   =       904
*-------------+----------------------------------   F(1, 902)       =   1305.10
*       Model |  3461.05737         1  3461.05737   Prob > F        =    0.0000
*    Residual |  2392.05633       902  2.65194715   R-squared       =    0.5913
*-------------+----------------------------------   Adj R-squared   =    0.5909
*       Total |   5853.1137       903  6.48185349   Root MSE        =    1.6285
*
*------------------------------------------------------------------------------
*           y |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
*-------------+----------------------------------------------------------------
*           x |   1.954579   .0541042    36.13   0.000     1.848394    2.060764
*       _cons |   .3886584   .0542296     7.17   0.000     .2822276    .4950893
*------------------------------------------------------------------------------
* Answer of Q(2): alpha_hat = 0.3886584 and beta_hat = 1.954579


******************************* Question 3 *******************************

* replace missing values with 0s
recode x (mis = 0)

* generate a dummy variable
generate dummy = 1
replace dummy = 0 if x != 0

* run the regression with dummy variable
reg y x dummy

*      Source |       SS           df       MS      Number of obs   =     1,000
*-------------+----------------------------------   F(2, 997)       =    595.29
*       Model |  3462.26758         2  1731.13379   Prob > F        =    0.0000
*    Residual |  2899.32354       997  2.90804768   R-squared       =    0.5442
*-------------+----------------------------------   Adj R-squared   =    0.5433
*       Total |  6361.59112       999  6.36795908   Root MSE        =    1.7053
*
*------------------------------------------------------------------------------
*           y |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
*-------------+----------------------------------------------------------------
*           x |   1.954579   .0566565    34.50   0.000     1.843399    2.065759
*       dummy |  -.2155552   .1830765    -1.18   0.239    -.5748147    .1437043
*       _cons |   .3886584   .0567878     6.84   0.000     .2772212    .5000957
*------------------------------------------------------------------------------

* Answer of Q(3): alpha_hat = 0.3886584 and beta_hat = 1.954579
* Yes, it provides the same estimates as in (1)


******************************* Question 4 *******************************
clear all
capture log close
set more off
set matsize 5000
cd "C:\Users\Administrator\Desktop\Duke\19 Fall\ECON 608"
pwd
use "C:\Users\Administrator\Desktop\Duke\19 Fall\ECON 608\ps1data1.dta",clear

* calculate the sample mean of x
summarize

*    Variable |        Obs        Mean    Std. Dev.       Min        Max
*-------------+---------------------------------------------------------
*           y |      1,000    .2798561    2.523482    -12.624     8.7591
*           x |        904   -.0498653     1.00163    -3.1289     2.9371

* replace missing value with sample mean
recode x (mis = -3.1289)
* run regression
reg y x

*      Source |       SS           df       MS      Number of obs   =     1,000
*-------------+----------------------------------   F(1, 998)       =    418.35
*       Model |  1879.03154         1  1879.03154   Prob > F        =    0.0000
*    Residual |  4482.55958       998  4.49154267   R-squared       =    0.2954
*-------------+----------------------------------   Adj R-squared   =    0.2947
*       Total |  6361.59112       999  6.36795908   Root MSE        =    2.1193
*
*------------------------------------------------------------------------------
*           y |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
*-------------+----------------------------------------------------------------
*           x |   1.042575   .0509728    20.45   0.000     .9425494    1.142602
*       _cons |   .6400166   .0692936     9.24   0.000     .5040386    .7759945
*------------------------------------------------------------------------------

* Estimates of Q(2): alpha_hat = 0.3886584 and beta_hat = 1.954579
* Estimates of Q(4): alpha_hat = 0.6400166 and beta_hat = 1.042575 
* Results are different.

******************************* Question 5 *******************************
* Please see homework sheet.



* save the modified data and close log-file, stop recording
save ECON608_PS1_data1_ZY, replace

******************************************************************************
* Thank you for reading! Feel free making comments! Have a good day!
******************************************************************************
* The End












