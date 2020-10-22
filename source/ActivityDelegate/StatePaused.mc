class StatePaused
{
	private var m_activityModel;
	private var m_activityWeakRef;
	
	function initialize(p_activityModel, p_activityWeakRef)
	{
		System.println("State: StatePaused");
		
		m_activityModel = p_activityModel;
		m_activityWeakRef = p_activityWeakRef;
		
				
		m_activityModel.setPaused(true);
		m_activityModel.setFinished(false);
	}
	
	function onMenu()
	{
		System.println("onMenu not available in StatePaused");
	}
	
	function onSelect()
	{
		resumeActivity();
	}
	
	function onBack()
	{		
		var l_finishedMenu = new FinishedMenu(m_activityModel, method(:resumeActivity));
		return true;
	}
	
	function onActivityTimer()
	{
		m_activityModel.incrementTimeElapsed();
	}
	
	function resumeActivity()
	{
		if(m_activityModel.getRemainingWorkTime() > 0)
		{
			stateTransition(:stateWork);
		}
		else
		{
			stateTransition(:stateRest);
		}
	}
	
	function stateTransition(p_state)
	{
		m_activityWeakRef.get().stateTransition(p_state);
	}	
}
