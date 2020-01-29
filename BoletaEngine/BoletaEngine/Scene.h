#include "BEpch.h"
#include "GameObject.h"
#pragma once
namespace BE {
	class Scene
	{
		std::vector<GameObject> rootNodes;
	public:
		Scene();
		~Scene();
	};
}

