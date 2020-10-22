class StateRest
{
	private var m_activityModel;
	private var m_activityWeakRef;
	
	function initialize(p_activityModel, p_activityWeakRef)
	{
		System.println("State: StateRest");
		
		m_activityModel = p_activityModel;
		m_activityWeakRef = p_activityWeakRef;
				
		m_activityModel.setPaused(false);
		m_activityModel.setFinished(false);
	}
	
	function onMenu()
	{
		System.println("onMenu not available in StateRest");
	}
	
	function onSelect()
	{
		pauseActivity();
	}

	function onBack()
	{		
		System.println("onBack not available in StateRest");	
		return true;
	}

	function onActivityTimer()
	{
		if(m_activityModel.getRemainingRestTime() > 0)
		{
			m_activityModel.decrementRemainingRestTime();
			m_activityModel.incrementTimeElapsed();
		}
		
		if(m_activityModel.getRemainingRestTime() == 0)
		{
			if(m_activityModel.isLastRepetition() && m_activityModel.isLastSet())
			{
				m_activityWeakRef.get().stateTransition(:stateFinished);	
			}
			else
			{
				m_activityModel.restartTimers();
				m_activityWeakRef.get().stateTransition(:stateWork);
				
				if(m_activityModel.isLastRepetition())
				{
					m_activityModel.restartRepetitions();
					m_activityModel.incrementCurrentSet();
				}
				else
				{
					m_activityModel.incrementCurrentRepetition();
				}
			}
		}
	}

	private function pauseActivity()
	{
		m_activityWeakRef.get().stateTransition(:statePaused);
	}
}
