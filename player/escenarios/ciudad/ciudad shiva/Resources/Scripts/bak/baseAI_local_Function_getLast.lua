--------------------------------------------------------------------------------
--  Function......... : getLast
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function baseAI_local.getLast ( iblock )
--------------------------------------------------------------------------------
	
    local _doc=xml.getRootElement ( this.doc() )
    if (_doc~=nil) then --existe xml
        --busco seccion blocks
        local _blocks = xml.getElementFirstChildWithName ( _doc, "blocks" )
        if (_blocks~=nil) then -- seccion _blocks encontrada...
            -- buscar bloque 
            local _block = xml.getElementChildAt ( _blocks,  iblock) 
            if (_block~=nil) then -- bloque actual encontrado...
                -- buscar seccion slides
                local _slides = xml.getElementFirstChildWithName ( _block, "slides" )
                if (_slides~=nil) then -- seccion _slides encontrada...
                    -- contar numero de hijos (de slides)
                    local c=xml.getElementChildCount ( _slides )
                    if (c>0) then
                        -- tiene slides
                        c=c-1   -- el ultimo tendrá numeracion "count-1"
                    end --no tiene hijos
                    return c
                else log.warning ( "No slides" )
                end -- fin seccion slides
            end -- fin bloque
        else log.warning ( "No blocks" )
        end -- fin seccion blocks
    else log.warning ( "No doc" )
    end --doc
	-- ALGO NO EXISTIA (doc, blocks, iblock, slides)
    return 0   -- si no tiene slides, la ultima será... ir al bloque anterior
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
