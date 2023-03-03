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

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-private-field"

class Bar {
  const int u     = 42;
  volatile char v = '*';
};

#pragma clang diagnostic pop

enum E0 : int {};
enum class E1 : int {};

static_assert(std::is_layout_compatible_v<const void, volatile void>, "");
static_assert(std::is_layout_compatible_v<Foo, Bar>, "");
static_assert(!std::is_layout_compatible_v<Foo[2], Bar[2]>, "");
static_assert(!std::is_layout_compatible_v<int, E0>, "");
static_assert(std::is_layout_compatible_v<E0, E1>, "");
static_assert(!std::is_layout_compatible_v<long, unsigned long>, "");
static_assert(!std::is_layout_compatible_v<char*, const char*>, "");
static_assert(std::is_layout_compatible_v<char*, char* const>, "");
