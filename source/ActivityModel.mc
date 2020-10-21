using Toybox.Attention as Attention;
using Toybox.ActivityRecording as ActivityRecording;

var g_settings = 
{
	:repetitions => 2,
	:sets => 2,
	:workTime => 5,
	:restTime => 5
};

class ActivityModel
{
	private var m_currentRepetition;
	private var m_currentSet;
	private var m_remainingWorkTime;
	private var m_remainingRestTime;
	
	private var m_timeElapsed;
	private var m_heartRate;
	
	private var m_recordingSession;	
	
	function initialize()
	{
		m_currentRepetition = 1;
		m_currentSet = 1;
		m_remainingWorkTime = g_settings[:workTime];
		m_remainingRestTime = g_settings[:restTime];
		m_timeElapsed = 0;
		m_heartRate = "--";	
		
		m_recordingSession = ActivityRecording.createSession(
		{
			:sport => ActivityRecording.SPORT_TRAINING,
			:subSport => ActivityRecording.SUB_SPORT_STRENGTH_TRAINING,
			:name => "Interval Training"
		});
	}
	
	function startActivity()
	{
		m_recordingSession.start();		
	}

	function stopActivity()
	{
		m_recordingSession.stop();
	}
	
	function addLap()
	{
		m_recordingSession.addLap();
	}
	
	function saveActivity()
	{
		m_recordingSession.save();
	}
	
	function discardActivity()
	{
		m_recordingSession.discard();
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
	
	function restartTimers()
	{
		m_remainingWorkTime = g_settings[:workTime];
		m_remainingRestTime = g_settings[:restTime];
	}
	
	function decrementRemainingWorkTime()
	{
		m_remainingWorkTime--;
		conditionalVibrate(m_remainingWorkTime < 3, 300);		
	}
		
	function getRemainingWorkTime()
	{
		return m_remainingWorkTime;
	}
		
	function decrementRemainingRestTime()
	{
		m_remainingRestTime--;
		conditionalVibrate(m_remainingRestTime < 3, 300);	
		conditionalVibrate(isLastRepetition() && isLastSet(), 3000);		
	}	
	
	function getRemainingRestTime()
	{
		return m_remainingRestTime;
	}	
	
	function incrementCurrentRepetition()
	{
		m_currentRepetition++;
	}	
	
	function getCurrentRepetition()
	{
		return m_currentRepetition;
	}	
	
	function isLastRepetition()
	{
		return m_currentRepetition == g_settings[:repetitions];
	}
	
	function restartRepetitions()
	{
		m_currentRepetition = 1;
	}
	
	function incrementCurrentSet()
	{
		m_currentSet++;
	}
	
	function getCurrentSet()
	{
		return m_currentSet;
	}

	function isLastSet()
	{
		return m_currentSet == g_settings[:sets];
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
		var l_timeLeft = m_remainingWorkTime + m_remainingRestTime + (l_timeOfOneRepetition * l_remainingFullRepetitions);
		
		return l_timeLeft;
	}	

	function incrementTimeElapsed()
	{
		m_timeElapsed++;
	}
		
	function getTimeElapsed()
	{
		return m_timeElapsed;
	}

	private function vibrate(l_duration)
	{
		var l_vibrateData = [new Attention.VibeProfile(100, l_duration)];
		Attention.vibrate(l_vibrateData);
	}
	
	private function conditionalVibrate(l_condition, l_duration)
	{
		if(l_condition)
		{
			vibrate(l_duration);
		}
	}	
		

}