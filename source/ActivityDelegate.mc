using Toybox.WatchUi as Ui;

class ActivityDelegate extends Ui.BehaviorDelegate 
{
	private var m_activity;
	
	function initialize(p_activity) 
  	{
		m_activity = p_activity;
    	BehaviorDelegate.initialize();
  	}
		
	function onMenu()
	{
		var l_mainMenu = new MainMenu();
	}

	function onSelect() 
	{
		m_activity.start();
		return true;
	}
	
	function onBack() 
	{
		m_activity.stop();	
		return true;	
	}
}
