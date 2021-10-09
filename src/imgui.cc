
#include <clasp/clasp.h>
#include <clasp/core/translators.h>
#include <iostream>
#include <imgui/align.h>
#include <imgui/seq_io.h>
#include <imgui/find.h>

using namespace imgui;


PACKAGE_USE("COMMON-LISP");
PACKAGE_NICKNAME("IG%");
NAMESPACE_PACKAGE_ASSOCIATION(imgui_,IGPkg,"IMGUI%");

namespace imgui_ {
CL_EXPOSE
void imgui_startup() {

  using namespace clbind;
  package_ ig(IGPkg);

  // Include bindings here using clbind

  
}
 
};


