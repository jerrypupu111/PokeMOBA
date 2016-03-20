using UnityEngine;
using System.Collections;

public class CharacterAnimation : MonoBehaviour {
    public Material eyeMaterial;
	// Use this for initialization
	void Start () {
        eyeMaterial.mainTextureOffset = new Vector2(0.0f,0.25f);
	}
	
	void changeEye()
    {
        
    }
	
}
