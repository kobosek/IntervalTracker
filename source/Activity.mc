using Toybox.Time as Time;
using Toybox.Timer as Timer;
using Toybox.Attention as Attention;
using Toybox.WatchUi as Ui;

using Toybox.Sensor as Sensor;
//using Toybox.Activity as Activity;
//using Toybox.ActivityMonitor as ActivityMonitor;
using Toybox.ActivityRecording as ActivityRecording;

var g_settings = 
{
	:repetitions => 4,
	:sets => 7,
	:workTime => 30,
	:restTime => 15,
};

class Activity
{
	private var m_currentRepetition;
	private var m_currentSet;
	private var m_remainingWorkTime;
	private var m_remainingRestTime;
	private var m_startedTotalTime;
	private var m_state;
	private var m_heartRate;
	private var m_recordingSession;
	//private var m_systemTimer;
	
	function initialize()
	{
		m_currentRepetition = 1;
		m_currentSet = 1;
		m_remainingWorkTime = g_settings[:workTime];
		m_remainingRestTime = g_settings[:restTime];
		m_startedTotalTime = 0;
		m_state = :notStarted;
		m_heartRate = "--";	
		m_recordingSession = ActivityRecording.createSession(
		{
			:sport => ActivityRecording.SPORT_TRAINING,
			:subsport => ActivityRecording.SUB_SPORT_STRENGTH_TRAINING,
			:name => "Interval Training"
		});
		
		Sensor.setEnabledSensors([Sensor.SENSOR_HEARTRATE]);
		Sensor.enableSensorEvents(method(:onTimeout));		
		//1Hz sensor event is used as a system timer instad of Timer
		//m_systemTimer = new Timer.Timer();
		//m_systemTimer.start(method(:onTimeout), 1000, true);
	}
	
	function onMenu()
	{
		if(m_state == :notStarted)
		{
			var l_mainMenu = new MainMenu();
		}	
	}
	
	function onSelect()
	{
		switch(m_state)
		{
			case :notStarted:
			{
				startRecording();	
			}
			case :paused:
			{
				if(m_remainingWorkTime > 0)
				{
					m_state = :work;
				}
				else
				{
					m_state = :rest;
				}
				break;	
			}			
			case :work:
			case :rest:
			{
				m_state = :paused;
				break;
			}
		}	
		updateUi();
	}
	
	function onBack()
	{
		switch(m_state)
		{
			case :notStarted:
			{
				return false;
			}
			case :work:
			{
				break;
			}
			case :rest:
			{
				break;
			}
			case :paused:
			case :finished:
			{
				stopRecording();
				saveRecording();
				return false;
			}
		}
		return true;
	}
		
	function startRecording()
	{
		m_recordingSession.start();	
	}
	
	function stopRecording()
	{
		m_recordingSession.stop();
	}
	
	function saveRecording()
	{
		m_recordingSession.save();
	}
	
	function discardRecording()
	{
		m_recordingSession.discard();
	}
	
	function onTimeout(p_sensorInfo)
	{	
		updateHeartRate(p_sensorInfo);
		
		switch(m_state)
		{
			case :work:
			{
				workTimeout();
				break;
			}
			case :rest:
			{
				restTimeout();
				break;
			}
		}
		if(m_state != :notStarted)
		{
			m_startedTotalTime++;
		}
		updateUi();
	}
	
	function updateHeartRate(p_sensorInfo)
	{
		var l_hr = p_sensorInfo.heartRate;
		
        if(l_hr != null)
        {
            m_heartRate = l_hr;
        }
	}
	
	function workTimeout()
	{
		m_remainingWorkTime--;
		conditionalVibrate(m_remainingWorkTime < 3, 300);		
		
		if(m_remainingWorkTime == 0)
		{
			m_state = :rest;
		}
	}
	
	function restTimeout()
	{
		m_remainingRestTime--;
		conditionalVibrate(m_remainingRestTime < 3, 300);		
			
		if(m_remainingRestTime == 0)
		{
			m_state = :work;
			finishRepetition();
		}
	}
	function updateUi()
	{
		Ui.requestUpdate();
	}	
	
	function finishRepetition()
	{
		if(m_currentRepetition == g_settings[:repetitions])
		{
			if(m_currentSet == g_settings[:sets])
			{
				m_state = :finished;
				vibrate(1000);
				return;
			}
			m_currentRepetition = 0;
			m_currentSet++;
		}
		m_currentRepetition++;
		m_remainingWorkTime = g_settings[:workTime];
		m_remainingRestTime = g_settings[:restTime];		
	}
	
	function vibrate(l_duration)
	{
		var l_vibrateData = [new Attention.VibeProfile(100, l_duration)];
		Attention.vibrate(l_vibrateData);
	}
	
	function conditionalVibrate(l_condition, l_duration)
	{
		if(l_condition)
		{
			vibrate(l_duration);
		}
	}	
	
	function getHeartRate()
	{
//		var l_heartRate = Activity.getActivityInfo().currentHeartRate;
//		
//		if(l_heartRate == null)
//		{
//			l_heartRate = "--";
//			if(ActivityMonitor has :getHeartRateHistory)
//			{
//				var l_heartRateHistory = ActivityMonitor.getHeartRateHistory(1, true);
//				var l_heartRateSample = l_heartRateHistory.next();
//				
//				if(l_heartRateSample != null and l_heartRateSample.heartRate != ActivityMonitor.INVALID_HR_SAMPLE)
//				{
//					l_heartRate = l_heartRateSample.heartRate;
//				}	
//			}
//		}
//		return l_heartRate;
		return m_heartRate;
	}
	
	function getRemainingWorkTime()
	{
		var l_remainingWorkTime = formatSecondsToMMSS(m_remainingWorkTime);
		return l_remainingWorkTime;
	}
	
	function getRemainingRestTime()
	{
		var l_remainingRestTime = formatSecondsToMMSS(m_remainingRestTime);
		return l_remainingRestTime;
	}	
	
	function getCurrentRepetition()
	{
		return m_currentRepetition;
	}
	
	function getCurrentSet()
	{
		return m_currentSet;
	}
	
	function getTimeOfDay()
	{
  		var l_clockTime = System.getClockTime();
  		var l_timeOfDay = l_clockTime.hour.format("%02d") + ":" + l_clockTime.min.format("%02d");
  		return l_timeOfDay;
	}	
		
	function getTimeLeft()
	{
		var l_repetitionsRemainingFromSetsNotStarted = g_settings[:repetitions] * (g_settings[:sets] - m_currentSet);
		var l_repetitionsRemainingFromCurrentSet = g_settings[:repetitions] - m_currentRepetition;
		var l_remainingFullRepetitions = l_repetitionsRemainingFromCurrentSet + l_repetitionsRemainingFromSetsNotStarted;
		var l_timeOfOneRepetition = g_settings[:workTime] + g_settings[:restTime];
		var l_totalSeconds = m_remainingWorkTime + m_remainingRestTime + (l_timeOfOneRepetition * l_remainingFullRepetitions);
		
		var l_timeLeft = formatSecondsToHMMSS(l_totalSeconds);
		
		return l_timeLeft;
	}	
	
	function getTotalTime()
	{
		var l_totalTime = formatSecondsToMMSS(m_startedTotalTime);
		return l_totalTime;
	}

	function isPaused()
	{
		return m_state == :paused;
	}
	
	function isFinished()
	{
		return m_state == :finished;
	}
	
	function formatSecondsToMMSS(p_seconds)
	{
		var l_minutes = p_seconds / 60;
		var remainder = p_seconds - l_minutes * 60;
		var l_seconds =  remainder;
		
		var l_MMSS = l_minutes.format("%02d") + ":" + l_seconds.format("%02d");
		
		return l_MMSS;	
	}	
	
	function formatSecondsToHMMSS(p_seconds)
	{
		var l_hours = p_seconds / 3600;
		var remainder = p_seconds - l_hours * 3600;
		
		var l_HMMSS = formatSecondsToMMSS(remainder);
		
		if (l_hours > 0)
		{	
			var l_HMMSS = l_hours.format("%d") + ":" + l_HMMSS;		
		}
		
		return l_HMMSS;
	}
}
