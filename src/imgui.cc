
#include <clasp/clasp.h>
#include <clasp/core/translators.h>
#include <iostream>
#include "imgui_internal.h"
#include "imgui.h"
#include "backends/imgui_impl_glfw.h"
#include "backends/imgui_impl_opengl2.h"
#include <stdio.h>
#ifdef __APPLE__
#define GL_SILENCE_DEPRECATION
#endif
#include <GLFW/glfw3.h>

//using namespace imgui;

namespace imgui_ {
  struct UnsignedCharStar {
    unsigned char* _Pointer;
    UnsignedCharStar() : _Pointer(NULL) {};
    UnsignedCharStar(unsigned char* p) : _Pointer(p) {};
  };
};

namespace translate {
template <>
struct from_object<imgui_::UnsignedCharStar*, std::false_type> {
  typedef imgui_::UnsignedCharStar DeclareType;
  DeclareType _v;
  from_object(T_P o) {};
  ~from_object() {/*non trivial*/};
};

#if 0
template <>
struct to_object<unsigned char**, translate::dont_adopt_pointer> {
  typedef unsigned char** DeclareType;
  DeclareType _v;
  static core::T_sp convert( DeclareType val ) {
    core::T_sp oi = core::Pointer_O::create(val);
    return oi;
  }
};
#endif
  
};


extern "C" {
  
  void imguiPERCENT__Text(const char* fmt, ...) {
    va_list ap;
    va_start(ap, fmt);
    ImGui::TextV( fmt, ap );
    va_end(ap);
  }
};








static void glfw_error_callback(int error, const char* description)
{
    fprintf(stderr, "Glfw Error %d: %s\n", error, description);
}


int imgui_main()
{
    // Setup window
    glfwSetErrorCallback(glfw_error_callback);
    if (!glfwInit())
        return 1;
    GLFWwindow* window = glfwCreateWindow(1280, 720, "Dear ImGui GLFW+OpenGL2 example", NULL, NULL);
    if (window == NULL)
        return 1;
    glfwMakeContextCurrent(window);
    glfwSwapInterval(1); // Enable vsync

    // Setup Dear ImGui context
    IMGUI_CHECKVERSION();
    ImGui::CreateContext();
    ImGuiIO& io = ImGui::GetIO(); (void)io;
    //io.ConfigFlags |= ImGuiConfigFlags_NavEnableKeyboard;     // Enable Keyboard Controls
    //io.ConfigFlags |= ImGuiConfigFlags_NavEnableGamepad;      // Enable Gamepad Controls

    // Setup Dear ImGui style
    ImGui::StyleColorsDark();
    //ImGui::StyleColorsClassic();

    // Setup Platform/Renderer backends
    ImGui_ImplGlfw_InitForOpenGL(window, true);
    ImGui_ImplOpenGL2_Init();

    // Load Fonts
    // - If no fonts are loaded, dear imgui will use the default font. You can also load multiple fonts and use ImGui::PushFont()/PopFont() to select them.
    // - AddFontFromFileTTF() will return the ImFont* so you can store it if you need to select the font among multiple.
    // - If the file cannot be loaded, the function will return NULL. Please handle those errors in your application (e.g. use an assertion, or display an error and quit).
    // - The fonts will be rasterized at a given size (w/ oversampling) and stored into a texture when calling ImFontAtlas::Build()/GetTexDataAsXXXX(), which ImGui_ImplXXXX_NewFrame below will call.
    // - Read 'docs/FONTS.md' for more instructions and details.
    // - Remember that in C/C++ if you want to include a backslash \ in a string literal you need to write a double backslash \\ !
    //io.Fonts->AddFontDefault();
    //io.Fonts->AddFontFromFileTTF("../../misc/fonts/Roboto-Medium.ttf", 16.0f);
    //io.Fonts->AddFontFromFileTTF("../../misc/fonts/Cousine-Regular.ttf", 15.0f);
    //io.Fonts->AddFontFromFileTTF("../../misc/fonts/DroidSans.ttf", 16.0f);
    //io.Fonts->AddFontFromFileTTF("../../misc/fonts/ProggyTiny.ttf", 10.0f);
    //ImFont* font = io.Fonts->AddFontFromFileTTF("c:\\Windows\\Fonts\\ArialUni.ttf", 18.0f, NULL, io.Fonts->GetGlyphRangesJapanese());
    //IM_ASSERT(font != NULL);

    // Our state
    bool show_demo_window = true;
    bool show_another_window = false;
    ImVec4 clear_color = ImVec4(0.45f, 0.55f, 0.60f, 1.00f);

    // Main loop
    while (!glfwWindowShouldClose(window))
    {
        // Poll and handle events (inputs, window resize, etc.)
        // You can read the io.WantCaptureMouse, io.WantCaptureKeyboard flags to tell if dear imgui wants to use your inputs.
        // - When io.WantCaptureMouse is true, do not dispatch mouse input data to your main application.
        // - When io.WantCaptureKeyboard is true, do not dispatch keyboard input data to your main application.
        // Generally you may always pass all inputs to dear imgui, and hide them from your application based on those two flags.
        glfwPollEvents();

        // Start the Dear ImGui frame
        ImGui_ImplOpenGL2_NewFrame();
        ImGui_ImplGlfw_NewFrame();
        ImGui::NewFrame();

        // 1. Show the big demo window (Most of the sample code is in ImGui::ShowDemoWindow()! You can browse its code to learn more about Dear ImGui!).
        if (show_demo_window)
            ImGui::ShowDemoWindow(&show_demo_window);

        // 2. Show a simple window that we create ourselves. We use a Begin/End pair to created a named window.
        {
            static float f = 0.0f;
            static int counter = 0;

            ImGui::Begin("Hello, world!");                          // Create a window called "Hello, world!" and append into it.

            ImGui::Text("This is some useful text.");               // Display some text (you can use a format strings too)
            ImGui::Checkbox("Demo Window", &show_demo_window);      // Edit bools storing our window open/close state
            ImGui::Checkbox("Another Window", &show_another_window);

            ImGui::SliderFloat("float", &f, 0.0f, 1.0f);            // Edit 1 float using a slider from 0.0f to 1.0f
            ImGui::ColorEdit3("clear color", (float*)&clear_color); // Edit 3 floats representing a color

            if (ImGui::Button("Button"))                            // Buttons return true when clicked (most widgets return true when edited/activated)
                counter++;
            ImGui::SameLine();
            ImGui::Text("counter = %d", counter);

            ImGui::Text("Application average %.3f ms/frame (%.1f FPS)", 1000.0f / ImGui::GetIO().Framerate, ImGui::GetIO().Framerate);
            ImGui::End();
        }

        // 3. Show another simple window.
        if (show_another_window)
        {
            ImGui::Begin("Another Window", &show_another_window);   // Pass a pointer to our bool variable (the window will have a closing button that will clear the bool when clicked)
            ImGui::Text("Hello from another window!");
            if (ImGui::Button("Close Me"))
                show_another_window = false;
            ImGui::End();
        }

        // Rendering
        ImGui::Render();
        int display_w, display_h;
        glfwGetFramebufferSize(window, &display_w, &display_h);
        glViewport(0, 0, display_w, display_h);
        glClearColor(clear_color.x * clear_color.w, clear_color.y * clear_color.w, clear_color.z * clear_color.w, clear_color.w);
        glClear(GL_COLOR_BUFFER_BIT);

        // If you are using this code with non-legacy OpenGL header/contexts (which you should not, prefer using imgui_impl_opengl3.cpp!!),
        // you may need to backup/reset/restore other state, e.g. for current shader using the commented lines below.
        //GLint last_program;
        //glGetIntegerv(GL_CURRENT_PROGRAM, &last_program);
        //glUseProgram(0);
        ImGui_ImplOpenGL2_RenderDrawData(ImGui::GetDrawData());
        //glUseProgram(last_program);

        glfwMakeContextCurrent(window);
        glfwSwapBuffers(window);
    }

    // Cleanup
    ImGui_ImplOpenGL2_Shutdown();
    ImGui_ImplGlfw_Shutdown();
    ImGui::DestroyContext();

    glfwDestroyWindow(window);
    glfwTerminate();

    return 0;
}





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


  class_<ImVec2>( ig, "ImVec2"_raw )
    .def_constructor( "ImVec2"_raw, constructor<int,int>() )
    .def_readonly("x"_raw, &ImVec2::x)
    .def_readonly("y"_raw, &ImVec2::y)
    ;
  class_<ImFontAtlas>( ig, "ImFontAtlas"_raw)
    ;

  class_<UnsignedCharStar>( ig, "UnsignedChar*"_raw)
    ;
  ig.def("GetTexDataAsRGBA32(ImFontAtlas&,UnsignedCharStar&,int&,int&,int&)"_raw,
	 +[]( ImFontAtlas& io, UnsignedCharStar& out_pixels, int& tex_w, int& tex_h, int& out_bytes_per_pixel ) {
	   io.GetTexDataAsRGBA32( &out_pixels._Pointer, &tex_w, &tex_h, &out_bytes_per_pixel );
	 }
	 ,pureOutValue<1>()
	 ,pureOutValue<2>()
	 ,pureOutValue<3>()
	 ,pureOutValue<4>()
	 );
  
  class_<ImGuiContext>( ig, "ImGuiContext"_raw)
      ;
  class_<ImGuiIO>( ig, "ImGuiIO"_raw)
      .def_readonly("Fonts"_raw, &ImGuiIO::Fonts ) // , +[]()->ImFontAtlas* { return this->Fonts; } )
      .def_readwrite("DisplaySize"_raw, &ImGuiIO::DisplaySize ) // , +[]()->ImFontAtlas* { return this->Fonts; } )
      .def_readwrite("DeltaTime"_raw, &ImGuiIO::DeltaTime )
      ;
  ig.def("CreateContext(ImFontAtlas*)"_raw,+[]( ImFontAtlas* fa) { return ImGui::CreateContext(fa); } );
  ig.def("GetIO()"_raw,+[]() -> ImGuiIO& { return ImGui::GetIO(); } );
  ig.def("NewFrame()"_raw,+[]() { return ImGui::NewFrame(); } );
    //    ig.def("Text(const char*,List_sp)"_raw, +[](const char* fmt, List_sp args) {


  ig.def("Render()"_raw,&ImGui::Render);
}
 
};


