using Toybox.WatchUi as Ui;

class FinishedMenu
{
	private var m_activity;
	
	function initialize(p_activity)
	{	
		m_activity = p_activity;
		
		var l_menuTitle = m_activity.getTimeElapsed();
	
		var l_menuItems = 
		[
			[:resume, Rez.Strings.FinishedMenuResume],	
			[:save, Rez.Strings.FinishedMenuSave],
			[:discard, Rez.Strings.FinishedMenuDiscard],
		];
		
		var l_menuActions = 
		{
			:resume => self.method(:resumeActivity),
			:save => self.method(:saveActivity),
			:discard => self.method(:discardActivity),
		};	 
		
		Ui.pushView(new MenuView(l_menuTitle, l_menuItems), new MenuDelegate(l_menuActions), Ui.SLIDE_UP);		
	}
	
	function resumeActivity()
	{
		m_activity.resumeActivity();
		Ui.popView(Ui.SLIDE_IMMEDIATE);
	}
	
	function saveActivity()
	{	
		m_activity.stopActivity();
		m_activity.saveActivity();
		Ui.popView(Ui.SLIDE_IMMEDIATE);
		Ui.popView(Ui.SLIDE_IMMEDIATE);
	}
	
	function discardActivity()
	{
		m_activity.stopActivity();
		m_activity.discardActivity();
		Ui.popView(Ui.SLIDE_IMMEDIATE);
		Ui.popView(Ui.SLIDE_IMMEDIATE);
	}	
}