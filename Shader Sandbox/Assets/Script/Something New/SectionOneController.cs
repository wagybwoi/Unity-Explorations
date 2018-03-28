using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SectionOneController : MonoBehaviour {

	private List<GameObject> cubes = new List<GameObject>();
	private int progress = 0;
	private int methodIndex = 0;

	void Start () {
		for(int i = 0; i < this.transform.childCount; i++) {
			cubes.Add (this.transform.GetChild (i).gameObject);
		}
		ScaleIn ();
	}

	void ScaleIn() {
		for(int i = 0; i < cubes.Count; i++) {
			iTween.MoveTo( cubes[i], iTween.Hash(
				"position", new Vector3(cubes[i].transform.position.x, 1.5f, cubes[i].transform.position.z),
				"time", 1.5f,
				"delay", (float)i/10f
			));

			iTween.ScaleTo( cubes[i], iTween.Hash(
				"scale", new Vector3(1f, 3f, 0.3f),
				"time", 1.5f,
				"delay", (float)i/10f,
				"oncomplete", "UpdateProgress",
				"oncompletetarget", this.gameObject
			));
		}
	}

	void ScaleOut() {
		for (int i = 0; i < cubes.Count; i++) {
			iTween.MoveTo( cubes[i], iTween.Hash(
				"position", new Vector3(cubes[i].transform.position.x, 0.05f, cubes[i].transform.position.z),
				"time", 1.5f,
				"delay", (float)i/10f
			));

			iTween.ScaleTo (cubes[i], iTween.Hash (
				"scale", new Vector3 (5f, 0.1f, 0.8f),
				"time", 1.5f,
				"delay", (float)i / 10f,
				"oncomplete", "UpdateProgress",
				"oncompletetarget", this.gameObject
			));
		}
	}

	public void UpdateProgress () {
		progress++;
		if(progress == cubes.Count) {
			if(methodIndex == 0) {
				progress = 0;
				methodIndex = 1;
				ScaleOut ();
			} else {
				progress = 0;
				methodIndex = 0;
				ScaleIn ();
			}
		}
	}
}
