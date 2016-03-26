using UnityEngine;
using UnityEngine.Events;
using System.Collections;

namespace WiFramework
{
    public delegate void SpeedEvent(float speed);
    public delegate void DestinationEvent();

    [System.Serializable]
    public enum DestinationEventType
    {
        Enter,
        Stay,
        Exit
    }

    [RequireComponent(typeof(NavMeshAgent))]
    public class Pathfinder : MonoBehaviour
    {
        public Vector3 Target;
        public bool FindByTag;
        public string Tag;

        public event SpeedEvent OnSpeedUpdateEvents;
        public event DestinationEvent OnEnterEvents;
        public event DestinationEvent OnStayEvents;
        public event DestinationEvent OnExitEvents;

        private NavMeshAgent m_Navigator;
        private bool m_IsReach = false;

        [SerializeField]
        private bool m_IsStop = false;

        public void Resume()
        {
            m_IsStop = false;
            m_Navigator.Resume();
        }

        public void Stop()
        {
            m_IsStop = true;
            m_Navigator.Stop();
            m_Navigator.velocity = Vector3.zero;
        }

        void invokeSpeedUpdateEvents()
        {
            if (OnSpeedUpdateEvents != null)
                OnSpeedUpdateEvents.Invoke(m_Navigator.velocity.magnitude);
        }

        void invokeDestinationEvents(DestinationEvent e)
        {
            if (e != null) e.Invoke();
        }

        void Awake()
        {
            m_Navigator = GetComponent<NavMeshAgent>();

            if (FindByTag)
                Target = GameObject.FindGameObjectWithTag(Tag).transform.position;
        }

        void Update()
        {
            if (m_IsStop)
                return;

            m_Navigator.SetDestination(Target);
            invokeSpeedUpdateEvents();

            float distance = Vector3.Distance(transform.position, Target);
            bool inRange = distance <= m_Navigator.stoppingDistance;

            if (m_IsReach && inRange)
            {
                invokeDestinationEvents(OnStayEvents);
            }
            else if(m_IsReach)
            {
                m_IsReach = false;
                invokeDestinationEvents(OnExitEvents);
            }

            if (!m_IsReach && inRange)
            {
                invokeDestinationEvents(OnEnterEvents);
                m_IsReach = true;
            }
        }
    }

}