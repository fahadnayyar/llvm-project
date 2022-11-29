// RUN: %clang_cc1 -fsyntax-only -verify -Wshorten-64-to-32 %s

// rdar://10466193

int i = 0;
int j = 0;
long long ll = 0;

void test0() {
  i += ll; // expected-warning {{implicit conversion loses integer precision}}
  i -= ll; // expected-warning {{implicit conversion loses integer precision}}
  i *= ll; // expected-warning {{implicit conversion loses integer precision}}
  i /= ll; // expected-warning {{implicit conversion loses integer precision}}
}

void test1() {
  i += i-ll; // expected-warning {{implicit conversion loses integer precision}}
  i += i+ll; // expected-warning {{implicit conversion loses integer precision}}
  i -= i-ll; // expected-warning {{implicit conversion loses integer precision}}
  i -= i+ll; // expected-warning {{implicit conversion loses integer precision}}
}

void test2() {
  i += (i-j)*ll; // expected-warning {{implicit conversion loses integer precision}}
  i += (i+j)*ll; // expected-warning {{implicit conversion loses integer precision}}
}
