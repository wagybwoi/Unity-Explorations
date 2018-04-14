using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CubeSpawner : MonoBehaviour {

	public GameObject cube_prefab;
	private int spawn_radius = 3;

	void Start () {
		bool even = spawn_radius % 2 == 0;
		Debug.Log (even);

		for(float x = -spawn_radius + (!even?1.0f:0f); x < spawn_radius; x++) {
			for(float z = -spawn_radius + (!even?1.0f:0f); z < spawn_radius; z++) {
				GameObject newCube = Instantiate (cube_prefab);
				newCube.transform.position = new Vector3(x, 0, z);
			}
		}
	}

	void Update () {
		
	}
}
