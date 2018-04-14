using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Mover : MonoBehaviour {

	void Update () {
		this.transform.position = new Vector3 (this.transform.position.x, -18f + Mathf.FloorToInt(Mathf.Sin (Time.realtimeSinceStartup/4f)*9f), this.transform.position.z);
	}
}
