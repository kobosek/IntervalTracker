using Toybox.WatchUi as Ui;

class MenuView extends Ui.Menu2
{
	function initialize(p_title, p_menuItems)
	{
		Ui.Menu2.initialize(
		{
			:title => p_title
		});
		
		for(var i = 0; i < p_menuItems.size(); i++)
		{	
			Ui.Menu2.addItem(new Ui.MenuItem(p_menuItems[i][1], null, p_menuItems[i][0], null));
		}
	}
}

class MenuDelegate extends Ui.Menu2InputDelegate
{
	var m_actions = {};
	function initialize(p_actions)
	{
		m_actions = p_actions;
		Ui.Menu2InputDelegate.initialize();
	}
	
	function onSelect(p_menuItem)	
	{
		m_actions[p_menuItem.getId()].invoke();
	}
}