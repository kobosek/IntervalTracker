using Toybox.Timer as Timer;
using Toybox.WatchUi as Ui;
using Toybox.Attention as Attention;
using Toybox.ActivityRecording as ActivityRecording;
using Toybox.Sensor as Sensor;
using Toybox.Time as Time;

var g_settings = 
{
	:activityName => "Interval Training",
	:activityType => ActivityRecording.SPORT_TRAINING,
	:activitySubType => ActivityRecording.SUB_SPORT_STRENGTH_TRAINING,
	:repetitions => 4,
	:sets => 6,
	:workTime => 30,
	:restTime => 20,
};

class Activity
{
	private var m_activityName;
	private var m_activityType;
	private var m_activitySubType;
	private var m_currentRepetition;
	private var m_currentSet;
	private var m_remainingWorkTime;
	private var m_remainingRestTime;
	
	function initialize()
	{
		m_activityName = g_settings[:activityName];
		m_activityType = g_settings[:activityType];
		m_activitySubType = g_settings[:activitySubType];
		m_currentRepetition = 1;
		m_currentSet = 1;
		m_remainingWorkTime = g_settings[:workTime];
		m_remainingRestTime = g_settings[:restTime];
	}
	
	function getHeartRate()
	{
		var l_heartRate = "0";
		return l_heartRate;
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
  		var l_timeOfDay = l_clockTime.hour + ":" + l_clockTime.min;
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

	
	function start()
	{
		System.println("Start");
		vibrate(500);
		startBacklight();
	}
	
	function stop()
	{
		System.println("Stop");
		stopBackligt();
	}

	function vibrate(duration)
	{
		var l_vibrateData = [new Attention.VibeProfile(100, duration)];
		Attention.vibrate(l_vibrateData);
	}
	
	function startBacklight()
	{
		Attention.backlight(true);
	}
	
	function stopBackligt()
	{
		Attention.backlight(false);
	}
}

//
//class Activity {
//
//	function createSession()
//	{
//		return ActivityRecording.createSession(
//		{
//			:name => g_settings[:activityName],
//			:sport => g_settings[:activityType],
//			:subSport => g_settings[:activitySubType]			
//		});
//	}
//	
//	var REST_TIME;
//	var PREP_TIME;
//	var WORK_TIME;
//	var TOTAL_ROUNDS;
//	const HAS_TONES = Attention has :playTone;
//
//	var counter;
//	var round = 0;
//	var phase = :prep;
//	var done = false;
//	var session = createSession();
//
//	hidden var refreshTimer = new Timer.Timer();
//	hidden var sensors = Sensor.setEnabledSensors([Sensor.SENSOR_HEARTRATE]);
//
//	
//	function initialize()
//	{
//		REST_TIME = g_settings[:restTime];
//		PREP_TIME = g_settings[:prepTime];
//		WORK_TIME = g_settings[:workTime];
//		TOTAL_ROUNDS = g_settings[:repetitions];
//
//		counter = PREP_TIME;
//	}
//
//	function start()
//	{
//		refreshTimer.start(method(:refresh), 1000, true);
//		startBuzz();
//		Ui.requestUpdate();
//	}
//
//	function refresh()
//	{
//		if (counter > 1)
//		{
//			counter--;
//		} 
//		else 
//		{
//			if (phase == :prep) 
//			{
//				session.start();
//				phase = :work;
//				counter = WORK_TIME;
//				round++;
//				intervalBuzz();
//			} 
//			else if (phase == :work) 
//			{
//				phase = :rest;
//				counter = REST_TIME;
//				intervalBuzz();
//			}	
//			else if (phase == :rest) 
//			{
//				if (round == TOTAL_ROUNDS)
//				{
//					completeSession();
//					stopBuzz();
//				} 
//				else 
//				{
//					phase = :work;
//					counter = WORK_TIME;
//					round++;
//					intervalBuzz();
//				}
//			}
//		}
//		Ui.requestUpdate();
//	}
//
//	function completeSession() 
//	{
//		done = true;
//		session.stop();
//		session.save();
//		refreshTimer.stop();
//	}
//
//
//	function dropSession() 
//	{
//		refreshTimer.stop();
//		if (session.isRecording()) 
//		{
//			session.stop();
//			session.discard();
//		}
//	}
//
//}
