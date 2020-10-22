class StateFactory
{
	private var m_activityModel;
	private var m_activityWeakRef;
	
	function initialize(p_activityModel, p_activityWeakRef)
	{
		m_activityModel = p_activityModel;
		m_activityWeakRef = p_activityWeakRef;
	}
	
	function createState(p_state)
	{
		if(p_state == :stateNotStarted)
		{
			return new StateNotStarted(m_activityWeakRef);
		}
		else if(p_state == :stateWork)
		{
			return new StateWork(m_activityModel, m_activityWeakRef);
		}
		else if(p_state == :stateRest)
		{
			return new StateRest(m_activityModel, m_activityWeakRef);
		}
		else if(p_state == :statePaused)
		{
			return new StatePaused(m_activityModel, m_activityWeakRef);
		}
		else
		{
			return new StateFinished(m_activityModel);
		}
	}
}
