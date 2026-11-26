package  {
	import com.greensock.TweenLite;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	import com.pixelfumes.reflect.*;
	
	import flash.desktop.NativeApplication;
	import flash.display.MovieClip;
	import flash.display.NativeWindow;
	import flash.display.StageAlign;
	import flash.display.StageAspectRatio;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileFilter;
	import flash.text.TextField;
	
	TweenPlugin.activate([AutoAlphaPlugin, GlowFilterPlugin]);
	
	public class Forma extends MovieClip {
		
		private var opciones:Opciones;
		private var masaBlanca:FondoBlanco;
		private var emergente:MovieClip;
		
		// Parte de fichero
		private var filtroFichero:FileFilter = new FileFilter("Fichero Forma", "*.*;");
		private var ficheroTrabajo:File = null;
		private var ficheroExportacion:File = null;
		private var xmlDatos:XML

		
		public function Forma() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(e:Event){
			removeEventListener(Event.ADDED_TO_STAGE, init);

			opciones = new Opciones();
			opciones.alpha = 0;
			opciones.cerrar.addEventListener(MouseEvent.CLICK, clickHandler);
			opciones.cerrar.buttonMode = true;
			
			masaBlanca = new FondoBlanco();
			masaBlanca.alpha = 0;
			masaBlanca.width = stage.stageWidth;
			masaBlanca.height = stage.stageHeight;
			masaBlanca.addEventListener(MouseEvent.CLICK, clickHandler);
			
			var menu:MenuSuperior = new MenuSuperior();
			
			menu.padre = this;
			diapos.padre = this;

			// Si es Mac OS X
			if (NativeApplication.supportsMenu) 
				NativeApplication.nativeApplication.menu = menu.init();
			
			// Si es Windows
			if (NativeWindow.supportsMenu)
				stage.nativeWindow.menu = menu.init();		
			
			stage.nativeWindow.activate();
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			var botonesMenu:Array = [menuNuevo, menuAbrir, menuGuardar, menuAnadir, menuQuitar,	menuSubir, menuBajar, menuRehacer, menuDeshacer, menuOpciones, menuVer];
			for(var i:int = 0; i < botonesMenu.length; i++){
				botonesMenu[i].addEventListener(MouseEvent.CLICK, clickHandler);
				botonesMenu[i].addEventListener(MouseEvent.MOUSE_OVER, overHandler);
				botonesMenu[i].addEventListener(MouseEvent.MOUSE_OUT, outHandler);
				botonesMenu[i].buttonMode = true;
				new Reflect({mc:botonesMenu[i].icono, alpha:40, ratio:150, distance:0, updateTime:-1, reflectionDropoff:0});
			}			

			var botonesNormales:Array = [editorboton, entornoboton, consolaboton];
			for(i = 0; i < botonesNormales.length; i++){
				botonesNormales[i].addEventListener(MouseEvent.CLICK, clickHandler);
				botonesNormales[i].buttonMode = true;
			}			
		}
		
		private function clickHandler(e:MouseEvent){
			switch(e.currentTarget){
				case opciones.cerrar:
				case masaBlanca:
					if(emergente != null)
						TweenLite.to(emergente,0.5,{autoAlpha:0,onComplete: function(){removeChild(emergente); emergente =null; }});
						TweenLite.to(masaBlanca,0.5,{autoAlpha:0,onComplete: function(){removeChild(masaBlanca); }});
					break;
				case menuNuevo:
					nuevoArchivo();
					break;
				case menuAbrir:
					abrirArchivo();
					break;
				case menuGuardar:
					guardarArchivo();
					break;
				case menuAnadir:
					nuevaDiapositiva();			
					break;
				case menuQuitar:
					eliminarDiapositiva();
					break;
				case menuSubir:
					subirDiapositiva();			
					break;
				case menuBajar:
					bajarDiapositiva();			
					break;
				case menuOpciones:
					cargarOpciones();
					break;
				case menuRehacer:
					rehacer();
					break;
				case menuDeshacer:
					deshacer();
					break;
				case menuVer:
					break;
				// Botones Normales
				case entornoboton:
					if(getChildIndex(entorno) < getChildIndex(editor))
						swapChildren(entorno, editor);
					if(getChildIndex(entorno) < getChildIndex(consola))
						swapChildren(entorno, consola);
					break;				
				case editorboton:
					if(getChildIndex(editor) < getChildIndex(entorno))
						swapChildren(editor, entorno);
					if(getChildIndex(editor) < getChildIndex(consola))
						swapChildren(editor, consola);
					break;
				case consolaboton:
					if(getChildIndex(consola) < getChildIndex(entorno))
						swapChildren(consola, entorno);
					if(getChildIndex(consola) < getChildIndex(editor))
						swapChildren(consola, editor);
					break;
			}
		}
		
		private function overHandler(e:MouseEvent){
			TweenLite.to(e.currentTarget.icono, 0.3, {glowFilter:{color:0xffffff, alpha:0.7, blurX:10, blurY:10, strength:1, quality:3}});
		}

		private function outHandler(e:MouseEvent){
			TweenLite.to(e.currentTarget.icono, 0.3, {glowFilter:{color:0xffffff, alpha:0, blurX:10, blurY:10, strength:1, quality:3}});
		}
		
		public function cargarOpciones(){
			emergente = opciones;
			addChild(masaBlanca);
			if(opciones.parent != this){
				addChild(opciones);
			}

			opciones.x = stage.stageWidth/2-777/2;
			opciones.y = stage.stageHeight/2-412/2;

			if(getChildIndex(masaBlanca) > getChildIndex(opciones))
				swapChildren(masaBlanca, opciones);
			
			TweenLite.to(masaBlanca,0.5,{autoAlpha:1});
			TweenLite.to(opciones,0.5,{autoAlpha:1});
		}
		
		public function nuevoArchivo(){
			trace("Avisar");
			ficheroTrabajo = null;
			xmlDatos = null;
			diapos.reiniciar();
		}
		
		// Abrimos fichero
		public function abrirArchivo(){
			nuevoArchivo();
			try{
				ficheroTrabajo = new File();
				ficheroTrabajo.browseForOpen("Abrir", [filtroFichero]);
				ficheroTrabajo.addEventListener(Event.SELECT, fileOpened);
			}
			catch (error:Error){
				
			}
		}
		
		function fileOpened(event:Event):void 
		{
			var fileStream:FileStream = new FileStream(); 
			fileStream.open(ficheroTrabajo, FileMode.READ);
			try{
				xmlDatos = new XML(fileStream.readUTFBytes(fileStream.bytesAvailable));
			}catch (error:Error){
				trace("Fallo al cargar el archivo");
				xmlDatos = null;
				ficheroTrabajo = null;
				return;
			}
			fileStream.close();
			
			//Cargamos opciones
			opciones.cargarConfig(new XML(xmlDatos.opciones));
			
			//Cargamos las diapos
			var directorio:String = ficheroTrabajo.url;
			var directorioBase:String = directorio.substr(0,directorio.lastIndexOf(ficheroTrabajo.name));
			var directorioFinal:String = directorioBase+ficheroTrabajo.name.split("."+ficheroTrabajo.extension).join("")+"Data"+File.separator;
			for(var i:int = 0; i < xmlDatos.diapositivas.diapositiva.length(); i++){
				trace(i , xmlDatos.diapositivas.diapositiva[i].@idtransicion);
				diapos.nuevaDiapositiva(directorioFinal+xmlDatos.diapositivas.diapositiva[i].@imagen, xmlDatos.diapositivas.diapositiva[i].@idtransicion, (xmlDatos.diapositivas.diapositiva[i].@video != null ? directorioFinal+xmlDatos.diapositivas.diapositiva[i].@video : null) );
			}
		}		
		
		public function guardarArchivo(){
			trace("FicheroTrabajo: ",ficheroTrabajo);
			if(ficheroTrabajo == null){
				ficheroTrabajo = new File();
				ficheroTrabajo.browseForSave("Guardar");
				ficheroTrabajo.addEventListener(Event.SELECT, fileSaved);	
			}else {
				escribirFichero();
			}
		}
		
		public function guardarComoArchivo(){
			if(ficheroTrabajo == null){
				guardarArchivo();
			}else{
				ficheroTrabajo = new File();
				ficheroTrabajo.browseForSave("Guardar como");
				ficheroTrabajo.addEventListener(Event.SELECT, fileSaved);
			}			
		}
		
		private function fileSaved(event:Event):void 
		{
			escribirFichero();
		}
		
		private function escribirFichero(){
			if(!diapos.compactar(ficheroTrabajo.name.split("."+ficheroTrabajo.extension)[0], ficheroTrabajo.url)){
				trace("Fallo al compactar");
				return;
			}
			trace(ficheroTrabajo.name);
			crearXML();
			if(!ficheroTrabajo.extension || ficheroTrabajo.extension.toLowerCase() != "xml"){
				ficheroTrabajo.url += ".xml";
			}
			var fileStream:FileStream = new FileStream(); 
			fileStream.open(ficheroTrabajo, FileMode.WRITE);
			fileStream.writeMultiByte(String(xmlDatos), "utf-8");
			fileStream.close();
		}
		
		private function crearXML(){
			xmlDatos = new XML('<xml></xml>');
			xmlDatos.appendChild(new XML('<opciones>'+ opciones.aXML() +'</opciones>'));
			xmlDatos.appendChild(new XML('<diapositivas>'+ diapos.aXML() +'</diapositivas>'));
			//trace(xmlDatos);
		}
		
		private function crearXMLAlt(){
			xmlDatos = new XML('<xml></xml>');
			xmlDatos.appendChild(new XML('<opciones>'+ opciones.aXMLAlt() +'</opciones>'));
			xmlDatos.appendChild(new XML('<general>'+ entorno.aXMLAlt() +'<directorio url="'+ficheroExportacion.name.split("."+ficheroExportacion.extension)[0]+"Data"+'" /></general>'));
			xmlDatos.appendChild(new XML('<bloques>'+ diapos.aXMLAlt() +'</bloques>'));
			//trace(xmlDatos);
		}

		public function exportar(){
			ficheroExportacion = new File();
			ficheroExportacion.browseForSave("Exportar en");
			ficheroExportacion.addEventListener(Event.SELECT, fileExported);
		}
		
		private function fileExported(event:Event):void 
		{
			if(!diapos.exportar(ficheroExportacion.name.split("."+ficheroExportacion.extension)[0], ficheroExportacion.url)){
				trace("Fallo al exportar");
				return;
			}
			trace(ficheroExportacion.name);
			crearXMLAlt();
			if(!ficheroExportacion.extension || ficheroExportacion.extension.toLowerCase() != "xml"){
				ficheroExportacion.url += ".xml";
			}
			var fileStream:FileStream = new FileStream(); 
			fileStream.open(ficheroExportacion, FileMode.WRITE);
			fileStream.writeMultiByte(String(xmlDatos), "utf-8");
			fileStream.close();
		}
		
		public function nuevaDiapositiva(){ 
			diapos.nuevaDiapositiva();
		}
		
		public function subirDiapositiva(){	
			diapos.subirDiapositiva();
		}
		
		public function bajarDiapositiva(){
			diapos.bajarDiapositiva();	
		}
		
		public function eliminarDiapositiva(){
			diapos.eliminarDiapositiva();
		}
		
		public function deshacer(){
			diapos.deshacer();
		}
		
		public function rehacer(){
			diapos.rehacer();
		}
		
		public function cortar(){
			diapos.cortar();
		}
		
		public function copiar(){
			diapos.copiar();
		}
		
		public function pegar(){
			diapos.pegar();
		}
		
		public function traceT(str:String, str2:String = "", str3:String = "", str4:String = ""){
			consola.texto.text = consola.texto.text + "\n" + str + str2 + str3 + str4;
			TextField(consola.texto).scrollV = TextField(consola.texto).maxScrollV;
		}
	}
}
