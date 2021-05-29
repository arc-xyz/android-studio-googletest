BUILD_DIR=build_android

# default to "Debug" config
CONFIG=Debug
if [ -n "$1" ]; then
    CONFIG=$1
fi

MINSDKVERSION=16

rm -rf $BUILD_DIR
mkdir $BUILD_DIR

ABI=x86

cmake -S . -B $BUILD_DIR -DANDROID_NDK=$NDK_ROOT \
    -DCMAKE_TOOLCHAIN_FILE=$NDK_ROOT/build/cmake/android.toolchain.cmake \
    -DANDROID_ABI=$ABI \
    -DANDROID_NATIVE_API_LEVEL=$MINSDKVERSION \
    -DCMAKE_BUILD_TYPE=$CONFIG \
    -Wno-error=deprecated-declarations


pushd $BUILD_DIR
cmake --build . --config $CONFIG
#cmake --install . --prefix ../../android/app/src/main/JniLibs/arm64-v8a
#cp ../bin/*.so ../../android/app/src/main/JniLibs/arm64-v8a/
popd

popd

