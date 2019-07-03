#!/bin/bash

git pull
git submodule update --recursive --remote --merge

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

pwd

THIRDPARTYROOT=`readlink -f ${SCRIPTPATH}/../3rdParty`
echo "3rd Party INSTALL ROOT: " $THIRDPARTYROOT

#make sure we on the right path
pushd $SCRIPTPATH

# CURRENT_BUILD="eigen"
# echo "------ BUILDING ${CURRENT_BUILD} -------"
# pushd $SCRIPTPATH/$CURRENT_BUILD
# cmake -G "Unix Makefiles" -Bbuild -Hsource -DCMAKE_INSTALL_PREFIX="${THIRDPARTYROOT}/${CURRENT_BUILD}" -DCMAKE_INSTALL_LIBDIR="${THIRDPARTYROOT}/${CURRENT_BUILD}/lib" -DBUILD_TESTING=false 2>&1 | tee ${CURRENT_BUILD}_CMAKE.txt
# make --directory build install 2>&1 | tee ${CURRENT_BUILD}_MAKE.txt
# popd

# CURRENT_BUILD="gflags"
# echo "------ BUILDING ${CURRENT_BUILD} -------"
# pushd $SCRIPTPATH/$CURRENT_BUILD
# cmake -G "Unix Makefiles" -Bbuild -Hsource -DCMAKE_INSTALL_PREFIX="${THIRDPARTYROOT}/${CURRENT_BUILD}" -DCMAKE_INSTALL_LIBDIR="${THIRDPARTYROOT}/${CURRENT_BUILD}/lib" 2>&1 | tee ${CURRENT_BUILD}_CMAKE.txt
# make --directory build install 2>&1 | tee ${CURRENT_BUILD}_MAKE.txt
# popd

# CURRENT_BUILD="glog"
# echo "------ BUILDING ${CURRENT_BUILD} -------"
# pushd $SCRIPTPATH/$CURRENT_BUILD
# cmake -G "Unix Makefiles" -Bbuild -Hsource -DCMAKE_INSTALL_PREFIX="${THIRDPARTYROOT}/${CURRENT_BUILD}" -DCMAKE_INSTALL_LIBDIR="${THIRDPARTYROOT}/${CURRENT_BUILD}/lib" -DBUILD_TESTING=False 2>&1 | tee ${CURRENT_BUILD}_CMAKE.txt
# make --directory build install 2>&1 | tee ${CURRENT_BUILD}_MAKE.txt
# popd

CURRENT_BUILD="opencv"
echo "------ BUILDING ${CURRENT_BUILD} -------"
pushd $SCRIPTPATH/$CURRENT_BUILD
cmake -G "Unix Makefiles" -Bbuild -Hsource -DCMAKE_INSTALL_PREFIX="${THIRDPARTYROOT}/${CURRENT_BUILD}" -DCMAKE_INSTALL_LIBDIR="${THIRDPARTYROOT}/${CURRENT_BUILD}/lib" -DWITH_TBB=ON -DWITH_QT=ON -DWITH_OPENGL=ON -DBUILD_TESTS=false -DBUILD_PERF_TESTS=false 2>&1 | tee ${CURRENT_BUILD}_CMAKE.txt
make --directory build install 2>&1 | tee ${CURRENT_BUILD}_MAKE.txt
popd

# CURRENT_BUILD="suitesparse"
# echo "------ BUILDING ${CURRENT_BUILD} -------"
# pushd $SCRIPTPATH/$CURRENT_BUILD
# cmake -G "Unix Makefiles" -Bbuild -Hsource -DCMAKE_INSTALL_PREFIX="${THIRDPARTYROOT}/${CURRENT_BUILD}" -DCMAKE_INSTALL_LIBDIR="${THIRDPARTYROOT}/${CURRENT_BUILD}/lib" -DBUILD_METIS=false 2>&1 | tee ${CURRENT_BUILD}_CMAKE.txt
# make --directory build install 2>&1 | tee ${CURRENT_BUILD}_MAKE.txt
# popd


# CURRENT_BUILD="ceres"
# echo "------ BUILDING ${CURRENT_BUILD} -------"
# pushd $SCRIPTPATH/$CURRENT_BUILD
# cmake -G "Unix Makefiles" -Bbuild -Hsource -DCMAKE_INSTALL_PREFIX="${THIRDPARTYROOT}/${CURRENT_BUILD}" -DCMAKE_INSTALL_LIBDIR="${THIRDPARTYROOT}/${CURRENT_BUILD}/lib" -DBUILD_METIS=false -DBUILD_EXAMPLES=false -DBUILD_TESTING=false -DSUITESPARSE=true -DSuiteSparse_DIR="${THIRDPARTYROOT}/suitesparse" -DGLOG_INCLUDE_DIR_HINTS="${THIRDPARTYROOT}/glog/include" -DGLOG_LIBRARY_DIR_HINTS="${THIRDPARTYROOT}/glog/lib" -DEigen3_DIR="${THIRDPARTYROOT}/eigen/share/eigen3/cmake" -DGLOG_INCLUDE_DIR_HINTS="${THIRDPARTYROOT}/glog/include" -DGFLAGS_INCLUDE_DIR_HINTS="${THIRDPARTYROOT}/gflags/include" -DGFLAGS_LIBRARY_DIR_HINTS="${THIRDPARTYROOT}/gflags/lib" -DGFLAGS=true 2>&1 | tee ${CURRENT_BUILD}_CMAKE.txt
# make --directory build install 2>&1 | tee ${CURRENT_BUILD}_MAKE.txt
# popd
