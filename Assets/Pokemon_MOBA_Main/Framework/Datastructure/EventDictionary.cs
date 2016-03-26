using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class TripleDictionary<S, K, V>
{
    private Dictionary<S, Dictionary<K, V>> m_Dict = new Dictionary<S, Dictionary<K, V>>();
    
    public void Add(S s, K k, V v)
    {
        Dictionary<K, V> d;

        if(!m_Dict.TryGetValue(s, out d))
        {
            d = new Dictionary<K, V>();
            m_Dict.Add(s, d);
        }

        d.Add(k, v);
    }

    public bool TryGetValue(S s, K k, out V v)
    {
        Dictionary<K, V> d;

        if (m_Dict.TryGetValue(s, out d))
        {
            
            if (d.TryGetValue(k, out v))
            {
                return true;
            }
        }
        v = default(V);
        return false;
    }

}
