class StateNotStarted
{
	private var m_activityWeakRef;
	
	function initialize(p_activityWeakRef)
	{
		System.println("State: StateNotStarted");
		
		m_activityWeakRef = p_activityWeakRef;
	}
	
	function onMenu()
	{
		var l_mainMenu = new MainMenu();	
	}
	
	function onSelect()
	{
		startActivity();	
	}
	
	function onBack()
	{		
		return false;
	}
	
	function onActivityTimer()
	{
		System.println("onActivityTimer() should not be triggered in StateNotStarted");
	}
	
	function isPaused()
	{
		return false;
	}
	
	function isFinished()
	{
		return false;
	}
	
	private function startActivity()
	{
		m_activityWeakRef.get().stateTransition(:stateWork);
	}
}
