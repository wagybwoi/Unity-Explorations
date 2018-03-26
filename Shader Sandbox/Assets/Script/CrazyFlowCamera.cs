using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CrazyFlowCamera : MonoBehaviour {
	private bool moving = false;

	void Update () {
		if(Input.GetMouseButtonDown(0)) moving = true;

		if(moving) {
			Vector3 newPos = new Vector3(this.transform.position.x, this.transform.position.y, this.transform.position.z - 0.001f);
			this.transform.position = newPos;
		}
	}
}
