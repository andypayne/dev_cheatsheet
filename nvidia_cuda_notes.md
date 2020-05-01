# Notes on installing/configuring/upgrading the NVIDIA CUDA Toolkit on Linux

[NVIDIA's CUDA Toolkit install docs](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html)

## 1. Verify that the GPU is supported

List the GPU:
```shell
lspci | grep -i nvidia
```

Or:
```shell
ubuntu-drivers devices

== /sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0 ==
modalias : pci:v000010DEd00001BA1sv00001A58sd00002000bc03sc00i00
vendor   : NVIDIA Corporation
model    : GP104M [GeForce GTX 1070 Mobile]
driver   : nvidia-driver-440 - third-party free recommended
driver   : nvidia-driver-415 - third-party free
driver   : nvidia-driver-435 - distro non-free
driver   : nvidia-driver-410 - third-party free
driver   : nvidia-driver-418 - third-party free
driver   : nvidia-driver-390 - third-party free
driver   : xserver-xorg-video-nouveau - distro free builtin

== /sys/devices/pci0000:00/0000:00:1b.0/0000:02:00.0 ==
modalias : pci:v00008086d00002526sv00008086sd00000014bc02sc80i00
vendor   : Intel Corporation
manual_install: True
driver   : backport-iwlwifi-dkms - distro free
```

Check for a compatible GPU on [NVIDIA's list](https://developer.nvidia.com/cuda-gpus).

Also if installed:
```shell
cat /proc/driver/nvidia/version
```


## 2. Check the Linux version

```shell
uname -m && cat /etc/*release
```

Or:
```shell
lsb_release -a
uname -a
```


## 3. Check gcc

```shell
gcc --version
```


## 4. Install the kernel headers

Install the headers matching the kernel version:

```shell
sudo apt-get install linux-headers-$(uname -r)
```

I checked my system and I already have them installed:

```shell
apt policy linux-headers-$(uname -r)

linux-headers-4.15.0-96-generic:
  Installed: 4.15.0-96.97
  Candidate: 4.15.0-96.97
  Version table:
 *** 4.15.0-96.97 500
        500 http://us.archive.ubuntu.com/ubuntu bionic-updates/main amd64 Packages
        500 http://security.ubuntu.com/ubuntu bionic-security/main amd64 Packages
        100 /var/lib/dpkg/status
```


[This page](https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&target_distro=Ubuntu&target_version=1804&target_type=debnetwork) lists the install steps for a given OS, distribution, architecture, and version. In my case:

```shell
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-ubuntu1804.pin
sudo mv cuda-ubuntu1804.pin /etc/apt/preferences.d/cuda-repository-pin-600
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub
sudo add-apt-repository "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/ /"
sudo apt-get update
sudo apt-get -y install cuda
```

## Symlink

```shell
sudo ln -s /usr/local/cuda-10.2 /usr/local/cuda
```


## Post-install actions

### Add to `$PATH`

Add to startup files (`.zshrc`):
```shell
export PATH=/usr/local/cuda-10.2/bin:/usr/local/cuda-10.2/NsightCompute-2019.1${PATH:+:${PATH}}
```

### Add to `$LD_LIBRARY_PATH`

Add to startup files (`.zshrc`):
```shell
export LD_LIBRARY_PATH=/usr/local/cuda-10.2/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
```


## Samples

```shell
git clone https://github.com/NVIDIA/cuda-samples.git
```


## Uninstalling and reinstalling

I had an old version (9.1) that I needed to uninstall to get the latest version
working. So I did a lot of things.

### Checking the video card driver and installing the recommended driver.
```shell
ubuntu-drivers devices
```
To install the recommended driver:
```shell
sudo ubuntu-drivers autoinstall
```


### Remove the entry from apt/sources.list

I edited `/etc/apt/sources.list` to remove the entry for NVIDIA, and then reran
`sudo apt --fix-broken install` to get rid of some of the conflicts.


### Check installed packages

I checked the installed packages for indications of NVIDIA and CUDA:
```shell
dpkg -l | grep -i nvidia
dpkg -l | grep -i cuda
```


### Removing packages

I removed a lot of NVIDIA and CUDA related packages (various versions over the
course of the session):
```shell
sudo apt-get --purge remove nvidia-cuda-dev
sudo apt-get --purge remove nvidia-cuda-toolkit
sudo apt-get --purge remove cuda-9.1
sudo apt-get --purge remove nvidia-cuda-9.1
sudo apt-get --purge remove nvidia-cuda
sudo apt-get --purge remove cuda-libraries-dev
sudo apt-get --purge remove cuda-documentation-10-2
sudo apt-get --purge remove cuda-libraries-dev-10-2
sudo apt-get --purge remove cuda-visual-tools-10-2
sudo apt-get --purge remove cuda
sudo apt-get --purge remove cuda-samples
sudo apt-get --purge remove cuda-samples-10-2
sudo apt-get remove --auto-remove nvidia-cuda-toolkit
sudo apt-get purge --auto-remove nvidia-cuda-toolkit
sudo apt-get purge --auto-remove cuda
sudo apt autoremove

## More post install stuff

### Check the video driver version (again)

```shell
cat /proc/driver/nvidia/version

NVRM version: NVIDIA UNIX x86_64 Kernel Module  440.82  Wed Apr  1 20:04:33 UTC 2020
GCC version:  gcc version 7.5.0 (Ubuntu 7.5.0-3ubuntu1~18.04) 
```

### Install and build the sample code

```shell
cuda-install-samples-10.2.sh ./cuda_samples/
```

Make from the samples directory. Add the `-k` to continue after errors in some
projects, which I got due to a missing `nvscibuf.h`, which NVIDIA says "is being
researched" in [this forum post](https://forums.developer.nvidia.com/t/where-is-nvscibuf-h/1078020).
```shell
make -k
```

Then run the `deviceQuery` sample and check its output.

```shell
./NVIDIA_CUDA-10.2_Samples/bin/x86_64/linux/release/deviceQuery

../src/NVIDIA_CUDA-10.2_Samples/bin/x86_64/linux/release/deviceQuery Starting...

 CUDA Device Query (Runtime API) version (CUDART static linking)

Detected 1 CUDA Capable device(s)

Device 0: "GeForce GTX 1070 with Max-Q Design"
  CUDA Driver Version / Runtime Version          10.2 / 10.2
  CUDA Capability Major/Minor version number:    6.1
  Total amount of global memory:                 8120 MBytes (8513978368 bytes)
  (16) Multiprocessors, (128) CUDA Cores/MP:     2048 CUDA Cores
  GPU Max Clock rate:                            1379 MHz (1.38 GHz)
  Memory Clock rate:                             4004 Mhz
  Memory Bus Width:                              256-bit
  L2 Cache Size:                                 2097152 bytes
  Maximum Texture Dimension Size (x,y,z)         1D=(131072), 2D=(131072, 65536), 3D=(16384, 16384, 16384)
  Maximum Layered 1D Texture Size, (num) layers  1D=(32768), 2048 layers
  Maximum Layered 2D Texture Size, (num) layers  2D=(32768, 32768), 2048 layers
  Total amount of constant memory:               65536 bytes
  Total amount of shared memory per block:       49152 bytes
  Total number of registers available per block: 65536
  Warp size:                                     32
  Maximum number of threads per multiprocessor:  2048
  Maximum number of threads per block:           1024
  Max dimension size of a thread block (x,y,z): (1024, 1024, 64)
  Max dimension size of a grid size    (x,y,z): (2147483647, 65535, 65535)
  Maximum memory pitch:                          2147483647 bytes
  Texture alignment:                             512 bytes
  Concurrent copy and kernel execution:          Yes with 2 copy engine(s)
  Run time limit on kernels:                     Yes
  Integrated GPU sharing Host Memory:            No
  Support host page-locked memory mapping:       Yes
  Alignment requirement for Surfaces:            Yes
  Device has ECC support:                        Disabled
  Device supports Unified Addressing (UVA):      Yes
  Device supports Compute Preemption:            Yes
  Supports Cooperative Kernel Launch:            Yes
  Supports MultiDevice Co-op Kernel Launch:      Yes
  Device PCI Domain ID / Bus ID / location ID:   0 / 1 / 0
  Compute Mode:
     < Default (multiple host threads can use ::cudaSetDevice() with device simultaneously) >

deviceQuery, CUDA Driver = CUDART, CUDA Driver Version = 10.2, CUDA Runtime Version = 10.2, NumDevs = 1
Result = PASS
```

The GPU was found and the test result is `PASS`.

Next run the `bandwidthTest` program:

```shell
./NVIDIA_CUDA-10.2_Samples/bin/x86_64/linux/release/bandwidthTest

[CUDA Bandwidth Test] - Starting...
Running on...

 Device 0: GeForce GTX 1070 with Max-Q Design
 Quick Mode

 Host to Device Bandwidth, 1 Device(s)
 PINNED Memory Transfers
   Transfer Size (Bytes)	Bandwidth(GB/s)
   32000000			12.8

 Device to Host Bandwidth, 1 Device(s)
 PINNED Memory Transfers
   Transfer Size (Bytes)	Bandwidth(GB/s)
   32000000			13.0

 Device to Device Bandwidth, 1 Device(s)
 PINNED Memory Transfers
   Transfer Size (Bytes)	Bandwidth(GB/s)
   32000000			193.7

Result = PASS

NOTE: The CUDA Samples are not meant for performance measurements. Results may vary when GPU Boost is enabled.
```

### Install some optional third-party libraries

These were all already installed and at the latest versions on my system:

```shell
sudo apt-get install g++ freeglut3-dev build-essential libx11-dev \
    libxmu-dev libxi-dev libglu1-mesa libglu1-mesa-dev
```

