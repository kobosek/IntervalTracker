using Toybox.Timer as Timer;
using Toybox.WatchUi as Ui;
using Toybox.Attention as Attention;
using Toybox.ActivityRecording as ActivityRecording;
using Toybox.Sensor as Sensor;
using Toybox.Time as Time;

class Activity
{
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
//var g_settings = 
//{
//	:activityName => "Interval Training",
//	:activityType => ActivityRecording.SPORT_TRAINING,
//	:activitySubType => ActivityRecording.SUB_SPORT_STRENGTH_TRAINING,
//	:repetitions => 4,
//	:sets => 6,
//	:workTime => 30,
//	:restTime => 20,
//	:prepTime => 5
//};
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
