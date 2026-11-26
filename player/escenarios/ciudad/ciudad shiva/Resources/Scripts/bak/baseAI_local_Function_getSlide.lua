--------------------------------------------------------------------------------
--  Function......... : getSlide
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function baseAI_local.getSlide ( iblock, islide, dir )
--------------------------------------------------------------------------------
	if (dir==nil) then dir=1 end -- por omision "entramos" en la diapo
    local _doc=xml.getRootElement ( this.doc() )
    if (_doc~=nil) then --existe xml a ejecutar
        --busco seccion blocks
        local _blocks = xml.getElementFirstChildWithName ( _doc, "blocks" )
        if (_blocks~=nil) then -- seccion _blocks encontrada...
            -- buscar bloque 
            local _block = xml.getElementChildAt ( _blocks,  iblock) 
            if (_block~=nil) then -- bloque actual encontrado...
                --buscar seccion _slides
                local _slides = xml.getElementFirstChildWithName( _block, "slides")
                if (_slides~=nil) then -- seccion _slides encontrada...
                    -- buscar slide
                    local _slide = xml.getElementChildAt ( _slides, islide )
                    if (_slide~=nil) then -- slide encontrada...
                        if (dir<0) then -- estamos "retrocediendo"
                            --buscamos seccion "roolback"
                            local _rollback = xml.getElementFirstChildWithName ( _slide, "rollback" )
                            if (_rollback~=nil) then
                                _slide=_rollback 
                            else
                                log.warning ( "No rollback in slide "..islide )
                                -- no se ejecuta nada, pero se considera correcto
                                --return true
                                --SI NO HAY SECCION "ROLLBACK" se ejecuta otra vez la slide
                                --(bueno para posiciones globales "set_target", p.ej)
                            end
                        end
                        -- lanzar sus comandos
                        local _c = xml.getElementFirstChild ( _slide )
                        while (_c~=nil) do
                            --agregar comandos a la lista cmds
                            table.add ( this.cmds ( ), xml.toString ( _c ) )
                            _c = xml.getElementNextSibling ( _c )
                        end --fin comandos
                        -- TODO EJECUTADO CORRECTAMENTE
                        return true
                    else log.warning ( "No slide "..islide )
                    end --fin slide
                else log.warning ( "No slides" )
                end -- fin seccion slides
            else log.warning ( "No block "..iblock )
            end -- fin bloque
        else log.warning ( "No blocks" )
        end -- fin seccion blocks
    else log.warning ( "No doc" )
    end --doc
	-- ALGO NO EXISTIA (doc, blocks, iblock, slides, islide)
    return false
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
