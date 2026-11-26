--------------------------------------------------------------------------------
--  Function......... : getParamValue
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function baseAI.getParamValue ( cmd, param)
--------------------------------------------------------------------------------
	
    local atrib = xml.getElementAttributeWithName ( cmd, param )
    if (atrib~=nil) then
        local v=xml.getAttributeValue ( atrib )
        if (string.getSubString ( v, 0, 1 )=="$") then
            local varname=string.getSubString ( v, 1, string.getLength ( v )-1 )
            v=hashtable.get ( this.variables ( ), varname )
        end
        return v
    else
        return nil
    end
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
