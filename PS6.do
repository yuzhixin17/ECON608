******************************************************************************
*Project:	ECON 608 PS6
*Created by: Zhixin Yu
*Created:	2019/11/17
******************************************************************************

* Set working environment
clear all
capture log close
set more off
set matsize 5000

* Set working directory
cd "C:\Users\Administrator\Desktop\Duke\19 Fall\ECON 608"
log using PS6log.log, replace
pwd

******************************************************************************
* Question 1 ---- Empirical Exercises: Difference in Difference
******************************************************************************
clear
* load ps6data1.dta
use "C:\Users\Administrator\Downloads\ps6data1.dta" 


*(1) The Ti in the Card and Krueger case should be variable "Treated", variable "t" is the Pt.

* Estimate the DID using sample means
collapse (mean) fte, by(t treated)

* Below is the result table
*-----------------
* t	 treated  fte
*-----------------
* 0	 PA	  19.94872
* 0	 NJ	  17.06518
* 1	 PA	  17.54221
* 1	 NJ	  17.57266
*-----------------
* We can calculate the DID = (17.57266-17.06518)-(17.54221-19.94872) = 2.9139


*(2) Write down the regression model to estimate DID:
*    fte = alpha + gamma*t + Lambda*treated + Delta*(t*treated) + Epsilon
*    Since we control for treated and t variable and then estimate the coefficient of the interaction term, 
*    then the coefficient of interaction term should be equal to the difference in difference.

* Using regression to estimate DID:
gen ttreated = t*treated
reg fte t treated ttreated

*      Source |       SS           df       MS      Number of obs   =       801
*-------------+----------------------------------   F(3, 797)       =      2.15
*       Model |  524.003099         3    174.6677   Prob > F        =    0.0919
*    Residual |  64600.6458       797  81.0547626   R-squared       =    0.0080
*-------------+----------------------------------   Adj R-squared   =    0.0043
*       Total |  65124.6489       800  81.4058111   Root MSE        =     9.003

*------------------------------------------------------------------------------
*         fte |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
*-------------+----------------------------------------------------------------
*           t |   -2.40651   1.446314    -1.66   0.097    -5.245544    .4325237
*     treated |  -2.883534   1.134812    -2.54   0.011    -5.111107   -.6559608
*    ttreated |   2.913982   1.610513     1.81   0.071    -.2473667    6.075331
*       _cons |   19.94872   1.019394    19.57   0.000      17.9477    21.94973
*------------------------------------------------------------------------------
* DID estimate = 2.913982, SE = 1.610513

* To show that DID estimates are the same form (1) and (2):
* when s=NJ,t=Nov, fte = alpha + gamma*1 + Lambda*1 + Delta*(1) + Epsilon    {1}
* when s=NJ,t=Feb, fte = alpha + gamma*0 + Lambda*1 + Delta*(0) + Epsilon    {2}
* when s=PA,t=Nov, fte = alpha + gamma*1 + Lambda*0 + Delta*(0) + Epsilon    {3}
* when s=PA,t=Feb, fte = alpha + gamma*0 + Lambda*0 + Delta*(0) + Epsilon    {4}
* DID = ({1}-{2})-({3}-{4}) = Lambda + Delta - (Lambda) = Delta


*(3) alpha(coefficient of constant) is the expected full time employment in Feb, PA
*    coefficient of t is the difference between expected full time employment in Nov, PA and the expected full time employment in Feb, PA
*    coefficient of treated is the difference between expected full time employment in Feb, NJ and the expected full time employment in Feb, PA
*    coefficient of interaction is the difference in difference


*(4) controlling the firm-specific effect
reg fte t treated ttreated kfc roys wendys

*      Source |       SS           df       MS      Number of obs   =       801
*-------------+----------------------------------   F(6, 794)       =     30.61
*       Model |  12233.2833         6  2038.88054   Prob > F        =    0.0000
*    Residual |  52891.3656       794  66.6138106   R-squared       =    0.1878
*-------------+----------------------------------   Adj R-squared   =    0.1817
*       Total |  65124.6489       800  81.4058111   Root MSE        =    8.1617

*------------------------------------------------------------------------------
*         fte |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
*-------------+----------------------------------------------------------------
*           t |  -2.402678   1.311311    -1.83   0.067    -4.976724    .1713688
*     treated |  -2.323906   1.030692    -2.25   0.024    -4.347109    -.300703
*    ttreated |    2.93502   1.460147     2.01   0.045     .0688142    5.801225
*         kfc |  -10.12174   .7858127   -12.88   0.000    -11.66425    -8.57922
*        roys |  -1.813925   .7371392    -2.46   0.014    -3.260897   -.3669533
*      wendys |  -.9168795   .8888416    -1.03   0.303    -2.661637    .8278775
*       _cons |   22.07757   .9825978    22.47   0.000     20.14878    24.00637
*------------------------------------------------------------------------------
* Comments: the result from (2) and (4) are slightly different.


*(5) Comments: It is much simple and accurate to use regression method 
*              and we can also obtain other information like SEs, P-values, etc.


******************************************************************************
* Question 2 ---- Empirical Exercises: Measurement Error
******************************************************************************
clear
* load ps6data2.dta from sakai
use "C:\Users\Administrator\Downloads\ps6data2.dta"

*(1) There are no problem here if measurement error v satisfies E[v|x1,x2] = 0,
*    y = beta0 + beta1*x1 + beta2*x2 + Epsiloni + vi
*      = beta0 + beta1*x1 + beta2*x2 + ui
*    E[ui|x1,x2] =E[Epsiloni + vi|x1,x2]= 0, meets all regularity conditions of the LRM,
*    the OLS estimator of beta is unbiased and consistent.


*(2) If E[v|x1,x2] != 0, then assumption 3 of OLS is violated, 
*    and then the OLS estimator of beta is biased and inconsistent.


*(3) run a regression with y on x1, x2
. reg y x1 x2

*      Source |       SS           df       MS      Number of obs   =     1,500
*-------------+----------------------------------   F(2, 1497)      =   3870.83
*       Model |  10517.5204         2  5258.76021   Prob > F        =    0.0000
*    Residual |  2033.76539     1,497  1.35856072   R-squared       =    0.8380
*-------------+----------------------------------   Adj R-squared   =    0.8377
*       Total |  12551.2858     1,499  8.37310595   Root MSE        =    1.1656

*------------------------------------------------------------------------------
*           y |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
*-------------+----------------------------------------------------------------
*          x1 |   1.540574   .0601992    25.59   0.000     1.422491    1.658658
*          x2 |    2.55445   .0304982    83.76   0.000     2.494626    2.614274
*       _cons |   1.009786   .0424269    23.80   0.000     .9265634    1.093009
*------------------------------------------------------------------------------


*(4) run a regression with y0 on x1, x2
reg y0 x1 x2

*      Source |       SS           df       MS      Number of obs   =       500
*-------------+----------------------------------   F(2, 497)       =   1480.89
*       Model |  2814.57155         2  1407.28578   Prob > F        =    0.0000
*    Residual |  472.298753       497  .950299302   R-squared       =    0.8563
*-------------+----------------------------------   Adj R-squared   =    0.8557
*       Total |  3286.87031       499  6.58691444   Root MSE        =    .97483

*------------------------------------------------------------------------------
*          y0 |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
*-------------+----------------------------------------------------------------
*          x1 |   1.606188   .0872496    18.41   0.000     1.434764    1.777612
*          x2 |    2.09159   .0413761    50.55   0.000     2.010296    2.172883
*       _cons |   .9291459   .0620596    14.97   0.000     .8072144    1.051077
*------------------------------------------------------------------------------
* Comments: The results are qutie different.
*           In my opinion,the estimator with y0 is biased but consistent. 
*           Since there are only partial of y0 available, if the number of y0 is sufficient large, 
*           then the result will be the same.


******************************************************************************
* Question 3 ---- 2SLS Estimation
******************************************************************************
clear
* load q3data.dta
use "C:\Users\Administrator\Downloads\q3data.dta" 


*(1) estimate beta using OLS
reg y x3 x1 x2 

*      Source |       SS           df       MS      Number of obs   =       500
*-------------+----------------------------------   F(3, 496)       =   2230.11
*       Model |  3191.46363         3  1063.82121   Prob > F        =    0.0000
*    Residual |  236.605585       496  .477027389   R-squared       =    0.9310
*-------------+----------------------------------   Adj R-squared   =    0.9306
*       Total |  3428.06921       499  6.86987818   Root MSE        =    .69067

*------------------------------------------------------------------------------
*           y |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
*-------------+----------------------------------------------------------------
*          x3 |   2.210636   .0310864    71.11   0.000     2.149559    2.271713
*          x1 |   1.102925    .061814    17.84   0.000     .9814754    1.224375
*          x2 |    2.01726   .0543212    37.14   0.000     1.910532    2.123988
*       _cons |   -1.58084   .0728977   -21.69   0.000    -1.724067   -1.437614
*------------------------------------------------------------------------------


*(2) obtain 2SLS estimates
ivregress 2sls y x1 x2 (x3 = z1 z2 z3) 

*Instrumental variables (2SLS) regression          Number of obs   =        500
*                                                  Wald chi2(3)    =     972.84
*                                                  Prob > chi2     =     0.0000
*                                                  R-squared       =     0.8676
*                                                  Root MSE        =     .95278

*------------------------------------------------------------------------------
*           y |      Coef.   Std. Err.      z    P>|z|     [95% Conf. Interval]
*-------------+----------------------------------------------------------------
*          x3 |   1.547169   .1445445    10.70   0.000     1.263867    1.830471
*          x1 |   1.121929   .0853641    13.14   0.000     .9546189     1.28924
*          x2 |   1.999243   .0750298    26.65   0.000     1.852187    2.146299
*       _cons |  -1.085068    .144056    -7.53   0.000    -1.367412   -.8027233
*------------------------------------------------------------------------------
*Instrumented:  x3
*Instruments:   x1 x2 z1 z2 z3
*-------------------------------------------------------------------------------
* Comments: The estimates of OLS and 2SLS are really different on x3(OLS:2.21,2SLS:1.54), 
*           while the estimates of x1(OLS:1.10,2SLS:1.12) and x2 are quite similar(OLS:2.02,2SLS:2.00),
*           maybe it is because x3 is probably an endogenous regressor.


*(3) test whether (z1,z2,z3) are exogenous
estat overid

*  Tests of overidentifying restrictions:

*  Sargan (score) chi2(2) =  2.63863  (p = 0.2673)
*  Basmann chi2(2)        =  2.62079  (p = 0.2697)
*-------------------------------------------------------------------------------
* Comments: Noted that J-stat = 2.63863 and p-Value = 0.2673), 
*          so exogeneity of over-identifying instrument cannot be rejected. 


*(4) test the endogeneity of x3
estat endogenous

*  Tests of endogeneity
*  Ho: variables are exogenous

*  Durbin (score) chi2(1)          =  44.3182  (p = 0.0000)
*  Wu-Hausman F(1,495)             =  48.1422  (p = 0.0000)
*-------------------------------------------------------------------------------
* Comment: P-Value associated with chi-squared(1) test is 0.0000, 
*          so we can reject null hypothesis that x3 is exogenous.


*(5) "Maunally" obtain 2SLS estimates by unning two OLS regressions

* 2SLS in 2 Steps with (z1,z2,z3) as instruments:
regress x3 z1 z2 z3

*      Source |       SS           df       MS      Number of obs   =       500
*-------------+----------------------------------   F(3, 496)       =     15.98
*       Model |  43.5198779         3   14.506626   Prob > F        =    0.0000
*    Residual |  450.336057       496  .907935598   R-squared       =    0.0881
*-------------+----------------------------------   Adj R-squared   =    0.0826
*       Total |  493.855935       499  .989691252   Root MSE        =    .95286

*------------------------------------------------------------------------------
*          x3 |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
*-------------+----------------------------------------------------------------
*          z1 |  -1.297585   .1962504    -6.61   0.000     -1.68317   -.9120006
*          z2 |   .1886538   .0906824     2.08   0.038     .0104847    .3668229
*          z3 |   .0450371   .0422751     1.07   0.287    -.0380232    .1280974
*       _cons |   1.261186   .1205863    10.46   0.000     1.024263    1.498109
*------------------------------------------------------------------------------

predict x3_hat 
*(option xb assumed; fitted values)

regress y x3_hat x1 x2 

*      Source |       SS           df       MS      Number of obs   =       500
*-------------+----------------------------------   F(3, 496)       =     57.37
*       Model |   883.12399         3  294.374663   Prob > F        =    0.0000
*    Residual |  2544.94522       496  5.13093795   R-squared       =    0.2576
*-------------+----------------------------------   Adj R-squared   =    0.2531
*       Total |  3428.06921       499  6.86987818   Root MSE        =    2.2652

*------------------------------------------------------------------------------
*           y |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
*-------------+----------------------------------------------------------------
*      x3_hat |   1.548645   .3439966     4.50   0.000     .8727745    2.224515
*          x1 |   1.176036   .2027187     5.80   0.000     .7777428    1.574329
*          x2 |     2.0053   .1784526    11.24   0.000     1.654684    2.355917
*       _cons |  -1.119821   .3483216    -3.21   0.001    -1.804189   -.4354534
*------------------------------------------------------------------------------
* Comments: we can get similar beta estimates for x3 in (2) and (5)
*          (2SLS beta: 1.547169; Two-step OLS beta: 1.548645)
*          while the standard error on x3 is different in these regressions
*          (2SLS se: 0.1445445;  Two-step OLS se: 0.3439966)


*(6) Test for weak instruments
regress x3 z1 z2 z3 x1 x2

*      Source |       SS           df       MS      Number of obs   =       500
*-------------+----------------------------------   F(5, 494)       =      9.59
*       Model |   43.674665         5    8.734933   Prob > F        =    0.0000
*    Residual |   450.18127       494  .911298117   R-squared       =    0.0884
*-------------+----------------------------------   Adj R-squared   =    0.0792
*       Total |  493.855935       499  .989691252   Root MSE        =    .95462

*------------------------------------------------------------------------------
*          x3 |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
*-------------+----------------------------------------------------------------
*          z1 |    -1.2994    .197159    -6.59   0.000    -1.686774   -.9120265
*          z2 |   .1876212    .090886     2.06   0.040     .0090503    .3661921
*          z3 |   .0453337   .0424039     1.07   0.286    -.0379805     .128648
*          x1 |   .0350198   .0854926     0.41   0.682    -.1329542    .2029937
*          x2 |   .0039242    .075344     0.05   0.958    -.1441101    .1519585
*       _cons |    1.24099    .143537     8.65   0.000     .9589713    1.523008
*------------------------------------------------------------------------------
test z1
*( 1)  z1 = 0
*       F(  1,   494) =    43.44
*            Prob > F =    0.0000
test z2
*( 1)  z2 = 0
*       F(  1,   494) =    4.26
*            Prob > F =    0.0395
test z3
*( 1)  z3 = 0
*       F(  1,   494) =    1.14
*            Prob > F =    0.2855

* Comments: Note that the F-statistic for the joint significance of z1 is 43.44 which is > 10, 
*           This evidence against the case that z1 is a weak instrument;
*           While the F-statistic for z2 and z3 are 4.26 and 1.14, which are < 10,
*           suggesting that z2 and z3 are weak instruments. 


*(7) Calculate 2SLS estimates without using weak instrumental variables
ivregress 2sls y x1 x2 (x3 = z1) 

*Instrumental variables (2SLS) regression          Number of obs   =        500
*                                                  Wald chi2(3)    =    1077.70
*                                                  Prob > chi2     =     0.0000
*                                                  R-squared       =     0.8808
*                                                  Root MSE        =     .90395

*------------------------------------------------------------------------------
*           y |      Coef.   Std. Err.      z    P>|z|     [95% Conf. Interval]
*-------------+----------------------------------------------------------------
*          x3 |   1.620421   .1454039    11.14   0.000     1.335435    1.905408
*          x1 |   1.119831   .0810009    13.82   0.000     .9610722     1.27859
*          x2 |   2.001232   .0711966    28.11   0.000     1.861689    2.140775
*       _cons |  -1.139805   .1413642    -8.06   0.000    -1.416874   -.8627365
*------------------------------------------------------------------------------
*Instrumented:  x3
*Instruments:   x1 x2 z1

* Comments: Compare to (2), the R-squared of (7) is higher, which means it fits better than (2).


log close
******************************************************************************
* Thank you for reading! Feel free making comments! Have a good day!
******************************************************************************
* The End















