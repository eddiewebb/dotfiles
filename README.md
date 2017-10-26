# Multiple .dotfiles repos

## What is it?
See [.dotfiles](https://github.com/eddiewebb/dotfiles) for info on the main project, this branch has instructions to support multiple sibling repos and sample alteration to [install.sh](install.sh)


## What's it look like?

Notice we have a ~/dotfiles and a ~/teamdotfiles folder.  Each are unique git repos.  The former is private and restricted, the latter is public and shared


```
my-rad-machine:~ ollitech$ ls -la ~
total 12360
drwxr-xr-x+   80 ollitech  staff     2720 Oct 25 13:43 .
drwxr-xr-x     6 root      admin      204 Jan 23  2016 ..
lrwxr-xr-x     1 ollitech  staff       43 Oct 25 13:43 .bash_profile -> /Users/ollitech/dotfiles/home/.bash_profile
lrwxr-xr-x     1 ollitech  staff       40 Oct 25 13:43 .gitconfig -> /Users/ollitech/dotfiles/home/.gitconfig
lrwxr-xr-x     1 ollitech  staff       40 Oct 25 13:43 .gitprompt -> /Users/ollitech/teamdotfiles/home/.gitprompt
...
drwxr-xr-x     7 ollitech  wheel      238 Oct 25 10:21 dotfiles  # <- this git repo
drwxr-xr-x     7 ollitech  wheel      238 Oct 25 10:21 teamdotfiles  # <- also this repo, but different files and shared
...
```

### Note:
Just be sure the various ~/[reponame]/home folders don't include overlapping file names. 

## Usage

### sharing/saving new files (for additional repositories)
instead of saving/editing files in ~/ you place the ones you want shared in ~/teamdotfiles/home, and the script manages symlinks.  THis let's you keep only the files you want in sync with remote repo.

#### additional repositories
```
mv [.shareddotfilename or folder] ~/teamdotfiles/home
cd ~/teamdotfiles
git commit -am"added new file [.shareddotfilename or folder]"
git push
```


### setting up new machine (from existing repo)

```
cd ~
bash dotfiles/install.sh
git clone [ANOTHER repo URL] teamdotfiles # shared
bash teamdotfiles/install.sh

```

