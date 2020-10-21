using Toybox.WatchUi as Ui;
using Toybox.Sensor as Sensor;
using Toybox.Timer as Timer;

class Activity
{	
	private var m_model;
	private var m_currentState;
	private var m_workTimer;
	
	function initialize()
	{	
		m_model = new ActivityModel();					
		m_workTimer = new Timer.Timer();
		stateTransition(:stateNotStarted);
		
		//1Hz sensor event is used as a system timer - HR and TIME OF DAY UPDATE
		Sensor.setEnabledSensors([Sensor.SENSOR_HEARTRATE]);
		Sensor.enableSensorEvents(method(:updateHeartRate));
	}	
	
	function stateTransition(p_state)
	{
		var l_stateFactory = new StateFactory(m_model, self.weak());
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

	function isPaused()
	{
		return m_currentState.isPaused();
	}
	
	function isFinished()
	{
		return m_currentState.isFinished();
	}	

	function updateHeartRate(p_sensorInfo)
	{
		m_model.updateHeartRate(p_sensorInfo);
        updateUi();
	}	
	
	function getHeartRate()
	{
		return m_model.getHeartRate();
	}
	
	function getRemainingWorkTime()
	{
		return m_model.getRemainingWorkTime();
	}
	
	function getRemainingRestTime()
	{
		return m_model.getRemainingRestTime();
	}	
	
	function getCurrentRepetition()
	{
		return m_model.getCurrentRepetition();
	}
	
	function getCurrentSet()
	{
		return m_model.getCurrentSet();
	}
	
	function getTimeOfDay()
	{
		return m_model.getTimeOfDay();
	}	
		
	function getTimeLeft()
	{
		return m_model.getTimeLeft();	
	}	
	
	function getTimeElapsed()
	{
		return m_model.getTimeElapsed();
	}

	function updateUi()
	{
		Ui.requestUpdate();
	}	
		
}
