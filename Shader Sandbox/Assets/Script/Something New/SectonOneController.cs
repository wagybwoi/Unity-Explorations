using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SectonOneController : MonoBehaviour {

	private List<GameObject> cubes = new List<GameObject>();

	void Start () {
		for(int i = 0; i < this.transform.childCount; i++) {
			cubes.Add (this.transform.GetChild (i).gameObject);
//			iTween.MoveBy(this.transform.GetChild (i).gameObject, new Vector3(0, 5, 0), 2);
			iTween.MoveBy( this.transform.GetChild (i).gameObject, iTween.Hash(
				"amount", new Vector3(0, 5, 0),
				"time", 2f,
				"delay", (float)i/4f
			));
		}
	}

	void Update () {
		
	}
}
