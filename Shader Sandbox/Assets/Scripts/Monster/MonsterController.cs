using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MonsterController : MonoBehaviour {

	public GameObject loosePiece;
	public GameObject eye;
	public GameObject pupil;
	public GameObject newPiece;

	void Start () {
		PushLoosePiece ();
	}

	void PushLoosePiece() {
		iTween.MoveTo( loosePiece, iTween.Hash(
			"position", new Vector3(loosePiece.transform.position.x, loosePiece.transform.position.y, 4.05f),
			"time", 1.0f,
			"delay", 2f,
			"oncomplete", "AddRigidbody",
			"oncompletetarget", this.gameObject
		));
	}

	void AddRigidbody() {
		loosePiece.AddComponent<Rigidbody> ();
		MoveEye ();
	}

	void MoveEye() {
		iTween.MoveTo( eye, iTween.Hash(
			"position", new Vector3(eye.transform.position.x, eye.transform.position.y, 4f),
			"time", 1.0f,
			"delay", 0.5f,
			"easetype", iTween.EaseType.easeOutQuad,
			"oncomplete", "LookAround1",
			"oncompletetarget", this.gameObject
		));
	}

	void LookAround1() {
		iTween.MoveTo( pupil, iTween.Hash(
			"position", new Vector3(eye.transform.position.x + 0.3f, eye.transform.position.y + 0.3f, pupil.transform.position.z),
			"time", 0.5f,
			"delay", 0.1f,
			"easetype", iTween.EaseType.easeInOutQuint,
			"oncomplete", "LookAround2",
			"oncompletetarget", this.gameObject
		));
	}

	void LookAround2() {
		iTween.MoveTo( pupil, iTween.Hash(
			"position", new Vector3(eye.transform.position.x - 0.3f, eye.transform.position.y + 0.3f, pupil.transform.position.z),
			"time", 0.5f,
			"delay", 0.1f,
			"easetype", iTween.EaseType.easeInOutQuint,
			"oncomplete", "LookAround3",
			"oncompletetarget", this.gameObject
		));
	}

	void LookAround3() {
		iTween.MoveTo( pupil, iTween.Hash(
			"position", new Vector3(eye.transform.position.x + 0.3f, eye.transform.position.y - 0.3f, pupil.transform.position.z),
			"time", 0.5f,
			"delay", 0.1f,
			"easetype", iTween.EaseType.easeInOutQuint,
			"oncomplete", "ResetLook",
			"oncompletetarget", this.gameObject
		));
	}

	void ResetLook() {
		iTween.MoveTo( pupil, iTween.Hash(
			"position", new Vector3(eye.transform.position.x, eye.transform.position.y, pupil.transform.position.z),
			"time", 0.5f,
			"delay", 0.1f,
			"easetype", iTween.EaseType.easeInOutQuint,
			"oncomplete", "MoveBack",
			"oncompletetarget", this.gameObject
		));
	}

	void MoveBack() {
		iTween.MoveTo( eye, iTween.Hash(
			"position", new Vector3(eye.transform.position.x, eye.transform.position.y, 22f),
			"time", 1.3f,
			"delay", 0.5f,
			"easetype", iTween.EaseType.easeInOutQuad,
			"oncomplete", "Replace",
			"oncompletetarget", this.gameObject
		));
	}

	void Replace() {
		iTween.MoveTo( newPiece, iTween.Hash(
			"position", new Vector3(newPiece.transform.position.x, newPiece.transform.position.y, 6f),
			"time", 1.0f,
			"delay", 0.0f,
			"easetype", iTween.EaseType.easeOutQuad
		));
	}
}
