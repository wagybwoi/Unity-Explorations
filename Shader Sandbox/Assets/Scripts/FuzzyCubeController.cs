using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FuzzyCubeController : MonoBehaviour {

	public GameObject furCubePrefab;
	private int cubeArraySize = 60;
	private List<GameObject> cubes = new List<GameObject>();
	private Vector3 windPosition = new Vector3(0, 0, 0);

	void Start () {
		for(float i = -cubeArraySize/2; i < cubeArraySize/2; i++) {
			for(float j = -cubeArraySize/2; j < cubeArraySize/2; j++) {
				GameObject newCube = Instantiate (furCubePrefab);
				cubes.Add (newCube);
				newCube.transform.position = new Vector3 (i/3, 0, j/3);
			}
		}
	}

	void Update () {
//		RaycastHit hit;
//		Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
//		if (Physics.Raycast (ray, out hit)) {
//			if (hit.transform != null) {
//				windPosition = hit.point;
//			}
//		}

		windPosition = new Vector3 (Mathf.Sin(Time.realtimeSinceStartup*0.8f)*10f, 0, Mathf.Cos(Time.realtimeSinceStartup*0.8f)*10f);

		foreach(GameObject cube in cubes) {
			cube.transform.LookAt (new Vector3(windPosition.x, cube.transform.position.y, windPosition.z));
			cube.transform.localEulerAngles = new Vector3 (
				-90 + Vector3.Distance(cube.transform.position, new Vector3(windPosition.x, cube.transform.position.y, windPosition.z))*5 + Random.Range(-0.5f, 0.5f),
				cube.transform.eulerAngles.y + Random.Range(-0.5f, 0.5f),
				cube.transform.eulerAngles.z + Random.Range(-0.5f, 0.5f)
			);
		}
	}
}
