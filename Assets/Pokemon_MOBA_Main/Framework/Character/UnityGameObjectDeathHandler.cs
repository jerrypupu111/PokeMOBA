using UnityEngine;
using System.Collections;

namespace WiFramework
{
    /**
     * @class   UnityGameObjectDeathHandler
     *
     * @brief   An unity game object death handler.
     *          This class handle all object (with Health) death routine.
     *          Assigning a source pool implies this object is recycleable.
     *          Otherwise, this object will be destroyed after its health value == 0
     *
     * @author  Williamd
     * @date    2016/3/25
     */
    [RequireComponent(typeof(Health))]
    public class UnityGameObjectDeathHandler : MonoBehaviour
    {
        /** @brief   Source pool.   
        /** If source pool is not null, then this object is recycleable*/
        public UnityGameObjectPool SourcePool;

        /** @brief   The death time.   
        /** Time before recycling or destroying*/
        public float DeathTime;

        /** @brief   true to death.   
        /** A flag used to indicate death status */
        private bool m_Death = false;

        /** @brief   The game object.   
        /** Cached the gameObject, we assume that this component bind on this object forever.*/
        private GameObject m_GameObject;

        /** @brief   The health.   
        /** Required health component */
        private Health m_Health;

        /**
         * @fn  void onDead(int hp, int diff, int max)
         *
         * @brief   Executes the dead action.
         *          When starting, this object will register this function to Health.
         *          So when health change, it will check if hp == 0
         *
         * @author  User
         * @date    2016/3/25
         *
         * @param   hp      The hp.
         * @param   diff    The difference.
         * @param   max     The maximum.
         */

        void onDead(int hp, int diff, int max)
        {
            if(hp == 0 && !m_Death)
            {
                StartCoroutine(delayDead(DeathTime, m_GameObject));
                m_Death = true;
            }
        }

        IEnumerator delayDead(float t, GameObject obj)
        {
            yield return new WaitForSeconds(t);
            if (SourcePool != null)
            {
                SourcePool.Push(obj);
                m_Health.Reborn();
                m_Death = false;
            }
            else
                Destroy(obj);
        }

        /**
         * @fn  void Start()
         *
         * @brief   Starts this object.
         *          Cache the gameObject first (since gameObject call is still a cost)
         *          register the callback function for health, handling the health changing event
         *
         * @author  User
         * @date    2016/3/25
         */

        void Start()
        {
            m_GameObject = gameObject;

            m_Health = GetComponent<Health>();
            m_Health.SingleValueChangeListeners += onDead;
        }
    }
}
