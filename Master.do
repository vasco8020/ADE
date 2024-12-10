*******************************************************************************
* QSAmaster.do
* Purpose: this is the master file for all Stata code
*******************************************************************************

* Setup

clear
set more off

* Set directory locations

global Data= "...ReplicationArchive/data"

global Analysis "...ReplicationArchive/analysis"

* Set directory to Github

cd "$Analysis/source"


* Check whether all .ado files are present

sysdir set PLUS "$Analysis/ado"

foreach x in estwrite estout labutil moremata egenmore ietoolkit ivreg2 ranktest ebalance distplot moss coefplot cibar binscatter erepost ciplot {
	capture findfile `x'.ado
	if _rc==601 {
		ssc install `x', replace
	}
}

capture findfile grc1leg.ado
	if _rc==601 {
	net from http://www.stata.com
	net cd users
	net cd vwiggins
	net install grc1leg
}

***********
*** QSA ***
***********

include "$Analysis/source/QSAdataPrep.do"
include "$Analysis/source/QSAmakeTablesAndFigures.do"

**********************
*** Misperceptions ***
**********************

* Misp Data Prep
include "$Analysis/source/MispDataPrep.do"
include "$Analysis/source/MispMakeTablesAndFigures.do"

* Misp V1 Data Prep
include "$Analysis/source/MispDataPrepV1.do"
include "$Analysis/source/MispMakeTablesAndFiguresV1.do"
