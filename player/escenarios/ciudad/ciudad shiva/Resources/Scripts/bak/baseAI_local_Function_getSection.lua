--------------------------------------------------------------------------------
--  Function......... : getSection
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function baseAI_local.getSection ( iblock, isection )
--------------------------------------------------------------------------------
    --if (iblock==-1) then iblock=nil end --para buscar seccion en general (no de bloque)

    local _doc=xml.getRootElement ( this.doc() )
    if (_doc~=nil) then --existe xml a ejecutar
        --busco seccion blocks
        local _blocks = xml.getElementFirstChildWithName ( _doc, "blocks" )
        if (_blocks~=nil or iblock==-1) then -- seccion _blocks encontrada... (o no necesaria)
            -- buscar bloque 
            local _block = xml.getElementChildAt ( _blocks,  iblock) 
            if (_block~=nil or iblock==-1) then -- bloque actual encontrado... (o no necesario)
                -- si no busco en bloques... usar el root del doc
                if (iblock==-1) then _block=_doc end
                -- buscar seccion
                local _seccion = xml.getElementFirstChildWithName ( _block, isection )
                if (_seccion~=nil) then -- isection encontrada..
                    -- lanzar sus comandos
                    local _c = xml.getElementFirstChild ( _seccion )
                    while (_c~=nil) do
                        --agregar comandos a la lista cmds
                        table.add ( this.cmds ( ), xml.toString ( _c ) )
                        _c = xml.getElementNextSibling ( _c )
                    end --fin comandos
                    -- TODO EJECUTADO CORRECTAMENTE
                    return true
                else log.warning ( "No section '"..isection.."'" )
                end --fin seccion
            else log.warning ( "No block "..iblock )
            end -- fin bloque
        else log.warning ( "No blocks" )
        end -- fin seccion blocks
    else log.warning ( "No doc" )
    end --doc
	-- ALGO NO EXISTIA (doc, blocks, iblock, isection)
    return false
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
