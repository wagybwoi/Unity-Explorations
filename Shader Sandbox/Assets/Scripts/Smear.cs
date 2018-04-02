using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Smear : MonoBehaviour {
	private Vector3 lastPos;
	private Renderer rend;
	private Vector3 direction;
	float bounds = 10;

	void Start () {
		lastPos = this.transform.position;
		direction = new Vector3( Random.Range(-0.1f, 0.1f), Random.Range(-0.1f, 0.1f), this.transform.position.z );
		rend = GetComponent<Renderer> ();
	}

	void Update () {
//		HandleInput ();
		Move ();
		HandleSmear ();
	}

	void Move() {
//		this.transform.position = Vector3.Lerp(this.transform.position, targetPos, 0.1f);
		this.transform.position = new Vector3 (this.transform.position.x + direction.x, this.transform.position.y + direction.y, this.transform.position.z);

		if( this.transform.position.x >= bounds || this.transform.position.x < -bounds ) {
			direction.x = -direction.x;
		}

		if( this.transform.position.y >= bounds || this.transform.position.y < -bounds ) {
			direction.y = -direction.y;
		}

		if(direction.magnitude < 11f) {
			direction.x *= 1.01f;
			direction.y *= 1.01f;
		}
	}

	void HandleSmear() {
		Vector3 currentPosition = this.transform.position;
		Vector3 direction = new Vector3 (currentPosition.x-lastPos.x, currentPosition.y-lastPos.y, currentPosition.z-lastPos.z);
		rend.material.SetVector ("_Direction", new Vector4(direction.x, direction.y, direction.z, 0));
		lastPos = currentPosition;
	}
}
