class StateFinished
{
	private var m_activityModel;
	
	function initialize(p_activityModel)
	{
		System.println("State: StateFinished");
		
		m_activityModel = p_activityModel;
		
		m_activityModel.setPaused(false);
		m_activityModel.setFinished(true);
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
	
	function resumeActivity()
	{
		System.println("cannot resume activity in StateFinished");
	}
}
