using UnityEngine;
using UnityEngine.Events;
using System.Collections;
using System;

namespace WiFramework
{
    public delegate void RestoreListener();

    [Serializable]
    public class Health : SingleValueStorage
    {
        public event RestoreListener RestoreEvents;

        public int HP
        {
            get { return Value; }
        }

        public void ChangeHealth(int diff)
        {
            ChangeValue(diff);
        }

        public void RestoreHealth()
        {
            Restore();
        }

        public void Reborn()
        {
            Restore();
            if (RestoreEvents != null)
                RestoreEvents();
        }
    }
}

