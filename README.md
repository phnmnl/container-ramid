# wframid
Version: 1.0

## Short description
Docker container of RaMID, R-program for extracting mass isotopomer spectra from raw data in CDF files

## Description

RaMID is a computer program designed to read the machine-generated files saved in netCDF format containing registered time course of m/z chromatograms. It evaluates the peaks of mass isotopomer distribution (MID) making them ready for further correction for natural isotope occurrence.
RaMID is written in “R”, uses library “ncdf4” (it should be installed before the first use of RaMID)  and contains several functions, located in the files “ramid.R” and "libcdf.R", designed to read cdf-files, and analyze and visualize  the spectra that they contain.

## Key features

- primary processing of 13C mass isotopomer data obtained with GCMS

## Functionality

- Preprocessing of raw data
- initiation of workflows

## Approaches

- Isotopic Labeling Analysis / 13C
    
## Instrument Data Types

- MS

## Data Analysis

RaMID reads the CDF files presented in the working directory, and then
- separates the time courses for selected m/z peaks corresponding to specific mass isotopomers;
- corrects baseline for each selected mz;
- choses the time points where the distribution of peaks is less contaminated by other compounds and thus is the most representative of the real analyzed distribution of mass isotopomers;
- evaluates this distribution, and saves it in files readable by MIDcor, a program, which performs the next step of analysis, i.e. correction of the RaMID spectra for natural isotope occurrence, which is necessary to perform a fluxomic analysis.
- correction for H+ loss produced by electron impact, natural occurring isotopes, and peaks overlapping

## Screenshots

- screenshot of input data (format Metabolights), output is the same format with one more column added: corrected mass spectrum

![screenshot]()

## Tool Authors

- Vitaly Selivanov (Universitat de Barcelona)

## Container Contributors

- [Pablo Moreno](EBI)

## Website

- N/A

## Git Repository

- https://github.com/seliv55/RaMID

## Installation

- 1) Docker image. To create the Docker container: i) go to the directory where the dockerfile is;
              ii) create container from dockerfile:
''' sudo docker build -t ramidcor:0.1 .  '''

## Usage Instructions

 # To run MIDcor as a docker image, execute
 
 '''  sudo docker run -i -t -v $PWD:/data ramidcor:0.1 -i /data/input.csv -o /data/output.csv '''
 
  #In the presented example we provided an input file "Anusha-hypoxia.csv"


