{smcl}
{* *! version 0.98  19 Mar 2020}{...}
{viewerdialog sgpv "dialog sgpv"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "SGPV Value Calculations" "help sgpvalue"}{...}
{vieweralsosee "SGPV Power Calculations" "help sgpower"}{...}
{vieweralsosee "SGPV False Confirmation/Discovery Risk" "help fdrisk"}{...}
{vieweralsosee "SGPV Plot Interval Estimates" "help plotsgpv"}{...}
{viewerjumpto "Syntax" "sgpv##syntax"}{...}
{viewerjumpto "Description" "sgpv##description"}{...}
{viewerjumpto "Options" "sgpv##options"}{...}
{* viewerjumpto "Remarks" "sgpv##remarks"}{...}
{viewerjumpto "Examples" "sgpv##examples"}{...}
{title:Title}
{phang}
{bf:sgpv} {hline 2} A wrapper command for calculating the Second-Generation P-Values and their associated diagnosis.  

{marker syntax}{...}
{title:Syntax}
{p 8 17 2}
{cmdab:sgpv}
[{help sgpv##menuInstall:menuInstall}]
[{cmd:,}
{it:options}] [{cmd::} {help sgpv##estimation_command:{it:estimation_command}}]

{synoptset 25 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Main}
{p2coldent :* {opt replay}} the default behaviour if no estimation command, matrix or stored estimate is set.
{p_end}
{p2coldent :* {opt e:stimate(name)}}  takes the name of a previously stored estimation.
{p_end}
{p2coldent :* {opt m:atrix(name)}}  takes the name of matrix as input for the calculation.
{p_end}
{synopt:{opt coef:ficient(string)}}  the coefficients for which the SGPVs and other statistics are calculated.
{p_end}
{* syntab:Null hypothesis}
{synopt:{opt nulllo(#)}}  change the upper limit of the null-hypothesis interval.
{p_end}
{synopt:{opt nullhi(#)}}  change the lower limit of the null-hypothesis interval.
{p_end}

{syntab:Display}
{synopt:{opt q:uietly}}  suppress the output of the estimation command.
{p_end}
{synopt:{opt matl:istopt(string asis)}}  change the options of the displayed matrix. 
{p_end}
{synopt:{opt nob:onus(string)}}  deactivate the display and calculation of bonus statistics like delta gaps and fdr/fcr. 
{p_end}

{syntab:Fdrisk}
{synopt:{opt altw:eights(string)}}  probability distribution for the alternative parameter space.
{p_end}
{synopt:{opt alts:pace(string)}}  support for the alternative probability distribution.
{p_end}
{synopt:{opt nulls:pace(string)}}  support of the null probability distribution.
{p_end}
{synopt:{opt nullw:eights(string)}}  probability distribution for the null parameter space.
{p_end}
{synopt:{opt intl:evel(string)}}  level of interval estimate.
{p_end}
{synopt:{opt intt:ype(string)}}  class of interval estimate used.
{p_end}
{synopt:{opt p:i0(#)}}  prior probability of the null hypothesis.
{p_end}

{syntab:menuInstall}
{synopt:{opt perm}} install permanently the dialog boxes into the User menubar.
{p_end}
{synoptline}
{p2colreset}{...}
{marker estimation_command}{...}
{p 4 6 2}
{it:estimation_command} can be any of Stata's or user-provided estimation commands which return their results in a matrix named {it:r(table)}.
This should be true so long the estimation command runs {help ereturn display:ereturn display} at some point.
If you want to calculate SGPVs for an estimation command or any other command which does not follow this convention, then you can use the {it: matrix(matrixname)} option. The matrix must be pre-processed to meet the expectations of {cmd:sgpv}.
 See the description {help sgpv##matrix_opt:here} for more information.
 
 {p 4 6 2}
 * ONLY one thing can be used to calculate the SGPVs: an estimation command, the results from the previous estimation command, a stored estimation result or a matrix with the necessary information.
 

{marker description}{...}
{title:Description}
{pstd}
{cmd:sgpv} allows the calculation of the Second-Generation P-Values (SGPV) developed by Blume et.al.(2018,2019) for and after commonly used estimation commands. 
The false discovery/confirmation risks (fdr/fcr) can be also reported. 
The SGPVs are reported alongside the usually reported p-values. {break}
An ordinary user should use this command and not other commands on which {cmd:sgpv} is based upon. 
{cmd:sgpv} uses sensible default values for calculating the SGPVs and the accompaning fdr/fcr, which can be changed.  
This wrapper command runs commands which are based on the original R-code from for the sgpv-package from {browse "https://github.com/weltybiostat/sgpv"}. 
This package comes also with the example leukemia dataset from {browse "https://github.com/ramhiser/datamicroarray/wiki/Golub-(1999)"}.{break}
Dialog boxes for each command are also provided to make the usage of the commands easier.
The dialog boxes can be installed into the User menubar. 
See {help sgpv##menuInstall:this example} for how to do it.{p_end}

{pstd}
For more information about how to interpret the SGPVs and other common questions, 
see {browse "https://journals.plos.org/plosone/article/file?id=10.1371/journal.pone.0188299.s002&type=supplementary":Frequently Asked Questions} by Blume et al. (2018).
An example of how to interpret the result from {cmd:sgpv} can be found in the {help sgpv##interpretation_example:examples section} of this help file.{p_end}

{pstd}
The formulas for the Second-Generation P-Values can be found {help sgpv##formulas:here}.{p_end}

{marker options}{...}
{title:Options}
{dlgtab:Main}
{phang}
{opt replay} the default behaviour if no estimation command, matrix or stored estimate is set. 
There is {bf:no} explicit replay option but instead {cmd:sgpv} behave like any other estimation command (e.g. {helpb regress}) which replays the previous results when run without a varlist.
At the moment, the results from previous runs of {cmd:sgpv} are {bf:not} used to display the results. Instead, the results are calculated fresh on every run of {cmd:sgpv}.{break}
To see the results from a previous run of {cmd:sgpv} without recalculation, you can run something like {stata matlist r(comparison)}.
This works only if no other commands did run after {cmd:sgpv}.

{phang} ONLY one thing can be used to calculate the SGPVs: an estimation command, the results from the previous estimation command, a stored estimation result or a matrix with the necessary information.

{phang}
{opt e:stimate(name)}     takes the name of a previously stored estimation.

{phang}
{opt coef:ficient(string)}  allows the selection of the coefficients for which the SGPVs and other statistics are calculated. 
The selected coefficients need to have the same names as displayed in the estimation output.
Multiple coefficients must be separated with a space.

{phang}
{marker matrix_opt}
{opt m:atrix(name)}  takes the name of matrix as input for the calculation. 
The matrix must follow the structure of the r(table) matrix returned after commonly used estimation commands due to the hardcoded row numbers used for identifiying the necessary numbers. 
Meaning that the parameter estimate has to be in the 1st row, the standard errors need to be in the 2nd row, the p-values in 4th row, the lower bound in the 5th and the upper bound in the 6th row.
As additional check, the row names of the supplied matrix need to match the rownames of the r(table) matrix.
The rownames are: b se t pvalue ll ul{break}
To the set rownames run: mat rownames <your matrix> =  b se t pvalue ll ul {break}
Example code is located in the file {cmd:sgpv-leukemia-example.do} which can be viewed {stata viewsource sgpv-leukemia-example.do:here}.
To run the example code, go to the respective {help sgpv##leukemia-example:example section}.


{phang}
{opt nulllo(#)}  change the upper limit of the null-hypothesis interval. The default is 0. Missing values are not allowed.

{phang}
{opt nullhi(#)}  change the lower limit of the null-hypothesis interval. The default is 0. Missing values are not allowed.

{dlgtab:Display}
{phang}
{opt q:uietly}     suppress the output of the estimation command.

{phang}
{opt matl:istopt(string asis)}     change the options of the displayed matrix. The same options as for {helpb matlist} can be used.

{phang}
{opt nob:onus(string)}     deactivate the display and calculation of bonus statistics like delta gaps and fdr/fcr. Possible values are "deltagap", "fdrisk", "all".

{dlgtab:Fdrisk}
{pstd}These options are only needed for the calculations of the False Confirmation/Discovery Risk. The default values should give sensible results in most situations.{p_end}

{phang}
{opt altw:eights(string)}  probability distribution for the alternative parameter space. Options are "Uniform", and "TruncNormal". The default is "Uniform".

{phang}
{opt alts:pace(string)}  support for the alternative probability distribution.  
If "altweights" is "Uniform" or "TruncNormal", then "altspace" contains two numbers separated by a space. These numbers can be also formulas which must be enclosed in " ".

{phang}
{opt nulls:pace(string)}  support of the null probability distribution. 
If "nullweights" is "Point", then "nullspace" is a single number. 
If "nullweights" is "Uniform" or "TruncNormal", then "nullspace" contains two numbers separated by a space. 
These numbers can be also formulas which must be  enclosed in " ".

{phang}
{opt nullw:eights(string)}  probability distribution for the null parameter space. Options are "Point", "Uniform", and "TruncNormal". 
The default is "Point" if both options {cmd:nulllo()} and {cmd:nullhi()} are set to the same value. 
If the options {cmd:nulllo()} and {cmd:nullhi()} are set to different values, then {cmd:nullweights()} is by default set to "Uniform".

{phang}
{opt intl:evel(string)}  level of interval estimate. If inttype is "confidence", the level is α. If "inttype" is "likelihood", the level is 1/k (not k). The default value is 0.05 for the confidence interval which gives the fdr/fcr for the typically reported 95% confidence interval. 

{phang}
{opt intt:ype(string)}  class of interval estimate used. This determines the functional form of the power function. 
Options are "confidence" for a (1-α)100% confidence interval and "likelihood" for a 1/k likelihood support interval. 
The default is "confidence".

{phang}
{opt p:i0(#)}     prior probability of the null hypothesis. Default is 0.5. This value can be only between 0 and 1 (exclusive). 
A prior probability outside of this interval is not sensible. 
The default value assumes that both hypotheses are equally likely.

{dlgtab: menuInstall}
{phang}
{opt perm} install permanently the dialog boxes into the User menubar. The necessary commands are added to the user's profile.do. If no profile.do exists or can be found then a new profile.do is created in the current directory. Without this option, the dialog boxes will only available from the menubar until the next restart of Stata. The dialog boxes can be accessed as usual by for example {stata db sgpv}.

{marker examples}{...}
{title:Examples}
{* pstd}

  {stata sysuse auto, clear}
{marker prefix}{...}
  Usage of {cmd:sgpv} as a prefix-command:
  {stata "sgpv: regress price mpg weight foreign"} 
  
  Example Output:
  		
  	  Source |       SS           df       MS      Number of obs   =        74
    -------------+----------------------------------   F(3, 70)        =     23.29
  	   Model |   317252881         3   105750960   Prob > F        =    0.0000
  	Residual |   317812515        70  4540178.78   R-squared       =    0.4996
    -------------+----------------------------------   Adj R-squared   =    0.4781
  	   Total |   635065396        73  8699525.97   Root MSE        =    2130.8
  
      ------------------------------------------------------------------------------
  	   price |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
      -----------+------------------------------------------------------------------
  	     mpg |    21.8536   74.22114     0.29   0.769    -126.1758     169.883
  	  weight |   3.464706    .630749     5.49   0.000     2.206717    4.722695
  	 foreign |    3673.06   683.9783     5.37   0.000     2308.909    5037.212
  	   _cons |  -5853.696   3376.987    -1.73   0.087    -12588.88    881.4934
      ------------------------------------------------------------------------------
  
  
  Comparison of ordinary P-Values and Second Generation P-Values
  
       Variables |   P-Value       SGPV  Delta-Gap        Fdr        Fcr 
    -------------+-------------------------------------------------------
    	     mpg |  .7692938         .5          .          .          . 
          weight |  5.99e-07          0   2.206717    .047926          . 
         foreign |  9.72e-07          0   2308.909   .0480251          . 
           _cons |  .0874262         .5          .          .          . 
   
  {marker interpretation_example}{...}
  Interpretation: There is inconclusive evidence for an effect of mpg on price, while there is no evidence for the null-hypothesis of no effect for weight and foreign. 
  Remember that the null-hypothesis is an interval of length 0 with both lower and upper bounds being also 0.
  This is the standard null-hypothesis of no effect.	
  You will usually have a more relastic interval which is larger than 0 due to measurement errors, scientific relevance, etc. 
  The delta-gap can be used to compare two different studies for the same model/estimation when both report second-generation p-values of zero (p_δ = 0).
  So for this example, the delta-gap is not needed, but still provides information about the distance
  between either the upper or the lower bound of the confidence interval and 0.
  Finally, the False Discovery Risk (Fdr) tells you there is a roughly a 5% chance
  that the null-hypothesis is true although you calculated a second-generation p-value of zero (p_δ = 0).
  Whether 5% is much, is for you to decide.
  
  {bf:NB}: Note that the given interpretations are based on my understanding of Blume et.al (2018,2019).
  I cannot guarantee that my understanding is correct.
  These interpretations are just meant as examples how to make sense out of the calculated numbers, but not meant as a definitive answer.	
  
  
  Save estimation for later usage 
	  {stata estimate store pricereg} 

  The same result but this time after the last estimation.
		{stata sgpv} 
		{stata qreg price mpg weight foreign} 
		{stata estimates store priceqreg}

{* pstd}
  Calculate sgpvs for the stored estimation and only the foreign coefficient
	{stata sgpv, estimate(pricereg) coefficient("foreign")} 
	{stata sgpv, estimate(priceqreg) coefficient("foreign")}

{marker leukemia-example}{...}
  Calculate the SGPVs and bonus statistics for the leukemia dataset (view the {view sgpv-leukemia-example.do:code} if installed; if not, you can download it {net "describe sgpv, from(https://raw.githubusercontent.com/skbormann/stata-tools/master/)":here}):
	{stata do sgpv-leukemia-example.do}
	
    This example code is rather slow on my machine and demonstrates some ways around the current limitations of the program code.
    Should your {help matsize:maximum matrix size}  be higher than the number of observations in the dataset (7128), then the example code should run faster. 
    You can run {stata display c(matsize)} to see your current setting.


    
{marker menuInstall}{...}
{* phang}
  Install the dialog boxes permanently in the User menubar: User -> Statistics {* p_end}
	{stata sgpv menuInstall, perm} //	install permanently the dialog boxes into the User menubar. 

{title:Stored results}
Besides its own calculations, {cmd:sgpv} also preserves the returned results from the estimation command including everything returned in r().
{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Matrices}{p_end}
{synopt:{cmd:r(comparison)}}  a matrix containing the displayed results {p_end}

{marker formulas}{...}
{title:Formulas & Interpretation}
{pstd}
The formulas below are taking from the help-files of {helpb sgpvalue} and {helpb fdrisk}.
An example about how to interpret the results is given in the {help sgpv##interpretation_example:example section} .
{p_end}

 {col 10} The SGPV is defined as : 	p_δ  = |I ∩ H_0|/|I|*max{|I|/(2|H_0|), 1} 
{col 10}				    = |I ∩ H_0|/|I| 		when |I|<=2|H_0| 
	{col 10}				    = 1/2*|I ∩ H_0|/|I| 	when |I|> 2|H_0| 
		{col 10}		      with I = {θ_l,θ_u} and |I|= θ_u - θ_l.  
								 
{pstd}								 
θ_u and θ_l are typically the upper and lower bound of a (1-α)100% confidence interval but any other interval estimate is also possible. {break}
H_0 is the null hypothesis and |H_0| its length. {break}
The null hypothesis should be an interval which contains all effects that are not scientifically relevant. {break}
The p-values reported by most of Stata's estimation commands are based on the null hypothesis of a parameter being exactly 0. {break}
Point null-hypothesis are supported by SGPVs, but they are discouraged. 
See answer 11 in the {browse "https://journals.plos.org/plosone/article/file?id=10.1371/journal.pone.0188299.s002&type=supplementary":Frequently asked questions} to Blume et al. (2018).
You could set a small null-hypothesis interval which includes effects of less than 1% or 0.1%. The exact numbers depend on what you deem a priori as not scientifically relevant.

{pstd}
p_δ lies between 0 and 1. {break}
A p_δ of 0 indicates that 0% of the null hypotheses are compatible with the data.  {break} 
A p_δ of 1 indicates that 100% of the null hypotheses are compatible with the data. {break}
A p_δ between 0 and 1 indicates inconclusive evidence. {break}
A p_δ of 1/2 indicates strictly inconclusive evidence.  {break} 

{pstd}
For more information about how to interpret the SGPVs and other common questions, 
see {browse "https://journals.plos.org/plosone/article/file?id=10.1371/journal.pone.0188299.s002&type=supplementary":Frequently Asked Questions} by Blume et al. (2018).

{pstd}
The delta-gap is have a way of ranking two studies that both have second-generation p-values of zero (p_δ = 0). It is defined as the distance between the intervals in δ units with δ being the half-width of the interval null hypothesis.{p_end}

		The delta-gap is calculated as: gap   	  = max(θ_l, H_0l) - min(H_0u, θ_u) 
						delta 	  = |H_0|/2 
						delta.gap = gap/delta 
								
    For the standard case of a point 0 null hypothesis and a 95% confidence interval, delta is set to be equal to 1. 
    Then the delta-gap is just the distance between either the upper or the lower bound of the confidence interval and 0. 
    If both θ_u and θ_l are negative then, the delta-gap is just θ_u, the upper bound of the confidence interval. 
    If both bounds of the confidence interval are positive, then the delta-gap is equal to the lower bound of the confidence interval.
		
    The false discovery risk is defined as: 	P(H_0|p_δ=0) = (1 + P(p_δ = 0| H_1)/P(p_δ=0|H_0) * r)^(-1)
    The false confirmation risk is defined as: 	P(H_1|p_δ=1) = (1 + P(p_δ = 1| H_0)/P(p_δ=1|H_1) * 1/r )^(-1)
    with r = P(H_1)/P(H_0) being the prior probability.	
    See equation(4) in Blume et.al.(2018)

{pstd}

{title:References}
{pstd}
 Blume JD, D’Agostino McGowan L, Dupont WD, Greevy RA Jr. (2018). Second-generation {it:p}-values: Improved rigor, reproducibility, & transparency in statistical analyses. {it:PLoS ONE} 13(3): e0188299. 
{browse "https://doi.org/10.1371/journal.pone.0188299"}

{pstd}
Blume JD, Greevy RA Jr., Welty VF, Smith JR, Dupont WD (2019). An Introduction to Second-generation {it:p}-values. {it:The American Statistician}. In press. {browse "https://doi.org/10.1080/00031305.2018.1537893"} 


{title:Author}
{p}

Sven-Kristjan Bormann, School of Economics and Business Administration, University of Tartu.

{title:Bug Reporting}
{psee}
Please submit bugs, comments and suggestions via email to:	{browse "mailto:sven-kristjan@gmx.de":sven-kristjan@gmx.de}{p_end}
{psee}
Further Stata programs and development versions can be found under {browse "https://github.com/skbormann/stata-tools":https://github.com/skbormann/stata-tools} {p_end}


{title:See Also}
Related commands:
 {help plotsgpv}, {help sgpvalue}, {help sgpower}, {help fdrisk}  
