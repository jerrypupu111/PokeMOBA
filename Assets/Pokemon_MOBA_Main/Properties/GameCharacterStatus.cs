using UnityEngine;
using System.Collections;
using System.Collections.Generic;

namespace WiFramework
{
    public enum GameCharacterStatusType
    {
        Fired,
        Freezed,
        Normal,
        Death,
        Disability
    }

    public enum GameCharacterStatusEventType
    {
        Enter,
        Stay,
        Exit
    }

    public delegate void GameCharacterStatusListener(GameCharacterStatusType status);

    /**
     * @class   GameCharacterStatus
     *
     * @brief   A game character status.
     *          Contorl the character status transition and status event.
     *          
     *
     * @author  User
     * @date    2016/3/23
     */

    public class GameCharacterStatus : MonoBehaviour
    {
        [SerializeField]
        private GameCharacterStatusType m_Status = GameCharacterStatusType.Normal;

        private TripleDictionary<GameCharacterStatusEventType, GameCharacterStatusType, GameCharacterStatusListener> m_StatusListeners = 
            new TripleDictionary<GameCharacterStatusEventType, GameCharacterStatusType, GameCharacterStatusListener>();

        public GameCharacterStatusType Status
        {
            get { return m_Status; }
        }

        public void AddListener(GameCharacterStatusEventType eventType, GameCharacterStatusType statusType, 
            GameCharacterStatusListener l)
        {
            m_StatusListeners.Add(eventType, statusType, l);
        }

        /**
         * @fn  public void SetStatus(GameCharacterStatusType s)
         *
         * @brief   Sets the status.
         *          Set new status. This function will trigger Exit event of old status and enter event of new status.
         *
         * @author  User
         * @date    2016/3/23
         *
         * @param   s   The GameCharacterStatusType to process.
         */

        public void SetStatus(GameCharacterStatusType s)
        {
            bool diff = (m_Status != s);

            GameCharacterStatusType old = m_Status;
            m_Status = s;
            if (diff)
            {
                invokeEvents(GameCharacterStatusEventType.Enter, s);
                invokeEvents(GameCharacterStatusEventType.Exit, old);
            }
        }

        /**
         * @fn  void invokeEvents(GameCharacterStatusEventType eventType, GameCharacterStatusType statusType)
         *
         * @brief   Query the dictionary, find the corresponding event listener, and invoke it.
         *
         * @author  Williamd
         * @date    2016/3/23
         *
         * @param   eventType   Type of the event.
         * @param   statusType  Type of the status.
         */

        void invokeEvents(GameCharacterStatusEventType eventType, GameCharacterStatusType statusType)
        {
            GameCharacterStatusListener l;
            if (m_StatusListeners.TryGetValue(eventType, statusType, out l))
            {
                l(statusType);
            }
        }

        /**
         * @fn  void Update()
         *
         * @brief   Calling Stay events continuously.
         * @todo    Frequently invoke events may cause some performance issue, 
         *          we may reserve Stay event implementation for designer. (e.g. polling)
         *          
         *
         * @author  User
         * @date    2016/3/23
         */

        void Update()
        {
            invokeEvents(GameCharacterStatusEventType.Stay, m_Status);
        }
    }
}
