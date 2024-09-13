# Modified-WSS-simulation-code
judgeH, sheardistribution, AWSS

Three functions have been added to help better optimise the experimental parameters. These modifications are detailed in the following functions:
1.	judgeH: Determining whether the fluid height is greater than 0 throughout the duration of the shear application (i.e., to ensure that the cells are covered by medium).
2.	sheardistribution: Obtaining the shear stress distribution by traversing each location within the cylinder.
3.	AWSS: Plotting the time-averaged wall shear stress (TAWSS) and maximum wall shear stress (maxWSS) over an oscillation period as a function of radial distance. Here, TAWSS refers to the average magnitude of shear stress experienced within an oscillation period in a specific location, whereas maxWSS means the highest shear stress at the same location within that period.

The above three files call the PTStokes function, which, as well as the original code, can be found at the following link:
https://zenodo.org/records/1186255
