# Notes on using drive for Google Drive on Linux

[drive](https://github.com/odeke-em/drive)

## Initialize

```shell
drive init ~/Documents/GoogleDrive
cd ~/Documents/GoogleDrive
```


## Push a new directory

```shell
drive push -no-clobber -directories ./new_directory
```


## Push an update

```shell
drive push ./new_directory
```


## Push updates without clobbering upstream changes

```shell
drive push -no-clobber ./some_dir
```


## Pull down updates

```shell
drive pull ./some_dir
```


## Check quota

```shell
drive quota
```


## List features

```shell
drive features
```
