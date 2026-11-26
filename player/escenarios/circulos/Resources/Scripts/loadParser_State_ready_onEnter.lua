--------------------------------------------------------------------------------
--  State............ : ready
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function loadParser.ready_onEnter ( )
--------------------------------------------------------------------------------
	
	--
	-- Write your code here, using 'this' as current AI instance.
	--
	log.message ( "parser.stk cargado en cache" )
    log.message ( cache.getFileProperty ( "parser.stk", cache.kPropertySize ))
    user.addAIModel ( this.getUser ( ), "parser/baseAI" )
    this.isReady ( true )
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
