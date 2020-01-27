outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"


IncludeDir = {}
IncludeDir["Catch2"] = "dependencies/Catch2"
IncludeDir["glad"] = "dependencies/glad/include"
IncludeDir["glm"] = "dependencies/glm/"
IncludeDir["ImGui"] = "dependencies/imgui/"
IncludeDir["SDL"] = "dependencies/SDL/include"
IncludeDir["stb"] = "dependencies/stb"
IncludeDir["GLFW"] = "dependencies/glfw/include"

workspace "BoletaEngine"
disablewarnings { "26495" }
   architecture "x64"
   startproject("BoletaEngineClient")
   configurations { "Debug", "Release"}

   group "Dependencies"
      include "dependencies/glad"
      include "dependencies/imgui"
      include "dependencies/glfw"
      -- include "dependencies/SDL"	
   group ""

project "BoletaEngine"
   systemversion "8.1"
   architecture "x64"

   location("%{prj.name}")
   kind "StaticLib"
   language "C++"
   cppdialect "C++17"

   files { "%{prj.name}/**.h", "%{prj.name}/**.cpp", "%{prj.name}/shaders/**.*"}

   links {
      "glad",
      "GLFW"
   }
	includedirs{
		-- "%{IncludeDir.SDL}",
		"%{IncludeDir.glad}",
      "%{IncludeDir.stb}",
	}

   filter "configurations:Debug"
      defines { "DEBUG" }
      symbols "On"

   filter "configurations:Release"
      defines { "NDEBUG" }
      optimize "On"
      

   filter "action:xcode4"
      buildoptions {
         "-Wall", "-Wextra", "-Werror", "-fdeclspec"
      }
      xcodebuildsettings { 
         ["WARNING_CFLAGS"] = "-Wall -Wextra " ..
            "-Wno-missing-field-initializers " ..
            "-Wno-unknown-pragmas " ..
            "-Wno-unused-parameter " ..
            "-Wno-unused-local-typedef " ..
            "-Wno-missing-braces " ..
            "-Wno-microsoft-anon-tag ",
            ["CLANG_ENABLE_OBJC_WEAK"] = "YES",
            ["Enable Testability"] = "YES",
      }
      

project "BoletaEngineClient"
   systemversion "8.1"
   location("%{prj.name}")
   kind "ConsoleApp"
   language "C++"
   cppdialect "C++17"

   files { "%{prj.name}/**.h", "%{prj.name}/**.cpp" }

   links {
      "BoletaEngine",
      "glad",
      "GLFW",
      -- "dependencies/SDL/VisualC/SDLmain/SDLmain.vcxproj",
      -- "dependencies/SDL/VisualC/SDL/SDL.vcxproj",
      "ImGui"
   }
   libdirs { "../RecastDemo/Contrib/SDL/lib/%{cfg.architecture:gsub('x86_64', 'x64')}" }
   postbuildcommands {
      -- Copy the SDL2 dll to the Bin folder.
      -- '{COPY} "%{path.getabsolute("Contrib/SDL/lib/" .. cfg.architecture:gsub("x86_64", "x64") .. "/SDL2.dll")}" "%{cfg.targetdir}"'
   }

   includedirs{
      "BoletaEngine",
		"%{prj.name}/src",
		"%{IncludeDir.SDL}",
		"%{IncludeDir.glad}",
		"%{IncludeDir.ImGui}",
		"%{IncludeDir.glm}",
      "%{IncludeDir.stb}",
		"%{IncludeDir.GLFW}"
	}


   filter "configurations:Debug"
      defines { "DEBUG" }
      symbols "On"

   filter "configurations:Release"
      defines { "NDEBUG" }
      optimize "On"

