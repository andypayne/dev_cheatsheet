#!/usr/bin/env bash

cmake \
  -D CMAKE_BUILD_TYPE=RELEASE \
  -D CMAKE_INSTALL_PREFIX=/usr/local \
  -D WITH_TBB=ON \
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

