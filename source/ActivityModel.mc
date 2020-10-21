using Toybox.Attention as Attention;

var g_settings = 
{
	:repetitions => 4,
	:sets => 7,
	:workTime => 30,
	:restTime => 15
};

class ActivityModel
{
	private var m_currentRepetition;
	private var m_currentSet;
	private var m_remainingWorkTime;
	private var m_remainingRestTime;
	
	private var m_timeElapsed;
	private var m_heartRate;
	
	function initialize()
	{
		m_currentRepetition = 1;
		m_currentSet = 1;
		m_remainingWorkTime = g_settings[:workTime];
		m_remainingRestTime = g_settings[:restTime];
		m_timeElapsed = 0;
		m_heartRate = "--";	
	}
	
	function workTimeout()
	{
		m_remainingWorkTime--;
		conditionalVibrate(m_remainingWorkTime < 3, 300);		
	}
	
	function restTimeout()
	{
		m_remainingRestTime--;
		conditionalVibrate(m_remainingWorkTime < 3, 300);		
	}
	
	function finishRepetition()
	{
		if(m_currentRepetition == g_settings[:repetitions])
		{
			if(m_currentSet == g_settings[:sets])
			{
				stateTransition(:finished);
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

	function updateTimeElapsed()
	{
		m_timeElapsed++;
	}
	
	function updateHeartRate(p_sensorInfo)
	{
		var l_hr = p_sensorInfo.heartRate;
		
        if(l_hr != null)
        {
			m_heartRate = l_hr;
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
	
	function getTimeElapsed()
	{
		var l_totalTime = formatSecondsToMMSS(m_timeElapsed);
		return l_totalTime;
	}
	
	function shouldTransitToStateWork()
	{
		return m_remainingRestTime == 0;
	}
	
	function shouldTransitToStateRest()
	{
		return m_remainingWorkTime == 0;
	}
	
	function shouldResumeInStateWork()
	{
		return m_remainingWorkTime > 0;
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