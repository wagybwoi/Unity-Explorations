using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraMoveAndRotate : MonoBehaviour {

	float timeToLerp = 25f;

	void Update () {
		this.transform.position = new Vector3 (this.transform.position.x, this.transform.position.y, this.transform.position.z + Time.deltaTime*6);
//		this.transform.eulerAngles = Vector3.Lerp (
//			new Vector3(42f, this.transform.eulerAngles.y, this.transform.eulerAngles.z),
//			new Vector3(5f, this.transform.eulerAngles.y, this.transform.eulerAngles.z),
//			(Time.realtimeSinceStartup)/timeToLerp
//		);
	}
}
