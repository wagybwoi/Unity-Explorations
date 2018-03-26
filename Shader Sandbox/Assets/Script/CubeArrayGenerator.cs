using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CubeArrayGenerator : MonoBehaviour {
	public GameObject Cube;
	public int cubeArraySize = 30;
	public float cubeSize;

	void Start () {
		for(float i = -cubeArraySize/2; i < cubeArraySize/2; i++) {
			for(float j = -cubeArraySize/2; j < cubeArraySize/2; j++) {
				GameObject newCube = Instantiate (Cube);
				newCube.transform.position = new Vector3 (i, 0, j);
				newCube.transform.localScale = new Vector3 (cubeSize, cubeSize, cubeSize);
			}
		}
	}

	void Update () {
		
	}
}
