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
 
   	function onShow()
  	{
 		System.println("Activity"); 	
  	}
  		
  	function onUpdate(p_dc)
  	{
  		var l_width = p_dc.getWidth();
  		var l_height = p_dc.getHeight();		

		//draw background color COLOR_WHITE
		p_dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
		p_dc.fillRectangle(0, 0, l_width, l_height);
		
		//draw background color COLOR_BLACK for sets rectangle
		p_dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
		p_dc.fillRectangle(l_width*6/16, l_height*10/16, l_width*2/16, l_height*2/16);		
				
		//draw lines
		p_dc.drawLine(			 0,  l_height*4/16, 	 l_width,  l_height*4/16);
		p_dc.drawLine(			 0,  l_height*8/16, 	 l_width,  l_height*8/16);
		p_dc.drawLine(			 0, l_height*12/16, 	 l_width, l_height*12/16);
		p_dc.drawLine(l_width*8/16,  l_height*4/16, l_width*8/16, l_height*12/16);
		
		//draw labels text with COLOR_BLACK
		p_dc.drawText( l_width*8/16, 	   		  0, Gfx.FONT_SYSTEM_XTINY,		     "HR", Gfx.TEXT_JUSTIFY_CENTER);
  		p_dc.drawText( l_width*4/16,  l_height*4/16, Gfx.FONT_SYSTEM_XTINY,		   "WORK", Gfx.TEXT_JUSTIFY_CENTER);
  		p_dc.drawText(l_width*12/16,  l_height*4/16, Gfx.FONT_SYSTEM_XTINY,		   "REST", Gfx.TEXT_JUSTIFY_CENTER);
  		p_dc.drawText( l_width*4/16,  l_height*8/16, Gfx.FONT_SYSTEM_XTINY,		    "REP", Gfx.TEXT_JUSTIFY_CENTER);
  		p_dc.drawText(l_width*12/16,  l_height*8/16, Gfx.FONT_SYSTEM_XTINY, "TIME OF DAY", Gfx.TEXT_JUSTIFY_CENTER);
  		p_dc.drawText( l_width*8/16, l_height*12/16, Gfx.FONT_SYSTEM_XTINY,   "TIME LEFT", Gfx.TEXT_JUSTIFY_CENTER);
  		
  		//draw data text with COLOR_BLACK	
 		p_dc.drawText( l_width*8/16,  l_height*2/16, Gfx.FONT_SYSTEM_NUMBER_MILD,         m_activity.getHeartRate(), Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER);
  		p_dc.drawText( l_width*4/16,  l_height*6/16, Gfx.FONT_SYSTEM_NUMBER_MILD, m_activity.getRemainingWorkTime(), Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER);
  		p_dc.drawText(l_width*12/16,  l_height*6/16, Gfx.FONT_SYSTEM_NUMBER_MILD, m_activity.getRemainingRestTime(), Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER);
  		p_dc.drawText( l_width*4/16, l_height*10/16, Gfx.FONT_SYSTEM_NUMBER_MILD, m_activity.getCurrentRepetition(), Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER);
  		p_dc.drawText(l_width*12/16, l_height*10/16, Gfx.FONT_SYSTEM_NUMBER_MILD, 		  m_activity.getTimeOfDay(), Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER); 		
  		p_dc.drawText( l_width*8/16, l_height*14/16, Gfx.FONT_SYSTEM_NUMBER_MILD,   	   m_activity.getTimeLeft(), Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER); 
  		
  		//draw data text with COLOR_WHITE
		p_dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
  		p_dc.drawText( l_width*7/16, l_height*10/16, Gfx.FONT_SYSTEM_TINY, 				 m_activity.getCurrentSet(), Gfx.TEXT_JUSTIFY_CENTER);

  	}
}
//  	function onUpdate(dc) 
//  	{
//  		setupDisplay(dc, m_model.phase);
//  		if (m_model.done)
//  		{
//  		} 
//  		
//  		else 
//  		{
//  			largeText(timerString(), dc);
//    		bottomText("" + m_model.round + "/" + m_model.TOTAL_ROUNDS, dc);
//	    	if (m_model.phase == :prep) 
//	    	{
//	    		topText("PREP", dc);
//	    	}
//	    	if (m_model.phase == :rest) 
//	    	{
//	    		topText("REST", dc);
//	    	}
//	      	if (m_model.phase == :work) 
//	     	{
//	    		topText("GO", dc);
//	    	}
//  		}
//  	}
//
//  	function setupDisplay(dc, phase)
//  	{
//  		if (phase == :work) 
//  		{
//  			dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_WHITE);
//  		} 
//  		else 
//  		{
//  			dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
//  		}
//    	dc.clear();
//    }
//
//  	function topText(text, dc)
//  	{
//  		dc.drawText(
//  			dc.getWidth()/2,
//  			dc.getHeight()*0.1,
//  			Gfx.FONT_LARGE,
//  			text,
//  			Gfx.TEXT_JUSTIFY_CENTER);
//  	}
//
//  	function bottomText(text, dc)
//  	{
//  		dc.drawText(
//  			dc.getWidth()/2,
//  			dc.getHeight()*0.8,
//  			Gfx.FONT_LARGE,
//  			text,
//  			Gfx.TEXT_JUSTIFY_CENTER);
//  	}
//
//  	function largeText(text, dc)
//  	{
//  		dc.drawText(
//  			dc.getWidth()/2,
//  			dc.getHeight()*0.25,
//  			Gfx.FONT_NUMBER_THAI_HOT,
//  			text,
//  			Gfx.TEXT_JUSTIFY_CENTER);
//  	}
//
//  	function timerString()
//  	{
//    	return "0:" + m_model.counter.format("%02d");
//  	}