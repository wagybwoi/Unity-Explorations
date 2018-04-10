using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MegacubeController : MonoBehaviour {

	public GameObject cubePrefab;
	private int gridSize = 9;
	private int boxSize = 5;
	private float cubeScale = 7f;
	private GridSection[,,] grid;

	void Start () {
		// Define grid
		grid = new GridSection[gridSize, gridSize, gridSize];

		// Create grid
		for(int z = 0; z < gridSize; z++) {
			for(int y = 0; y < gridSize; y++) {
				for(int x = 0; x < gridSize; x++) {
					grid[x, y, z] = new GridSection(
						new Vector3(
							(x*cubeScale) - Mathf.FloorToInt((gridSize/2)*cubeScale),
							(y*cubeScale) - Mathf.FloorToInt((gridSize/2)*cubeScale),
							(z*cubeScale) - Mathf.FloorToInt((gridSize/2)*cubeScale)
						)
					);

					if(	x >= Mathf.FloorToInt(gridSize/2) - Mathf.FloorToInt(boxSize/2) && x <= Mathf.FloorToInt(gridSize/2) + Mathf.FloorToInt(boxSize/2)
					&&	y >= Mathf.FloorToInt(gridSize/2) - Mathf.FloorToInt(boxSize/2) && y <= Mathf.FloorToInt(gridSize/2) + Mathf.FloorToInt(boxSize/2)
					&&	z >= Mathf.FloorToInt(gridSize/2) - Mathf.FloorToInt(boxSize/2) && z <= Mathf.FloorToInt(gridSize/2) + Mathf.FloorToInt(boxSize/2)) {
						var newCube = Instantiate (cubePrefab);
						newCube.transform.localScale = new Vector3(cubeScale, cubeScale, cubeScale);
						newCube.transform.position = grid[x, y, z].worldPos;
						grid [x, y, z].Occupy (newCube);
					}
				}
			}
		}

		// Test movement on random cube
		GridSection randomSection = null;
		int counter = 0;

		while (randomSection == null && counter < 20) {
			GridSection r = grid[ Random.Range(0, gridSize-1), Random.Range(0, gridSize-1), Random.Range(0, gridSize-1)];
			if (r.occupied)
				randomSection = r;

			counter++;
		}

		// Left: x-1

		// Right: x+1

		// Up: y+1

		// Down: y-1

		// Forward: z+1

		// Back: z-1


		// Start periodic movement coroutine
	}

	private void MoveCubeToSection(GridSection start, GridSection end) {
//		iTween.MoveTo( cubes[i], iTween.Hash(
//			"position", new Vector3(cubes[i].transform.position.x, 1.5f, cubes[i].transform.position.z),
//			"time", 0.5f,
//			"delay", (float)i/10f
//		));
	}
}


public class GridSection {
	public bool occupied;
	public GameObject occupiedObjectReference;
	public Vector3 worldPos;

	public GridSection(Vector3 worldPosition) {
		this.worldPos = worldPosition;
		this.occupied = false;
	}

	public GridSection(Vector3 worldPosition, GameObject occupiedObject) {
		this.worldPos = worldPosition;
		this.occupiedObjectReference = occupiedObject;
		this.occupied = true;
	}

	public void Occupy(GameObject occupyingObjectReference) {
		this.occupiedObjectReference = occupyingObjectReference;
		this.occupied = true;
	}
}