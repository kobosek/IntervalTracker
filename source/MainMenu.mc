using Toybox.WatchUi as Ui;

class MainMenu
{	
	function initialize()
	{
		System.println("Main Menu");
		
		var l_menuTitle = Rez.Strings.MainMenuTitle;
	
		var l_menuItems = 
		[
			[:settings, Rez.Strings.MainMenuSettings]
		];
					
		var l_menuActions = 
		{
			:settings => self.method(:showSettingsMenu)
		};
		
		Ui.pushView(new MenuView(l_menuTitle, l_menuItems), new MenuDelegate(l_menuActions), Ui.SLIDE_UP);
	}
	
	function showSettingsMenu()
	{
		var l_settingsMenu = new SettingsMenu();
	}
}	