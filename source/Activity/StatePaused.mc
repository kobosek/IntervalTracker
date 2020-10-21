class StatePaused
{
	private var m_activity;
	
	function initialize(p_activity)
	{
		System.println("State: StatePaused");
		m_activity = p_activity;
	}
	
	function onMenu()
	{
		System.println("onMenu not available in StatePaused");
	}
	
	function onSelect()
	{
		m_activity.resumeActivity();
	}

	function onBack()
	{		
		var l_finishedMenu = new FinishedMenu(m_activity);
		return true;
	}

	function onActivityTimer()
	{
		m_activity.updateTimeElapsed();
	}

	function isPaused()
	{
		return true;
	}
	
	function isFinished()
	{
		return false;
	}
}
