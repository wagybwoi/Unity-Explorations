using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Rotato : MonoBehaviour {
	public int inverse = 1;

	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
//		transform.rotation.Set(Time.timeSinceLevelLoad / 1000, Time.timeSinceLevelLoad / 1000, Time.timeSinceLevelLoad / 1000, 1);
		transform.eulerAngles = new Vector3(
			Time.realtimeSinceStartup * 80+((4-transform.position.x)*(4-transform.position.y))/2 *inverse,
			Time.realtimeSinceStartup * 60+((4-transform.position.x)*(4-transform.position.y))/2 *inverse, 
			Time.realtimeSinceStartup * 60+((4-transform.position.x)*(4-transform.position.y))/2 *inverse
		);
	}
}
