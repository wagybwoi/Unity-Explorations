using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PopcornSpawner : MonoBehaviour {

	public GameObject popcornPrefab;

	void Start () {
		for(int i = 0; i < 150; i++) {
			GameObject newPopcorn = Instantiate (popcornPrefab);
			newPopcorn.transform.position = new Vector3 ( Random.Range(-10f, 10f), Random.Range(25f, 32f), Random.Range(-10f, 10f) );
			newPopcorn.transform.localEulerAngles = new Vector3 (
				Random.Range(0f, 90f),
				Random.Range(0f, 90f),
				Random.Range(0f, 90f)
			);
		}
	}
}
