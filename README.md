# vim_dotfiles

Install Vundle Plugin Manager first:https://github.com/VundleVim/Vundle.vim (installation instructions)


Contains vim dotfiles configured for verilog, C++


Note: you will need to install verilator for linting features.
You can also use icarus verilog as a linter - change verilator to iverilog in .vimrc


Also contains syntax highlightinf for UPF2.0, SDC, CPF formats 


For C++ autocomplete, you will have to navigate to youcompleteme folder : ~/.vim/bundle/youcompleteme
Then execute $python3 ./install.py --clangd-completer 

Note: you will have to install clangd package. In ubuntu: $ sudo apt install clangd


Here are the commands:

$ cd ~/.vim/bundle/youcompleteme

$ python3 ./install.py --clangd-completer

Note: --clang-completer was used a few years ago.It has since changed to --clangd-completer


Extract syntax highlighting files for UPF, SDC to ~/.vim/syntax

UPF syntax files ownloaded from : https://www.vim.org/scripts/script.php?script_id=5420

