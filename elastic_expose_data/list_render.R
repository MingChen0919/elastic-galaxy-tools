##============ Sink warnings and errors to a file ==============
## use the sink() function to wrap all code within it.
##==============================================================
zz = file(Sys.getenv('TOOL_LOG'))
sink(zz)
sink(zz, type = 'message')

#------------import libraries--------------------
options(stringsAsFactors = FALSE)

library(rmarkdown)
#------------------------------------------------

#------------------------------------------------
options_and_arguments = read.table(paste0(Sys.getenv('REPORT_FILES_PATH'), '/options_and_arguments.txt'), 
                                   sep = '|', header = TRUE)

#------------------------------------------------
# create three folders within working directory
dir.create('list')

job_working_dir = getwd()
list_path = paste0(job_working_dir, '/list/')

#-----------------render Rmd--------------
# copy R markdown file to working directory and render it within the working directory.
render(paste0(Sys.getenv('TOOL_INSTALL_DIR'), '/list.Rmd'),
       output_file = paste0(Sys.getenv('REPORT_FILES_PATH'), '/report.html'))

# for some unknow reason, directly using REPORT as the input value for output_file parameter
# in the render function can cause empty report file when the tool runs in batch mode.
# the solution is to render the rmarkdown to a explicitly specified file and then copy the
# file to ${REPORT}
system(command = 'cp ${REPORT_FILES_PATH}/report.html ${REPORT}')
# system(command = 'sh ${REPORT_FILES_PATH}/script.sh')
#------------------------------------------


##--------end of code rendering .Rmd templates----------------
sink()
##=========== End of sinking output=============================