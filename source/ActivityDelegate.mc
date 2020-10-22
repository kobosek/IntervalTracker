using Toybox.WatchUi as Ui;
using Toybox.Timer as Timer;

class ActivityDelegate extends Ui.BehaviorDelegate 
{	
	private var m_activityModel;
	private var m_currentState;
	private var m_workTimer;
	
	function initialize(p_activityModel)
	{	
		BehaviorDelegate.initialize();
		m_activityModel = p_activityModel;
		stateTransition(:stateNotStarted);			
		m_workTimer = new Timer.Timer();
		startOneSecondTimer();
	}	
	
	function stateTransition(p_state)
	{
		var l_stateFactory = new StateFactory(m_activityModel, self.weak());
		m_currentState = l_stateFactory.createState(p_state);
	}	
	
	function startOneSecondTimer()
	{
		var l_shouldBeRepeated = false;
		var l_timeInMiliseconds = 1000;
		
		m_workTimer.stop();		
		m_workTimer.start(method(:onActivityTimer), l_timeInMiliseconds, l_shouldBeRepeated);
	}
	
	function onMenu()
	{
		m_currentState.onMenu();
	}
	
	function onSelect()
	{
		m_currentState.onSelect();
		
		startOneSecondTimer();
		updateUi();
	}
	
	function onBack()
	{
		return m_currentState.onBack();
	}
		
	function onActivityTimer()
	{
		m_currentState.onActivityTimer();
		
		startOneSecondTimer();
		updateUi();
	}

	function updateUi()
	{
		Ui.requestUpdate();
	}	
		
}
