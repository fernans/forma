package 
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;

	
	public class Diapositiva extends MovieClip
	{
		private var seleccionada:Boolean = false;
		public var idtransicion:String = null;
		public var corte:Boolean = false;
		public var urlimagen:String = null;
		public var urlvideo:String = null;
		public var nombreimagen:String = null;
		public var nombrevideo:String = null;
		public var indice:Number = 0;
		
		public function Diapositiva(img:String, trans:String = null, video:String = null){
			fondo.visible = false;
			buttonMode = true;
			idtransicion = trans;
			addEventListener(MouseEvent.CLICK, toggle);
			addEventListener(Event.ADDED_TO_STAGE, init);
			urlimagen = img;
			if(video != null){
				urlvideo = video;
				var partes:Array = urlvideo.split("\\");
				partes = partes[partes.length-1].split("/");
				nombrevideo = partes[partes.length-1];
			}
			papelera.visible = false;
			papelera.addEventListener(MouseEvent.CLICK, clickTrash);
			cargarImagen();
		}
		
		public function init(e:Event){
			//trace("Transicion precargada = ", MovieClip(root).editor.getTransicion(idtransicion));
			if(idtransicion != "" && idtransicion != null){
				cargarTransicion(MovieClip(root).editor.getTransicion(idtransicion));
			}
		}
		
		public function toggle(e:MouseEvent){
			MovieClip(parent.parent).seleccionarDiapositiva(this);
		}
		
		public function seleccionar(){
			if(!seleccionada){
				fondo.visible = true;
				seleccionada = true;
				trace(nombreimagen, nombrevideo, idtransicion);
			}
		}
		
		public function deseleccionar(){
			if(seleccionada){
				fondo.visible = false;
				seleccionada = false;
			}
		}
		
		public function aXML():String{
			var cadena:String = "<diapositiva ";
			cadena += 'imagen="'+nombreimagen+'" ';
			if(nombrevideo != null && nombrevideo != "") cadena += 'video="'+nombrevideo+'" ';
			
			trace(indice, idtransicion);
			if(idtransicion != "" && idtransicion != null){
				cadena += 'idtransicion="'+idtransicion+'" ';
			} else if(indice == 0){
				cadena += 'idtransicion="default" ';
			}
			if(corte){
				cadena += 'corte="1" ';
			}
			cadena += "/>";
			return cadena;
		}
		
		public function aXMLAlt():String{
			var nombre:Array;
			var cadena:String = "<diapositiva ";
			if(nombrevideo != null && nombrevideo != "")
				nombre = nombrevideo.split(".");
			else 
				nombre = nombreimagen.split(".");
			cadena += 'url="'+nombre[0]+'" ';
			cadena += 'extension="'+nombre[nombre.length-1]+'" ';
			if(corte){
				cadena += 'corte="1" ';
			}
			cadena += "/>";
			return cadena;
		}
		
		public function clickTrash(event:MouseEvent = null){
			if(indice != 0){
				while(trans.numChildren > 0){
					trans.removeChildAt(0);
				}
				idtransicion = null;
				papelera.visible = false;
			}
		}
		
		public function cargarTransicion(transicion:Transicion = null){
			while(trans.numChildren > 0){
				trans.removeChildAt(0);
			}
			if(transicion != null){
				idtransicion = transicion.id;
				papelera.visible = true;
			} else {
				clickTrash();
				return;
			}
			//trace("Cargo Transicion", transicion.imagenurl);
			var mLoader:Loader = new Loader();
			var mRequest:URLRequest = new URLRequest(transicion.imagenurl);
			mLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteTrans);
			mLoader.load(mRequest);
		}
		
		function onCompleteTrans(event:Event)
		{
			var objeto:Bitmap = event.target.loader.content;
			event.target.loader.unload();
			objeto.smoothing = true;
			objeto.width = 59;
			objeto.scaleY = objeto.scaleX;
			trans.addChild(objeto);			
		}
		
		function cargarImagen(){
			var partes:Array = urlimagen.split("\\");
			partes = partes[partes.length-1].split("/");
			nombreimagen = partes[partes.length-1];
			trace("Cargo la imagen:",nombreimagen, urlimagen);
			var mLoader:Loader = new Loader();
			var mRequest:URLRequest = new URLRequest(urlimagen);
			mLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteHandler);
			mLoader.load(mRequest);
		}
		
		function onCompleteHandler(event:Event)
		{
			var objeto:Bitmap = event.target.loader.content;
			event.target.loader.unload();
			objeto.smoothing = true;
			objeto.width = 130;
			objeto.scaleY = objeto.scaleX;
			imagen.addChild(objeto);			
		}
		
		public function clonar(){
			var clon:Diapositiva = new Diapositiva(urlimagen, idtransicion);
			clon.indice = indice;
			return clon;			
		}
	}
}