# includes openssl libs onto android build

# INFO:
# To build application you need to build openssl libraries.
# For example you can use https://github.com/esutton/android-openssl and copy libcrypto.so and libssl.so to this folder
android {
  ANDROID_EXTRA_LIBS += $$PWD/libcrypto.so
  ANDROID_EXTRA_LIBS += $$PWD/libssl.so
}
