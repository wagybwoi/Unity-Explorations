using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PopcornController : MonoBehaviour {

	private bool collided = false;
	public GameObject kernelReference;
	public GameObject popcornBitPrefab;

	void OnCollisionEnter(Collision collision) {
		foreach (ContactPoint contact in collision.contacts) {
			if(contact.otherCollider.gameObject.name == "Base" && !collided) {
				// Change collision status
				collided = true;

				// Disappear kernel
				kernelReference.SetActive(false);

				// Add popcorn bits
				for(int i = 0; i < Random.Range(3, 6); i++) {
					GameObject newPopcornBit = Instantiate(popcornBitPrefab, this.transform);
					newPopcornBit.transform.localPosition = new Vector3 (
						Random.Range(-.5f, .5f),
						Random.Range(-.5f, .5f),
						Random.Range(-.5f, .5f)
					);
					newPopcornBit.transform.localEulerAngles = new Vector3 (
						Random.Range(0f, 90f),
						Random.Range(0f, 90f),
						Random.Range(0f, 90f)
					);
					newPopcornBit.transform.localScale = new Vector3 (
						Random.Range(0.5f, 0.8f),
						Random.Range(0.5f, 0.8f),
						Random.Range(0.5f, 0.8f)
					);

//					popcornBits.Add (newPopcornBit);
				}
				// Shoot popcorn upwards
				this.gameObject.GetComponent<Rigidbody> ().AddForce(
					new Vector3(
						Random.Range(-30.0f, 30f),
						Random.Range(80.0f, 100f),
						Random.Range(-30.0f, 30f)
					),
					ForceMode.Impulse
				);
			}
		}
	}
}
