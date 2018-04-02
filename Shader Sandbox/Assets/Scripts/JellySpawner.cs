using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class JellySpawner : MonoBehaviour {

	public GameObject jellyPrefab;
	private int jellyCount = 30;

	void Start () {
		for(int i = 0; i < jellyCount; i++) {
			GameObject newJelly = Instantiate(jellyPrefab);
			newJelly.transform.position = new Vector3( Random.Range(-5f, 5f), Random.Range(-10f, -4f), Random.Range(15f, 25f) );
		}
	}
}
