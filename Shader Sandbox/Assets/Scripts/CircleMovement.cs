using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CircleMovement : MonoBehaviour {

	public float offset;
	public GameObject cam;

	void Start () {
		
	}

	void Update () {
		if(cam) cam.transform.position = new Vector3 (5f + Time.realtimeSinceStartup*1.5f, cam.transform.position.y, cam.transform.position.z);
		this.transform.position = new Vector3 (
			Time.realtimeSinceStartup*1.5f,
			Mathf.Sin(Time.realtimeSinceStartup*1f + offset) * Mathf.Sin(Time.realtimeSinceStartup*1f)*1f,
			Mathf.Cos(Time.realtimeSinceStartup*1f + offset) * Mathf.Sin(Time.realtimeSinceStartup*1f)*1f
		);
	}
}
