using UnityEngine;
using System.Collections;

public class PlayerController : MonoBehaviour {

	// Use this for initialization
	void Start () {
		
		mTarget = player.transform.position;
	}
	
	Vector3 mTarget;
	Vector2 mMousePress;
	public PlayerCharacter player;
	// Update is called once per frame
	void Update () {
	
		if (Input.GetKey(KeyCode.Mouse1))
		{
			mMousePress = Input.mousePosition;
			Debug.Log("right Key down");
			RaycastHit hit;
			Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
			
			if (Physics.Raycast(ray, out hit, 300f, LayerMask.GetMask("Terrian")))
			{
				mTarget = hit.point;
			}
			
			player.setDestination(mTarget);
			/*
			float dist = Vector3.Distance(player.transform.position, mTarget);
			if (dist > 0.001f)
			{
				Vector3 delta = mTarget-target.transform.position;
				target.transform.rotation = Quaternion.LookRotation(delta);
				Vector3 xy = new Vector3(delta.x,delta.y,0);
				target.rigidbody.velocity = xy.normalized * 10;
				//Vector3 newPos = Vector3.MoveTowards(target.transform.position, mTarget, 10f * Time.deltaTime);
				//newPos.y = Terrain.activeTerrain.SampleHeight(newPos);
				//target.transform.position = newPos;
			}
			*/
		}
		
		
	}
}
