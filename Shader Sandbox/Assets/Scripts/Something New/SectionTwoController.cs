using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SectionTwoController : MonoBehaviour {

	public GameObject cube;

	void Start () {
		Squish ();
	}

	void Update () {
		
	}

	void Squish() {
		// Squish
//		iTween.MoveTo (cube, iTween.Hash (
//			"position", new Vector3 (cube.transform.position.x, 0.2f, cube.transform.position.z),
//			"time", 0.5f,
//			"delay", 1f,
//			"easetype", iTween.EaseType.easeInOutQuad
//		));

		iTween.ScaleTo (cube, iTween.Hash (
			"scale", new Vector3 (2f, 0.3f, 2f),
			"time", 0.5f,
			"delay", 1f,
			"easetype", iTween.EaseType.easeInOutQuad,
			"oncomplete", "SpinJump",
			"oncompletetarget", this.gameObject
		));
	}

	void SpinJump() {
		// Spin Jump
		iTween.MoveTo( cube, iTween.Hash(
			"position", new Vector3(cube.transform.position.x, 4f, cube.transform.position.z),
			"time", 1f,
			"delay", 0f,
			"easetype", iTween.EaseType.easeOutQuad
		));

		iTween.ScaleTo( cube, iTween.Hash(
			"scale", new Vector3(0.5f, 2f, 0.5f),
			"time", 0.5f, 
			"delay", 0f,
			"easetype", iTween.EaseType.linear
		));

		iTween.ScaleTo( cube, iTween.Hash(
			"scale", new Vector3(1.5f, 0.8f, 1.5f),
			"time", 0.5f,
			"delay", 0.5f,
			"easetype", iTween.EaseType.linear
		));

		iTween.RotateBy( cube, iTween.Hash(
			"amount", new Vector3(0f, 2f, 0f),
			"time", 1.2f,
			"delay", 0f,
			"easetype", iTween.EaseType.easeOutQuad,
			"oncomplete", "Slam",
			"oncompletetarget", this.gameObject
		));
	}

	void Slam() {
		// Slam
		iTween.MoveTo (cube, iTween.Hash (
			"position", new Vector3 (cube.transform.position.x, 0f, cube.transform.position.z),
			"time", 0.2f,
			"delay", 0f,
			"easetype", iTween.EaseType.linear
		));

		iTween.ScaleTo( cube, iTween.Hash(
			"scale", new Vector3(1f, 3f, 1f),
			"time", 0.2f,
			"delay", 0f,
			"easetype", iTween.EaseType.linear
		));

		iTween.ScaleTo( cube, iTween.Hash(
			"scale", new Vector3(1f, 1f, 1f),
			"time", 0.5f,
			"delay", 0.2f,
			"easetype", iTween.EaseType.easeOutElastic
		));
	}
}
