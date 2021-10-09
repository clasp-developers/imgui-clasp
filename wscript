import os
from wscript_utils import *

def analyze_clasp(cfg):
    pass
    
def options(cfg):
    pass

def configure(cfg):
    cfg.recurse("src")

def update_dependencies(cfg):
    print( "In update_dependencies for imgui")
    fetch_git_revision("extensions/imgui-clasp/imgui",
                       "https://github.com/ocornut/imgui.git",
                       label = "master")
    
def build(bld):
    bld.extensions_include_dirs.append("extensions/imgui-clasp/imgui/include")
    bld.recurse("src",name="build")
    
def build3(bld):
    pass

def build4(bld):
    pass

