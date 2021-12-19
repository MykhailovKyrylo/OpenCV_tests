#!/bin/bash

# ENV OPTIONS
CUR_DIR=$(pwd)
CMAKE_DIR="$CUR_DIR/opencv"
INSTALL_DIR="$CUR_DIR/out"
THREADS_COUNT="12"

# Build tests, samples and applications
BUILD_TESTS=ON
BUILD_PERF_TESTS=ON
BUILD_EXAMPLE=ON
BUILD_opencv_apps=ON

echo "============================ BUILDING ============================"

echo "CMake dir: "$(cd $CMAKE_DIR && pwd)
echo ""

cmake -B"$INSTALL_DIR" -H"$CMAKE_DIR"

cd "$INSTALL_DIR" && make -j"$THREADS_COUNT"

echo "============================ RUN TESTS ============================"

OPENCV_TEST_BINS_DIR="$INSTALL_DIR/bin"
OPENCV_TEST_BINS=(
	"opencv_test_calib3d"
	"opencv_test_core"
	"opencv_test_dnn"
	"opencv_test_features2d"
	"opencv_test_flann"
	"opencv_test_gapi"
	"opencv_test_highgui"
	"opencv_test_imgcodecs"
	"opencv_test_imgproc"
	"opencv_test_ml"
	"opencv_test_objdetect"
	"opencv_test_photo"
	"opencv_test_stitching"
	"opencv_test_video"
	"opencv_test_videoio")

for opencv_test_bin_path in ${OPENCV_TEST_BINS[@]}; do
  ./bin/"$opencv_test_bin_path"
done
