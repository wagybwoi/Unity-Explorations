using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CubeRotato : MonoBehaviour {
	private Vector3 rotationVector;

	void Start () {
		rotationVector = new Vector3 (Random.Range(-0.5f, 0.5f), Random.Range(-0.5f, 0.5f), Random.Range(-0.5f, 0.5f));
	}

	void Update () {
		this.transform.eulerAngles = new Vector3 (this.transform.eulerAngles.x + rotationVector.x, this.transform.eulerAngles.y + rotationVector.y, this.transform.eulerAngles.z + rotationVector.z);
	}
}
