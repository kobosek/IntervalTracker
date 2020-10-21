class StateFinished
{
	private var m_activityModel;
	
	function initialize(p_activityModel)
	{
		System.println("State: StateFinished");
		
		m_activityModel = p_activityModel;
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
		var l_finishedMenu = new FinishedMenu(m_activityModel, method(:resumeActivity));
		return true;
	}

	function onActivityTimer()
	{
		m_activityModel.incrementTimeElapsed();
	}
	
	function isPaused()
	{
		return false;
	}
	
	function isFinished()
	{
		return true;
	}
	
	function resumeActivity()
	{
		System.println("cannot resume activity in StateFinished");
	}
}
