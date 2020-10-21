class StateFactory
{
	function createState(p_state, p_activity)
	{
		if(p_state == :notStarted)
		{
			return new StateNotStarted(p_activity);	
		}
		else if(p_state == :work)
		{
			return new StateWork(p_activity);	
		}
		else if(p_state == :rest)
		{
			return new StateRest(p_activity);	
		}
		else if(p_state == :paused)
		{
			return new StatePaused(p_activity);	
		}
		else
		{
			return new StateFinished(p_activity);	
		}
	}
}