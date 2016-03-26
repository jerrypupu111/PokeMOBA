using UnityEngine;
using System.Collections;

namespace WiFramework
{
    public delegate void CastAction(Vector3 pos);

    /**
     * @class   ScreenCaster
     *
     * @brief   A screen caster.
     *          Project a screen space point to game scene. When hit some object with specific mask,
     *          cast actions will be invoked with passing projection point.
     *
     * @author  Williamd
     * @date    2016/3/25
     */

    public class ScreenCaster : MonoBehaviour
    {
        public LayerMask CastMask;
        public float CameraRayLength = 1000f;

        public event CastAction CastActions;

        public void Cast(Vector3 screenPosition)
        {
            Vector3 projectPosition;
            if(tryCast(screenPosition, CastMask, CameraRayLength, out projectPosition))
            {
                if (CastActions != null)
                {
                    CastActions(projectPosition);
                }
            }
        }

        public static void FastCast(Vector3 screenPosition, 
            LayerMask CastMask, float CameraRayLength, CastAction action)
        {
            Vector3 projectPosition;
            if (tryCast(screenPosition, CastMask, CameraRayLength, out projectPosition))
            {
                action(projectPosition);
            }
        }

        private static bool tryCast(Vector3 screenPosition,
            LayerMask CastMask, float CameraRayLength, out Vector3 projectPosition)
        {
            Ray camRay = Camera.main.ScreenPointToRay(screenPosition);
            RaycastHit floorHit;

            if (Physics.Raycast(camRay, out floorHit, CameraRayLength, CastMask))
            {
                projectPosition = floorHit.point;
                return true;
            }

            projectPosition = default(Vector3);
            return false;
        }
    }

}