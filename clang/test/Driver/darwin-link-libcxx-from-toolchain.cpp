// UNSUPPORTED: system-windows

// Tests to check that we pass -L <install>/bin/../lib/libc++.dylib to link with the toolchain's libc++.dylib 
// whenever we are including the toolchain's libc++ headers

// Check without a sysroot and without headers alongside the installation
//
// RUN: %clang -### %s 2>&1 \
// RUN:     --target=x86_64-apple-darwin \
// RUN:     -stdlib=libc++ \
// RUN:     -ccc-install-dir %S/Inputs/basic_darwin_toolchain_no_libcxx/usr/bin \
// RUN:   | FileCheck -DTOOLCHAIN=%S/Inputs/basic_darwin_toolchain_no_libcxx --check-prefix=CHECK-TOOLCHAIN-LIBCXX-LINKING-2 %s

// Check with only headers alongside the installation (those should be used).
//
// RUN: %clang -### %s 2>&1 \
// RUN:     --target=x86_64-apple-darwin \
// RUN:     -stdlib=libc++ \
// RUN:     -ccc-install-dir %S/Inputs/basic_darwin_toolchain/usr/bin \
// RUN:     --sysroot="" \
// RUN:   | FileCheck -DTOOLCHAIN=%S/Inputs/basic_darwin_toolchain \
// RUN:               --check-prefix=CHECK-TOOLCHAIN-LIBCXX-LINKING-1 %s
//
// RUN: %clang -### %s 2>&1 \
// RUN:     --target=x86_64-apple-darwin \
// RUN:     -stdlib=libc++ \
// RUN:     -ccc-install-dir %S/Inputs/basic_darwin_toolchain/usr/bin \
// RUN:     -isysroot %S/Inputs/basic_darwin_sdk_no_libcxx \
// RUN:   | FileCheck -DTOOLCHAIN=%S/Inputs/basic_darwin_toolchain \
// RUN:               -DSYSROOT=%S/Inputs/basic_darwin_sdk_no_libcxx \
// RUN:               --check-prefix=CHECK-TOOLCHAIN-LIBCXX-LINKING-1 %s

// Check with only headers in the sysroot (those should be used).
//
// RUN: %clang -### %s 2>&1 \
// RUN:     --target=x86_64-apple-darwin \
// RUN:     -stdlib=libc++ \
// RUN:     -ccc-install-dir %S/Inputs/basic_darwin_toolchain_no_libcxx/usr/bin \
// RUN:     -isysroot %S/Inputs/basic_darwin_sdk_usr_cxx_v1 \
// RUN:   | FileCheck -DSYSROOT=%S/Inputs/basic_darwin_sdk_usr_cxx_v1 \
// RUN:               -DTOOLCHAIN=%S/Inputs/basic_darwin_toolchain_no_libcxx \
// RUN:               --check-prefix=CHECK-TOOLCHAIN-LIBCXX-LINKING-2 %s

// Check with both headers in the sysroot and headers alongside the installation
//
// RUN: %clang -### %s 2>&1 \
// RUN:     --target=x86_64-apple-darwin \
// RUN:     -stdlib=libc++ \
// RUN:     -ccc-install-dir %S/Inputs/basic_darwin_toolchain/usr/bin \
// RUN:     -resource-dir=%S/Inputs/resource_dir \
// RUN:     -isysroot %S/Inputs/basic_darwin_sdk_usr_cxx_v1 \
// RUN:   | FileCheck -DSYSROOT=%S/Inputs/basic_darwin_sdk_usr_cxx_v1 \
// RUN:               -DTOOLCHAIN=%S/Inputs/basic_darwin_toolchain \
// RUN:               --check-prefix=CHECK-TOOLCHAIN-LIBCXX-LINKING-1 %s
//
// RUN: %clang -### %s 2>&1 \
// RUN:     --target=x86_64-apple-darwin \
// RUN:     -stdlib=libc++ \
// RUN:     -ccc-install-dir %S/Inputs/basic_darwin_toolchain/usr/bin \
// RUN:     -resource-dir=%S/Inputs/resource_dir \
// RUN:     --sysroot %S/Inputs/basic_darwin_sdk_usr_cxx_v1 \
// RUN:   | FileCheck -DSYSROOT=%S/Inputs/basic_darwin_sdk_usr_cxx_v1 \
// RUN:               -DTOOLCHAIN=%S/Inputs/basic_darwin_toolchain \
// RUN:               --check-prefix=CHECK-TOOLCHAIN-LIBCXX-LINKING-1 %s
//
// RUN: %clang -### %s 2>&1 \
// RUN:     --target=x86_64-apple-darwin \
// RUN:     -stdlib=libc++ \
// RUN:     -ccc-install-dir %S/Inputs/basic_darwin_toolchain/usr/bin \
// RUN:     -resource-dir=%S/Inputs/resource_dir \
// RUN:     -isysroot %S/Inputs/basic_darwin_sdk_usr_cxx_v1 \
// RUN:     --sysroot %S/Inputs/basic_darwin_sdk_no_libcxx \
// RUN:   | FileCheck -DSYSROOT=%S/Inputs/basic_darwin_sdk_usr_cxx_v1 \
// RUN:               -DTOOLCHAIN=%S/Inputs/basic_darwin_toolchain \
// RUN:               --check-prefix=CHECK-TOOLCHAIN-LIBCXX-LINKING-1 %s
//

// Make sure that using -nostdinc, -nostdinc++ or -nostdlib will drop both the toolchain
// C++ include path and the sysroot one and thus not link with toolchain's libc++.dylib
//
// RUN: %clang -### %s 2>&1 \
// RUN:     --target=x86_64-apple-darwin16 \
// RUN:     -ccc-install-dir %S/Inputs/basic_darwin_toolchain/usr/bin \
// RUN:     -resource-dir=%S/Inputs/resource_dir \
// RUN:     -isysroot %S/Inputs/basic_darwin_sdk_usr \
// RUN:     -stdlib=platform \
// RUN:     -nostdinc \
// RUN:   | FileCheck -DSYSROOT=%S/Inputs/basic_darwin_sdk_usr \
// RUN:               -DTOOLCHAIN=%S/Inputs/basic_darwin_toolchain \
// RUN:               --check-prefix=CHECK-TOOLCHAIN-LIBCXX-LINKING-2 %s
//
// RUN: %clang -### %s 2>&1 \
// RUN:     --target=x86_64-apple-darwin16 \
// RUN:     -ccc-install-dir %S/Inputs/basic_darwin_toolchain/usr/bin \
// RUN:     -resource-dir=%S/Inputs/resource_dir \
// RUN:     -isysroot %S/Inputs/basic_darwin_sdk_usr_cxx_v1 \
// RUN:     -stdlib=platform \
// RUN:     -nostdinc++ \
// RUN:   | FileCheck -DSYSROOT=%S/Inputs/basic_darwin_sdk_usr_cxx_v1 \
// RUN:               -DTOOLCHAIN=%S/Inputs/basic_darwin_toolchain \
// RUN:               --check-prefix=CHECK-TOOLCHAIN-LIBCXX-LINKING-2 %s
//
// RUN: %clang -### %s 2>&1 \
// RUN:     --target=x86_64-apple-darwin16 \
// RUN:     -ccc-install-dir %S/Inputs/basic_darwin_toolchain/usr/bin \
// RUN:     -resource-dir=%S/Inputs/resource_dir \
// RUN:     -isysroot %S/Inputs/basic_darwin_sdk_usr \
// RUN:     -stdlib=platform \
// RUN:     -nostdlibinc \
// RUN:   | FileCheck -DSYSROOT=%S/Inputs/basic_darwin_sdk_usr \
// RUN:               -DTOOLCHAIN=%S/Inputs/basic_darwin_toolchain \
// RUN:               --check-prefix=CHECK-TOOLCHAIN-LIBCXX-LINKING-2 %s

// Make sure we explain that we do not link with toolchain's libc++ when the paths to 
// toolchain's libc++ headers doesn't exist.
//
// RUN: %clang -### %s -v 2>&1 \
// RUN:     --target=x86_64-apple-darwin \
// RUN:     -ccc-install-dir %S/Inputs/basic_darwin_toolchain_no_libcxx/usr/bin \
// RUN:     -isysroot %S/Inputs/basic_darwin_sdk \
// RUN:     -stdlib=libc++ \
// RUN:   | FileCheck -DTOOLCHAIN=%S/Inputs/basic_darwin_toolchain_no_libcxx \
// RUN:               --check-prefix=CHECK-TOOLCHAIN-LIBCXX-LINKING-2 %s
//
// RUN: %clang -### %s -v 2>&1 \
// RUN:     --target=x86_64-apple-darwin \
// RUN:     -ccc-install-dir %S/Inputs/basic_darwin_toolchain_no_libcxx/usr/bin \
// RUN:     -isysroot %S/Inputs/basic_darwin_sdk_no_libcxx \
// RUN:     -stdlib=libc++ \
// RUN:   | FileCheck -DSYSROOT=%S/Inputs/basic_darwin_sdk_no_libcxx \
// RUN:               -DTOOLCHAIN=%S/Inputs/basic_darwin_toolchain_no_libcxx \
// RUN:               --check-prefix=CHECK-TOOLCHAIN-LIBCXX-LINKING-2 %s

// Make sure that on Darwin, we use libc++ header search paths by default even when
// -stdlib= isn't passed and do not link to toolchain's libc++.dylib in this case.
//
// RUN: %clang -### %s 2>&1 \
// RUN:     --target=x86_64-apple-darwin \
// RUN:     -ccc-install-dir %S/Inputs/basic_darwin_toolchain_no_libcxx/usr/bin \
// RUN:     -isysroot %S/Inputs/basic_darwin_sdk_usr_cxx_v1 \
// RUN:   | FileCheck -DSYSROOT=%S/Inputs/basic_darwin_sdk_usr_cxx_v1 \
// RUN:               -DTOOLCHAIN=%S/Inputs/basic_darwin_toolchain_no_libcxx \
// RUN:               --check-prefix=CHECK-TOOLCHAIN-LIBCXX-LINKING-2 %s

// CHECK-TOOLCHAIN-LIBCXX-LINKING-1: "/usr/bin/ld"
// CHECK-TOOLCHAIN-LIBCXX-LINKING-1: "-L" "[[TOOLCHAIN]]/usr/bin/../lib"

// CHECK-TOOLCHAIN-LIBCXX-LINKING-2: "/usr/bin/ld"
// CHECK-TOOLCHAIN-LIBCXX-LINKING-2-NOT: "-L" "[[TOOLCHAIN]]/usr/bin/../lib"
