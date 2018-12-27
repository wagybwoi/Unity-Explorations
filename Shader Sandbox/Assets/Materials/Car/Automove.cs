using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Automove : MonoBehaviour {

	public Vector3 direction = new Vector3(0f, 0f, 0f);

	void Update () {
		this.transform.position += direction;
	}
}
