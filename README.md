# Q_entropy_portfolio: A Software to Estimate Tsallis (q) Relatve Entropy as a 'Relative Risk' Measure of a Portfolio (Relative to a Market Index)

## Author/Developer:     Sandhya Devi     4/20/2019
### Reference: The algorithm is described in the publications
### 1.  Financial Market Dynamics: Superdiffusive or not?,  Sandhya Devi, Journal of Statistical Mechanics (2017) 083207
###     http://dx.doi.org/10.1088/1742-5468/aa8199 (abstract can be found at this location).
### The paper can also be found in arXiv.org under the title given above. 
    
### 2.  Financial Portfolios based on Tsallis Relative Entropy as the Risk Measure 
###   arXiv:1901.04945 

##  Contact: For questions and help in using this software sdevi@entropicdynamics.com

## The software is developed in OCTAVE (which is compatible with MATLAB). The executable for OCTAVE can be downloaded from https://www.gnu.org/software/octave


## Scope: 
### The Tsallis relative entropy can be used as a risk measure for constructing managed portfolios that likely exceed Market Returns over a reasonably long period (ex:  >= 3 yrs)

## Disclaimer
### This is a research Software. The software is tested on S&P 500 and Nasdaq stocks.
### This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 3 of the License, or (at your option) any later version. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details. see http://www.gnu.org/licenses/.

## Data 

### The data required to run this software is the stock/bond data in .csv format. It should have two headers followed by data. 
### ex:
### Ticker symbol
### date  open  High  Low  Close  Adj_close  Volume
### 1-4-1995 459.209991	459.269989	457.200012	459.109985	459.109985	262450000
### The date is treated as having 3 columns. The data columns are 4 -9 Any of the data columns 4-8 can be used for the analysis. Default(preferred)  is 8  since it is adjusted for dividend and splits. Also the data should not have 'null' characters in it.

### Two  sets of data are needed. 1) Reference data (usually a market index, ex: S&P 500, nasdaq ----) and 2) Individual equities data fom which to construct the portfolio. 

##	Usage of the Software

###  General Usage:
###  [ outfil ] = qportfolio_main(ref_file, stk_port, out_path, mm1, dd1, yr1, num_turnover, nd_b, col) 

###  Minimal Usage
###  [ outfil ] = qportfolio_main(ref_file, stk_port, out_path, mm1, dd1, yr1)

## Input:
##
### Mandatory Input
###
### ref_file: Name of the reference file containing index data (preferably daily data) in .csv format
### ex: ref_file = '\fullpath\refdat.csv'
### stk_port:  List of names of the files for portfolio construction
### ex: '\fullpath\*.csv' 
### out_path: Name of the directory path to which the output file containing
### risk estimates to be written;
### ex: '\fullpath\' 
### mm1, dd1, yr1: month, day, year of the date when investment starts.
### (ex: today's date)
## num_turnover: Portfolio turn over time in days. (ex: 66 days (3 mnths), default)

### nd_b: no: of days (samples) to be used for the parameters of Ttsallis
### relative entropy estimation. (min = default 1300 smpls. More the better).
### col: Column of the data to be used (default = 8)

##Output

## outfil: Text file containing the  equity ticker symbol and the risk values
## for all equities provided.
##


