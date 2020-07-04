# Parameter estimation and sensitivity analysis framework for colon cancer (An NCI-NIH funded project)
Codes for parameter estimation and sensitivity analysis of QSP models for colon cancer. 
Though the current model is a modification of the one given in the paper by dePillis et. al. (2014), "Mathematical Model of Colorectal Cancer with Monoclonal Antibody Treatments", doi:10.9734/BJMMR/2014/8393, the codes are generic as they can be appropriately modified for any QSP model.

This is a part of the National Cancer Institute-NIH funded project titled "Data-driven QSP software for personalized colon cancer treatment"
Grant number: R21 CA242933-01

Developers: Achyuth Manoj, Susanth Kakarla, Suvra Pal and Souvik Roy.

# Description of the files:
PARAMETER ESTIMATION-

DRIVER.m: The main file to run a optimization algorithm for estimating parameters.

forward.m: Solves the forward ODE QSP model for colon cancer. Should modify if the QSP model changes.

adjoint.m: solves the adjoint ODE. Should modify if the QSP model changes.

data.m: Generates the patient data to be fed in as input for the optimization setup. Should modify if the QSP model changes.

J.m: Functional to be minimized that includes the data-fitting least squares terms and regularization terms. Should modify if the QSP model changes.

gradient.m: Computes the gradient of the reduced functional. Should modify if the QSP model changes.

optim.m: Optimization solver.

lin_search.m: Line search algorithm required for the gradient step of the optimization solver.

inner_g.m: Computes the inner product of 2 vectors.

parameters.m: Contains the list of all the known and user defined parameter values for the colon cancer model. Should modify if the QSP model changes.

SENSITIVTY ANALYSIS-

LHS.m: Computes the Latin hypercube samples (LHS) of the uncertain parameters obtained from the optimization step.

Weibull_par.m: Computes the LHS for a given uncertain parameter using a Weibull distribution.

Newton.m: Computes the scale and the shape parameter of a Weibull distribution in a given interval.

par_corr.m: Computes the PRCC of the uncertain parameters with respect to the tumor cell count.

# Description of the pdf file
The pdf file is the summary of the actual paper under preparation based on which the codes have been developed.
