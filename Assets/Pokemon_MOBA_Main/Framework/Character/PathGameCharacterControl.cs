using UnityEngine;
using System.Collections;

namespace WiFramework
{
    [RequireComponent(typeof(Pathfinder))]
    [RequireComponent(typeof(ScreenCaster))]
    public class PathGameCharacterControl : MonoBehaviour
    {
        private Pathfinder m_Pathfinder;
        private ScreenCaster m_ScreenCaster;

        void Start()
        {
            m_Pathfinder = GetComponent<Pathfinder>();
            m_ScreenCaster = GetComponent<ScreenCaster>();
        }

        void Update()
        {
            if(Input.GetButtonDown("Fire2"))
            {
                // Right mouse cast
                m_ScreenCaster.Cast(Input.mousePosition);
            }
            else if(Input.GetButtonDown("Skill1"))
            {
                // Fast skill casting  
                // TODO: Currently, just testing one type of skill casting,
                //          add more casting key later
                ScreenCaster.FastCast(Input.mousePosition,
                    m_ScreenCaster.CastMask, m_ScreenCaster.CameraRayLength, onFastSkillCast);
            }
        }

        void onDestinationFound(Vector3 pos)
        {
            m_Pathfinder.Target = pos;
        }

        void onFastSkillCast(Vector3 pos)
        {

        }
    }

}