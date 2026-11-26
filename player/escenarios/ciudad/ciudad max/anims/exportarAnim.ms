function exportarAnim ini fin = (
		flip=false
		if (fin<ini) then (
			swap ini fin
			flip=true
		)
	
		undo on (
			if (flip) then (
				reverseTime $ ini fin #incLeft #incRight
			)
			deleteTime $ (fin+1) 5000
			deleteTime $ -1f (ini-1)
		)
		max file export selected
		max undo
	)