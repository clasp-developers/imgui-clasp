
#include <clasp/clasp.h>
#include <clasp/core/translators.h>
#include <iostream>
#include "imgui_internal.h"
#include "imgui.h"

//using namespace imgui;


PACKAGE_USE("COMMON-LISP");
PACKAGE_NICKNAME("IG%");
NAMESPACE_PACKAGE_ASSOCIATION(imgui_,IGPkg,"IMGUI%");

namespace imgui_ {
CL_EXPOSE
void imgui_startup() {

  using namespace clbind;
  package_ ig(IGPkg);

  // Include bindings here using clbind

  printf("%s:%d:%s Initilizing IMGUI\n", __FILE__, __LINE__, __FUNCTION__ );
  IMGUI_CHECKVERSION();


  class_<ImFontAtlas>( ig, "ImFontAtlas"_raw)
      ;
  class_<ImGuiContext>( ig, "ImGuiContext"_raw)
      ;
  class_<ImGuiIO>( ig, "ImGuiIO"_raw)
      .def_readonly("Fonts"_raw, &ImGuiIO::Fonts ) // , +[]()->ImFontAtlas* { return this->Fonts; } )
      ;
  ig.def("CreateContext(ImFontAtlas*)"_raw,+[]( ImFontAtlas* fa) { return ImGui::CreateContext(fa); } );
  ig.def("GetIO()"_raw,+[]() { return ImGui::GetIO(); } );
  
  
}
 
};


