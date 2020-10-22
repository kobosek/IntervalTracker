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
	}
	
	private function startActivity()
	{
		m_activityWeakRef.get().stateTransition(:stateWork);
	}
}
