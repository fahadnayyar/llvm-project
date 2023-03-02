#include "clang/AST/ASTContext.h"
#include "clang/AST/Type.h"

bool isLayoutCompatible(clang::ASTContext &C, clang::QualType T1,
                        clang::QualType T2);