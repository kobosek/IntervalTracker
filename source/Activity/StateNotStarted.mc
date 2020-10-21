class StateNotStarted
{
	private var m_activity;
	
	function initialize(p_activity)
	{
		System.println("State: StateNotStarted");
		m_activity = p_activity;
	}
	
	function onMenu()
	{
		var l_mainMenu = new MainMenu();	
	}
	
	function onSelect()
	{
		m_activity.startActivity();
	}
	
	function onBack()
	{		
		return false;
	}
	
	function onActivityTimer()
	{
		System.println("onActivityTimer should not be triggered while in state: StateNotStarted");			
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
