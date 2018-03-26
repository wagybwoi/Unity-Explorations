using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BlobSpawner : MonoBehaviour {
	public GameObject blobPrefab;
	float lastBlobTimeStamp;
	public float spawnIntervalSeconds;

	void Start () {
		lastBlobTimeStamp = 5f;
	}

	void Update () {
		float currentTime = Time.realtimeSinceStartup;
		if(currentTime >= lastBlobTimeStamp + spawnIntervalSeconds) {
			lastBlobTimeStamp = currentTime;
			GameObject newBlob = Instantiate (blobPrefab);
			newBlob.transform.position = new Vector3( Random.Range(-20f, 20f), 15f, Random.Range(-20f, 20f) );
			float randomSize = Random.Range (0.1f, 2.5f);
			newBlob.transform.localScale = new Vector3( randomSize, 1f, randomSize );
		}
	}
}
