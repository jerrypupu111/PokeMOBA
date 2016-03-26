using UnityEngine;
using System.Collections;
using System;

namespace WiFramework
{
    [RequireComponent(typeof(DelayOperation))]
    [RequireComponent(typeof(UnityGameObjectPool))]
    public class GameObjectSpawner : SpawnerBase<GameObject>
    {
        [SerializeField]
        private float m_SpawnPeriod = 1.0f;
        [SerializeField]
        private GameObject m_Template;
        [SerializeField]
        private int m_Count = 1;
        [SerializeField]
        private Transform[] m_SpawnPoints;

        private UnityGameObjectPool m_Pool;
        private DelayOperation m_DelayOps;
        private int m_SpawnPointsIndex = 0;

        public override GameObject Spawn()
        {
            return m_Pool.Pop();
        }

        void Start()
        {
            m_Pool = GetComponent<UnityGameObjectPool>();
            m_DelayOps = GetComponent<DelayOperation>();

            GameObject obj = Instantiate(m_Template);
            UnityGameObjectDeathHandler handler = obj.GetComponent<UnityGameObjectDeathHandler>();
            if (handler == null)
            {
                handler = obj.AddComponent<UnityGameObjectDeathHandler>();
                handler.DeathTime = m_SpawnPeriod;
            }
            handler.SourcePool = m_Pool;
            m_Pool.Push(obj, m_Count);

            m_DelayOps.StartPeriodicDelayOperation(()=> {
                m_SpawnPointsIndex %= m_SpawnPoints.Length;
                GameObject o = Spawn();
                if (o != null)
                {
                    o.transform.position = m_SpawnPoints[m_SpawnPointsIndex++].position;
                }
            }, m_SpawnPeriod, "Spawn");
        }

    }

}