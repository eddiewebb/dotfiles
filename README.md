# .dotfiles

## What is it?
Provides an easy way to manage & sync the common files found in a user's home directory `~/` that are lovingly enhanced over years of use and optimization.
- `scripts` folder
- bash, git or other common tool config

Useful if you use multiple devices/vms or want to share some common config across teams.



**Because multiple "collections" can live next to each other in harmony you can combine repos for private and shared use cases.**

You can browse eddie's [dotfiles-public](https://github.com/eddiewebb/dotfiles-public) for a working example of his publicly safe files. All his `dotfiles-secret` are safely encrypted in a private [keybase git repo](https://keybase.io/blog/encrypted-git-for-everyone)

## How it is different than [insert other dotfiles refernce]?
Unlike most dotfile projects:
1) I make no assumptions about *what* files or config you want, I just enable the how.
2) I allow to repeat this pattern for many collections/folders so you can have some private, and some shared.


## What's it look like?
In simplest it just is one or many git repos in ~/ that manage symlinks for you.

```
my-rad-machine:~ ollitech$ ls -la ~
total 12360
drwxr-xr-x+   80 ollitech  staff     2720 Oct 25 13:43 .
drwxr-xr-x     6 root      admin      204 Jan 23  2016 ..
lrwxr-xr-x     1 ollitech  staff       43 Oct 25 13:43 .bash_profile -> /Users/ollitech/dotfiles/home/.bash_profile
lrwxr-xr-x     1 ollitech  staff       40 Oct 25 13:43 .gitconfig -> /Users/ollitech/dotfiles/home/.gitconfig
...
drwxr-xr-x     7 ollitech  wheel      238 Oct 25 10:21 dotfiles  # <- this git repo
...
```

This project should be cloned into your home directory, you can rename and even have multiple versions, and [install.sh](install.sh) will set symlinks properly based on checked out repo path.

## Making this your own

1) Just fork this repo as you would normally,
2) Clone the repo into your home directory (by default as ~/dotfiles) 
2) Start moving or creating ~/dotfiles/home with your own, and commit then to your fork
```
git clone [YOUR repo URL] 
cd dotfiles
# add your files
cp -a ~/[.dotFileToTrack] home/
cp -a ~/[.dotFileToTrackEtc] home/
# Create symlinks
bash install.sh

git commit -am"Adding my very own and magical dotfiles"
git push
```
3)Now use the instructions below moving forward.

## Usage

### sharing/saving new configs/files
instead of saving/editing files in ~/ you place them all in ~/dotfiles/home, and the script manages symlinks.  THis let's you keep only the files you want in sync with remote repo.

```
mv [.dotfilename or folder] ~/dotfiles/home
git commit -am"added new file [.dotfilename or folder]"
git push
```


### setting up new machine (from existing repo)

```
cd ~
git clone [YOUR repo URL] 
bash dotfiles/install.sh
```

### Getting remote changes

```
cd ~/dotfiles
git pull
bash install.sh
```


## You said I can have multiple instances of this?
That's right. You may have a repo for personal settings, aliases, color-schemes, etc, and also a team repository for common frameworks, aliases, etc.

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

here "gitprompt" is a file that does some nifty formatting of the bash_prompt, and is sourced from everyone's unique .bash_profile

All you need to do is check out the repo as a different name, really that's it. Everything else works the same!

```
cd ~
git clone [ADDITIONAL repo URL] [different repo name]
```

## What about folders like `scripts`

Supports nested/overlapping folders as well.  This allows a user for instance to have both private and shared contents in a `~/scripts/` folder.

```
LIBP45P-31715DD:dotfiles ollitech$ ls -la ~/scripts/
lrwxr-xr-x   1 ollitech  staff    51B Oct 27 15:26 ngrok@ -> /Users/ollitech/dotfiles/home/scripts/ngrok
lrwxr-xr-x   1 ollitech  staff    46B Oct 27 15:26 proxy.sh@ -> /Users/ollitech/teamdotfiles/home/scripts/proxy.sh
```



