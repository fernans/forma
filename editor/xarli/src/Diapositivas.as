package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.net.FileFilter;
	
	public class Diapositivas extends MovieClip
	{
		public var padre:MovieClip;
		private var seleccionada:Diapositiva = null;
		private var numseleccionada:Number = -1;
		private var fichero:File = new File();
		private var filtroFichero:FileFilter = new FileFilter("Media", "*.ppt;*.pps;*.tif;*.tiff;*.tga;*.bmp;*.jpg;*.gif;*.png;*.mpeg;*.mpg;*.avi;*.mov;*.ogm;*.ogg");
		//private var filtroFichero:FileFilter = new FileFilter("Imagenes", "*.jpg;*.gif;*.png");
		private var pilaDeshacer:Array = [];
		private var pilaRehacer:Array = [];	
		private var portapeles:Diapositiva = null;
		
		public function Diapositivas(){
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(e:Event){
			removeEventListener(Event.ADDED_TO_STAGE, init);
			scroll.init();
			diapositivas.mask = mascara;
			padre = root as MovieClip;
		}
		
		public function nuevaDiapositiva(img:String = null, trans:String = null, video:String = null){
			padre.traceT("Creo diapositiva");
			if(img == null){
				try{
					fichero.browseForOpen("Importar", [filtroFichero]);
					fichero.addEventListener(Event.SELECT, fileSelected);
					fichero.addEventListener(Event.CANCEL, fileCancel);
				}
				catch (error:Error){
					padre.traceT("Fallo al cargar:"+ error.message);
				}
			}
			else {
				var hijo:Diapositiva = new Diapositiva(img,trans,video);
				diapositivas.addChild(hijo);
				/*
				if(numseleccionada >= 0 && trans == null){
					diapositivas.setChildIndex(hijo,numseleccionada+1);
				}
				*/
				seleccionarDiapositiva(hijo);
				organizarDiapositivas();
				pilaDeshacer.push({id:"añadir",diapo:hijo.clonar()});
			}
		}
		
		function fileSelected(event:Event):void 
		{
			padre.traceT("Fichero seleccionado");			
			padre.traceT(fichero);
			var imp:Importador = new Importador(fichero, padre);
		}
		
		function fileCancel(event:Event):void{
			padre.traceT("Cancelado");
		}		

		public function eliminarDiapositiva(){
			if(seleccionada){
				pilaDeshacer.push({id:"eliminar",diapo:seleccionada.clonar()});
				diapositivas.removeChild(seleccionada);
				if(numseleccionada == diapositivas.numChildren) numseleccionada--;
				if(numseleccionada >= 0 && numseleccionada <= diapositivas.numChildren-1){
					seleccionada = diapositivas.getChildAt(numseleccionada) as Diapositiva;
					seleccionada.seleccionar();
					MovieClip(root).editor.cargarDiapositiva(seleccionada);
				} else {
					deseleccionarDiapositiva();
				}
				organizarDiapositivas();
			}
		}
		
		public function subirDiapositiva(){
			padre.traceT("Subo " + numseleccionada + diapositivas.numChildren);
			if(numseleccionada > 0 && seleccionada != null){
				pilaDeshacer.push({id:"subir",diapo:seleccionada.clonar()});
				diapositivas.setChildIndex(seleccionada, --numseleccionada);
				organizarDiapositivas();
				//scroll.mostrar(seleccionada.y);
			}
		}
		
		public function bajarDiapositiva(){
			padre.traceT("Bajo" + numseleccionada + diapositivas.numChildren);
			if(numseleccionada < (diapositivas.numChildren-1) && seleccionada != null){
				pilaDeshacer.push({id:"bajar",diapo:seleccionada.clonar()});
				diapositivas.setChildIndex(seleccionada, ++numseleccionada);
				organizarDiapositivas();
				//scroll.mostrar(seleccionada.y);
			}
		}
		
		private function organizarDiapositivas(){
			for(var i:int = 0; i < diapositivas.numChildren; i++){
				var hijo:MovieClip = diapositivas.getChildAt(i) as MovieClip;
				hijo.y = i*180;
				hijo.x = 0;
				hijo.indice = i;
				hijo.titulo.text = "Diapo "+ (i+1);
				hijo.mascaratrans.visible = true;
			}
			
			//Transicion por defecto
			if(diapositivas.numChildren > 0 && (diapositivas.getChildAt(0) as Diapositiva).idtransicion == null){
				(diapositivas.getChildAt(0) as Diapositiva).cargarTransicion(MovieClip(root).editor.getTransicion("default"));
			}
			
			//Autoseleccionamos una
			if(seleccionada == null && diapositivas.numChildren > 0){
				seleccionarDiapositiva(diapositivas.getChildAt(0) as Diapositiva);
			}
			
			//Eliminamos el aviso
			if(diapositivas.numChildren > 0) aviso.visible = false;
			else aviso.visible = true;
			
			//Desactivamos el scroll si es necesairo
			if(diapositivas.height <= scroll.height){
				scroll.desactivar();
			}
			else {
				scroll.activar();
				
				//Ajustamos la barra del scroll
				scroll.reescalar();
				
				//Mostramos la seleccionada
				scroll.mostrar(seleccionada.y);
			} 			
		}

		public function seleccionarDiapositiva(diapo:Diapositiva){
			if(padre.editor == null) return;
			if(seleccionada != diapo){
				if(seleccionada != null) deseleccionarDiapositiva();
				seleccionada = diapo;
				seleccionada.seleccionar();
				numseleccionada = diapositivas.getChildIndex(seleccionada);
				padre.editor.cargarDiapositiva(diapo);
				scroll.mostrar(seleccionada.y);
			}
		}
		
		public function deseleccionarDiapositiva()
		{
			seleccionada.deseleccionar();
			seleccionada = null;
			numseleccionada == -1;
			padre.editor.cargarDiapositiva(null);	
		}
		
		public function aXML():String{
			var cadena:String = "";
			for(var i:int = 0; i < diapositivas.numChildren; i++){
				var hijo:MovieClip = diapositivas.getChildAt(i) as MovieClip;
				cadena += hijo.aXML();
			}
			return cadena;
		}
		
		public function aXMLAlt():String{
			var cadena:String = "";
			var j:int = 0;
			for(var i:int = 0; i < diapositivas.numChildren; i++){
				var hijo:MovieClip = diapositivas.getChildAt(i) as MovieClip;
				trace(i, hijo.idtransicion);
				if(hijo.idtransicion != null && hijo.idtransicion != ""){
					if(i != 0) cadena += "</bloque>";
					cadena += '<bloque lugar="posicion'+ ((j%4)+1)+'" idtransicion="'+hijo.idtransicion+'">';
					j++;
				}
				cadena += hijo.aXMLAlt();
			}
			cadena += "</bloque>";
			trace(cadena);
			return cadena;
		}

		
		public function compactar(nombre:String, directorio:String):Boolean{
			var tempOrig:File;
			var tempDest:File; 
			var tempFolder:File = File.createTempDirectory();
			
			var directorioBase:String = directorio.substr(0,directorio.lastIndexOf(nombre));
			var directorioFinal:String = directorioBase+nombre+"Data"+File.separator;
			var urltemporal:String = tempFolder.url+File.separator;
			
			tempDest = new File(directorioFinal);
			var urlfinal:String = tempDest.url+File.separator;

			
			try {
				tempDest.createDirectory();
			} catch(e:Error){ return false; }
			
			// Movemos todo a temporales
			for(var i:int = 0; i < diapositivas.numChildren; i++){
				var hijo:Diapositiva = diapositivas.getChildAt(i) as Diapositiva;
				tempOrig = new File(hijo.urlimagen);
				tempDest = new File(urltemporal+hijo.nombreimagen);
				
				tempOrig.copyTo(tempDest,true);
				
				if(hijo.nombrevideo != null && hijo.nombrevideo != ""){
					tempOrig = new File(hijo.urlvideo);
					tempDest = new File(urltemporal+hijo.nombrevideo);
					tempOrig.copyTo(tempDest,true);
				}				
				//hijo.urlimagen = urltemporal+hijo.nombreimagen;
			}
			
			//  Vaciamos el padre;
			tempDest = new File(directorioFinal);
			var ficheros:Array = tempDest.getDirectoryListing();
			for(i = 0; i < ficheros.length; i++){
				padre.traceT("Borro: " + ficheros[i].url);
				ficheros[i].deleteFile();				
			}
			
			// Movemos todo a la carpeta final
			for(i = 0; i < diapositivas.numChildren; i++){
				hijo = diapositivas.getChildAt(i) as Diapositiva;
				
				tempOrig = new File(urltemporal+hijo.nombreimagen);
				tempDest = new File(urlfinal+hijo.nombreimagen);
				
				padre.traceT("Nombre de la imagen: " + hijo.nombreimagen);
				padre.traceT("URL de la imagen: " + urltemporal+hijo.nombreimagen);
				padre.traceT("Copio de: " + tempOrig.nativePath);
				padre.traceT("Copio a: " + tempDest.nativePath);
				tempOrig.copyTo(tempDest,true);
				
				if(hijo.nombrevideo != null && hijo.nombrevideo != ""){
					tempOrig = new File(urltemporal+hijo.nombrevideo);
					tempDest = new File(urlfinal+hijo.nombrevideo);
					
					padre.traceT("Nombre del video: " + hijo.nombrevideo);
					padre.traceT("URL del video: " + urltemporal+hijo.nombrevideo);
					padre.traceT("Copio de: " + tempOrig.nativePath);
					padre.traceT("Copio a: " + tempDest.nativePath);
					tempOrig.copyTo(tempDest,true);
					
					hijo.urlvideo = urlfinal+hijo.nombrevideo;
				}

				hijo.urlimagen = urlfinal+hijo.nombreimagen;
			}
			return true;
		}
		
		public function exportar(nombre:String, directorio:String):Boolean{
			var tempOrig:File;
			var tempDest:File; 
			var tempFolder:File = File.createTempDirectory();
			
			var directorioBase:String = directorio.substr(0,directorio.lastIndexOf(nombre));
			var directorioFinal:String = directorioBase+nombre+"Data"+File.separator;
			var urltemporal:String = tempFolder.url+File.separator;
			
			tempDest = new File(directorioFinal);
			var urlfinal:String = tempDest.url+File.separator;
			
			
			try {
				tempDest.createDirectory();
			} catch(e:Error){ return false; }
			
			// Movemos todo a temporales
			for(var i:int = 0; i < diapositivas.numChildren; i++){
				var hijo:Diapositiva = diapositivas.getChildAt(i) as Diapositiva;
				tempOrig = new File(hijo.urlimagen);
				tempDest = new File(urltemporal+hijo.nombreimagen);
				
				tempOrig.copyTo(tempDest,true);
				
				if(hijo.nombrevideo != null && hijo.nombrevideo != ""){
					trace(hijo.urlvideo);
					tempOrig = new File(hijo.urlvideo);
					tempDest = new File(urltemporal+hijo.nombrevideo);
					tempOrig.copyTo(tempDest,true);
				}				
			}
			
			// Movemos todo a la carpeta final
			for(i = 0; i < diapositivas.numChildren; i++){
				hijo = diapositivas.getChildAt(i) as Diapositiva;
				
				tempOrig = new File(urltemporal+hijo.nombreimagen);
				tempDest = new File(urlfinal+hijo.nombreimagen);
				
				padre.traceT("Nombre de la imagen: " + hijo.nombreimagen);
				padre.traceT("URL de la imagen: " + urltemporal+hijo.nombreimagen);
				padre.traceT("Copio de: " + tempOrig.nativePath);
				padre.traceT("Copio a: " + tempDest.nativePath);
				tempOrig.copyTo(tempDest,true);
				
				if(hijo.nombrevideo != null && hijo.nombrevideo != ""){
					tempOrig = new File(urltemporal+hijo.nombrevideo);
					tempDest = new File(urlfinal+hijo.nombrevideo);
					
					padre.traceT("Nombre del video: " + hijo.nombrevideo);
					padre.traceT("URL del video: " + urltemporal+hijo.nombrevideo);
					padre.traceT("Copio de: " + tempOrig.nativePath);
					padre.traceT("Copio a: " + tempDest.nativePath);
					tempOrig.copyTo(tempDest,true);
				}
			}
			return true;
		}
		
		public function seleccionarTransicion(trans:Transicion){
			if(seleccionada){
				seleccionada.cargarTransicion(trans);
				pilaDeshacer.push({id:"transicion",diapo:seleccionada.clonar()});
			}
		}
		
		public function reiniciar(){
			while(diapositivas.numChildren > 0){
				diapositivas.removeChildAt(0);
			}
			aviso.visible = true;
			MovieClip(root).editor.cargarDiapositiva(null);
			seleccionada = null;
			numseleccionada = -1;
			scroll.desactivar();
			
			// Creo unas cuentas sobre la marcha
			//for(var i:int = 0; i < 10; i++){
			//	nuevaDiapositiva(File.applicationDirectory.url+"config/transicion" + (1+i%4) + ".jpg",null);
			//}
			//vaciarPilas();
		}
		
		public function deshacer(){
			if(pilaDeshacer.length > 0){
				var elemento:Object = pilaDeshacer.pop();
				switch(elemento.id){
					case "añadir":
						padre.traceT("Deshago añadir");
						seleccionarDiapositiva(diapositivas.getChildAt(elemento.diapo.indice) as Diapositiva);
						eliminarDiapositiva();
						pilaDeshacer.pop();
						pilaRehacer.push(elemento);
						break;
					case "eliminar":
						padre.traceT("Deshago eliminar");
						diapositivas.addChild(elemento.diapo);
						diapositivas.setChildIndex(elemento.diapo, elemento.diapo.indice);
						seleccionarDiapositiva(elemento.diapo);
						organizarDiapositivas();
						pilaRehacer.push(elemento);
						break;
					case "subir":
						padre.traceT("Deshago subir");
						seleccionarDiapositiva(diapositivas.getChildAt(elemento.diapo.indice-1) as Diapositiva);
						bajarDiapositiva();
						pilaRehacer.push(elemento);
						break;
					case "bajar":
						padre.traceT("Deshago bajar");
						seleccionarDiapositiva(diapositivas.getChildAt(elemento.diapo.indice+1) as Diapositiva);
						subirDiapositiva();
						pilaRehacer.push(elemento);
						break;
					case "transicion":
						padre.traceT("Deshago transicion");
						diapositivas.addChild(elemento.diapo);
						var temp:Diapositiva = diapositivas.getChildAt(elemento.diapo.indice) as Diapositiva;
						diapositivas.removeChildAt(elemento.diapo.indice);
						diapositivas.setChildIndex(elemento.diapo, elemento.diapo.indice);
						seleccionarDiapositiva(elemento.diapo);
						organizarDiapositivas();
						elemento.diapo = temp;
						pilaRehacer.push(elemento);
						break;
				}
			}
		}
		
		public function rehacer(){
			if(pilaRehacer.length > 0){
				var elemento:Object = pilaRehacer.pop();
				switch(elemento.id){
					case "añadir":
						padre.traceT("Rehago añadir");
						diapositivas.addChild(elemento.diapo);
						diapositivas.setChildIndex(elemento.diapo, elemento.diapo.indice);
						seleccionarDiapositiva(elemento.diapo);
						organizarDiapositivas();
						pilaDeshacer.push(elemento);
						break;
					case "eliminar":
						padre.traceT("Rehago eliminar");
						seleccionarDiapositiva(diapositivas.getChildAt(elemento.diapo.indice) as Diapositiva);
						eliminarDiapositiva();
						organizarDiapositivas();
						break;
					case "subir":
						padre.traceT("Rehago subir");
						seleccionarDiapositiva(diapositivas.getChildAt(elemento.diapo.indice) as Diapositiva);
						subirDiapositiva();
						break;
					case "bajar":
						padre.traceT("Rehago bajar");
						seleccionarDiapositiva(diapositivas.getChildAt(elemento.diapo.indice) as Diapositiva);
						bajarDiapositiva();
						break;
					case "transicion":
						padre.traceT("Rehago transicion");
						diapositivas.addChild(elemento.diapo);
						var temp:Diapositiva = diapositivas.getChildAt(elemento.diapo.indice) as Diapositiva;
						diapositivas.removeChildAt(elemento.diapo.indice);
						diapositivas.setChildIndex(elemento.diapo, elemento.diapo.indice);
						seleccionarDiapositiva(elemento.diapo);
						organizarDiapositivas();
						elemento.diapo = temp;
						pilaDeshacer.push(elemento);
						break;
				}
			}
		}
		
		public function vaciarPilas(){
			while(pilaDeshacer.length > 0){
				pilaDeshacer.pop();
			}
			while(pilaRehacer.length > 0){
				pilaRehacer.pop();
			}
		}
		
		public function cortar(){
			if(seleccionada){
				padre.traceT("Cortar");
				copiar();
				eliminarDiapositiva();
			}	
		}

		
		public function copiar(){
			if(seleccionada){
				padre.traceT("Copiar");
			 	portapeles = seleccionada.clonar();
			}
		}
		
		public function pegar(){
			padre.traceT("Pegar");
			diapositivas.addChild(portapeles);
			diapositivas.setChildIndex(portapeles, seleccionada.indice+1);
			seleccionarDiapositiva(portapeles);
			organizarDiapositivas();
			portapeles = portapeles.clonar();
			pilaDeshacer.push({id:"añadir",diapo:portapeles});
		}
	}
}