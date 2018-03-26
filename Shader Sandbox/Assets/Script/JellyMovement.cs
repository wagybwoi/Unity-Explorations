using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class JellyMovement : MonoBehaviour {

	public float speed = 0.01f;
	private Material mat;
	private float amplitude;
	private float frequency;
	private float startTime;

	void Start () {
		startTime = Random.Range (0f, 10f);

		Renderer rend = GetComponent<Renderer>();
		rend.material.shader = Shader.Find("CookbookShaders/TestVertices");

		amplitude = rend.material.GetFloat("_Amplitude");
		frequency = rend.material.GetFloat("_Frequency");
	}

	void Update () {
		if(Time.realtimeSinceStartup > startTime) {
			transform.position = new Vector3(
				transform.position.x,
				transform.position.y + (((Mathf.Sin(Time.realtimeSinceStartup + frequency) + 1f)/5f) * amplitude)/10,
				transform.position.z
			);
		}
	}
}
