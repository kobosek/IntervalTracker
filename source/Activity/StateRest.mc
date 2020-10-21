class StateRest
{
	private var m_activity;
	
	function initialize(p_activity)
	{
		System.println("State: StateRest");
		m_activity = p_activity;
	}
	
	function onMenu()
	{
		System.println("onMenu not available in StateRest");
	}
	
	function onSelect()
	{
		m_activity.pauseActivity();
	}

	function onBack()
	{		
		System.println("onBack not available in StateRest");	
		return true;
	}
	
	function onActivityTimer()
	{
		m_activity.restTimeout();
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
