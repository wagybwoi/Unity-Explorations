using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ApplyMaterialToChildren : MonoBehaviour {
	public Material newMaterial;

	void Start() {
		setMaterial (this.transform, newMaterial);
	}

	void setMaterial(Transform t, Material mat) {
		foreach(Transform child in transform)
		{
			setMaterial(child, mat);
			child.GetComponent<Renderer>().material = mat;
			Debug.Log("Ey fuk");
		}
	}

}