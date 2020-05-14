# OpenCV Notes


## Installing on Linux

This is based on the [linux install tutorial](https://docs.opencv.org/master/d7/d9f/tutorial_linux_install.html).


### General Dependencies

Install dependencies:
```shell
sudo apt install build-essential
sudo apt install libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
sudo apt install python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev
```

Trying to install `libjasper-dev` results in an error:
```shell
sudo apt install python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev

Reading package lists...
Building dependency tree...
Reading state information...
E: Unable to locate package libjasper-dev
```

So install the other dependencies without it:
```shell
sudo apt install python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libdc1394-22-dev
```

And then add a repo and repeat the `libjasper-dev` installation:
```shell
sudo add-apt-repository "deb http://security.ubuntu.com/ubuntu xenial-security main"
sudo apt update
sudo apt install libjasper1 libjasper-dev
```

For OpenBLAS support (may not be needed with CUBLAS):
```shell
sudo apt install libopenblas-dev libopenblas-base
```

Update `gtk+` to 3.0:
```shell
sudo apt install libgtk-3-dev
```


### NVIDIA CUDA (cuDNN, etc) dependencies

This assumes CUDA is installed. See my CUDA notes for installing CUDA on Linux.

[Download cuDNN from NVIDIA](https://developer.nvidia.com/cudnn) after signing in or registering and completing their survey. Installation is just copying files to the CUDA install location.

Check the cuDNN version:
```shell
cat /usr/local/cuda/include/cudnn.h | grep CUDNN_MAJOR -A 2
```

Copy the files to your CUDA install manually (probably with sudo):
```shell
cp include/cudnn.h /usr/local/cuda-10.2/include/
cp NVIDIA_SLA_cuDNN_Support.txt /usr/local/cuda-10.2
cp lib64/libcudnn* /usr/local/cuda-10.2/lib64
```

Download the [NVIDIA video codec SDK](https://developer.nvidia.com/nvidia-video-codec-sdk/download). I had to do this because of build errors with finding versions of `nvcuvid.h`.

Again, copy the files to your CUDA install manually (probably with sudo). I'm probably doing extra copying here:
```shell
cp -i Lib/linux/stubs/x86_64/* /usr/local/cuda/lib64/
cp -i Lib/x64/* /usr/local/cuda/lib64/
cp -i Lib/x64/* /usr/local/cuda/libnvvp
cp -i ./Lib/linux/stubs/x86_64/* /usr/local/cuda/targets/x86_64-linux/lib/stubs
```


### Building OpenCV

Download the source from [OpenCV Releases](https://opencv.org/releases/) (currently 4.3.0). Also download the [opencv_contrib source](https://github.com/opencv/opencv_contrib/releases/tag/4.3.0).

Then:
```shell
cd opencv-4.3.0
mkdir build
cd build
```

#### Cmake command

- Note the python 3 flags, which are required to use python 3 instead of python 2.
- No `ENABLE_FAST_MATH` or `CUDA_FAST_MATH` - [no IEEE compliance](https://answers.opencv.org/question/222056/fast-math-flags-enable_fast_math-and-cuda_fast_math/)
- No `WITH_CSTRIPES`
- Use the deprecated option `OPENCV_GENERATE_PKGCONFIG=YES` to generate a
  `opencv4.pc` file to be used with `pkg-config`, which many makefiles still use.

My cmake script is here: [`opencv_cmake.sh`](opencv_cmake.sh). And inline:

```shell
cmake \
  -D CMAKE_BUILD_TYPE=RELEASE \
  -D CMAKE_INSTALL_PREFIX=/usr/local \
  -D WITH_TBB=ON \
  -D OPENCV_GENERATE_PKGCONFIG=YES \
  -D WITH_OPENMP=ON \
  -D WITH_IPP=ON \
  -D WITH_NVCUVID=ON \
  -D WITH_CUDA=ON \
  -DBUILD_opencv_cudacodec=OFF \
  -D WITH_CUBLAS=1 \
  -D WITH_CUDNN=1 \
  -D WITH_OPENCL=ON \
  -D BUILD_NEW_PYTHON_SUPPORT=ON \
  -D BUILD_opencv_python3=ON \
  -D HAVE_opencv_python3=ON \
  -D PYTHON_DEFAULT_EXECUTABLE=$(which python3) \
  -D BUILD_DOCS=ON \
  -D BUILD_PERF_TESTS=ON \
  -D BUILD_TESTS=ON \
  -D BUILD_EXAMPLES=ON \
  -D INSTALL_PYTHON_EXAMPLES=ON \
  -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib-4.3.0/modules \
  ..
```

#### Cmake summary

The configuration summary, which shows CUDA and Python support:

```shell
-- General configuration for OpenCV 4.3.0 =====================================
--   Version control:               unknown
--
--   Extra modules:
--     Location (extra):            /home/Downloads/opencv_contrib-4.3.0/modules
--     Version control (extra):     unknown
--
--   Platform:
--     Timestamp:                   2020-05-08T02:34:43Z
--     Host:                        Linux 4.15.0-99-generic x86_64
--     CMake:                       3.17.2
--     CMake generator:             Unix Makefiles
--     CMake build tool:            /usr/bin/make
--     Configuration:               RELEASE
--
--   CPU/HW features:
--     Baseline:                    SSE SSE2 SSE3
--       requested:                 SSE3
--     Dispatched code generation:  SSE4_1 SSE4_2 FP16 AVX AVX2 AVX512_SKX
--       requested:                 SSE4_1 SSE4_2 AVX FP16 AVX2 AVX512_SKX
--       SSE4_1 (16 files):         + SSSE3 SSE4_1
--       SSE4_2 (2 files):          + SSSE3 SSE4_1 POPCNT SSE4_2
--       FP16 (1 files):            + SSSE3 SSE4_1 POPCNT SSE4_2 FP16 AVX
--       AVX (5 files):             + SSSE3 SSE4_1 POPCNT SSE4_2 AVX
--       AVX2 (30 files):           + SSSE3 SSE4_1 POPCNT SSE4_2 FP16 FMA3 AVX AVX2
--       AVX512_SKX (6 files):      + SSSE3 SSE4_1 POPCNT SSE4_2 FP16 FMA3 AVX AVX2 AVX_512F AVX512_COMMON AVX512_SKX
--
--   C/C++:
--     Built as dynamic libs?:      YES
--     C++ standard:                11
--     C++ Compiler:                /usr/bin/c++  (ver 7.5.0)
--     C++ flags (Release):         -fsigned-char -W -Wall -Werror=return-type -Werror=non-virtual-dtor -Werror=address -Werror=sequence-point -Wformat -Werror=format-security -Wmissing-declarations -Wundef -Winit-self -Wpointer-arith -Wshadow -Wsign-promo -Wuninitialized -Winit-self -Wsuggest-override -Wno-delete-non-virtual-dtor -Wno-comment -Wimplicit-fallthrough=3 -Wno-strict-overflow -fdiagnostics-show-option -Wno-long-long -pthread -fomit-frame-pointer -ffunction-sections -fdata-sections  -msse -msse2 -msse3 -fvisibility=hidden -fvisibility-inlines-hidden -fopenmp -O3 -DNDEBUG  -DNDEBUG
--     C++ flags (Debug):           -fsigned-char -W -Wall -Werror=return-type -Werror=non-virtual-dtor -Werror=address -Werror=sequence-point -Wformat -Werror=format-security -Wmissing-declarations -Wundef -Winit-self -Wpointer-arith -Wshadow -Wsign-promo -Wuninitialized -Winit-self -Wsuggest-override -Wno-delete-non-virtual-dtor -Wno-comment -Wimplicit-fallthrough=3 -Wno-strict-overflow -fdiagnostics-show-option -Wno-long-long -pthread -fomit-frame-pointer -ffunction-sections -fdata-sections  -msse -msse2 -msse3 -fvisibility=hidden -fvisibility-inlines-hidden -fopenmp -g  -O0 -DDEBUG -D_DEBUG
--     C Compiler:                  /usr/bin/cc
--     C flags (Release):           -fsigned-char -W -Wall -Werror=return-type -Werror=address -Werror=sequence-point -Wformat -Werror=format-security -Wmissing-declarations -Wmissing-prototypes -Wstrict-prototypes -Wundef -Winit-self -Wpointer-arith -Wshadow -Wuninitialized -Winit-self -Wno-comment -Wimplicit-fallthrough=3 -Wno-strict-overflow -fdiagnostics-show-option -Wno-long-long -pthread -fomit-frame-pointer -ffunction-sections -fdata-sections  -msse -msse2 -msse3 -fvisibility=hidden -fopenmp -O3 -DNDEBUG  -DNDEBUG
--     C flags (Debug):             -fsigned-char -W -Wall -Werror=return-type -Werror=address -Werror=sequence-point -Wformat -Werror=format-security -Wmissing-declarations -Wmissing-prototypes -Wstrict-prototypes -Wundef -Winit-self -Wpointer-arith -Wshadow -Wuninitialized -Winit-self -Wno-comment -Wimplicit-fallthrough=3 -Wno-strict-overflow -fdiagnostics-show-option -Wno-long-long -pthread -fomit-frame-pointer -ffunction-sections -fdata-sections  -msse -msse2 -msse3 -fvisibility=hidden -fopenmp -g  -O0 -DDEBUG -D_DEBUG
--     Linker flags (Release):      -Wl,--exclude-libs,libippicv.a -Wl,--exclude-libs,libippiw.a   -Wl,--gc-sections -Wl,--as-needed
--     Linker flags (Debug):        -Wl,--exclude-libs,libippicv.a -Wl,--exclude-libs,libippiw.a   -Wl,--gc-sections -Wl,--as-needed
--     ccache:                      NO
--     Precompiled headers:         NO
--     Extra dependencies:          m pthread cudart_static dl rt nppc nppial nppicc nppicom nppidei nppif nppig nppim nppist nppisu nppitc npps cublas cudnn cufft -L/usr/local/cuda/lib64 -L/usr/lib/x86_64-linux-gnu
--     3rdparty dependencies:
--
--   OpenCV modules:
--     To be built:                 aruco bgsegm bioinspired calib3d ccalib core cudaarithm cudabgsegm cudafeatures2d cudafilters cudaimgproc cudalegacy cudaobjdetect cudaoptflow cudastereo cudawarping cudev datasets dnn dnn_objdetect dnn_superres dpm face features2d flann freetype fuzzy gapi hdf hfs highgui img_hash imgcodecs imgproc intensity_transform line_descriptor ml objdetect optflow phase_unwrapping photo plot python2 quality rapid reg rgbd saliency shape stereo stitching structured_light superres surface_matching text tracking ts video videoio videostab xfeatures2d ximgproc xobjdetect xphoto
--     Disabled:                    cudacodec world
--     Disabled by dependency:      -
--     Unavailable:                 alphamat cnn_3dobj cvv java js matlab ovis python3 sfm viz
--     Applications:                tests perf_tests examples apps
--     Documentation:               NO
--     Non-free algorithms:         NO
--
--   GUI:
--     GTK+:                        YES (ver 3.22.30)
--       GThread :                  YES (ver 2.56.4)
--       GtkGlExt:                  NO
--     VTK support:                 NO
--
--   Media I/O:
--     ZLib:                        /usr/lib/x86_64-linux-gnu/libz.so (ver 1.2.11)
--     JPEG:                        /usr/lib/x86_64-linux-gnu/libjpeg.so (ver 80)
--     WEBP:                        build (ver encoder: 0x020f)
--     PNG:                         /usr/lib/x86_64-linux-gnu/libpng.so (ver 1.6.34)
--     TIFF:                        /usr/lib/x86_64-linux-gnu/libtiff.so (ver 42 / 4.0.9)
--     JPEG 2000:                   /usr/lib/x86_64-linux-gnu/libjasper.so (ver 1.900.1)
--     OpenEXR:                     build (ver 2.3.0)
--     HDR:                         YES
--     SUNRASTER:                   YES
--     PXM:                         YES
--     PFM:                         YES
--
--   Video I/O:
--     DC1394:                      YES (2.2.5)
--     FFMPEG:                      YES
--       avcodec:                   YES (57.107.100)
--       avformat:                  YES (57.83.100)
--       avutil:                    YES (55.78.100)
--       swscale:                   YES (4.8.100)
--       avresample:                YES (3.7.0)
--     GStreamer:                   NO
--     v4l/v4l2:                    YES (linux/videodev2.h)
--
--   Parallel framework:            TBB (ver 2017.0 interface 9107)
--
--   Trace:                         YES (with Intel ITT)
--
--   Other third-party libraries:
--     Intel IPP:                   2020.0.0 Gold [2020.0.0]
--            at:                   /home/Downloads/opencv-4.3.0/build/3rdparty/ippicv/ippicv_lnx/icv
--     Intel IPP IW:                sources (2020.0.0)
--               at:                /home/Downloads/opencv-4.3.0/build/3rdparty/ippicv/ippicv_lnx/iw
--     Lapack:                      NO
--     Eigen:                       NO
--     Custom HAL:                  NO
--     Protobuf:                    build (3.5.1)
--
--   NVIDIA CUDA:                   YES (ver 10.2, CUFFT CUBLAS NVCUVID)
--     NVIDIA GPU arch:             30 35 37 50 52 60 61 70 75
--     NVIDIA PTX archs:
--
--   cuDNN:                         YES (ver 7.6.5)
--
--   OpenCL:                        YES (no extra features)
--     Include path:                /home/Downloads/opencv-4.3.0/3rdparty/include/opencl/1.2
--     Link libraries:              Dynamic load
--
--   Python 2:
--     Interpreter:                 /usr/bin/python2.7 (ver 2.7.17)
--     Libraries:                   /usr/lib/x86_64-linux-gnu/libpython2.7.so (ver 2.7.17)
--     numpy:                       /usr/lib/python2.7/dist-packages/numpy/core/include (ver 1.13.3)
--     install path:                lib/python2.7/dist-packages/cv2/python-2.7
--
--   Python 3:
--     Interpreter:                 /home/anaconda3/bin/python3 (ver 3.7.4)
--     Libraries:
--     numpy:                       /home/anaconda3/lib/python3.7/site-packages/numpy/core/include (ver 1.17.2)
--     install path:
--
--   Python (for build):            /home/anaconda3/bin/python3
--     Pylint:                      /home/anaconda3/bin/pylint (ver: 3.7.4, checks: 174)
--
--   Java:
--     ant:                         NO
--     JNI:                         NO
--     Java wrappers:               NO
--     Java tests:                  NO
--
--   Install to:                    /usr/local
-- -----------------------------------------------------------------
--
-- Configuring done
-- Generating done
-- Build files have been written to: /home/Downloads/opencv-4.3.0/build
```

#### Build

Run make, with parallel jobs equal to the number of processing cores:
```shell
make -j$(nproc)
```

Or to choose your own adventure:
```shell
make -j<num>
```

And wait... Then install.

```shell
sudo make install
```

If successful:
```shell
opencv_version

4.3.0
```


### `pkg-config`

Some libraries I'm using use
[`pkg-config`](https://www.freedesktop.org/wiki/Software/pkg-config/) to find
installed libraries. OpenCV has [dropped support](https://github.com/opencv/opencv/issues/13154#issuecomment-438473073)
for `pkg-config`, so it's deprecated in the default install. I added a flag to
generate it and rebuilt. An alternative for libraries under your control is to
use CMake's `find_package(OpenCV)`. I'm working with
[Darknet](https://pjreddie.com/darknet/) which uses bare makefiles by default,
so it requires `pkg-config`.

Incidentally, Darknet also references `opencv`, not `opencv4`, which is the
default installed by OpenCV-4.3.0. So I duplicated `opencv4.pc` as `opencv.pc`.

After building OpenCV (also add `PKG_CONFIG_PATH` to dotfiles):
```shell
mkdir /usr/local/lib/pkgconfig
cp unix-install/opencv4.pc /usr/local/lib/pkgconfig
cp unix-install/opencv4.pc /usr/local/lib/pkgconfig/opencv.pc
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH
```

