using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class ActivityView extends Ui.View 
{
	private var m_activity;
	
	function initialize(p_activity) 
  	{
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
  		
   		System.println("Width: " + l_width + " Height: " + l_height);  		

		//introduce background color COLOR_WHITE
		p_dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
		p_dc.fillRectangle(0, 0, l_width, l_height);
		
		//draw text with COLOR_BLACK
		p_dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
  		p_dc.drawText(l_width*1/4, l_height*1/4, Gfx.FONT_XTINY, "MY TEXT", Gfx.TEXT_JUSTIFY_CENTER);
  		p_dc.drawText(l_width*3/4, l_height*1/4, Gfx.FONT_XTINY, "MY TEXT", Gfx.TEXT_JUSTIFY_CENTER);
  		p_dc.drawText(l_width*1/4, l_height*3/4, Gfx.FONT_XTINY, "MY TEXT", Gfx.TEXT_JUSTIFY_CENTER);
  		p_dc.drawText(l_width*3/4, l_height*3/4, Gfx.FONT_XTINY, "MY TEXT", Gfx.TEXT_JUSTIFY_CENTER);
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
}
