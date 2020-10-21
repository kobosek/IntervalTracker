using Toybox.WatchUi as Ui;

class FinishedMenu
{
	private var m_activityModel;
	private var m_resumeActivityCallback;
	
	function initialize(p_activityModel, p_resumeActivityCallback)
	{	
		m_activityModel = p_activityModel;
		m_resumeActivityCallback = p_resumeActivityCallback;
		
		var l_menuTitle = Rez.Strings.FinishedMenuTitle;
	
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
		m_resumeActivityCallback.invoke();
		Ui.popView(Ui.SLIDE_IMMEDIATE);
	}
	
	function saveActivity()
	{	
		m_activityModel.stopActivity();
		m_activityModel.saveActivity();
		Ui.popView(Ui.SLIDE_IMMEDIATE);
		Ui.popView(Ui.SLIDE_IMMEDIATE);
	}
	
	function discardActivity()
	{
		m_activityModel.stopActivity();
		m_activityModel.discardActivity();
		Ui.popView(Ui.SLIDE_IMMEDIATE);
		Ui.popView(Ui.SLIDE_IMMEDIATE);
	}	
}