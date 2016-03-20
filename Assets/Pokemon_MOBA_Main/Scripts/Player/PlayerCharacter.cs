using UnityEngine;
using System.Collections;

public class PlayerCharacter : MonoBehaviour {

	public Rigidbody rigidbody;
	
	NavMeshAgent agent;
	// Use this for initialization
	void Awake() {
		rigidbody = GetComponent<Rigidbody>();
		agent = GetComponent<NavMeshAgent>();
	}
	void Start () {
		//agent.destination = goal.position; 
	}
	// Update is called once per frame
	void Update () {
	
	}
	public void setDestination(Vector3 position)
	{
		rigidbody.velocity = Vector3.zero;
		rigidbody.angularVelocity = Vector3.zero;
		agent.destination = position;
		
	}
}
