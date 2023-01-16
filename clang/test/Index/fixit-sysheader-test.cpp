// RUN: c-index-test -test-load-source all %s 2>&1 | FileCheck %s
// CHECK: Number FIX-ITs = 0
// CHECK-NEXT: {{.*? candidate constructor not viable}}

#include "../../../libcxx/include/string_view"

int main()
{
  char* str{};
  std::string_view(str, str + 10);
}
