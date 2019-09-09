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
use "C:\Users\Administrator\Desktop\Duke\19 Fall\ECON 608\ps1data2.dta",clear

* browsing data
list

* Answer of Q1: beta is the gross price effect, holding everything else constant, when price increase one unit, the demand of oil will change b units. 


******************************* Question 2 *******************************

* run regression
reg q p

*      Source |       SS           df       MS      Number of obs   =        20
*-------------+----------------------------------   F(1, 18)        =      0.10
*       Model |  .505356122         1  .505356122   Prob > F        =    0.7505
*    Residual |  87.2142153        18  4.84523418   R-squared       =    0.0058
*-------------+----------------------------------   Adj R-squared   =   -0.0495
*       Total |  87.7195714        19  4.61681955   Root MSE        =    2.2012
*
*------------------------------------------------------------------------------
*           q |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
*-------------+----------------------------------------------------------------
*           p |  -.5050688   1.563901    -0.32   0.750    -3.790702    2.780565
*       _cons |   13.86275   6.958802     1.99   0.062    -.7571519    28.48265
*------------------------------------------------------------------------------

* Answer of Q2: alpha_hat = 13.86275 and beta_hat = -.5050688


******************************* Question 3 *******************************

* calculate sample mean
summarize

*    Variable |        Obs        Mean    Std. Dev.       Min        Max
*-------------+---------------------------------------------------------
*           q |         20      11.621    2.148679       8.01      16.17
*           p |         20      4.4385    .3229025       3.75       4.89

* Answer of Q3: p0 = p_bar = 4.4385, q0 = q_bar = 11.621, price elasticity = -0.5050688*(4.4385/11.621) = -0.11379238
* when the price of oil increase one unit, the demand of oil will decrease 0.11379238 unit


 ******************************* Question 4 *******************************

 * generate two new variables
gen q_star = q - 11.621
gen p_star = p - 4.4385

* run regression
reg q_star p_star

*      Source |       SS           df       MS      Number of obs   =        20
*-------------+----------------------------------   F(1, 18)        =      0.10
*       Model |    .5053564         1    .5053564   Prob > F        =    0.7505
*    Residual |   87.214217        18  4.84523428   R-squared       =    0.0058
*-------------+----------------------------------   Adj R-squared   =   -0.0495
*       Total |  87.7195734        19  4.61681965   Root MSE        =    2.2012
*
*------------------------------------------------------------------------------
*      q_star |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
*-------------+----------------------------------------------------------------
*      p_star |  -.5050689   1.563901    -0.32   0.750    -3.790702    2.780564
*       _cons |   8.39e-08   .4922009     0.00   1.000    -1.034076    1.034076
*------------------------------------------------------------------------------

* Answer of Q4: The coefficiant of independent variable remains the same, while the constant becomes zero.
* That is because we are centering variables by sample means


 ******************************* Question 5 *******************************

* Answer of Q5: beta_hat = (1030.596 - 232.420*(1/20)*88.77)/(395.986-(1/20)*(88.770)^2) = -0.505046
* alpha_hat = (1/20)*232.42 - beta_hat*(1/20)*88.77 = 13.8626
* It is really similiar with the stata result.(alpha_hat = 13.86275 and beta_hat = -.5050688)


* save the modified data and close log-file, stop recording
save ECON608_PS1_data2_ZY, replace

******************************************************************************
* Thank you for reading! Feel free making comments! Have a good day!
******************************************************************************
* The End
