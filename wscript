import os
from wscript_utils import *

def analyze_clasp(cfg):
    pass
    
def options(cfg):
    pass

def configure(cfg):
    cfg.extensions_lib.append("glfw")
    cfg.extensions_lib.append("gl")
    cfg.recurse("src")

def update_dependencies(cfg):
    print( "In update_dependencies for imgui")
    fetch_git_revision("extensions/imgui-clasp/imgui",
                       "https://github.com/ocornut/imgui.git",
                       label = "master")
    
imgui_files = [ "imgui/backends/imgui_impl_glfw.cpp",
                "imgui/backends/imgui_impl_opengl2.cpp",
                "imgui/imgui_draw.cpp",
                "imgui/imgui_widgets.cpp",
                "imgui/imgui_tables.cpp",
                "imgui/imgui.cpp"
                ]
def build(bld):
    print("Imgui build bld.path = %s" % bld.path)
    for file in imgui_files:
        node = bld.path.find_node(file)
        if (node == None):
            print("Could not find %s" % file)
        bld.extensions_source_files.append(node)
    bld.extensions_include_dirs.append("extensions/imgui-clasp/imgui")
    bld.recurse("src",name="build")
    
def build3(bld):
    pass

def build4(bld):
    pass

