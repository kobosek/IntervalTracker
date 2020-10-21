class StateWork
{
	private var m_activity;
	
	function initialize(p_activity)
	{
		System.println("State: StateWork");
		m_activity = p_activity;
	}
	
	function onMenu()
	{
		System.println("onMenu not available in StateWork");
	}
	
	function onSelect()
	{
		m_activity.pauseActivity();
	}

	function onBack()
	{	
		System.println("onBack not available in StateWork");	
		return true;
	}

	function onActivityTimer()
	{
		m_activity.workTimeout();
		m_activity.updateTimeElapsed();
	}

	function isPaused()
	{
		return false;
	}
	
	function isFinished()
	{
		return false;
	}
}
