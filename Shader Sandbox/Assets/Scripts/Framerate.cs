using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Framerate : MonoBehaviour {

	public int framerate = 24;

	// Use this for initialization
	void Start () {
		Screen.SetResolution (1920, 1080, false);
		QualitySettings.vSyncCount = 0;
		Application.targetFrameRate = framerate;
	}
	
	// Update is called once per frame
	void Update () {
		
	}
}
