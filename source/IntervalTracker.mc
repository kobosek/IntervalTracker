using Toybox.Application as App;

class IntervalTracker extends App.AppBase 
{
	function initialize() 
	{
		AppBase.initialize();
	}

	function getInitialView() 
	{
		var l_activty = new Activity();
		return [new ActivityView(l_activty), new ActivityDelegate(l_activty)];
	}
}
