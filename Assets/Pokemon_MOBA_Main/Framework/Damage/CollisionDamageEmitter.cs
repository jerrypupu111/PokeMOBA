using UnityEngine;
using System.Collections;
using System.Collections.Generic;

namespace WiFramework
{
    [RequireComponent(typeof(Collider))]
    public class CollisionDamageEmitter : MonoBehaviour
    {
        /** @brief   The possible target tags.   
        /**             define tags of those who can be damaged*/
        [SerializeField]
        private string[] m_PossibleTargetTags;

        /** @brief   The damage.   
        /**             define emitting damage type*/
        [SerializeField]
        private Damage m_Damage;

        /** @brief   The damageable cache.  
        /**             Since each [Collider, DamageReceiver] pair won 't change through the whole game  
        /**             Cache can reduce overhead of GetComponent() */
        private Dictionary<Collider, DamageReceiver> m_DamageableCache = 
            new Dictionary<Collider, DamageReceiver>();

        /**
         * @fn  void OnTriggerEnter(Collider other)
         *
         * @brief   Executes the trigger enter action.
         *
         * @author  Williamd
         * @date    2016/3/23
         *
         * @param   other   The other.
         */

        void OnTriggerEnter(Collider other)
        {
            if(isValid(other))
            {
                DamageReceiver receiver;
                if (m_DamageableCache.TryGetValue(other, out receiver))
                {
                    receiver.OnEnterDamage(m_Damage);
                }
                else
                {
                    receiver = other.GetComponent<DamageReceiver>();
                    if (receiver != null)
                    {
                        m_DamageableCache.Add(other, receiver);
                        receiver.OnEnterDamage(m_Damage);
                    }
                }
            }
        }

        /**
         * @fn  void OnTriggerStay(Collider other)
         *
         * @brief   Executes the trigger stay action.
         *
         * @author  Williamd
         * @date    2016/3/23
         *
         * @param   other   The other.
         */

        void OnTriggerStay(Collider other)
        {
            if(isValid(other))
            {
                DamageReceiver receiver;
                if (m_DamageableCache.TryGetValue(other, out receiver))
                {
                    receiver.OnStayDamage(m_Damage);
                }
                else
                {
                    receiver = other.GetComponent<DamageReceiver>();
                    if (receiver != null)
                    {
                        m_DamageableCache.Add(other, receiver);
                        receiver.OnStayDamage(m_Damage);
                    }
                }
            }
        }

        /**
         * @fn  void OnTriggerExit(Collider other)
         *
         * @brief   Executes the trigger exit action.
         *
         * @author  Williamd
         * @date    2016/3/23
         *
         * @param   other   The other.
         */

        void OnTriggerExit(Collider other)
        {
            if(isValid(other))
            {
                DamageReceiver receiver;
                if (m_DamageableCache.TryGetValue(other, out receiver))
                {
                    receiver.OnStayDamage(m_Damage);
                }
                else
                {
                    receiver = other.GetComponent<DamageReceiver>();
                    if (receiver != null)
                    {
                        receiver.OnExitDamage(m_Damage);
                    }
                }
            }
        }

        /**
         * @fn  bool isValid(Collider collider)
         *
         * @brief   Query if 'collider' is valid.
         *          Check tags is in possiable tags
         *
         * @author  Williamd
         * @date    2016/3/23
         *
         * @param   collider    The collider.
         *
         * @return  true if valid, false if not.
         */

        bool isValid(Collider collider)
        {
            foreach (string tag in m_PossibleTargetTags)
                if (collider.CompareTag(tag))
                    return true;
            return false;
        }
    }
}
