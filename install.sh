#!/bin/bash

# Creates symlinks for all folders in ./home, displacing existing files if present.
# You only need to run this on new machines, or after pulls (to add any new dotfiles)




dotfiles_dir=~/dotfiles/home   # change this if you checked out repo under different name      
backup_dir=~/dotfiles_bak       
files=$(ls -A ${dotfiles_dir})   


echo "Files and folders to symlink/overwrite:"
for file in $files;do
	echo -e "\t$file"
done
read -rep $'Press [Enter] to continue these files, otherwise press CTRL+C:\n>'
##########

# create backup_dir in homedir
echo "Creating $backup_dir for backup of any existing dotfiles in ~"
mkdir -p $backup_dir
echo -e "\t...done"

# change to the dotfiles directory
cd $dotfiles_dir

echo ""

# move any existing dotfiles in homedir to backup_dir directory, then create symlinks 
for file in $files; do
    echo -e "Creating symlink to $file in home directory."
    if [ -L ~/$file ];then
    	target=$(stat -f %Y ~/$file)
    	if [ "$dotfiles_dir/$file" == "$target" ];then
    		echo -e "\tSymlink already exists, done."
    		continue
    	else
    		echo -e "\tSymlink already points to $target, it will be replaced by path $dotfiles_dir/$file"
    		rm ~/$file
    	fi
    elif [ -s ~/$file ]; then
    	echo -e "\t Moving existing file to $backup_dir/$file"
    	mv ~/$file $backup_dir/
    fi
    ln -s $dotfiles_dir/$file ~/$file
    echo -e "\t~/$file -> $dotfiles_dir/$file"
done

#back to where ya started!
cd - >/dev/null
echo -e "\nAll Set! Results:"
ls -la ~ | grep lrw 