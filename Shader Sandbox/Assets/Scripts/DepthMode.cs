﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class DepthMode : MonoBehaviour {

	private Camera cam;

	void Start () {
		cam = GetComponent<Camera>();
		cam.depthTextureMode = DepthTextureMode.Depth;
	}

}