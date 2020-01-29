#pragma once
#include "Scene.h"
namespace BE
{
	class Engine
	{
	public:
		Engine();
		~Engine();

		Scene& LoadScene(const std::string& path);
		void Render();
	};
}
