using UnityEngine;
using System.Collections;
using System.Collections.Generic;

namespace WiFramework
{
    [System.Serializable]
    abstract public class PoolBase<T> : MonoBehaviour
    {
        abstract public void Push(T t);
        abstract public T Pop();
    }
}
