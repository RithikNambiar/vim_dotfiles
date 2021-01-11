"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""                                                                                                                                         ""
""                                                                                                                                         ""
""   This is a small modification to the regex for linting support for verilog                                                             ""
""   It was taken from ALE linter                                                                                                          ""
""   The regex doesnt work for modelsim/questasim on Windows due to issues in path handling (forward-back slash  & root folder problems)   ""
""   The fix was taken from here:  https://github.com/dense-analysis/ale/issues/3340                                                       ""
""   The changes have been made to lines 38 & 55 of this file                                                                              ""
""   The original regex has been put in comments on lines 37 & 54 respectively(just above the corrected regex)                             ""
""                                                                                                                                         ""
""   This file must be placed/replaced in the folder "ale_linters/verilog"                                                                 ""
""   These folder are located inside the ale folder in the vim plugins location                                                            ""
""                                                                                                                                         ""
""   This file is otherwise untouched                                                                                                      ""
""                                                                                                                                         ""
""                                                                                                                                         ""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



" Author:      John Gentile <johncgentile17@gmail.com>
" Description: Adds support for Mentor Graphics Questa/ModelSim `vlog` Verilog compiler/checker

call ale#Set('verilog_vlog_executable', 'vlog')
" See `$ vlog -h` for more options
call ale#Set('verilog_vlog_options', '-quiet -lint')

function! ale_linters#verilog#vlog#GetCommand(buffer) abort
    return '%e ' . ale#Pad(ale#Var(a:buffer, 'verilog_vlog_options')) . ' %t'
endfunction

function! ale_linters#verilog#vlog#Handle(buffer, lines) abort
    "Matches patterns like the following:
    "** Warning: add.v(7): (vlog-2623) Undefined variable: C.
    "** Error: file.v(1): (vlog-13294) Identifier must be declared with a port mode: C.
    "let l:pattern = '^**\s\(\w*\):[a-zA-Z0-9\-\.\_\/ ]\+(\(\d\+\)):\s\+\(.*\)'        "ORIGINAL REGEX
    let l:pattern = '^**\s\(\w*\):[a-zA-Z0-9\-\.\_\/:~ ]\+(\(\d\+\)):\s\+\(.*\)'       "MODIFIED REGEX
    "https://github.com/dense-analysis/ale/issues/3340   to know more about the reason the original regex has been modified, go to this link
    let l:output = []

    for l:match in ale#util#GetMatches(a:lines, l:pattern)
        call add(l:output, {
        \   'lnum': l:match[2] + 0,
        \   'type': l:match[1] is? 'Error' ? 'E' : 'W',
        \   'text': l:match[3],
        \})
    endfor

    "Matches patterns like the following:
    "** Warning: (vlog-2623) add.v(7): Undefined variable: C.
    "** Error: (vlog-13294) file.v(1): Identifier must be declared with a port mode: C.
    " let l:pattern = '^**\s\(\w*\):[a-zA-Z0-9\-\.\_\/ ]\+(\(\d\+\)):\s\+\(.*\)'
    "let l:pattern = '^**\s\(\w*\):\s\([^)]*)\)[a-zA-Z0-9\-\.\_\/ ]\+(\(\d\+\)):\s\+\(.*\)'        "ORIGINAL REGEX
     let l:pattern = '^**\s\(\w*\):\s\([^)]*)\)[a-zA-Z0-9\-\.\_\/:~ ]\+(\(\d\+\)):\s\+\(.*\)'      "MODIFIED REGEX

    for l:match in ale#util#GetMatches(a:lines, l:pattern)
        call add(l:output, {
        \   'lnum': l:match[3] + 0,
        \   'type': l:match[1] is? 'Error' ? 'E' : 'W',
        \   'text': l:match[2] . ' ' . l:match[4],
        \})
    endfor

    return l:output
endfunction

call ale#linter#Define('verilog', {
\   'name': 'vlog',
\   'output_stream': 'stdout',
\   'executable': {b -> ale#Var(b, 'verilog_vlog_executable')},
\   'command': function('ale_linters#verilog#vlog#GetCommand'),
\   'callback': 'ale_linters#verilog#vlog#Handle',
\})
