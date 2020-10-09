using Toybox.WatchUi as Ui;

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