package 
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.URLRequest;
	
	import com.greensock.TweenLite;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	
	public class Editor extends MovieClip
	{
		private var ficheroTransiciones:File;
		private var seleccionada:Transicion = null;
		private var numAbajo:Number = 0;
		
		public function Editor()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(e:Event){
			transiciones.mask = masctrans;
			
			flechaIzqAbajo.addEventListener(MouseEvent.CLICK, onClick);
			flechaDerAbajo.addEventListener(MouseEvent.CLICK, onClick);
			flechaIzqAbajo.buttonMode = true;
			flechaDerAbajo.buttonMode = true;
			
			ficheroTransiciones = File.applicationDirectory.resolvePath("config/Transiciones.xml");
			var fileStream:FileStream = new FileStream(); 
			fileStream.open(ficheroTransiciones, FileMode.READ);
			var xml:XML = new XML(fileStream.readUTFBytes(fileStream.bytesAvailable));
			fileStream.close();
			
			for(var i:int = 0; i<xml.transicion.length(); i++){
				var hijo:Transicion = new Transicion(xml.transicion[i].@nombre, xml.transicion[i].@id, 	xml.transicion[i].@imagen);
				hijo.x = 142*i;
				transiciones.addChild(hijo);
			}
			actualizarFlechasTransiciones();
		}
		
		public function cargarDiapositiva(diapo:Diapositiva = null){
			while(imagen.numChildren > 0){
				imagen.removeChildAt(0);
			}
			if(diapo == null) return;
			if(diapo.urlimagen == null) return;
			seleccionarTransicion(diapo.idtransicion);					
			var mLoader:Loader = new Loader();
			var mRequest:URLRequest = new URLRequest(diapo.urlimagen);
			mLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteHandler);
			mLoader.load(mRequest);
		}
		
		function onCompleteHandler(event:Event)
		{
			var objeto:Bitmap = event.target.loader.content;
			event.target.loader.unload();
			objeto.smoothing = true;
			objeto.height = 300;
			objeto.scaleX = objeto.scaleY;
			objeto.x = -objeto.width/2;
			objeto.y = -objeto.height/2;
			imagen.addChild(objeto);			
		}

		public function onClick(evt:MouseEvent){
			switch(evt.currentTarget){
				case flechaIzqAbajo:
					if(numAbajo > 0){
						numAbajo--;
						TweenLite.to(transiciones, 0.5, {x:106-142*numAbajo});
						actualizarFlechasTransiciones();
					}
					break;
				case flechaDerAbajo:
					if(numAbajo < transiciones.numChildren-4){
						numAbajo++;
						TweenLite.to(transiciones, 0.5, {x:106-142*numAbajo});
						actualizarFlechasTransiciones();
					}
					break;
			}
		}
		
		private function actualizarFlechasTransiciones(){
			if(numAbajo > 0){
				mostrarFlecha(flechaIzqAbajo);
			} else {
				ocultarFlecha(flechaIzqAbajo);
			}
			if(numAbajo < transiciones.numChildren-4){
				mostrarFlecha(flechaDerAbajo);
			} else {
				ocultarFlecha(flechaDerAbajo);
			}			
		}
		
		public function seleccionarTransicion(trans:String){
			MovieClip(root).traceT("Selecciono Transicion");
			for(var i:int = 0; i<transiciones.numChildren; i++){
				var hijo:Transicion = transiciones.getChildAt(i) as Transicion;
				if(hijo.id == trans){
					hijo.alpha = 1;
					seleccionada = hijo;
					MovieClip(root).diapos.seleccionarTransicion(hijo);
				} else {
					hijo.alpha = 0.6;
				}
			}
		}
		
		public function getTransicion(trans:String){
			for(var i:int = 0; i<transiciones.numChildren; i++){
				var hijo:Transicion = transiciones.getChildAt(i) as Transicion;
				if(hijo.id == trans){
					return hijo;
					break;
				}
			}
			return null;
		}
		
		private function mostrarFlecha(flecha:MovieClip){
			flecha.visible = true;
		}
		
		private function ocultarFlecha(flecha:MovieClip){
			flecha.visible = false;
		}
	}
}