using Toybox.Application as App;

class IntervalTracker extends App.AppBase 
{
	function initialize() 
	{
		AppBase.initialize();
	}

	function getInitialView() 
	{
		var l_activityModel = new ActivityModel();
		var l_activityDelegate = new ActivityDelegate(l_activityModel);
		var l_activityView = new ActivityView(l_activityModel);
		
		return [l_activityView, l_activityDelegate];
	}
}
