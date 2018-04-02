using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PixelDensity : MonoBehaviour {

	void Start () {
//		Camera cam = this.GetComponent<Camera> ();
//		Debug.Log ("width = " + cam.pixelWidth + " height = " + cam.pixelHeight);
//		Screen.SetResolution (Screen.width/10, Screen.height/10, false);
		Debug.Log(Screen.currentResolution);
		Screen.SetResolution (100, 50, false);
		Debug.Log(Screen.currentResolution);
	}

	void Update () {
		
	}
}
