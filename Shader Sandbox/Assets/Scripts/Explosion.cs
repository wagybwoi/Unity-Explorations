using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Explosion : MonoBehaviour {

	public float size = 0;
	public float acceleration = 0f;
	public float accelerationDamping = 0.98f;
	public float explosionAcceleration = 5f;

	public float deceleration = -0.01f;
	public Camera cam;

	public float delayInSeconds = 0f;

	void Start() {
		StartCoroutine(Delay());
	}

	void Update () {
		// if(Input.GetMouseButtonDown(0)) {
		// 	RaycastHit hit;
		// 	Ray ray = cam.ScreenPointToRay(Input.mousePosition);
			
		// 	if (Physics.Raycast(ray, out hit)) SpawnExplosion(hit.point);
		// }

		acceleration *= accelerationDamping;
		size = Mathf.Clamp(size+acceleration+deceleration, 0f, 1000f);

		this.GetComponent<Renderer>().material.SetFloat("_VertexMultiplier", size);
	}

	void SpawnExplosion(Vector3 pos) {
		this.transform.position = pos;

		size = 0f;
		acceleration = explosionAcceleration;

		Debug.Log("BOOM");
	}

	IEnumerator Delay()
    {
        yield return new WaitForSeconds(delayInSeconds);
		SpawnExplosion(this.transform.position);
    }
}
