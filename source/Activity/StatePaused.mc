class StatePaused
{
	private var m_activityModel;
	private var m_activityWeakRef;
	
	function initialize(p_activityModel, p_activityWeakRef)
	{
		System.println("State: StatePaused");
		
		m_activityModel = p_activityModel;
		m_activityWeakRef = p_activityWeakRef;
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
		
	function isPaused()
	{
		return true;
	}
	
	function isFinished()
	{
		return false;
	}
	
	function resumeActivity()
	{
		if(m_activityModel.getRemainingWorkTime() > 0)
		{
			m_activityWeakRef.get().stateTransition(:stateWork);
		}
		else
		{
			m_activityWeakRef.get().stateTransition(:stateRest);
		}
	}	
}
