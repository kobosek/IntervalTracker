using Toybox.WatchUi as Ui;

class SettingsMenu
{
	function initialize()
	{
		System.println("Settings Menu");
		
		var l_menuTitle = Rez.Strings.SettingsMenuTitle;
	
		var l_menuItems = 
		[
			//[:activityType, Rez.Strings.SettingsMenuActivityType],
			[:repetitions, Rez.Strings.SettingsMenuRepetitions],	
			[:sets, Rez.Strings.SettingsMenuSets],
			[:workTimer, Rez.Strings.SettingsMenuWorkTimer],
			[:restTimer, Rez.Strings.SettingsMenuRestTimer]	
		];
		
		var l_menuActions = 
		{
			//:activityType => self.method(:showActivityTypeSettings),
			:repetitions => self.method(:showRepetitionsSettings),
			:sets => self.method(:showSetsSettings),
			:workTimer => self.method(:showWorkTimerSettings),
			:restTimer => self.method(:showRestTimerSettings)
		};	 
		
		Ui.pushView(new MenuView(l_menuTitle, l_menuItems), new MenuDelegate(l_menuActions), Ui.SLIDE_UP);		
	}
		
//	function showActivityTypeSettings()
//	{
//		System.println("Activity Type Settings");
//	}
	
	function showRepetitionsSettings()
	{
		System.println("Repetitions Settings");
	}
	
	function showSetsSettings()
	{
		System.println("Sets Settings");
	}
	
	function showWorkTimerSettings()
	{
		Ui.pushView(new Ui.Picker(), new Ui.PickerDelegate(), Ui.SLIDE_UP);
		System.println("Work Timer Settings");
	}	
	
	function showRestTimerSettings()
	{
		System.println("Rest Timer Settings");
	}
}