# Parameter estimation and sensitivity analysis framework for colon cancer (An NCI-NIH funded project)
Codes for parameter estimation and sensitivity analysis of QSP models for colon cancer. 
The current model is based on the paper by dePillis et. al. (2014), "Mathematical Model of Colorectal Cancer with Monoclonal Antibody Treatments", doi:10.9734/BJMMR/2014/8393 

This is a part of the National Cancer Institute-NIH funded project titled "Data-driven QSP software for personalized colon cancer treatment"
Grant number: R21 CA242933-01

Developers: Achyuth Manoj, Susanth Kakarla, Suvra Pal and Souvik Roy.

# Description of the files:

DRIVER.m: The main file to run a optimization algorithm for estimating parameters

forward.m: Solves the forward ODE QSP model for colon cancer

adjoint.m: solves the adjoint ODE 

data.m: Generates the patient data to be fed in as input for the optimization setup

J.m: Functional to be minimized that includes the data-fitting least squares terms and regularization terms

gradient.m: Computes the gradient of the reduced functional

optim.m: Optimization solver

lin_search.m: Line search algorithm required for the gradient step of the optimization solver

inner_g.m: Computes the inner product of 2 vectors

parameters.m: Contains the list of all the known and user defined parameter values for the colon cancer model

# Description of the pdf file
The pdf file is the summary of the actual paper under preparation based on which the codes have been developed.
