#!/bin/bash

# Creates symlinks for all folders in ./home, displacing existing files if present.
# You only need to run this on new machines, or after pulls (to add any new dotfiles)



## Wherever this repo exists will be set as target for symlinks, and get a sibling folder with _bak suffix for any displaced files
this_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
dotfiles_dir=$this_path/home   # change this if you checked out repo under different name      
backup_dir=${this_path}_bak      



 

#########
# show use potential impact before doing anything, this can be omitted.
echo "Files and folders to symlink/overwrite:"
files=$(ls -A ${dotfiles_dir})  
for file in $files;do
    echo -e "\t$file"
done
read -rep $'Press [Enter] to continue these files, otherwise press CTRL+C:\n>'
##########



# why is this so complex?
# It allows multiple repos to use overlapping folder structures without stomping on each other.
function link_it(){
    pushd $1 >/dev/null
    files=$(ls -A .)  
    for file in $files; do
        current_path="$(pwd)/"
        relative_path="${current_path/#$dotfiles_dir}"
        src="$dotfiles_dir$relative_path$file"
        target="$HOME$relative_path$file"
        if [ -d $src ];then
            if [ -L $target ];then
                echo "WARN: $target is currently symlink, and will be converted to directory."
                rm $target
            elif [ ! -d $target ];then
                echo "WARN: $target exists as file, moving to $backup_dir."
                mv $target $backup_dir 2>/dev/null #move existing folder/file to backup
            fi
            # create a real folder, which may already exist, and continue recursive any symlinks
            mkdir $target 2>/dev/null 
            link_it $file
        else
            echo -e "Creating symlink: $target --> $src"
            if [ -L $target ];then
                old_src=$(stat -f %Y $target)
                if [ "$src" == "$old_src" ];then
                    echo -e "\tSymlink already exists, done."
                else
                    echo -e "\tSymlink exists, but points to $old_src, it will be replaced by path $src"
                    rm $target
                fi
            elif [ -s $target ]; then
                echo -e "\t Moving existing file to $backup_dir/$file"
                mv $target $backup_dir/
            fi
            ln -sf $src $target
        fi
    done
    popd >/dev/null
}




# create backup_dir in homedir
echo "Creating $backup_dir for backup of any existing dotfiles in $HOME"
mkdir -p $backup_dir
echo -e "\t...done"


echo ""



# start linking any files within this repo
link_it $dotfiles_dir


#back to where ya started!
cd - >/dev/null
echo -e "\nAll Set! Results:"
ls -la ~ | grep lrw 
