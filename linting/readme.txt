This is a small modification to the regex for linting support for verilog                                                             
It was taken from ALE linter                                                                                                          
The regex doesnt work for modelsim/questasim on Windows due to issues in path handling (forward-back slash  & root folder problems)   
The fix was taken from here:  https://github.com/dense-analysis/ale/issues/3340                                                       
The changes have been made to lines 38 & 55 of this file                                                                              
The original regex has been put in comments on lines 37 & 54 respectively(just above the corrected regex)                             
                                                                                           
This file must be placed/replaced in the folder "ale_linters/verilog"                     
These folder are located inside the ale folder in the vim plugins location                                                            
                                                                                           
This file is otherwise untouched
