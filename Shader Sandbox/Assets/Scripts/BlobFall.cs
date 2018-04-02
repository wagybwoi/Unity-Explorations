using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BlobFall : MonoBehaviour {
	float spawnTimestamp;
	public float secondsToFall;
	Vector3 landingSpot;

	void Start () {
		spawnTimestamp = Time.realtimeSinceStartup;
		secondsToFall = Random.Range (0.3f, 0.6f);
		landingSpot = new Vector3( this.transform.position.x, Random.Range(-0.2f, 0.0f), this.transform.position.z );
	}

	void Update () {
		this.transform.position = Vector3.Lerp ( this.transform.position, landingSpot, (Time.realtimeSinceStartup-spawnTimestamp)/secondsToFall );
	}
}
