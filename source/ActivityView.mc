using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class ActivityView extends Ui.View 
{
	private var m_activity;
			
	function initialize(p_activity) 
  	{
  		m_activity = p_activity;
		View.initialize();
  	}

  	function onUpdate(p_dc)
  	{
  		var l_width = p_dc.getWidth();
  		var l_height = p_dc.getHeight();		

		var l_backgroundColor = m_activity.isPaused() ? Gfx.COLOR_BLACK : Gfx.COLOR_WHITE;
		var l_textColor = m_activity.isPaused() ? Gfx.COLOR_WHITE : Gfx.COLOR_BLACK;
		var l_featureColor = Gfx.COLOR_RED;		
		
		//draw background: BACKGROUND COLOR
		p_dc.setColor(l_backgroundColor, Gfx.COLOR_TRANSPARENT);
		p_dc.fillRectangle(0, 0, l_width, l_height);
						  		
  		//draw lines: FEATURE COLOR
  		p_dc.setColor(l_featureColor, Gfx.COLOR_TRANSPARENT);
		p_dc.drawLine(			 0,  l_height*4/16, 	 l_width,  l_height*4/16);
		p_dc.drawLine(			 0,  l_height*8/16, 	 l_width,  l_height*8/16);
		p_dc.drawLine(			 0, l_height*12/16, 	 l_width, l_height*12/16);
		p_dc.drawLine(l_width*8/16,  l_height*4/16, l_width*8/16, l_height*12/16);
		
		//draw rectangle around sets counter: TEXT COLOR
		p_dc.setColor(l_textColor, Gfx.COLOR_TRANSPARENT);
		p_dc.fillRectangle(l_width*6/16, l_height*10/16, l_width*2/16, l_height*2/16);	
		
		var l_timeLabel = m_activity.isFinished() ? "TIME ELAPSED" : "TIME REMAINING";
		var l_timeValue = m_activity.isFinished() ? m_activity.getTotalTime() : m_activity.getTimeLeft();	
			
		//write field labels: TEXT COLOR
		p_dc.drawText( l_width*8/16, 	   		  0, Gfx.FONT_SYSTEM_XTINY,   		  "HR", Gfx.TEXT_JUSTIFY_CENTER);
  		p_dc.drawText( l_width*4/16,  l_height*4/16, Gfx.FONT_SYSTEM_XTINY,			"WORK", Gfx.TEXT_JUSTIFY_CENTER);
  		p_dc.drawText(l_width*12/16,  l_height*4/16, Gfx.FONT_SYSTEM_XTINY, 		"REST", Gfx.TEXT_JUSTIFY_CENTER);
  		p_dc.drawText( l_width*4/16,  l_height*8/16, Gfx.FONT_SYSTEM_XTINY,  	    "REP", Gfx.TEXT_JUSTIFY_CENTER);
  		p_dc.drawText(l_width*12/16,  l_height*8/16, Gfx.FONT_SYSTEM_XTINY, "TIME OF DAY", Gfx.TEXT_JUSTIFY_CENTER);
  		p_dc.drawText( l_width*8/16, l_height*12/16, Gfx.FONT_SYSTEM_XTINY,   l_timeLabel, Gfx.TEXT_JUSTIFY_CENTER);
  	
  
  		//write field values: TEXT COLOR	
 		p_dc.drawText( l_width*8/16,  l_height*2/16, Gfx.FONT_SYSTEM_NUMBER_MILD,         m_activity.getHeartRate(), Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER);
  		p_dc.drawText( l_width*4/16,  l_height*6/16, Gfx.FONT_SYSTEM_NUMBER_MILD, m_activity.getRemainingWorkTime(), Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER);
  		p_dc.drawText(l_width*12/16,  l_height*6/16, Gfx.FONT_SYSTEM_NUMBER_MILD, m_activity.getRemainingRestTime(), Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER);
  		p_dc.drawText( l_width*4/16, l_height*10/16, Gfx.FONT_SYSTEM_NUMBER_MILD, m_activity.getCurrentRepetition(), Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER);
  		p_dc.drawText(l_width*12/16, l_height*10/16, Gfx.FONT_SYSTEM_NUMBER_MILD, 		  m_activity.getTimeOfDay(), Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER); 		
  		p_dc.drawText( l_width*8/16, l_height*14/16, Gfx.FONT_SYSTEM_NUMBER_MILD,   	   				l_timeValue, Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER); 
  		
  		//write set counter field value: BACKGROUND COLOR
		p_dc.setColor(l_backgroundColor, Gfx.COLOR_TRANSPARENT);
  		p_dc.drawText(l_width*7/16, l_height*10/16, Gfx.FONT_SYSTEM_TINY, m_activity.getCurrentSet(), Gfx.TEXT_JUSTIFY_CENTER);
  	}
}

class ActivityDelegate extends Ui.BehaviorDelegate 
{
	private var m_activity;
	
	function initialize(p_activity) 
  	{
		m_activity = p_activity;
    	BehaviorDelegate.initialize();
  	}
		
	function onMenu()
	{
		m_activity.onMenu();
	}

	function onSelect() 
	{
		m_activity.onSelect();
		return true;
	}
	
	function onBack() 
	{
		return m_activity.onBack();
	}
}
