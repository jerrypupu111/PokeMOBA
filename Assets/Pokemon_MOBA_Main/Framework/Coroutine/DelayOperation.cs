using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class DelayOperation : MonoBehaviour
{
    public delegate void Callback();

    private Dictionary<string, Coroutine> m_Coroutines = new Dictionary<string, Coroutine>();

    public Coroutine StartDelayOperation(Callback callback, float delay)
    {
        return StartCoroutine(Delay(callback, delay));
    }
    
    public void StartDelayOperation(Callback callback, float delay, string name)
    {
        Coroutine c;
        if (m_Coroutines.TryGetValue(name, out c))
        {
            StopCoroutine(c);
            m_Coroutines[name] = StartCoroutine(Delay(callback, delay));
        }
        else
            m_Coroutines.Add(name, StartDelayOperation(callback, delay));
    }

    public void StartPeriodicDelayOperation(Callback callback, float period, string name)
    {
        Coroutine c;
        if (m_Coroutines.TryGetValue(name, out c))
        {
            StopCoroutine(c);
            m_Coroutines[name] = StartCoroutine(Periodic(callback, period, name));
        }
        else
        {
            m_Coroutines.Add(name, StartCoroutine(Periodic(callback, period, name)));
        }
    }

    public void StopDelayOperation(string name)
    {
        Coroutine c;
        if (m_Coroutines.TryGetValue(name, out c))
        {
            StopCoroutine(c);
        }
    }

    IEnumerator Delay(Callback callback, float delay)
    {
        yield return new WaitForSeconds(delay);
        callback.Invoke();
    }

    IEnumerator Periodic(Callback callback, float period, string name)
    {
        yield return new WaitForSeconds(period);
        callback.Invoke();
        StartPeriodicDelayOperation(callback, period, name);
    }
}
