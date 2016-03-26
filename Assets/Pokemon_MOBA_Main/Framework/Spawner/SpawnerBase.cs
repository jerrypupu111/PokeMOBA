using UnityEngine;
using System.Collections;

namespace WiFramework
{
    abstract public class SpawnerBase<T> : MonoBehaviour
    {
        abstract public T Spawn();
    }

}