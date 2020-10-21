class StateFinished
{
	private var m_activity;
	
	function initialize(p_activity)
	{
		System.println("State: StateFinished");
		m_activity = p_activity;
	}
	
	function onMenu()
	{
		System.println("onMenu not available in StateFinished");
	}
	
	function onSelect()
	{
		System.println("onSelect not available in StateFinished");
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
		return false;
	}
	
	function isFinished()
	{
		return true;
	}
}
