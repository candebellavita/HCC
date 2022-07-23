# HCC

Para compilar la versión original del código en fortran, escribir en la terminal:

gfortran -O5 -Wall dependencies/*f sco_simpson.f90 sco_global.f90 sco_arrays.f90 sco_mppinv.f90 sco_model.f90 sco_band_integration.f90 sco_par.f90   sco_program.f90 -lopenblas -o scorpio_fortran

Para compilar el código que usa la grilla logarítmica, escribir en la terminal:

gfortran -O5 -Wall dependencies/*f sco_simpson.f90 sco_global.f90 sco_arrays.f90 sco_mppinv.f90 sco_model_LOG.f90 sco_band_integration.f90 sco_par.f90 sco_programLOG.f90 -lopenblas -o scorpio_fortranLOG

Para compilar la versión que la expresión numérica del BB,  escribir en la terminal:

gfortran -O5 -Wall dependencies/*f sco_simpson.f90 sco_global.f90 sco_arrays.f90 sco_mppinv.f90 sco_model_LOGbb.f90 sco_band_integration.f90 sco_par.f90 sco_program_BB.f90 xsbbrd.f -lopenblas -o scorpio_fortranBB

Para compilar la versión que modela la fuente emisora con diskbb, escribir en la terminal:

gfortran -O5 -Wall dependencies/*f sco_simpson.f90 sco_global.f90 sco_arrays.f90 sco_mppinv.f90 sco_model_LOG_dskb.f90 sco_band_integration.f90 sco_par.f90 sco_programDSKB.f90 xsbbrd.f xsdskb.f -lopenblas -o scorpio_fortranDSKB


