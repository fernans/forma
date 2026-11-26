--------------------------------------------------------------------------------
--  Function......... : existsBlock
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function baseAI.existsBlock ( iblock )
--------------------------------------------------------------------------------
	
    local _doc=xml.getRootElement ( this.doc() )
    if (_doc~=nil) then --existe xml
        --busco seccion blocks
        local _blocks = xml.getElementFirstChildWithName ( _doc, "blocks" )
        if (_blocks~=nil) then -- seccion _blocks encontrada...
            -- buscar bloque 
            local _block = xml.getElementChildAt ( _blocks,  iblock) 
            if (_block~=nil) then -- bloque actual encontrado...
                return true
            end -- fin bloque
        else log.warning ( "No blocks" )
        end -- fin seccion blocks
    else log.warning ( "No doc" )
    end --doc
	-- ALGO NO EXISTIA (doc, blocks, iblock)
    return false
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
