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


## List features

```shell
drive features
```
