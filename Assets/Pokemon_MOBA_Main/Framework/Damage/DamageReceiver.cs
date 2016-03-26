using UnityEngine;
using System.Collections;
using System.Collections.Generic;

namespace WiFramework
{
    [System.Serializable]
    public struct DamageTypeImmortalTimeEditorEntry
    {
        public DamageType Type;
        public float ImmortalTime;
    }

    public delegate void DamageListner(Damage damge);

    /**
     * @class   DamageReceiver
     *
     * @brief   A damage receiver.
     *          Register your event listener on 3 type of events.
     *          When object 's damage emitter call OnEnterDamage, OnStayDamage, OnExitDamage, 
     *          your event listener will be invoked.
     *
     * @author  User
     * @date    2016/3/23
     */

    public class DamageReceiver : MonoBehaviour
    {
        /** @brief   The damage type immortal time editor entrys.   
        /**             For editor*/
        [SerializeField]
        public DamageTypeImmortalTimeEditorEntry[] DamageTypeImmortalTimeEditorEntrys;

        private event DamageListner onDamageEnterEvents;
        private event DamageListner onDamageStayEvents;
        private event DamageListner onDamageExitEvents;

        /** @brief   The damage type immortal time table.   
        /**             Define [DamageType, Immortal Time]*/
        private Dictionary<DamageType, float> m_DamageTypeImmortalTimeTable = 
            new Dictionary<DamageType, float>();

        private bool m_Immortal = false;

        public bool Immortal
        {
            get { return m_Immortal; }
            set
            {
                // If you want to set immortal to false, must stop recover corutine
                if (m_CountdownRoutine != null && value == false)
                {
                    StopCoroutine(m_CountdownRoutine);
                    m_CountdownRoutine = null;
                }
                m_Immortal = value;
            }
        }

        private Coroutine m_CountdownRoutine;

        void invokeDamageEvent(DamageListner l, Damage d)
        {
            if (l != null)
                l.Invoke(d);
        }

        public void OnEnterDamage(Damage d)
        {
            invokeDamageEvent(onDamageEnterEvents, d);
            Immortal = false;
        }

        public void OnStayDamage(Damage d)
        {
            if (m_Immortal)
                return;
            invokeDamageEvent(onDamageStayEvents, d);
            Immortal = true;
            if(m_CountdownRoutine == null)
                m_CountdownRoutine = StartCoroutine(countdown(getImmortalTime(d.Type)));
        }

        public void OnExitDamage(Damage d)
        {
            invokeDamageEvent(onDamageExitEvents, d);
        }

        float getImmortalTime(DamageType t)
        {
            float time;
            if(m_DamageTypeImmortalTimeTable.TryGetValue(t, out time))
            {
                return time;
            }
            return 0;
        }

        IEnumerator countdown(float t)
        {
            yield return new WaitForSeconds(t);
            m_CountdownRoutine = null;
            Immortal = false;   
        }

        void Start()
        {
            foreach (DamageTypeImmortalTimeEditorEntry entry in DamageTypeImmortalTimeEditorEntrys)
                m_DamageTypeImmortalTimeTable.Add(entry.Type, entry.ImmortalTime);
        }
    }

}