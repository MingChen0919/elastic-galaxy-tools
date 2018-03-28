##============ Sink warnings and errors to a file ==============
## use the sink() function to wrap all code within it.
##==============================================================
zz = file(Sys.getenv('TOOL_LOG'))
sink(zz)
sink(zz, type = 'message')

#------------import libraries--------------------
options(stringsAsFactors = FALSE)

library(rmarkdown)
library(tidyverse)
#------------------------------------------------

#------------------------------------------------
arguments = read.table(paste0(Sys.getenv('REPORT_FILES_PATH'), '/arguments.txt'),
                                   sep = '|', header = TRUE)


#-----------------render Rmd--------------
render(paste0(Sys.getenv('TOOL_INSTALL_DIR'), '/elastic_r_package.Rmd'),
       output_file = paste0(Sys.getenv('REPORT_FILES_PATH'), '/report.html'))

# for some unknow reason, directly using REPORT as the input value for output_file parameter
# in the render function can cause empty report file when the tool runs in batch mode.
# the solution is to render the rmarkdown to a explicitly specified file and then copy the
# file to ${REPORT}
system(command = 'cp ${REPORT_FILES_PATH}/report.html ${REPORT}')
#------------------------------------------


##--------end of code rendering .Rmd templates----------------
sink()
##=========== End of sinking output=============================