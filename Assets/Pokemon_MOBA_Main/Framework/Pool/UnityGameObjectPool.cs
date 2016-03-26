using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using System;

namespace WiFramework
{
    public class UnityGameObjectPool : PoolBase<GameObject>
    {
        private Queue<GameObject> m_Queue = new Queue<GameObject>();

        public override GameObject Pop()
        {
            if (m_Queue.Count > 0)
            {
                GameObject o = m_Queue.Dequeue();
                o.SetActive(true);
                return o;
            }
            return default(GameObject);
        }

        public override void Push(GameObject t)
        {
            m_Queue.Enqueue(t);
            t.SetActive(false);
        }
        
        public void Push(GameObject t, int n)
        {
            for (int i = 0; i < n; i++)
                Push(t);
        }
    }

}