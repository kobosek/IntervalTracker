class StateWork
{
	private var m_activityModel;
	private var m_activityWeakRef;
	
	function initialize(p_activityModel, p_activityWeakRef)
	{
		System.println("State: StateWork");
		
		m_activityModel = p_activityModel;
		m_activityWeakRef = p_activityWeakRef;
	}
	
	function onMenu()
	{
		System.println("onMenu not available in StateWork");
	}	
		
	function onSelect()
	{
		pauseActivity();
	}

	function onBack()
	{	
		System.println("onBack not available in StateWork");	
		return true;
	}

	function onActivityTimer()
	{
		if(m_activityModel.getRemainingWorkTime() > 0)
		{
			m_activityModel.decrementRemainingWorkTime();
			m_activityModel.incrementTimeElapsed();
		}
		
		if(m_activityModel.getRemainingWorkTime() == 0)
		{
			m_activityWeakRef.get().stateTransition(:stateRest);
		}	
	}
	
	function isPaused()
	{
		return false;
	}
	
	function isFinished()
	{
		return false;
	}

	private function pauseActivity()
	{
		m_activityWeakRef.get().stateTransition(:statePaused);
	}

}
