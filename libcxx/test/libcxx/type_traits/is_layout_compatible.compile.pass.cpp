//===----------------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include <type_traits>

struct Foo {
  int x;
  char y;
};

class Bar {
  const int u     = 42;
  volatile char v = '*';
};

enum E0 : int {};
enum class E1 : int {};

static_assert(std::is_layout_compatible_v<const void, volatile void>, "");
